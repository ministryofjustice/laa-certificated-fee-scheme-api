-- Insert advocacy fees for:
-- scheme_id = 1
-- proceeding_type_id = 1

WITH hearing_type_lookup AS (SELECT id, code
                             FROM hearing_type),
     hearing_band_lookup AS (SELECT hb.id, hb.band_code, ht.code AS hearing_type_code
                             FROM hearing_band hb
                                      JOIN hearing_type ht
                                           ON hb.hearing_type_id = ht.id),
     fee_data AS (SELECT *
                  FROM (VALUES
                            -- =========================================================
                            -- JUSTICES’ legal adviser or lay justices
                            -- judge_level_id = 1
                            -- =========================================================
                            (1, 1, 1, 'INTERIM_HEARING', 'UNIT_1', 86.72),
                            (1, 1, 1, 'INTERIM_HEARING', 'UNIT_2', 216.81),
                            (1, 1, 1, 'CONFERENCE', NULL, 127.71),
                            (1, 1, 1, 'OPINION', NULL, 105.66),
                            (1, 1, 1, 'ADVOCATES_MEETING', NULL, 128.16),
                            (1, 1, 1, 'FINAL_HEARING', NULL, 506.25),

                            -- =========================================================
                            -- DISTRICT JUDGE
                            -- judge_level_id = 2
                            -- =========================================================
                            (1, 1, 2, 'INTERIM_HEARING', 'UNIT_1', 95.40),
                            (1, 1, 2, 'INTERIM_HEARING', 'UNIT_2', 238.46),
                            (1, 1, 2, 'CONFERENCE', NULL, 127.71),
                            (1, 1, 2, 'OPINION', NULL, 105.66),
                            (1, 1, 2, 'ADVOCATES_MEETING', NULL, 140.99),
                            (1, 1, 2, 'FINAL_HEARING', NULL, 556.88),

                            -- =========================================================
                            -- CIRCUIT JUDGE
                            -- judge_level_id = 3
                            -- =========================================================
                            (1, 1, 3, 'INTERIM_HEARING', 'UNIT_1', 95.40),
                            (1, 1, 3, 'INTERIM_HEARING', 'UNIT_2', 238.46),
                            (1, 1, 3, 'CONFERENCE', NULL, 127.71),
                            (1, 1, 3, 'OPINION', NULL, 105.66),
                            (1, 1, 3, 'ADVOCATES_MEETING', NULL, 140.99),
                            (1, 1, 3, 'FINAL_HEARING', NULL, 556.88),

                            -- =========================================================
                            -- COSTS JUDGE
                            -- judge_level_id = 4
                            -- =========================================================
                            (1, 1, 4, 'INTERIM_HEARING', 'UNIT_1', 95.40),
                            (1, 1, 4, 'INTERIM_HEARING', 'UNIT_2', 238.46),
                            (1, 1, 4, 'CONFERENCE', NULL, 127.71),
                            (1, 1, 4, 'OPINION', NULL, 105.66),
                            (1, 1, 4, 'ADVOCATES_MEETING', NULL, 140.99),
                            (1, 1, 4, 'FINAL_HEARING', NULL, 556.88),

                            -- =========================================================
                            -- HIGH COURT
                            -- judge_level_id = 5
                            -- =========================================================
                            (1, 1, 5, 'INTERIM_HEARING', 'UNIT_1', 114.48),
                            (1, 1, 5, 'INTERIM_HEARING', 'UNIT_2', 286.16),
                            (1, 1, 5, 'CONFERENCE', NULL, 127.71),
                            (1, 1, 5, 'OPINION', NULL, 105.66),
                            (1, 1, 5, 'ADVOCATES_MEETING', NULL, 169.20),
                            (1, 1, 5, 'FINAL_HEARING', NULL, 668.25)) AS t (
                                                                            scheme_id,
                                                                            proceeding_type_id,
                                                                            judge_level_id,
                                                                            hearing_type_code,
                                                                            hearing_band_code,
                                                                            amount
                      ))
INSERT
INTO advocacy_fee (scheme_id,
                   proceeding_type_id,
                   judge_level_id,
                   hearing_type_id,
                   hearing_band_id,
                   amount)
SELECT fd.scheme_id,
       fd.proceeding_type_id,
       fd.judge_level_id,
       ht.id AS hearing_type_id,
       hb.id AS hearing_band_id,
       fd.amount
FROM fee_data fd
         JOIN hearing_type_lookup ht
              ON ht.code = fd.hearing_type_code
         LEFT JOIN hearing_band_lookup hb
                   ON hb.band_code = fd.hearing_band_code
                       AND hb.hearing_type_code = fd.hearing_type_code;