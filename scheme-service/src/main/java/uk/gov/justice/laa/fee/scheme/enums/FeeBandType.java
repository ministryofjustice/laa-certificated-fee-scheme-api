package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 *  Enum for Fee Bands.
 */

@Getter
@AllArgsConstructor
public enum FeeBandType {
  STANDARD("Standard"),
  HIGHER("Higher"),
  LOWER("Lower");

  private final String description;
}
