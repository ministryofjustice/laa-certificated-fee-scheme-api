-- PostgreSQL / Flyway
-- Simplified certificated fee scheme schema for CPGFS, FAS and PHRS.
-- Fee scheme version is the only effective-date layer.
-- Scheme-specific rate tables share generic lookup/reference tables.
SET search_path TO "${flyway:defaultSchema}";

CREATE TABLE IF NOT EXISTS fee_scheme (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(20) NOT NULL UNIQUE,
    name        VARCHAR(200) NOT NULL,
    description VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS fee_scheme_version (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fee_scheme_id   BIGINT NOT NULL REFERENCES fee_scheme(id),
    version_code    VARCHAR(50) NOT NULL UNIQUE,
    version_name    VARCHAR(200) NOT NULL,
    effective_from  DATE NOT NULL,
    effective_to    DATE,
    CONSTRAINT ck_fee_scheme_version_dates
        CHECK (effective_to IS NULL OR effective_to > effective_from),
    CONSTRAINT uq_fee_scheme_version_start
        UNIQUE (fee_scheme_id, effective_from)
);

CREATE TABLE IF NOT EXISTS proceeding_type (
    id                    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code                  VARCHAR(20) NOT NULL UNIQUE,
    name                  VARCHAR(200) NOT NULL,
    description           VARCHAR(500),
    children_act_section  VARCHAR(10),
    is_sca                BOOLEAN NOT NULL DEFAULT FALSE,
    fee_scheme_id         BIGINT REFERENCES fee_scheme(id)
);

-- Shared lookup/reference tables
CREATE TABLE IF NOT EXISTS party_type (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(300)
);

CREATE TABLE IF NOT EXISTS court_level (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(300)
);

CREATE TABLE IF NOT EXISTS client_count_category (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(300),
    min_clients INTEGER,
    max_clients INTEGER,
    CONSTRAINT ck_client_count_category_range
        CHECK (max_clients IS NULL OR min_clients IS NULL OR max_clients >= min_clients)
);

CREATE TABLE IF NOT EXISTS location (
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code          VARCHAR(30) NOT NULL UNIQUE,
    name          VARCHAR(100) NOT NULL,
    location_type VARCHAR(30) NOT NULL,
    description   VARCHAR(300),
    CONSTRAINT ck_location_type
        CHECK (location_type IN ('CPGFS_REGION', 'RATE_BAND', 'GENERIC'))
);

CREATE TABLE IF NOT EXISTS case_category (
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code          VARCHAR(40) NOT NULL UNIQUE,
    name          VARCHAR(200) NOT NULL,
    category_type VARCHAR(30) NOT NULL,
    description   VARCHAR(300),
    CONSTRAINT ck_case_category_type
        CHECK (category_type IN ('FAS', 'PHRS'))
);

CREATE TABLE IF NOT EXISTS activity_type (
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code         VARCHAR(50) NOT NULL UNIQUE,
    name         VARCHAR(160) NOT NULL,
    description  VARCHAR(300),
    counsel_only BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS unit_type (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(300)
);

-- Backfill expected columns when legacy tables already exist in the target schema.
ALTER TABLE fee_scheme_version ADD COLUMN IF NOT EXISTS version_name VARCHAR(200);
ALTER TABLE fee_scheme_version ADD COLUMN IF NOT EXISTS name VARCHAR(200);
ALTER TABLE proceeding_type ADD COLUMN IF NOT EXISTS fee_scheme_id BIGINT;
ALTER TABLE party_type ADD COLUMN IF NOT EXISTS name VARCHAR(100);
ALTER TABLE court_level ADD COLUMN IF NOT EXISTS name VARCHAR(100);
ALTER TABLE client_count_category ADD COLUMN IF NOT EXISTS name VARCHAR(100);
ALTER TABLE client_count_category ADD COLUMN IF NOT EXISTS min_clients INTEGER;
ALTER TABLE client_count_category ADD COLUMN IF NOT EXISTS max_clients INTEGER;
ALTER TABLE activity_type ADD COLUMN IF NOT EXISTS name VARCHAR(160);
ALTER TABLE activity_type ADD COLUMN IF NOT EXISTS counsel_only BOOLEAN;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = current_schema()
          AND table_name = 'fee_scheme_version'
          AND column_name = 'name'
    ) THEN
        EXECUTE 'UPDATE fee_scheme_version SET version_name = name WHERE version_name IS NULL AND name IS NOT NULL';
    END IF;
END $$;

UPDATE fee_scheme_version
SET name = version_name
WHERE name IS NULL AND version_name IS NOT NULL;

UPDATE party_type
SET name = description
WHERE name IS NULL AND description IS NOT NULL;

UPDATE court_level
SET name = description
WHERE name IS NULL AND description IS NOT NULL;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = current_schema()
          AND table_name = 'client_count_category'
          AND column_name = 'minimum_count'
    ) THEN
        EXECUTE 'UPDATE client_count_category SET min_clients = minimum_count WHERE min_clients IS NULL AND minimum_count IS NOT NULL';
    END IF;
