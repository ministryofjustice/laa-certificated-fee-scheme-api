package uk.gov.justice.laa.fee.scheme.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeEntity;
import uk.gov.justice.laa.fee.scheme.exception.AdvocacyFeeNotFoundException;
import uk.gov.justice.laa.fee.scheme.mapper.AdvocacyFeeMapper;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequest;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeResponse;
import uk.gov.justice.laa.fee.scheme.repository.AdvocacyFeeRepository;

/**
 * Service for looking up advocacy fee amounts from the advocacy_fee table.
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class AdvocacyFeeService {

  private final AdvocacyFeeRepository advocacyFeeRepository;

  /**
   * Retrieves the advocacy fee amount for the given lookup parameters.
   *
   * @param request the advocacy fee lookup request containing schemeCode, proceedingTypeCode
   *                and optional judgeLevelCode, hearingTypeCode, hearingBandCode
   * @return {@link AdvocacyFeeResponse} containing the matched fee amount and echo of lookup params
   * @throws AdvocacyFeeNotFoundException if no matching record is found
   */
  public AdvocacyFeeResponse getAdvocacyFee(AdvocacyFeeRequest request) {

    log.info("Looking up advocacy fee: schemeCode={}, proceedingTypeCode={}, judgeLevelCode={}, hearingTypeCode={}, hearingBandCode={}",
        request.getSchemeCode(), request.getProceedingTypeCode(), request.getJudgeLevelCode(),
        request.getHearingTypeCode(), request.getHearingBandCode());

    AdvocacyFeeEntity entity = advocacyFeeRepository
        .findByLookupParams(
            request.getSchemeCode(),
            request.getProceedingTypeCode(),
            request.getJudgeLevelCode(),
            request.getHearingTypeCode(),
            request.getHearingBandCode())
        .orElseThrow(() -> new AdvocacyFeeNotFoundException(
            request.getSchemeCode(), request.getProceedingTypeCode(), request.getJudgeLevelCode(),
            request.getHearingTypeCode(), request.getHearingBandCode()));

    log.info("Found advocacy fee: id={}, amount={}", entity.getId(), entity.getAmount());

    return AdvocacyFeeMapper.toResponse(entity, request);
  }
}
