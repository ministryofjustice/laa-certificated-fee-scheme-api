package uk.gov.justice.laa.fee.scheme.exception;

/**
 * Exception thrown when no advocacy fee record is found for the supplied lookup parameters.
 */
public class AdvocacyFeeNotFoundException extends RuntimeException {

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

