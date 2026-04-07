package uk.gov.justice.laa.fee.scheme.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequest;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequestDTO;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeResponse;

public interface AdvocacyFeeApi {
    ResponseEntity<AdvocacyFeeResponse> getAdvocacyFee(AdvocacyFeeRequest advocacyFeeRequest);
    ResponseEntity<Void> createAdvocacyFeeRequest(@RequestBody AdvocacyFeeRequestDTO requestDTO);
}
