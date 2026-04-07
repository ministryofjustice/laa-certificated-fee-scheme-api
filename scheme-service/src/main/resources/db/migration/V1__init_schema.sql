DROP TABLE IF EXISTS fee CASCADE;

DROP TABLE IF EXISTS fee_schemes CASCADE;

DROP TABLE IF EXISTS police_station_fees CASCADE;

DROP TABLE IF EXISTS fee_category_mapping CASCADE;

DROP TABLE IF EXISTS category_of_law_type CASCADE;

DROP TABLE IF EXISTS fee_scheme_category_type CASCADE;

DROP TABLE IF EXISTS area_of_law_type CASCADE;

DROP TABLE IF EXISTS police_stations CASCADE;

DROP TABLE IF EXISTS category_of_law_look_up CASCADE;

DROP TABLE IF EXISTS vat_rates CASCADE;

DROP TABLE IF EXISTS fee_code_information CASCADE;

CREATE TABLE IF NOT EXISTS fee_schemes
(
    scheme_code VARCHAR PRIMARY KEY,
    scheme_name VARCHAR NOT NULL,
    valid_from  DATE    NOT NULL,
    valid_to    DATE    NULL
);

CREATE TABLE IF NOT EXISTS fee_code_information
(
    fee_code                    VARCHAR(10) PRIMARY KEY,
    fee_description             TEXT        NOT NULL,
    fee_type                    VARCHAR(15) NOT NULL,
    category_type               VARCHAR        NOT NULL,
    court_designation_type      VARCHAR        NULL,
    fee_band_type               VARCHAR        NULL
);

CREATE TABLE IF NOT EXISTS fee
(
    fee_id                      SERIAL PRIMARY KEY,
    fee_code                    VARCHAR(10) NOT NULL REFERENCES fee_code_information(fee_code),
    fee_scheme_code             VARCHAR        NOT NULL REFERENCES fee_schemes (scheme_code),
    region                      VARCHAR        NULL,
    fixed_fee                   NUMERIC(10, 2) NULL,
    profit_cost_limit           NUMERIC(10, 2) NULL,
    upper_cost_limit            NUMERIC(10, 2) NULL,
    disbursement_limit          NUMERIC(10, 2) NULL,
    escape_threshold_limit      NUMERIC(10, 2) NULL,
    total_limit                 NUMERIC(10, 2) NULL,
    prior_authority_applicable  BOOL           NULL,
    schedule_reference          BOOL           NULL,
    ho_interview_bolt_on        NUMERIC(10, 2) NULL,
    oral_cmrh_bolt_on           NUMERIC(10, 2) NULL,
    telephone_cmrh_bolt_on      NUMERIC(10, 2) NULL,
    substantive_hearing_bolt_on NUMERIC(10, 2) NULL,
    adjorn_hearing_bolt_on      NUMERIC(10, 2) NULL,
    mediation_fee_lower         NUMERIC(10, 2) NULL,
    mediation_fee_higher        NUMERIC(10, 2) NULL
);


CREATE TABLE IF NOT EXISTS police_station_fees
(
    police_station_fees_id SERIAL PRIMARY KEY,
    ps_scheme_name         VARCHAR(255)   NOT NULL,
    ps_scheme_id           VARCHAR(255)   NOT NULL,
    fixed_fee              NUMERIC(10, 2) NULL,
    escape_threshold       NUMERIC(10, 2) NULL,
    fee_scheme_code        VARCHAR        NOT NULL REFERENCES fee_schemes (scheme_code)
);

