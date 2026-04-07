package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum representing the proceeding type for advocacy fee requests.
 */
@Getter
@AllArgsConstructor
public enum ProceedingType {
  FINAL_HEARING("FINAL_HEARING");
  private final String value;
}
