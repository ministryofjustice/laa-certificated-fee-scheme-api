package uk.gov.justice.laa.fee.scheme.mapper;

import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeEntity;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequest;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeResponse;

/**
 * Mapper to convert AdvocacyFeeEntity to AdvocacyFeeResponse.
 */
public final class AdvocacyFeeMapper {

  private AdvocacyFeeMapper() {
    // utility class
  }

  /**
   * Maps an {@link AdvocacyFeeEntity} and the original {@link AdvocacyFeeRequest}
   * to an {@link AdvocacyFeeResponse}.
   *
   * @param entity  the resolved advocacy fee entity
   * @param request the original lookup request
   * @return the populated response
   */
  public static AdvocacyFeeResponse toResponse(AdvocacyFeeEntity entity, AdvocacyFeeRequest request) {
    AdvocacyFeeResponse response = new AdvocacyFeeResponse();
    response.setAmount(entity.getAmount().doubleValue());
    response.setSchemeCode(request.getSchemeCode());
    response.setProceedingTypeCode(request.getProceedingTypeCode());
    response.setJudgeLevelCode(request.getJudgeLevelCode());
    response.setHearingTypeCode(request.getHearingTypeCode());
    response.setHearingBandCode(request.getHearingBandCode());
    return response;
  }
}
