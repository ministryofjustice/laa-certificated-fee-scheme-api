CREATE TABLE advocacy_fee_request (
    id BIGSERIAL PRIMARY KEY,
    aspect_of_work VARCHAR(100),
    proceeding_type VARCHAR(100),
    hearing_date DATE,
    hearing_type VARCHAR(100),
    number_of_interim_proceedings VARCHAR(20),
    duration_band VARCHAR(50),
    days VARCHAR(10),
    judge_level VARCHAR(100),
    court_directed VARCHAR(10),
    calculated_fee NUMERIC(10,2),
    total_interim_fee NUMERIC(10,2),
    is_bolton_applicable VARCHAR(10),
    total_bolton_fee NUMERIC(10,2),
    attended_advocates_meetings VARCHAR(10),
    certification_date DATE,
    pflrs_proceedings_type VARCHAR(100),
    provider_location VARCHAR(100),
    fee_type VARCHAR(100),
    bill_type VARCHAR(100),
    court_type VARCHAR(100),
    level_of_work_done VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE advocacy_fee_bolton_item (
    id BIGSERIAL PRIMARY KEY,
    request_id BIGINT REFERENCES advocacy_fee_request(id) ON DELETE CASCADE,
    bolton_type VARCHAR(100),
    amount NUMERIC(10,2),
    auto_calculated BOOLEAN
);

-- You may want to add similar tables for interimHearings and advocatesMeetings if they are complex objects.

