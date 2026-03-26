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

INSERT INTO hearing_type (code, description)
VALUES ('INTERIM_HEARING', 'Interim Hearing'),
       ('FINAL_HEARING', 'Final Hearing'),
       ('ADVOCATES_MEETING', 'Advocates Meeting'),
       ('CONFERENCE_OPINION', 'Conference or Opinion'),
       ('APPEAL_REVIEW', 'Appeal or Review')
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

INSERT INTO advocacy_fee (scheme_id,
                          proceeding_type_id,
                          judge_level_id,
                          hearing_type_id,
                          hearing_band_id,
                          amount)
SELECT s.id,
       p.id,
       j.id,
       h.id,
       b.id,
       v.amount
FROM (VALUES ('CARE_SUPERVISION', 'JUSTICES', 'INTERIM_HEARING', 'UNIT_1', 86.72),
             ('CARE_SUPERVISION', 'JUSTICES', 'INTERIM_HEARING', 'UNIT_2', 216.81),
             ('CARE_SUPERVISION', 'DISTRICT', 'INTERIM_HEARING', 'UNIT_1', 95.40),
             ('CARE_SUPERVISION', 'DISTRICT', 'INTERIM_HEARING', 'UNIT_2', 238.46),
             ('CARE_SUPERVISION', 'CIRCUIT', 'INTERIM_HEARING', 'UNIT_2', 238.46),
             ('CARE_SUPERVISION', 'HIGH_COURT', 'INTERIM_HEARING', 'UNIT_1', 114.48),
             ('CARE_SUPERVISION', 'HIGH_COURT', 'INTERIM_HEARING', 'UNIT_2',
              286.16)) AS v(proceeding_code, judge_code, hearing_code, band_code, amount)
         JOIN cert_fee_scheme s
              ON s.scheme_code = 'FAS_2020'
         JOIN proceeding_type p
              ON p.code = v.proceeding_code
         JOIN judge_level j
              ON j.code = v.judge_code
         JOIN hearing_type h
              ON h.code = v.hearing_code
         JOIN hearing_band b
              ON b.band_code = v.band_code;
-- Justices