package uk.gov.justice.laa.fee.scheme.mapper;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Component;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeBoltonItemEntity;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeRequestEntity;
import uk.gov.justice.laa.fee.scheme.model.AdvocacyFeeRequestDTO;
import uk.gov.justice.laa.fee.scheme.model.BoltonItemDTO;

/**
 * Mapper to convert AdvocacyFeeRequestDTO to AdvocacyFeeRequestEntity.
 */
@Component
public class AdvocacyFeeRequestMapper {

  /**
   * Maps the DTO to the entity.
   */
  public AdvocacyFeeRequestEntity toEntity(AdvocacyFeeRequestDTO dto) {
    AdvocacyFeeRequestEntity entity = new AdvocacyFeeRequestEntity();
    entity.setAspectOfWork(dto.getAspectOfWork());
    entity.setProceedingType(dto.getProceedingType());
    entity.setHearingDate(dto.getHearingDate());
    entity.setHearingType(dto.getHearingType());
    entity.setNumberOfInterimProceedings(dto.getNumberOfInterimProceedings());
    entity.setDurationBand(dto.getDurationBand());
    entity.setDays(dto.getDays());
    entity.setJudgeLevel(dto.getJudgeLevel());
    entity.setCourtDirected(dto.getCourtDirected());
    entity.setCalculatedFee(dto.getCalculatedFee());
    entity.setTotalInterimFee(dto.getTotalInterimFee());
    entity.setIsBoltonApplicable(dto.getIsBoltonApplicable());
    entity.setTotalBoltonFee(dto.getTotalBoltonFee());
    entity.setAttendedAdvocatesMeetings(dto.getAttendedAdvocatesMeetings());
    entity.setCertificationDate(dto.getCertificationDate());
    entity.setPflrsProceedingsType(dto.getPflrsProceedingsType());
    entity.setProviderLocation(dto.getProviderLocation());
    entity.setFeeType(dto.getFeeType());
    entity.setBillType(dto.getBillType());
    entity.setCourtType(dto.getCourtType());
    entity.setLevelOfWorkDone(dto.getLevelOfWorkDone());

    if (dto.getBoltonItems() != null) {
      List<AdvocacyFeeBoltonItemEntity> boltonEntities = new ArrayList<>();
      for (BoltonItemDTO item : dto.getBoltonItems()) {
        AdvocacyFeeBoltonItemEntity boltonEntity = new AdvocacyFeeBoltonItemEntity();
        boltonEntity.setBoltonType(item.getBoltonType());
        boltonEntity.setAmount(item.getAmount());
        boltonEntity.setAutoCalculated(item.getAutoCalculated());
        boltonEntity.setRequest(entity);
        boltonEntities.add(boltonEntity);
      }
      entity.setBoltonItems(boltonEntities);
    }

    return entity;
  }
}
