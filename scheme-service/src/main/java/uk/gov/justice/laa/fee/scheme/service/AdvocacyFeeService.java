package uk.gov.justice.laa.fee.scheme.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeEntity;
import uk.gov.justice.laa.fee.scheme.exception.AdvocacyFeeNotFoundException;
import uk.gov.justice.laa.fee.scheme.mapper.AdvocacyFeeMapper;
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
   * @param schemeCode         the fee scheme code (e.g. FAS1)
   * @param proceedingTypeCode the proceeding type code (e.g. TRIAL)
   * @param judgeLevelCode     the judge level code, may be null (e.g. CJ)
   * @param hearingTypeCode    the hearing type code, may be null (e.g. CC)
   * @param hearingBandCode    the hearing band code, may be null (e.g. BAND_1)
   * @return {@link AdvocacyFeeResponse} containing the matched fee amount and echo of lookup params
   * @throws AdvocacyFeeNotFoundException if no matching record is found
   */
  public AdvocacyFeeResponse getAdvocacyFee(
      String schemeCode,
      String proceedingTypeCode,
      String judgeLevelCode,
      String hearingTypeCode,
      String hearingBandCode) {

    log.info("Looking up advocacy fee: schemeCode={}, proceedingTypeCode={}, judgeLevelCode={}, hearingTypeCode={}, hearingBandCode={}",
        schemeCode, proceedingTypeCode, judgeLevelCode, hearingTypeCode, hearingBandCode);

    AdvocacyFeeEntity entity = advocacyFeeRepository
        .findByLookupParams(schemeCode, proceedingTypeCode, judgeLevelCode, hearingTypeCode, hearingBandCode)
        .orElseThrow(() -> new AdvocacyFeeNotFoundException(
            schemeCode, proceedingTypeCode, judgeLevelCode, hearingTypeCode, hearingBandCode));

    log.info("Found advocacy fee: id={}, amount={}", entity.getId(), entity.getAmount());

    return AdvocacyFeeMapper.toResponse(entity, schemeCode, proceedingTypeCode, judgeLevelCode, hearingTypeCode, hearingBandCode);
  }
}

