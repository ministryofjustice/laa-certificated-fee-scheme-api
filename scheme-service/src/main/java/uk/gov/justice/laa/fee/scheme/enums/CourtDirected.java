package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum representing whether the court directed a specific action for advocacy fee requests.
 */
@Getter
@AllArgsConstructor
public enum CourtDirected {
  YES("YES"), NO("NO");
  private final String value;
}
