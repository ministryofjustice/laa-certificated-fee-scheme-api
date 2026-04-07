package uk.gov.justice.laa.fee.scheme.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeRequestEntity;

/*
 * To store advocacy fee request
 */
public interface AdvocacyFeeRequestRepository extends JpaRepository<AdvocacyFeeRequestEntity, Long> {
}

