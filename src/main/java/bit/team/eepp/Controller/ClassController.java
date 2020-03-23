package bit.team.eepp.Controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import bit.team.eepp.Page.ClassPageMaker;
import bit.team.eepp.Search.ClassSearchCriteria;
import bit.team.eepp.Service.ClassService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.PaymentVO;

@RequestMapping("/class")
@Controller
public class ClassController {

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Autowired
	private ClassService classService;

	@Autowired
	private UserService us;

	@RequestMapping("/classList")
	public String classList(Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory", required = false, defaultValue = "") String cCategory) {
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
	public String classOpenView(Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory") String cCategory) {
		System.out.println("classOpenView() method");
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/classOpenView";
	}

	@RequestMapping("/classOpen")
	public String classOpen(ClassVO classVO, Model model, MultipartFile file,
			@ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory)
			throws Exception {
		System.out.println("classOpen() method");

		if (classVO.getcMaterials().equals("")) {
			classVO.setcMaterials("없음");
		}

		// 클래스 썸네일 파일경로
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			classVO.setcThumnail(ymdPath + File.separator + fileName);

		} else {
			if (classVO.getcCategory().equals("it_dev")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "it_dev.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("workSkill")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "workSkill.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("daily")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "daily.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("financialTechnology")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "financialTechnology.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("etc")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "etc.jpg";
				classVO.setcThumnail(fileName);
			}
		}

		System.out.println("썸네일 저장경로: " + classVO.getcThumnail());
		// 클래스 썸네일 파일경로 끝

		classService.classOpen(classVO);
		return "redirect:/class/classView?cId=" + classVO.getcId() + "&page=" + cscri.getPage() + "&perPageNum="
				+ cscri.getPerPageNum() + "&cCategory=" + cCategory;

	}

	@RequestMapping("/classView")
	public String classView(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory") String cCategory) {
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
	public String classModifyView(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory") String cCategory) {
		System.out.println("/classModifyView() method");
		model.addAttribute("modifyClass", classService.classModifyView(classVO));
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/classModify_view";
	}

	@RequestMapping("/modifyClass")
	public String modifyClass(ClassVO classVO, Model model, MultipartFile file,
			@ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory)
			throws Exception {
		System.out.println("/modifyClass() method");

		if (classVO.getcMaterials().equals("")) {
			classVO.setcMaterials("없음");
		}

		// 클래스 썸네일 파일경로
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			classVO.setcThumnail(ymdPath + File.separator + fileName);
		} else {
			fileName = classService.getFilePath(classVO.getcId());
			classVO.setcThumnail(fileName);
		}

		System.out.println("썸네일 저장경로: " + classVO.getcThumnail());
		// 클래스 썸네일 파일경로 끝

		classService.modifyClass(classVO);
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "redirect:/class/classView?cId=" + classVO.getcId() + "&page=" + cscri.getPage() + "&perPageNum="
				+ cscri.getPerPageNum();
	}

	@RequestMapping("/getUserIdList")
	@ResponseBody
	public List<ClassJoinVO> getUserIdList(ClassJoinVO classJoinVO) {
		return classService.getUserIdList(classJoinVO.getClass_id());
	}

	@RequestMapping("/getCurrentUserCount")
	@ResponseBody
	public int getCurrentUserCount(ClassJoinVO classJoinVO) {
		return classService.getCurrentUserCount(classJoinVO.getClass_id());
	}

	@RequestMapping("/classJoin")
	@ResponseBody
	public void classJoin(PaymentVO paymentVO, ClassJoinVO classJoinVO,
			@RequestParam(value = "opennerUser_id") int opennerUser_id,
			@RequestParam(value = "classPrice") int classPrice) {
		System.out.println("내 user_id : " + classJoinVO.getUser_id());
		System.out.println("class_id : " + classJoinVO.getClass_id());
		System.out.println("개설자 user_id : " + opennerUser_id);
		System.out.println("클래스 가격 : " + classPrice);

		// 개설된 클래스에 신청한 유저 추가
		classService.classJoin(classJoinVO);

		// 개설자의 users 테이블에서 총 포인트 금액 update(+)
		us.updateOpennerPoint(opennerUser_id, classPrice);

		// payment 테이블에 추가 : 개설자
		int opennerTotalPoint = us.getTotalPoint(opennerUser_id); // 업데이트된 클래스 개설자의 총 포인트 금액
		paymentVO.setTotalPoint(opennerTotalPoint);
		paymentVO.setClass_id(classJoinVO.getClass_id());
		paymentVO.setUser_id(opennerUser_id);
		paymentVO.setPoint_io(classPrice);

		us.opennerPayment(paymentVO);

		// 신청자의 users 테이블에서 총 포인트 금액 update(-)
		us.updateParticipantPoint(classJoinVO.getUser_id(), classPrice);

		// payment 테이블에 추가 : 참가자
		int participantTotalPoint = us.getTotalPoint(classJoinVO.getUser_id()); // 업데이트된 클래스 참가자의 총 포인트 금액
		paymentVO.setTotalPoint(participantTotalPoint);
		paymentVO.setClass_id(classJoinVO.getClass_id());
		paymentVO.setUser_id(classJoinVO.getUser_id());
		paymentVO.setPoint_io(classPrice);

		us.participantPayment(paymentVO);

	}

}
