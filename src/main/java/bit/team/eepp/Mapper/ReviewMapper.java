package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import bit.team.eepp.Page.ReviewCriteria;
import bit.team.eepp.VO.ReviewVO;

@Repository
public interface ReviewMapper {
	
	public abstract int reviewCount(@Param("eating_id") int eating_id);

	public abstract List<ReviewVO> reviewList(@Param("rvCriteria") ReviewCriteria rvCriteria, @Param("eating_id") int eating_id);
	
	@Select("SELECT TRUNC(AVG(rv.rvScore), 1) FROM REVIEW rv, eating e where rv.eating_id = e.eid GROUP BY rv.eating_id")
	public float reviewAVG(ReviewVO reviewVO);

	public abstract void reviewWrite(@Param("reviewVO") ReviewVO reviewVO);

	public abstract void reviewModify(@Param("reviewVO") ReviewVO reviewVO);

	public abstract void reviewDelete(@Param("rvId") int rvId);
}
