package uk.gov.justice.laa.fee.scheme.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
public class AdvocacyFeeRequestDTO {
  private String aspectOfWork;
  private String proceedingType;
  private LocalDate hearingDate;
  private String hearingType;
  private String numberOfInterimProceedings;
  private List<Object> interimHearings; // Define a class if needed
  private String durationBand;
  private String days;
  private String judgeLevel;
  private String courtDirected;
  private BigDecimal calculatedFee;
  private List<Object> interimHearingFees; // Define a class if needed
  private BigDecimal totalInterimFee;
  private String isBoltonApplicable;
  private String boltonCategory;
  private List<BoltonItemDTO> boltonItems;
  private BigDecimal totalBoltonFee;
  private String attendedAdvocatesMeetings;
  private List<Object> advocatesMeetings; // Define a class if needed
  private LocalDate certificationDate;
  private String pflrsProceedingsType;
  private String providerLocation;
  private String feeType;
  private String billType;
  private String courtType;
  private String levelOfWorkDone;
}


