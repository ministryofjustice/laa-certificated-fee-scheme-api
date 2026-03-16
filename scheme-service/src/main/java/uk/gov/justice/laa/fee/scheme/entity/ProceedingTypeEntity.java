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
 * The entity class for Proceeding Type.
 */

@Getter
@Setter
@Entity
@Table(name = "proceeding_type", schema = "cert_fee_scheme")
public class ProceedingTypeEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id", nullable = false)
  private Integer id;

  @Size(max = 50)
  @NotNull
  @Column(name = "code", nullable = false, length = 50)
  private String code;

  @NotNull
  @Column(name = "description", nullable = false, length = Integer.MAX_VALUE)
  private String description;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "scheme_type_id")
  private SchemeTypeEntity schemeType;

}

