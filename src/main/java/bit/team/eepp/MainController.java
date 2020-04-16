package bit.team.eepp;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bit.team.eepp.Service.MainService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.EatingVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Inject
	UserService us;

	@Autowired
	private MainService mainService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpSession session) {
		logger.info("Access Main Page");

		ModelAndView mv = new ModelAndView();

		// 직무게시판 베스트 - 공지사항 2개
		List<BoardVO> boardNotice = mainService.getBoardNotice();

		// 직무게시판 베스트 - Hot글 3개
		List<BoardVO> boardHot = mainService.getBoardHot();

		// 직무게시판 베스트 - 최신글 5개(전체)
		List<BoardVO> boardListALL = mainService.getBoardListALL();

		// 직무게시판 베스트 - 최신글 8개(IT)
		List<BoardVO> boardListIT = mainService.getBoardListIT();

		// 직무게시판 베스트 - 최신글 8개(서비스)
		List<BoardVO> boardListService = mainService.getBoardListService();

		// 직무게시판 베스트 - 최신글 8개(금융)
		List<BoardVO> boardListFinance = mainService.getBoardListFinance();

		// 직무게시판 베스트 - 최신글 8개(디자인)
		List<BoardVO> boardListDesign = mainService.getBoardListDesign();

		// 직무게시판 베스트 - 최신글 8개(공무원)
		List<BoardVO> boardListOfficial = mainService.getBoardListOfficial();

		// 직무게시판 베스트 - 최신글 8개(기타)
		List<BoardVO> boardListEtc = mainService.getBoardListEtc();

		// 클래스강좌 베스트- 마감임박 4개
		List<ClassVO> classList = mainService.getClassList();

		// 오늘뭐먹지 베스트 - 평점 높은 4개
		List<EatingVO> eatStoreList = mainService.getEatStoreList();

		// 최신글 검사
		String isNew = null;
		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, -1);
		isNew = sdformat.format(cal.getTime());
		Timestamp newArticle = Timestamp.valueOf(isNew);

		mv.addObject("boardNotice", boardNotice);
		mv.addObject("boardHot", boardHot);
		mv.addObject("newArticle", newArticle);
		mv.addObject("boardListALL", boardListALL);
		mv.addObject("boardListIT", boardListIT);
		mv.addObject("boardListService", boardListService);
		mv.addObject("boardListFinance", boardListFinance);
		mv.addObject("boardListDesign", boardListDesign);
		mv.addObject("boardListOfficial", boardListOfficial);
		mv.addObject("boardListEtc", boardListEtc);
		mv.addObject("classList", classList);
		mv.addObject("eatStoreList", eatStoreList);

		mv.setViewName("main");

		return mv;
	}
	
	@RequestMapping("/aboutUs")
	public String aboutUs() {
		System.out.println("aboutUs() method");
		return "/aboutUs";
	}
	
	@RequestMapping("/popUp")
	public String popUp() {
		System.out.println("popUp() method");
		return "/popUp";
	}
	
}
