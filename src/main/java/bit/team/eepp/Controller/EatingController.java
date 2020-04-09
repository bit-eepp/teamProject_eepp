package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bit.team.eepp.Page.EatingPageMaker;
import bit.team.eepp.Search.EatingSearchCriteria;
import bit.team.eepp.Service.EatingService;
import bit.team.eepp.VO.EatingVO;

@RequestMapping("/eating")
@Controller
public class EatingController {
	
	private static final Logger logger = LoggerFactory.getLogger(EatingController.class);
	
	@Autowired
	private EatingService eatingService;
	
	@RequestMapping("/eatingList")
	public String eatingList(Model model, @ModelAttribute("escri") EatingSearchCriteria escri, @RequestParam(value = "eThema", required = false, defaultValue = "") String eThema) {
		logger.info("eatingList method Active(");
		System.out.println("all store list print");
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(!(escri.getKeyword().equals(""))) {
			map.put("escri", escri);
		}else {
			map.put("eThema", eThema);
		}
		
		if(!(escri.getKeyword().equals(""))) {
			logger.info("eatingList를 보냅니다.");
			
			if(eatingService.eatingList(map).size() == 0) {
				logger.info("empty Search Result");
				model.addAttribute("emptyResult", "emptyResult");
			}else {
				logger.info("Search Result");
				model.addAttribute("eatingList", eatingService.eatingList(map));
			}
		}
		
		EatingPageMaker eatingPageMaker = new EatingPageMaker();
		eatingPageMaker.setCri(escri);
		eatingPageMaker.setTotalCount(eatingService.eatingListCount(map));
		model.addAttribute("eatingPageMaker", eatingPageMaker);
		model.addAttribute("ethema", eThema);
		
		return "/eating/eatingList";
	}
	
	@RequestMapping("/eatingView")
	public String eatingView(EatingVO eatingVO, Model model, @ModelAttribute("escri") EatingSearchCriteria escri) {
		
		System.out.println("store information print");
		
		model.addAttribute("eContentView", eatingService.selectOne(eatingVO));
		model.addAttribute("escri", escri);
		
		return "/eating/eatingView";
	}
	
	@RequestMapping("/themaList")
	public String themaList(EatingVO eatingVO, Model model, @ModelAttribute("escri") EatingSearchCriteria escri,@RequestParam(value = "eThema", required = false, defaultValue = "") String eThema) {
		
		System.out.println("thema list print");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("escri", escri);
		map.put("eThema", eThema);

		EatingPageMaker eatingPageMaker = new EatingPageMaker();
		eatingPageMaker.setCri(escri);
		eatingPageMaker.setTotalCount(eatingService.eatingListCount(map));

		model.addAttribute("themaList", eatingService.themaList(map));
		model.addAttribute("eatingPageMaker", eatingPageMaker);
		model.addAttribute("eThema", eThema);
		
		return "/eating/themaList";
	}
	
	@RequestMapping("/eatingDelete")
	public String eatingDelete(EatingVO eatingVO) {
		System.out.println("store information delete");
		
		return "redirect:/eating/eatingList";
	}
}
