package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.ScrapVO;

@Repository
public interface ScrapMapper {
	public abstract List<ScrapVO> myScrapListB(@Param("user_id") int user_id);

	public abstract void doBoardScrap(@Param("scrapVO") ScrapVO scrapVO);
	
	public abstract List<ScrapVO> myScrapListC(@Param("user_id") int user_id);
	
	public abstract void doClassScrap(@Param("scrapVO") ScrapVO scrapVO);

}
