-- Endpoint-oriented views for the simplified model.
SET search_path TO "${flyway:defaultSchema}";

CREATE OR REPLACE VIEW v_lead_proceeding_fee_scheme AS
SELECT
    pt.code AS lead_proceeding_type_code,
    fs.code AS fee_scheme_code,
    fsv.version_code AS fee_scheme_version_code,
    fsv.effective_from,
    fsv.effective_to
FROM proceeding_type pt
JOIN fee_scheme fs ON fs.id = pt.fee_scheme_id
JOIN fee_scheme_version fsv ON fsv.fee_scheme_id = fs.id;

CREATE OR REPLACE VIEW v_cpgfs_rate_lookup AS
SELECT
    fsv.version_code AS fee_scheme_version_code,
    pt.code AS party_type,
    cl.code AS court_level,
    ccc.code AS client_count_category,
    l.code AS provider_office_location,
    cr.amount
FROM cpgfs_rate cr
JOIN fee_scheme_version fsv ON fsv.id = cr.fee_scheme_version_id
JOIN party_type pt ON pt.id = cr.party_type_id
JOIN court_level cl ON cl.id = cr.court_level_id
JOIN client_count_category ccc ON ccc.id = cr.client_count_category_id
JOIN location l ON l.id = cr.location_id;

CREATE OR REPLACE VIEW v_fas_rate_lookup AS
SELECT
    fsv.version_code AS fee_scheme_version_code,
    cc.code AS case_category,
    cl.code AS court_level,
    at.code AS activity_type,
    ut.code AS unit_type,
    fr.amount
FROM fas_rate fr
JOIN fee_scheme_version fsv ON fsv.id = fr.fee_scheme_version_id
JOIN case_category cc ON cc.id = fr.case_category_id
JOIN court_level cl ON cl.id = fr.court_level_id
JOIN activity_type at ON at.id = fr.activity_type_id
JOIN unit_type ut ON ut.id = fr.unit_type_id;

CREATE OR REPLACE VIEW v_phrs_rate_lookup AS
SELECT
    fsv.version_code AS fee_scheme_version_code,
    cc.code AS case_category,
    cl.code AS court_level,
    l.code AS location,
    at.code AS activity_type,
    ut.code AS unit_type,
    pr.amount
FROM phrs_rate pr
JOIN fee_scheme_version fsv ON fsv.id = pr.fee_scheme_version_id
JOIN case_category cc ON cc.id = pr.case_category_id
JOIN court_level cl ON cl.id = pr.court_level_id
JOIN location l ON l.id = pr.location_id
JOIN activity_type at ON at.id = pr.activity_type_id
JOIN unit_type ut ON ut.id = pr.unit_type_id;

COMMENT ON VIEW v_lead_proceeding_fee_scheme IS
'Filter by lead_proceeding_type_code and a relevant date against effective_from/effective_to to select the applicable fee scheme version.';

COMMENT ON VIEW v_cpgfs_rate_lookup IS
'Lookup CPGFS by fee scheme version, party type, court level, client count category and provider-office location.';

COMMENT ON VIEW v_fas_rate_lookup IS
'Lookup FAS by fee scheme version, case category, court level, activity type and unit type.';

COMMENT ON VIEW v_phrs_rate_lookup IS
'Lookup PHRS by fee scheme version, case category, court level, location, activity type and unit type.';