CREATE TABLE IF NOT EXISTS police_stations
(
    id                  SERIAL PRIMARY KEY,
    police_station_id   varchar NOT NULL UNIQUE,
    police_station_name varchar NOT NULL,
    ps_scheme_id        varchar NOT NULL,
    ps_scheme_name      varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS area_of_law_type
(
    area_of_law_type_id SERIAL PRIMARY KEY,
    code                VARCHAR(15) NOT NULL UNIQUE,
    description         VARCHAR(50) NOT NULL,
    case_type           VARCHAR     NOT NULL
);

CREATE TABLE IF NOT EXISTS category_of_law_type
(
    category_of_law_type_id SERIAL PRIMARY KEY,
    code                    VARCHAR(10) NOT NULL UNIQUE,
    description             TEXT        NOT NULL,
    area_of_law_type_id     INT         NOT NULL REFERENCES area_of_law_type (area_of_law_type_id)
);


CREATE TABLE IF NOT EXISTS fee_scheme_category_type
(
    fee_scheme_category_type_id SERIAL PRIMARY KEY,
    fee_scheme_category_name    VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS fee_category_mapping
(
    id                          SERIAL PRIMARY KEY,
    fee_code                    VARCHAR(10) NOT NULL UNIQUE REFERENCES fee_code_information (fee_code),
    fee_scheme_category_type_id INT         NOT NULL REFERENCES fee_scheme_category_type (fee_scheme_category_type_id),
    category_of_law_type_id     INT         NOT NULL REFERENCES category_of_law_type (category_of_law_type_id)
);

CREATE TABLE IF NOT EXISTS vat_rates
(
    id                          SERIAL PRIMARY KEY,
    start_date                  DATE NOT NULL,
    vat_rate                    NUMERIC(10,2) NOT NULL
);

ALTER TABLE police_station_fees
    ADD CONSTRAINT uq_police_station_fees_category_code_fee_code UNIQUE (ps_scheme_id, fee_scheme_code);

ALTER TABLE fee
    ADD CONSTRAINT uq_fee_scheme_code_fee_code UNIQUE (fee_code, fee_scheme_code);

ALTER TABLE vat_rates
    ADD CONSTRAINT uq_start_date_vat_rate UNIQUE (start_date, vat_rate);

DROP TABLE IF EXISTS cert_fee_scheme CASCADE;

DROP TABLE IF EXISTS scheme_type CASCADE;

DROP TABLE IF EXISTS proceeding_type CASCADE;

DROP TABLE IF EXISTS judge_level CASCADE;

DROP TABLE IF EXISTS hearing_type CASCADE;

DROP TABLE IF EXISTS hearing_band CASCADE;

DROP TABLE IF EXISTS advocacy_fee CASCADE;

DROP TABLE IF EXISTS advocacy_fee_request CASCADE;

DROP TABLE IF EXISTS advocacy_fee_bolton_item CASCADE;

CREATE TABLE IF NOT EXISTS cert_fee_scheme
(
    id             SERIAL PRIMARY KEY,
    scheme_code    VARCHAR(50)  NOT NULL UNIQUE,
    scheme_name    VARCHAR(255) NOT NULL,
    effective_from DATE         NOT NULL,
    effective_to   DATE
);

CREATE TABLE IF NOT EXISTS scheme_type
(
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(50) NOT NULL UNIQUE,
    description TEXT        NOT NULL
);

CREATE TABLE IF NOT EXISTS proceeding_type
(
    id             SERIAL PRIMARY KEY,
    code           VARCHAR(50) NOT NULL UNIQUE,
    description    TEXT        NOT NULL,
    scheme_type_id INTEGER REFERENCES scheme_type (id)
);

CREATE TABLE IF NOT EXISTS judge_level
(
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(50) NOT NULL UNIQUE,
    description TEXT        NOT NULL
);

CREATE TABLE IF NOT EXISTS hearing_type
(
    id          SERIAL PRIMARY KEY,
    code        VARCHAR(50) NOT NULL UNIQUE,
    description TEXT        NOT NULL,
    is_per_day  BOOLEAN    default false
);

CREATE TABLE IF NOT EXISTS hearing_band
(
    id              SERIAL PRIMARY KEY,
    hearing_type_id INTEGER NOT NULL REFERENCES hearing_type (id),
    band_code       VARCHAR(50),
    min_minutes     INTEGER,
    max_minutes     INTEGER,
    description     TEXT,
    band_order      INTEGER
);

CREATE TABLE IF NOT EXISTS advocacy_fee_request
(
    id                            BIGSERIAL PRIMARY KEY,
    aspect_of_work                VARCHAR(100),
    proceeding_type               VARCHAR(100),
    hearing_date                  DATE,
    hearing_type                  VARCHAR(100),
    number_of_interim_proceedings VARCHAR(20),
    duration_band                 VARCHAR(50),
    days                          VARCHAR(10),
    judge_level                   VARCHAR(100),
    court_directed                VARCHAR(10),
    calculated_fee                NUMERIC(10, 2),
    total_interim_fee             NUMERIC(10, 2),
    is_bolton_applicable          VARCHAR(10),
    total_bolton_fee              NUMERIC(10, 2),
    attended_advocates_meetings   VARCHAR(10),
    certification_date            DATE,
    pflrs_proceedings_type        VARCHAR(100),
    provider_location             VARCHAR(100),
    fee_type                      VARCHAR(100),
    bill_type                     VARCHAR(100),
    court_type                    VARCHAR(100),
    level_of_work_done            VARCHAR(100),
    created_at                    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS advocacy_fee_bolton_item
(
    id              BIGSERIAL PRIMARY KEY,
    request_id      BIGINT REFERENCES advocacy_fee_request (id) ON DELETE CASCADE,
    bolton_type     VARCHAR(100),
    amount          NUMERIC(10, 2),
    auto_calculated BOOLEAN
);

CREATE TABLE IF NOT EXISTS advocacy_fee
(
    id                 SERIAL PRIMARY KEY,
    scheme_id          INTEGER        NOT NULL REFERENCES cert_fee_scheme (id),
    proceeding_type_id INTEGER        NOT NULL REFERENCES proceeding_type (id),
    judge_level_id     INTEGER REFERENCES judge_level (id),
    hearing_type_id    INTEGER REFERENCES hearing_type (id),
    hearing_band_id    INTEGER REFERENCES hearing_band (id),
    amount             NUMERIC(12, 2) NOT NULL
);

ALTER TABLE advocacy_fee
    ADD CONSTRAINT uq_adv_fee
        UNIQUE (scheme_id,
                proceeding_type_id,
                judge_level_id,
                hearing_type_id,
                hearing_band_id);