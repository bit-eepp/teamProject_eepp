package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.ScrapMapper;
import bit.team.eepp.VO.ScrapVO;

@Service
public class ScrapService {
	@Autowired
	private ScrapMapper scrapMapper;

	public List<ScrapVO> myScrapListB(int user_id) {
		return scrapMapper.myScrapListB(user_id);
	}

	public void doBoardScrap(ScrapVO scrapVO) {
		scrapMapper.doBoardScrap(scrapVO);
	}

	public List<ScrapVO> myScrapListC(int user_id) {
		return scrapMapper.myScrapListC(user_id);
	}

	public void doClassScrap(ScrapVO scrapVO) {
		scrapMapper.doClassScrap(scrapVO);
	}

}
