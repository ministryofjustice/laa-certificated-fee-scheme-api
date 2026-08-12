package uk.gov.justice.laa.fee.scheme.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * MDC logging config for interceptor.
 */
@Configuration
@RequiredArgsConstructor
public class MdcLoggingConfig implements WebMvcConfigurer {


}
