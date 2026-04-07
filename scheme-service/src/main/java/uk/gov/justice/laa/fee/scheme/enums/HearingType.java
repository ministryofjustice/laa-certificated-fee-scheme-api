package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum representing the hearing type for advocacy fee requests.
 */
@Getter
@AllArgsConstructor
public enum HearingType {
  FINAL_HEARING("FINAL_HEARING");
  private final String value;
}
