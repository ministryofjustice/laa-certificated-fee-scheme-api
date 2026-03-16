package uk.gov.justice.laa.fee.scheme.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enum for proceeding type codes used in advocacy fee lookup.
 */
@Getter
@RequiredArgsConstructor
public enum ProceedingTypeCode {

  CRACKED_TRIAL("CRACKED_TRIAL", "Cracked Trial"),
  GUILTY_PLEA("GUILTY_PLEA", "Guilty Plea"),
  TRIAL("TRIAL", "Trial");

  private final String code;
  private final String displayName;
}

