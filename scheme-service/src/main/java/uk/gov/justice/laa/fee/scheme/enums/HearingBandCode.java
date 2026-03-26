package uk.gov.justice.laa.fee.scheme.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enum for hearing band codes used in advocacy fee lookup.
 * Values match the hearing_band.band_code column populated by R__22_populate_fas.sql.
 */
@Getter
@RequiredArgsConstructor
public enum HearingBandCode {

  UNIT_1("UNIT_1", "Interim Hearing Unit 1 - up to 1 hour"),
  UNIT_2("UNIT_2", "Interim Hearing Unit 2 - up to 2 hours 30 minutes"),
  UNIT_2_PLUS("UNIT_2_PLUS", "Interim Hearing exceeding 2 hours 30 minutes");

  private final String code;
  private final String displayName;
}
