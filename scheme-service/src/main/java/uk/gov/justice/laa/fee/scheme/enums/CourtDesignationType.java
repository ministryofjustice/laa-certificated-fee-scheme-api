package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for the types of court designation.
 */
@Getter
@AllArgsConstructor
public enum CourtDesignationType {
  DESIGNATED("Designated"), UNDESIGNATED("Undesignated");

  private final String description;
}
