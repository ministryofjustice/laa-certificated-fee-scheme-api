package uk.gov.justice.laa.fee.scheme.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
/*
 * represents advocacy_fee_request table which stores the advocacy fee request details
 */
@Entity
@Table(name = "advocacy_fee_request")
@Getter
@Setter
public class AdvocacyFeeRequestEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String aspectOfWork;
  private String proceedingType;
  private LocalDate hearingDate;
  private String hearingType;
  private String numberOfInterimProceedings;
  private String durationBand;
  private String days;
  private String judgeLevel;
  private String courtDirected;
  private BigDecimal calculatedFee;
  private BigDecimal totalInterimFee;
  private String isBoltonApplicable;
  private BigDecimal totalBoltonFee;
  private String attendedAdvocatesMeetings;
  private LocalDate certificationDate;
  private String pflrsProceedingsType;
  private String providerLocation;
  private String feeType;
  private String billType;
  private String courtType;
  private String levelOfWorkDone;

  @OneToMany(mappedBy = "request", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<AdvocacyFeeBoltonItemEntity> boltonItems;
}
