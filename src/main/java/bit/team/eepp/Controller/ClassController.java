package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.team.eepp.Page.ClassPageMaker;
import bit.team.eepp.Search.ClassSearchCriteria;
import bit.team.eepp.Service.ClassService;
import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;

@RequestMapping("/class")
@Controller
public class ClassController {

	@Autowired
	private ClassService classService;

	@RequestMapping("/classList")
	public String classList(Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory", required = false, defaultValue = "") String cCategory) {
		System.out.println("classList() method");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cscri", cscri);
		map.put("cCategory", cCategory);

		ClassPageMaker classPageMaker = new ClassPageMaker();
		classPageMaker.setCri(cscri);
		classPageMaker.setTotalCount(classService.classListCount(map));

		model.addAttribute("classList", classService.classList(map));
		model.addAttribute("classPageMaker", classPageMaker);
		model.addAttribute("cCategory", cCategory);
		return "/class/classList";
	}

	@RequestMapping("/classOpenView")
	public String classOpenView(Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory) {
		System.out.println("classOpenView() method");
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/classOpenView";
	}

	@RequestMapping("/classOpen")
	public String classOpen(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory) {
		System.out.println("classOpen() method");
		classService.classOpen(classVO);
		return "redirect:/class/classView?cId=" + classVO.getcId() + "&page=" + cscri.getPage() + "&perPageNum="
				+ cscri.getPerPageNum() + "&cCategory=" + cCategory;
	}

	@RequestMapping("/classView")
	public String classView(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory) {
		System.out.println("classView() method");
		model.addAttribute("clView", classService.classView(classVO));
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/class_view";
	}

	@RequestMapping("/deleteClass")
	public String deleteClass(ClassVO classVO) {
		System.out.println("/deleteClass() method");
		classService.deleteClass(classVO);
		return "redirect:/class/classList";
	}

	@RequestMapping("/classModifyView")
	public String classModifyView(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory) {
		System.out.println("/classModifyView() method");
		model.addAttribute("modifyClass", classService.classModifyView(classVO));
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/classModify_view";
	}
	
	@RequestMapping("/modifyClass")
	public String modifyClass(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory) {
		System.out.println("/modifyClass() method");
		classService.modifyClass(classVO);
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "redirect:/class/classView?cId=" + classVO.getcId() + "&page=" + cscri.getPage() + "&perPageNum=" + cscri.getPerPageNum();
	}
	
	@RequestMapping("/classJoin")
	@ResponseBody
	public void classJoin(ClassJoinVO classJoinVO) {
		classService.classJoin(classJoinVO);
	}
	

}
