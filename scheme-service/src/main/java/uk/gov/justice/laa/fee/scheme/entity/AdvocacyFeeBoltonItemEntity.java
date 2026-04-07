package uk.gov.justice.laa.fee.scheme.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import lombok.Getter;
import lombok.Setter;

/*
 * represents advocacy_fee_bolton_item table which stores the bolton items for advocacy fee request
 */
@Entity
@Table(name = "advocacy_fee_bolton_item")
@Getter
@Setter
public class AdvocacyFeeBoltonItemEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "request_id")
  private AdvocacyFeeRequestEntity request;

  private String boltonType;
  private BigDecimal amount;
  private Boolean autoCalculated;
}
