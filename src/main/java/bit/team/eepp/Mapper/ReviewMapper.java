package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import bit.team.eepp.Page.ReviewCriteria;
import bit.team.eepp.VO.ReviewVO;

@Repository
public interface ReviewMapper {
	
	public abstract int reviewCount(@Param("eId") int eId);

	public abstract List<ReviewVO> reviewList(@Param("rvCriteria") ReviewCriteria rvCriteria,
			@Param("eId") int eId);
	
//	public abstract float reviewAVG(@Param("rvScore") float rvScore);
	
	@Select("SELECT TRUNC(AVG(rv.rvScore), 1) FROM REVIEW rv where rv.eid = #{eId} GROUP BY rv.eId")
	public float reviewAVG(ReviewVO reviewVO);

	public abstract void reviewWrite(@Param("reviewVO") ReviewVO reviewVO);

	public abstract void reviewModify(@Param("reviewVO") ReviewVO reviewVO);

	public abstract void reviewDelete(@Param("rvId") int rvId);

	//리리플1
	//public abstract void reviewShape(@Param("rpGroup") int rvGroup, @Param("rvStep") int rvStep);
	
	//리리플2
	//public abstract void reReplyWrite(@Param("replyVO") ReplyVO replyVO);

}
