package uk.gov.justice.laa.fee.scheme.exception;

/**
 * Exception thrown when no advocacy fee record is found for the supplied lookup parameters.
 */
public class AdvocacyFeeNotFoundException extends RuntimeException {

  /**
   * Constructs a new AdvocacyFeeNotFoundException with a message containing the lookup parameters.
   *
   * @param schemeCode Scheme code should never be null for fee lookups
   * @param proceedingTypeCode Proceeding type code should be null for pre-AGFS v2 fee lookups
   * @param judgeLevelCode Judge level code should be null for pre-AGFS v2 fee lookups
   * @param hearingTypeCode Hearing type code should be null for pre-AGFS v2 fee lookups
   * @param hearingBandCode Should be null for pre-AGFS v2 fee lookups
   */
  public AdvocacyFeeNotFoundException(
      String schemeCode,
      String proceedingTypeCode,
      String judgeLevelCode,
      String hearingTypeCode,
      String hearingBandCode) {
    super(String.format(
        "Advocacy fee not found for schemeCode=%s, proceedingTypeCode=%s, judgeLevelCode=%s, hearingTypeCode=%s, hearingBandCode=%s",
        schemeCode, proceedingTypeCode, judgeLevelCode, hearingTypeCode, hearingBandCode));
  }
}

