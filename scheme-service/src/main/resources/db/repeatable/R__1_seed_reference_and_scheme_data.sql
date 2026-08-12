-- Fee schemes
SET search_path TO "${flyway:defaultSchema}";

INSERT INTO fee_scheme (code, name, description) VALUES
('CPGFS', 'Care Proceedings Graduated Fee Scheme', 'Fixed fees for section 31 care and supervision proceedings.'),
('FAS', 'Family Advocacy Scheme', 'Graduated advocacy fees for family proceedings.'),
('PHRS', 'Prescribed Hourly Rate Scheme', 'Prescribed hourly rates for qualifying family and public-law work.')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description;

-- Fee scheme versions. End dates are exclusive: [effective_from, effective_to).
INSERT INTO fee_scheme_version (fee_scheme_id, version_code, name, version_name, effective_from, effective_to)
SELECT id, 'CPGFS2013', 'CPGFS version effective 1 April 2013', 'CPGFS version effective 1 April 2013', DATE '2013-04-01', DATE '2014-04-22'
FROM fee_scheme WHERE code = 'CPGFS'
ON CONFLICT (version_code) DO UPDATE
SET fee_scheme_id = EXCLUDED.fee_scheme_id,
    name = EXCLUDED.name,
    version_name = EXCLUDED.version_name,
    effective_from = EXCLUDED.effective_from,
    effective_to = EXCLUDED.effective_to;

INSERT INTO fee_scheme_version (fee_scheme_id, version_code, name, version_name, effective_from, effective_to)
SELECT id, 'CPGFS2014', 'CPGFS version effective 22 April 2014', 'CPGFS version effective 22 April 2014', DATE '2014-04-22', NULL
FROM fee_scheme WHERE code = 'CPGFS'
ON CONFLICT (version_code) DO UPDATE
SET fee_scheme_id = EXCLUDED.fee_scheme_id,
    name = EXCLUDED.name,
    version_name = EXCLUDED.version_name,
    effective_from = EXCLUDED.effective_from,
    effective_to = EXCLUDED.effective_to;

INSERT INTO fee_scheme_version (fee_scheme_id, version_code, name, version_name, effective_from, effective_to)
SELECT id, 'FAS2013', 'FAS version effective 1 April 2013', 'FAS version effective 1 April 2013', DATE '2013-04-01', DATE '2014-04-22'
FROM fee_scheme WHERE code = 'FAS'
ON CONFLICT (version_code) DO UPDATE
SET fee_scheme_id = EXCLUDED.fee_scheme_id,
    name = EXCLUDED.name,
    version_name = EXCLUDED.version_name,
    effective_from = EXCLUDED.effective_from,
    effective_to = EXCLUDED.effective_to;

INSERT INTO fee_scheme_version (fee_scheme_id, version_code, name, version_name, effective_from, effective_to)
SELECT id, 'FAS2014', 'FAS version effective 22 April 2014', 'FAS version effective 22 April 2014', DATE '2014-04-22', DATE '2020-04-06'
FROM fee_scheme WHERE code = 'FAS'
ON CONFLICT (version_code) DO UPDATE
SET fee_scheme_id = EXCLUDED.fee_scheme_id,
    name = EXCLUDED.name,
    version_name = EXCLUDED.version_name,
    effective_from = EXCLUDED.effective_from,
    effective_to = EXCLUDED.effective_to;

INSERT INTO fee_scheme_version (fee_scheme_id, version_code, name, version_name, effective_from, effective_to)
SELECT id, 'FAS2020', 'FAS version effective 6 April 2020', 'FAS version effective 6 April 2020', DATE '2020-04-06', NULL
FROM fee_scheme WHERE code = 'FAS'
ON CONFLICT (version_code) DO UPDATE
SET fee_scheme_id = EXCLUDED.fee_scheme_id,
    name = EXCLUDED.name,
    version_name = EXCLUDED.version_name,
    effective_from = EXCLUDED.effective_from,
    effective_to = EXCLUDED.effective_to;

INSERT INTO fee_scheme_version (fee_scheme_id, version_code, name, version_name, effective_from, effective_to)
SELECT id, 'PHRS2020', 'PHRS version effective 6 April 2020', 'PHRS version effective 6 April 2020', DATE '2020-04-06', NULL
FROM fee_scheme WHERE code = 'PHRS'
ON CONFLICT (version_code) DO UPDATE
SET fee_scheme_id = EXCLUDED.fee_scheme_id,
    name = EXCLUDED.name,
    version_name = EXCLUDED.version_name,
    effective_from = EXCLUDED.effective_from,
    effective_to = EXCLUDED.effective_to;

-- Shared lookup/reference data
INSERT INTO party_type (code, name, description) VALUES
('CHILD', 'Child', 'Child represented in the proceedings.'),
('PARENT', 'Parent', 'Parent or person with parental responsibility.'),
('JOINED_PARTY', 'Joined party', 'Other joined party.')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description;

INSERT INTO court_level (code, name, description) VALUES
('LOWER_COURT', 'Lower court', 'Justices legal adviser / lay justice and other lower-court level work.'),
('DISTRICT_CIRCUIT', 'District / Circuit / Costs judge', 'District judge, circuit judge or costs judge level.'),
('HIGH_COURT', 'High Court', 'High Court judge level or higher court.')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description;

