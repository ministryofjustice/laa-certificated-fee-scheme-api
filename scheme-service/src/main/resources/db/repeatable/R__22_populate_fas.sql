-- Certificate Fee Scheme
INSERT INTO cert_fee_scheme
(scheme_code, scheme_name, effective_from, effective_to)
VALUES('FAS', 'Family Advocacy Scheme 2020', '2020-04-06', NULL)
ON CONFLICT (scheme_code) DO NOTHING;

-- Proceeding Types
INSERT INTO proceeding_type (code, description)
VALUES ('CARE_SUPERVISION', 'Care or supervision'),
       ('OTHER_PUBLIC_LAW', 'Other Public Law')
ON CONFLICT (code) DO NOTHING;

-- Judge Levels
INSERT INTO judge_level (code, description)
VALUES ('JUSTICES', 'Justices’ legal adviser or lay justices'),
       ('DISTRICT', 'District judge'),
       ('CIRCUIT', 'Circuit judge'),
       ('COSTS', 'Costs judge'),
       ('HIGH_COURT', 'High court')
ON CONFLICT (code) DO NOTHING;

INSERT INTO hearing_type (code, description, is_per_day)
VALUES ('INTERIM_HEARING', 'Interim Hearing', false),
       ('CONFERENCE', 'Conference', false),
       ('OPINION', 'Opinion', false),
       ('FINAL_HEARING', 'Final Hearing', true),
       ('ADVOCATES_MEETING', 'Advocates Meeting', false),
       ('APPEAL_REVIEW', 'Appeal or Review', false)
ON CONFLICT (code) DO NOTHING;


INSERT INTO hearing_band
    (hearing_type_id, band_code, min_minutes, max_minutes, description)
SELECT *
FROM (VALUES (1, 'UNIT_1', 0, 60, 'Interim Hearing Unit 1 - up to 1 hour'),
             (1, 'UNIT_2', 61, 150, 'Interim Hearing Unit 2 - up to 2 hours 30 minutes'),
             (1, 'UNIT_2_PLUS', 151, NULL,
              'Interim Hearing exceeding 2 hours 30 minutes')) AS v(hearing_type_id, band_code, min_minutes, max_minutes, description)
WHERE NOT EXISTS (SELECT 1
                  FROM hearing_band hb
                  WHERE hb.band_code = v.band_code);

UPDATE hearing_band
SET band_order = CASE band_code
                     WHEN 'UNIT_1' THEN 1
                     WHEN 'UNIT_2' THEN 2
                     WHEN 'UNIT_2_PLUS' THEN 3
    END;
