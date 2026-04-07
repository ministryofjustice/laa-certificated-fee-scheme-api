package uk.gov.justice.laa.fee.scheme.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeRequestEntity;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequestDTO;
import uk.gov.justice.laa.fee.scheme.repository.AdvocacyFeeRequestRepository;
import uk.gov.justice.laa.fee.scheme.mapper.AdvocacyFeeRequestMapper;

@Service
public class AdvocacyFeeRequestService {
    @Autowired
    private AdvocacyFeeRequestRepository repository;
    @Autowired
    private AdvocacyFeeRequestMapper mapper;

    public AdvocacyFeeRequestEntity saveRequest(AdvocacyFeeRequestDTO dto) {
        AdvocacyFeeRequestEntity entity = mapper.toEntity(dto);
        return repository.save(entity);
    }
}

