package uk.gov.justice.laa.fee.scheme.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enum for judge level codes used in advocacy fee lookup.
 */
@Getter
@RequiredArgsConstructor
public enum JudgeLevelCode {

  CIRCUIT_JUDGE("CJ", "Circuit Judge"),
  HIGH_COURT_JUDGE("HCJ", "High Court Judge"),
  RECORDER("REC", "Recorder"),
  DISTRICT_JUDGE("DJ", "District Judge");

  private final String code;
  private final String displayName;
}

