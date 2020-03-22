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
	public void doBoardScrap(ScrapVO scrapVO) {
		System.out.println("doBoardScrap() method");
		scrapService.doBoardScrap(scrapVO);
	}

	@RequestMapping("/doClassScrap")
	@ResponseBody
	public void doClassScrap(ScrapVO scrapVO) {
		System.out.println("doClassScrap() method");
		scrapService.doClassScrap(scrapVO);
	}

}
