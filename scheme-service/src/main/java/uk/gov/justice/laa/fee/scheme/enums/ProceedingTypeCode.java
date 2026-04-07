package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for proceeding type codes used in advocacy fee lookup.
 * Values match the proceeding_type.code column populated by R__22_populate_fas.sql.
 */
@Getter
@AllArgsConstructor
public enum ProceedingTypeCode {

  CARE_SUPERVISION("CARE_SUPERVISION", "Care or supervision"),
  OTHER_PUBLIC_LAW("OTHER_PUBLIC_LAW", "Other Public Law");

  private final String code;
  private final String displayName;
}
