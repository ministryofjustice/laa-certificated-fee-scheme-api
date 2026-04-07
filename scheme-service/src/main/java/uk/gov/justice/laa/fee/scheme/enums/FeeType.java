package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for the types of fee.
 */
@Getter
@AllArgsConstructor
public enum FeeType {
  FIXED("Fixed Fee"), 
  HOURLY("Hourly Fee"), 
  DISB_ONLY("Disbursement Only");

  private final String description;
}
