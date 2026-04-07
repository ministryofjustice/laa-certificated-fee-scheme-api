package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum representing whether the Bolton rule is applicable for advocacy fee requests.
 */
@Getter
@AllArgsConstructor
public enum IsBoltonApplicable {
  YES("yes"), NO("no");
  private final String value;
}
