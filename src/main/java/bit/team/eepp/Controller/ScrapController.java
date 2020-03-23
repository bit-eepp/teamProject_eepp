package bit.team.eepp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.team.eepp.Service.ScrapService;
import bit.team.eepp.VO.ScrapVO;

@RequestMapping("/scrap")
@Controller
public class ScrapController {
	@Autowired
	private ScrapService scrapService;

	@RequestMapping("/doBoardScrap")
	@ResponseBody
	public int doBoardScrap(ScrapVO scrapVO) {
		System.out.println("doBoardScrap() method");
		
		int haveScrap = scrapService.haveScrapActive(scrapVO);
		if(haveScrap != 0){
			// 스크랩 이력이 있을경우
			return 1;
		} else {
			scrapService.doBoardScrap(scrapVO);
			return 0;
		}
		
	}

	@RequestMapping("/doClassScrap")
	@ResponseBody
	public int doClassScrap(ScrapVO scrapVO) {
		System.out.println("doClassScrap() method");
		
		int haveScrap = scrapService.haveScrapActive(scrapVO);
		if(haveScrap != 0){
			// 스크랩 이력이 있을경우
			return 1;
		} else {
			scrapService.doClassScrap(scrapVO);
			return 0;
		}
		
	}
	
	@RequestMapping("/doEatingScrap")
	@ResponseBody
	public int doEatingScrap(ScrapVO scrapVO) {
		System.out.println("doEatingScrap() method");
		
		int haveScrap = scrapService.haveScrapActive(scrapVO);
		if(haveScrap != 0){
			// 스크랩 이력이 있을경우
			return 1;
		} else {
			scrapService.doEatingScrap(scrapVO);
			return 0;
		}
		
	}

}
