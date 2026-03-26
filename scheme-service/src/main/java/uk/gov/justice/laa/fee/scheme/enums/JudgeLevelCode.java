package uk.gov.justice.laa.fee.scheme.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enum for judge level codes used in advocacy fee lookup.
 * Values match the judge_level.code column populated by R__22_populate_fas.sql.
 */
@Getter
@RequiredArgsConstructor
public enum JudgeLevelCode {

  JUSTICES("JUSTICES", "Justices' legal adviser or lay justices"),
  DISTRICT("DISTRICT", "District judge"),
  CIRCUIT("CIRCUIT", "Circuit judge"),
  COSTS("COSTS", "Costs judge"),
  HIGH_COURT("HIGH_COURT", "High court");

  private final String code;
  private final String displayName;
}
