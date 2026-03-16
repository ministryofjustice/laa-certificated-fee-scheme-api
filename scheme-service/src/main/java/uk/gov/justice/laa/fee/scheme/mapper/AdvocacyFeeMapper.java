package uk.gov.justice.laa.fee.scheme.mapper;

import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeEntity;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeResponse;

/**
 * Mapper to convert AdvocacyFeeEntity to AdvocacyFeeResponse.
 */
public class AdvocacyFeeMapper {

  private AdvocacyFeeMapper() {
    // utility class
  }

  /**
   * Maps an {@link AdvocacyFeeEntity} and the lookup parameters to an {@link AdvocacyFeeResponse}.
   *
   * @param entity             the resolved advocacy fee entity
   * @param schemeCode         the scheme code used in the lookup
   * @param proceedingTypeCode the proceeding type code used in the lookup
   * @param judgeLevelCode     the judge level code used in the lookup (may be null)
   * @param hearingTypeCode    the hearing type code used in the lookup (may be null)
   * @param hearingBandCode    the hearing band code used in the lookup (may be null)
   * @return the populated response
   */
  public static AdvocacyFeeResponse toResponse(
      AdvocacyFeeEntity entity,
      String schemeCode,
      String proceedingTypeCode,
      String judgeLevelCode,
      String hearingTypeCode,
      String hearingBandCode) {

    AdvocacyFeeResponse response = new AdvocacyFeeResponse();
    response.setAmount(entity.getAmount().doubleValue());
    response.setSchemeCode(schemeCode);
    response.setProceedingTypeCode(proceedingTypeCode);
    response.setJudgeLevelCode(judgeLevelCode);
    response.setHearingTypeCode(hearingTypeCode);
    response.setHearingBandCode(hearingBandCode);
    return response;
  }
}