END $$;

UPDATE activity_type
SET name = code
WHERE name IS NULL AND code IS NOT NULL;

UPDATE activity_type
SET counsel_only = FALSE
WHERE counsel_only IS NULL;

-- CPGFS fixed-fee rates
CREATE TABLE IF NOT EXISTS cpgfs_rate (
    id                        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fee_scheme_version_id     BIGINT NOT NULL REFERENCES fee_scheme_version(id),
    party_type_id             BIGINT NOT NULL REFERENCES party_type(id),
    court_level_id            BIGINT NOT NULL REFERENCES court_level(id),
    client_count_category_id  BIGINT NOT NULL REFERENCES client_count_category(id),
    location_id               BIGINT NOT NULL REFERENCES location(id),
    amount                    NUMERIC(12,2) NOT NULL,
    CONSTRAINT ck_cpgfs_rate_amount
        CHECK (amount >= 0),
    CONSTRAINT uq_cpgfs_rate
        UNIQUE (fee_scheme_version_id, party_type_id, court_level_id,
                client_count_category_id, location_id)
);

-- FAS graduated advocacy rates. Bolt-ons are outside this table.
CREATE TABLE IF NOT EXISTS fas_rate (
    id                    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fee_scheme_version_id BIGINT NOT NULL REFERENCES fee_scheme_version(id),
    case_category_id      BIGINT NOT NULL REFERENCES case_category(id),
    court_level_id        BIGINT NOT NULL REFERENCES court_level(id),
    activity_type_id      BIGINT NOT NULL REFERENCES activity_type(id),
    unit_type_id          BIGINT NOT NULL REFERENCES unit_type(id),
    amount                NUMERIC(12,2) NOT NULL,
    CONSTRAINT ck_fas_rate_amount
        CHECK (amount >= 0),
    CONSTRAINT uq_fas_rate
        UNIQUE (fee_scheme_version_id, case_category_id, court_level_id,
                activity_type_id, unit_type_id)
);

-- Prescribed Hourly Rates.
CREATE TABLE IF NOT EXISTS phrs_rate (
    id                    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fee_scheme_version_id BIGINT NOT NULL REFERENCES fee_scheme_version(id),
    case_category_id      BIGINT NOT NULL REFERENCES case_category(id),
    court_level_id        BIGINT NOT NULL REFERENCES court_level(id),
    location_id           BIGINT NOT NULL REFERENCES location(id),
    activity_type_id      BIGINT NOT NULL REFERENCES activity_type(id),
    unit_type_id          BIGINT NOT NULL REFERENCES unit_type(id),
    amount                NUMERIC(12,2) NOT NULL,
    CONSTRAINT ck_phrs_rate_amount
        CHECK (amount >= 0),
    CONSTRAINT uq_phrs_rate
        UNIQUE (fee_scheme_version_id, case_category_id, court_level_id,
                location_id, activity_type_id, unit_type_id)
);

CREATE INDEX IF NOT EXISTS ix_proceeding_type_fee_scheme
    ON proceeding_type(fee_scheme_id);

CREATE INDEX IF NOT EXISTS ix_fee_scheme_version_scheme_dates
    ON fee_scheme_version(fee_scheme_id, effective_from, effective_to);

CREATE INDEX IF NOT EXISTS ix_cpgfs_rate_version
    ON cpgfs_rate(fee_scheme_version_id);

CREATE INDEX IF NOT EXISTS ix_fas_rate_version
    ON fas_rate(fee_scheme_version_id);

CREATE INDEX IF NOT EXISTS ix_phrs_rate_version
    ON phrs_rate(fee_scheme_version_id);