INSERT INTO client_count_category (code, name, description, min_clients, max_clients) VALUES
('ONE', 'One client', 'Exactly one represented client.', 1, 1),
('TWO_OR_MORE', 'Two or more clients', 'Two or more represented clients.', 2, NULL),
('NOT_APPLICABLE', 'Not applicable', 'Client count does not determine this rate.', NULL, NULL)
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description,
    min_clients = EXCLUDED.min_clients,
    max_clients = EXCLUDED.max_clients;

INSERT INTO location (code, name, location_type, description) VALUES
('NORTH', 'North', 'CPGFS_REGION', 'CPGFS provider-office region.'),
('MIDLANDS', 'Midlands', 'CPGFS_REGION', 'CPGFS provider-office region.'),
('WALES', 'Wales', 'CPGFS_REGION', 'CPGFS provider-office region.'),
('LONDON_AND_SOUTH', 'London and South', 'CPGFS_REGION', 'CPGFS provider-office region.'),
('LONDON', 'London', 'RATE_BAND', 'London prescribed hourly rate band.'),
('NON_LONDON', 'Non-London', 'RATE_BAND', 'Non-London prescribed hourly rate band.'),
('NOT_APPLICABLE', 'Not applicable', 'GENERIC', 'No location split applies to this rate.')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    location_type = EXCLUDED.location_type,
    description = EXCLUDED.description;

INSERT INTO case_category (code, name, category_type, description) VALUES
('CARE_AND_SUPERVISION', 'Care and supervision', 'FAS', 'Section 31 care and supervision proceedings.'),
('OTHER_PUBLIC_LAW', 'Other public law', 'FAS', 'Other public-law family proceedings.'),
('PUBLIC_LAW_CHILDREN', 'Public law children', 'PHRS', 'Parts IV/V Children Act proceedings excluding section 31.'),
('OTHER_FAMILY', 'Other family', 'PHRS', 'Other family proceedings subject to prescribed hourly rates.')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    category_type = EXCLUDED.category_type,
    description = EXCLUDED.description;

INSERT INTO unit_type (code, name, description) VALUES
('PER_ITEM', 'Per item', 'Fixed amount for an individual item.'),
('PER_HOUR', 'Per hour', 'Hourly rate.'),
('PER_UNIT', 'Per unit', 'Graduated hearing unit.'),
('PER_DAY', 'Per day', 'Rate payable per day.'),
('PER_ACTIVITY', 'Per activity', 'Fixed amount for an activity.')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description;

INSERT INTO activity_type (code, name, description, counsel_only) VALUES
('HEARING_UNIT_1', 'Hearing Unit 1', 'Hearing Unit 1, up to one hour.', FALSE),
('HEARING_UNIT_2', 'Hearing Unit 2', 'Hearing Unit 2, up to two and a half hours.', FALSE),
('CONFERENCE', 'Conference', 'Conference fee.', TRUE),
('OPINION', 'Opinion', 'Opinion fee.', TRUE),
('ADVOCATES_MEETING', 'Advocates meeting', 'Advocates meeting fee.', FALSE),
('FINAL_HEARING', 'Final hearing', 'Final hearing fee.', FALSE),
('ROUTINE_LETTER_OUT', 'Routine letter out', 'Writing routine letters / routine letters out.', FALSE),
('ROUTINE_LETTER_IN', 'Routine letter in', 'Receiving routine letters.', FALSE),
('ROUTINE_TELEPHONE_CALL', 'Routine telephone call', 'Routine telephone calls.', FALSE),
('PREPARATION_ATTENDANCE', 'Preparation and attendance', 'Preparation and attendance.', FALSE),
('COURT_OR_COUNSEL_CONFERENCE', 'Court or counsel conference', 'Attendance at court or conference with counsel.', FALSE),
('ADVOCACY', 'Advocacy', 'Advocacy.', FALSE),
('TRAVEL_WAITING', 'Travel and waiting', 'Travelling and waiting time.', FALSE)
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    description = EXCLUDED.description,
    counsel_only = EXCLUDED.counsel_only;

-- Proceeding types. fee_scheme_id is the default scheme when the proceeding is the lead proceeding.
INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB057', 'Application for care order - SCA', '31', TRUE, id FROM fee_scheme WHERE code = 'CPGFS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;

INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB059', 'Application for supervision order - SCA', '31', TRUE, id FROM fee_scheme WHERE code = 'CPGFS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;

INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB003', 'Application for child assessment order - SCA', '43', TRUE, id FROM fee_scheme WHERE code = 'PHRS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;

INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB004', 'Extend emergency protection - SCA', '45', TRUE, id FROM fee_scheme WHERE code = 'PHRS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;

INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB005', 'Discharge emergency protection - SCA', '45', TRUE, id FROM fee_scheme WHERE code = 'PHRS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;

INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB006', 'Secure accommodation order - SCA', '25', TRUE, id FROM fee_scheme WHERE code = 'PHRS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;

INSERT INTO proceeding_type (code, name, children_act_section, is_sca, fee_scheme_id)
SELECT 'PB026', 'Emergency protection order - SCA', '44', TRUE, id FROM fee_scheme WHERE code = 'PHRS'
ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, children_act_section = EXCLUDED.children_act_section, is_sca = EXCLUDED.is_sca, fee_scheme_id = EXCLUDED.fee_scheme_id;
