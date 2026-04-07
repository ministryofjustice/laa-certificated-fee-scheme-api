package uk.gov.justice.laa.fee.scheme.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Enum for the types of category of law.
 */
@Getter
@AllArgsConstructor
public enum CategoryType {
  ADVICE_ASSISTANCE_ADVOCACY("Advice Assistance Advocacy"),
  ADVOCACY_APPEALS_REVIEWS("Advocacy Appeals Reviews"),
  ASSOCIATED_CIVIL("Associated Civil"),
  CLAIMS_PUBLIC_AUTHORITIES("Claims Public Authorities"),
  CLINICAL_NEGLIGENCE("Clinical Negligence"),
  COMMUNITY_CARE("Community Care"),
  DEBT("Debt"),
  DISCRIMINATION("Discrimination"),
  EARLY_COVER("Early Cover"),
  EDUCATION("Education"),
  FAMILY("Family"),
  HOUSING("Housing"),
  HOUSING_HLPAS("Housing HLPA's"),
  IMMIGRATION_ASYLUM("Immigration Asylum"),
  MAGISTRATES_COURT("Magistrates Court"),
  MEDIATION("Mediation"),
  MENTAL_HEALTH("Mental Health"),
  MISCELLANEOUS("Miscellaneous"),
  POLICE_STATION("Police Station"),
  PUBLIC_LAW("Public Law"),
  PRISON_LAW("Prison Law"),
  PRE_ORDER_COVER("Pre Order Cover"),
  REFUSED_MEANS_TEST("Refused Means Test"),
  SENDING_HEARING("Sending Hearing"),
  WELFARE_BENEFITS("Welfare Benefits"),
  YOUTH_COURT("Youth Court");

  private final String description;
}
