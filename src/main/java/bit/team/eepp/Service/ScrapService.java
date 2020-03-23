package bit.team.eepp.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.ScrapMapper;
import bit.team.eepp.VO.ScrapVO;

@Service
public class ScrapService {
	@Autowired
	private ScrapMapper scrapMapper;

	public void doBoardScrap(ScrapVO scrapVO) {
		scrapMapper.doBoardScrap(scrapVO);
	}

	public void doClassScrap(ScrapVO scrapVO) {
		scrapMapper.doClassScrap(scrapVO);
	}
	
	public void doEatingScrap(ScrapVO scrapVO) {
		scrapMapper.doEatingScrap(scrapVO);
	}
	
	public int haveScrapActive(ScrapVO scrapVO) {
		return scrapMapper.haveScrapActive(scrapVO);
	}

}
