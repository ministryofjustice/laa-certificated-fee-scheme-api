package uk.gov.justice.laa.fee.scheme.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;


/**
 * The entity class for scheme type.
 */
@Getter
@Setter
@Entity
@Table(name = "scheme_type", schema = "cert_fee_scheme")
public class SchemeTypeEntity {
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

}

