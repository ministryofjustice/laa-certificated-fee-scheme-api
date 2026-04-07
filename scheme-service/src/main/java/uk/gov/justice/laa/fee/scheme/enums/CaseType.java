package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for the types of case.
 */

@Getter
@AllArgsConstructor
public enum CaseType {
  CIVIL("Civil"),
  CRIME("Crime");

  private final String description;
}
