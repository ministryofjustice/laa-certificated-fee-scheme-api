package uk.gov.justice.laa.fee.scheme.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import lombok.Getter;
import lombok.Setter;

/**
 * The entity class for Advocacy fees.
 */

@Getter
@Setter
@Entity
@Table(name = "advocacy_fee", schema = "cert_fee_scheme")
public class AdvocacyFeeEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id", nullable = false)
  private Integer id;

  @NotNull
  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "scheme_id", nullable = false)
  private CertFeeSchemeEntity scheme;

  @NotNull
  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "proceeding_type_id", nullable = false)
  private ProceedingTypeEntity proceedingType;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "judge_level_id")
  private JudgeLevelEntity judgeLevel;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "hearing_type_id")
  private HearingTypeEntity hearingType;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "hearing_band_id")
  private HearingBandEntity hearingBand;

  @NotNull
  @Column(name = "amount", nullable = false, precision = 12, scale = 2)
  private BigDecimal amount;

}

