package uk.gov.justice.laa.fee.scheme.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enum for hearing band codes used in advocacy fee lookup.
 */
@Getter
@RequiredArgsConstructor
public enum HearingBandCode {

  BAND_1("BAND_1", "Band 1 (0-90 minutes)"),
  BAND_2("BAND_2", "Band 2 (90-150 minutes)"),
  BAND_3("BAND_3", "Band 3 (150+ minutes)");

  private final String code;
  private final String displayName;
}

