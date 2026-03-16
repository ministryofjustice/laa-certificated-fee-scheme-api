package uk.gov.justice.laa.fee.scheme.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import uk.gov.justice.laa.fee.scheme.entity.AdvocacyFeeEntity;

/**
 * Repository for advocacy fee lookups from the advocacy_fee table.
 */
@Repository
public interface AdvocacyFeeRepository extends JpaRepository<AdvocacyFeeEntity, Integer> {

  /**
   * Find an advocacy fee record by scheme code, proceeding type code,
   * and optional judge level, hearing type and hearing band codes.
   *
   * @param schemeCode         the scheme code (cert_fee_scheme.scheme_code)
   * @param proceedingTypeCode the proceeding type code (proceeding_type.code)
   * @param judgeLevelCode     the judge level code (judge_level.code), may be null
   * @param hearingTypeCode    the hearing type code (hearing_type.code), may be null
   * @param hearingBandCode    the hearing band code (hearing_band.band_code), may be null
   * @return matching AdvocacyFeeEntity if found
   */
  @Query("""
      SELECT af FROM AdvocacyFeeEntity af
      JOIN af.scheme s
      JOIN af.proceedingType pt
      LEFT JOIN af.judgeLevel jl
      LEFT JOIN af.hearingType ht
      LEFT JOIN af.hearingBand hb
      WHERE s.schemeCode = :schemeCode
        AND pt.code = :proceedingTypeCode
        AND (:judgeLevelCode IS NULL OR jl.code = :judgeLevelCode)
        AND (:hearingTypeCode IS NULL OR ht.code = :hearingTypeCode)
        AND (:hearingBandCode IS NULL OR hb.bandCode = :hearingBandCode)
      """)
  Optional<AdvocacyFeeEntity> findByLookupParams(
      @Param("schemeCode") String schemeCode,
      @Param("proceedingTypeCode") String proceedingTypeCode,
      @Param("judgeLevelCode") String judgeLevelCode,
      @Param("hearingTypeCode") String hearingTypeCode,
      @Param("hearingBandCode") String hearingBandCode
  );
}

