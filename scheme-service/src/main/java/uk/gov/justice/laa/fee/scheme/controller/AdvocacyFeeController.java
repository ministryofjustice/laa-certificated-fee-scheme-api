package uk.gov.justice.laa.fee.scheme.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import uk.gov.justice.laa.fee.scheme.api.AdvocacyFeeApi;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeResponse;
import uk.gov.justice.laa.fee.scheme.service.AdvocacyFeeService;

/**
 * Controller for looking up advocacy fee amounts.
 */
@Slf4j
@RestController
@RequiredArgsConstructor
public class AdvocacyFeeController implements AdvocacyFeeApi {

  private final AdvocacyFeeService advocacyFeeService;

  @Override
  public ResponseEntity<AdvocacyFeeResponse> getAdvocacyFee(
      String schemeCode,
      String proceedingTypeCode,
      String judgeLevelCode,
      String hearingTypeCode,
      String hearingBandCode) {

    log.info("Getting advocacy fee for schemeCode={}, proceedingTypeCode={}", schemeCode, proceedingTypeCode);

    AdvocacyFeeResponse response = advocacyFeeService.getAdvocacyFee(
        schemeCode, proceedingTypeCode, judgeLevelCode, hearingTypeCode, hearingBandCode);

    log.info("Successfully retrieved advocacy fee amount={}", response.getAmount());

    return ResponseEntity.ok(response);
  }
}

