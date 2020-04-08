package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bit.team.eepp.Service.EatingService;
import bit.team.eepp.VO.EatingVO;
import bit.team.eepp.Search.EatingSearchCriteria;
import bit.team.eepp.Page.EatingPageMaker;

@RequestMapping("/eating")
@Controller
public class EatingController {
	@Autowired
	private EatingService eatingService;
	
	@RequestMapping("/eatingList")
	public String eatingList(Model model, @ModelAttribute("escri") EatingSearchCriteria escri, @RequestParam(value = "sortType", required = false, defaultValue = "eDate") String sortType, @RequestParam(value = "eCategory", required = false, defaultValue = "") String eCategory,
			@RequestParam(value = "eThema", required = false, defaultValue = "") String eThema) {
		System.out.println("all store list print");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("escri", escri);
		map.put("sortType", sortType);
		map.put("eCategory", eCategory);
		map.put("eThema", eThema);

		EatingPageMaker eatingPageMaker = new EatingPageMaker();
		eatingPageMaker.setCri(escri);
		eatingPageMaker.setTotalCount(eatingService.eatingListCount(map));

		model.addAttribute("eatingList", eatingService.eatingList(map));
		model.addAttribute("eatingPageMaker", eatingPageMaker);
		model.addAttribute("sortType", sortType);
		model.addAttribute("eCategory", eCategory);
		model.addAttribute("eThema", eThema);
		
		return "/eating/eatingList";
	}
	
	@RequestMapping("/eatingView")
	public String eatingView(EatingVO eatingVO, Model model, @ModelAttribute("escri") EatingSearchCriteria escri,
			@RequestParam(value = "sortType", required = false, defaultValue = "eDate") String sortType, @RequestParam(value = "eCategory", required = false, defaultValue = "") String eCategory) {
		
		System.out.println("store information print");
		
		model.addAttribute("eContentView", eatingService.selectOne(eatingVO));
		model.addAttribute("escri", escri);
		model.addAttribute("sortType", sortType);
		model.addAttribute("eCategory", eCategory);
		
		return "/eating/eatingView";
	}
	
	@RequestMapping("/themaList")
	public String themaList(EatingVO eatingVO, Model model, @ModelAttribute("escri") EatingSearchCriteria escri,
			@RequestParam(value = "sortType", required = false, defaultValue = "eDate") String sortType, @RequestParam(value = "eCategory", required = false, defaultValue = "") String eCategory,
			@RequestParam(value = "eThema", required = false, defaultValue = "") String eThema) {
		
		System.out.println("thema list print");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("escri", escri);
		map.put("sortType", sortType);
		map.put("eCategory", eCategory);
		map.put("eThema", eThema);

		EatingPageMaker eatingPageMaker = new EatingPageMaker();
		eatingPageMaker.setCri(escri);
		eatingPageMaker.setTotalCount(eatingService.eatingListCount(map));

		model.addAttribute("themaList", eatingService.themaList(map));
		model.addAttribute("eatingPageMaker", eatingPageMaker);
		model.addAttribute("sortType", sortType);
		model.addAttribute("eCategory", eCategory);
		model.addAttribute("eThema", eThema);
		
		return "/eating/themaList";
	}
	
	@RequestMapping("/eatingDelete")
	public String eatingDelete(EatingVO eatingVO) {
		System.out.println("store information delete");
		
		return "redirect:/eating/eatingList";
	}
}
