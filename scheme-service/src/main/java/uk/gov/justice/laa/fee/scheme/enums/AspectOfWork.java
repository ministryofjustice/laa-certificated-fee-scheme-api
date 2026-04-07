package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum representing the aspect of work for advocacy fee requests.
 */
@Getter
@AllArgsConstructor
public enum AspectOfWork {
  CARE_AND_SUPERVISION("care-and-supervision");
  private final String value;
}
