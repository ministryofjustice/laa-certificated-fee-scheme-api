package uk.gov.justice.laa.fee.scheme.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enum for hearing type codes used in advocacy fee lookup.
 */
@Getter
@RequiredArgsConstructor
public enum HearingTypeCode {

  CROWN_COURT("CC", "Crown Court"),
  MAGISTRATES_COURT("MC", "Magistrates Court"),
  APPEAL("APP", "Appeal");

  private final String code;
  private final String displayName;
}

