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
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * The entity class for hearing band.
 */

@Getter
@Setter
@Entity
@Table(name = "hearing_band", schema = "cert_fee_scheme")
public class HearingBandEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id", nullable = false)
  private Integer id;

  @NotNull
  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "hearing_type_id", nullable = false)
  private HearingTypeEntity hearingType;

  @Size(max = 50)
  @Column(name = "band_code", length = 50)
  private String bandCode;

  @Column(name = "min_minutes")
  private Integer minMinutes;

  @Column(name = "max_minutes")
  private Integer maxMinutes;

  @Column(name = "description", length = Integer.MAX_VALUE)
  private String description;

  @Column(name = "band_order")
  private Integer bandOrder;

}

