package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.ScrapVO;

@Repository
public interface ScrapMapper {
	
	public abstract void doBoardScrap(@Param("scrapVO") ScrapVO scrapVO);
	
	public abstract void doClassScrap(@Param("scrapVO") ScrapVO scrapVO);

}
