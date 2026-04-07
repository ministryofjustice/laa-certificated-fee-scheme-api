package uk.gov.justice.laa.fee.scheme.model;

import java.math.BigDecimal;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoltonItemDTO {
  private Long id;
  private String boltonType;
  private BigDecimal amount;
  private Boolean autoCalculated;
}
