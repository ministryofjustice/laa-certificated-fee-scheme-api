package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 *  Enum for types of Claim Start Date.
 */

@Getter
@AllArgsConstructor
public enum ClaimStartDateType {
  CASE_CONCLUDED_DATE("Case Concluded Date"),
  CASE_START_DATE("Case Start Date"),
  REP_ORDER_DATE("Rep Order Date"),
  UFN("UFN");

  private final String description;
}
