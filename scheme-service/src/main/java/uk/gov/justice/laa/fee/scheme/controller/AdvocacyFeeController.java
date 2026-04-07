package uk.gov.justice.laa.fee.scheme.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import uk.gov.justice.laa.fee.scheme.api.AdvocacyFeeApi;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequest;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequestDTO;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeResponse;
import uk.gov.justice.laa.fee.scheme.service.AdvocacyFeeService;
import uk.gov.justice.laa.fee.scheme.service.AdvocacyFeeRequestService;

/**
 * Controller for looking up advocacy fee amounts.
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping
public class AdvocacyFeeController implements AdvocacyFeeApi {

  private final AdvocacyFeeService advocacyFeeService;
  private final AdvocacyFeeRequestService advocacyFeeRequestService;

  @Override
  @PostMapping("/api/v1/advocacy-fee")
  public ResponseEntity<AdvocacyFeeResponse> getAdvocacyFee(@RequestBody AdvocacyFeeRequest advocacyFeeRequest) {

    log.info("Getting advocacy fee for schemeCode={}, proceedingTypeCode={}",
        advocacyFeeRequest.getSchemeCode(), advocacyFeeRequest.getProceedingTypeCode());

    AdvocacyFeeResponse response = advocacyFeeService.getAdvocacyFee(advocacyFeeRequest);

    log.info("Successfully retrieved advocacy fee amount={}", response.getAmount());

    return ResponseEntity.ok(response);
  }

  @Override
  @PostMapping("/api/v1/advocacy-fee-request")
  public ResponseEntity<Void> createAdvocacyFeeRequest(@RequestBody AdvocacyFeeRequestDTO requestDTO) {
    advocacyFeeRequestService.saveRequest(requestDTO);
    return ResponseEntity.ok().build();
  }
}
