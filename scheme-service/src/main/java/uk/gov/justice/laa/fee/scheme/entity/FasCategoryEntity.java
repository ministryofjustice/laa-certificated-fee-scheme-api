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
 * The entity class for fas category.
 */
@Getter
@Setter
@Entity
@Table(name = "fas_category", schema = "cert_fee_scheme")
public class FasCategoryEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id", nullable = false)
  private Integer id;

  @Size(max = 50)
  @NotNull
  @Column(name = "category_code", nullable = false, length = 50)
  private String categoryCode;

  @Size(max = 255)
  @NotNull
  @Column(name = "category_name", nullable = false)
  private String categoryName;

}

