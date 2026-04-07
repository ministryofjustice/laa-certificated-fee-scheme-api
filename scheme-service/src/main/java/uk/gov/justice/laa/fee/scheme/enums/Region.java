package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for regions.
 */
@Getter
@AllArgsConstructor
public enum Region {
  LONDON("London"),
  NON_LONDON("Non-London");

  private final String description;
}
