package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for hearing type codes used in advocacy fee lookup.
 * Values match the hearing_type.code column populated by R__22_populate_fas.sql.
 */
@Getter
@AllArgsConstructor
public enum HearingTypeCode {

  INTERIM_HEARING("INTERIM_HEARING", "Interim Hearing"),
  FINAL_HEARING("FINAL_HEARING", "Final Hearing"),
  ADVOCATES_MEETING("ADVOCATES_MEETING", "Advocates Meeting"),
  CONFERENCE_OPINION("CONFERENCE_OPINION", "Conference or Opinion"),
  APPEAL_REVIEW("APPEAL_REVIEW", "Appeal or Review");

  private final String code;
  private final String displayName;
}
