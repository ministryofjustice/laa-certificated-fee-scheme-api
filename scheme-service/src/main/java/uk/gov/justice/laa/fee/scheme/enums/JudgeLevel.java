package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum representing the judge level for advocacy fee requests.
 */
@Getter
@AllArgsConstructor
public enum JudgeLevel {
  HIGH_COURT_JUDGE("HIGH_COURT_JUDGE");
  private final String value;
}
