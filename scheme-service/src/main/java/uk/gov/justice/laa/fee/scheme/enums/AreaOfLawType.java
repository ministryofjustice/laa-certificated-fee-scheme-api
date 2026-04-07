package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 *   For Area of Law look up purpose.
 */

@Getter
@AllArgsConstructor
public enum AreaOfLawType {

  LEGAL_HELP("Legal Help"),
  CRIME_LOWER("Crime Lower"),
  MEDIATION("Mediation");

  private final String displayName;

}
