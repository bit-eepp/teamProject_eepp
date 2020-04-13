package bit.team.eepp.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bit.team.eepp.Page.BoardReportCriteria;
import bit.team.eepp.Page.BoardReportPageMaker;
import bit.team.eepp.Page.MemberPageMaker;
import bit.team.eepp.Page.NoticeCriteria;
import bit.team.eepp.Page.NoticePageMaker;
import bit.team.eepp.Page.ReplyReportCriteria;
import bit.team.eepp.Page.ReplyReportPageMaker;
import bit.team.eepp.Page.UserReportCriteria;
import bit.team.eepp.Page.UserReportPageMaker;
import bit.team.eepp.Page.myPagePageMaker;
import bit.team.eepp.Search.MemberSearchCriteria;
import bit.team.eepp.Search.MypageSearchCriteria;
import bit.team.eepp.Service.ClassService;
import bit.team.eepp.Service.FileService;
import bit.team.eepp.Service.ScrapService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.ScrapVO;
import bit.team.eepp.VO.UserVO;

@Controller
public class MypageController {

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Inject
	UserService us;
	@Inject
	BCryptPasswordEncoder pwEncoder;
	@Autowired
	FileService fs;
	@Autowired
	ScrapService sc;
	@Autowired
	ClassService classservice;

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	/*
	 * ------- mypage part -------
	 */
	@RequestMapping("/myContent")
	public String myContent(Model model, UserVO userVO, HttpSession session,
			@ModelAttribute("mscri") MypageSearchCriteria mscri) throws Exception {
		logger.info("page to myContent");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);
		userVO.setUser_id(user.getUser_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", userVO.getUser_id());
		map.put("mscri", mscri);
		map.put("scrapCount", us.ScrapCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));
		map.put("messageRes", us.receiveCount(map));
		map.put("messageSen", us.sendCount(map));
		map.put("listCount", us.listCount(map));
		map.put("reviewListCount", us.reviewListCount(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("joinClassCount", us.joinClassCount(map));
		map.put("scrapEatingCount", us.scrapEatingCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));

		// 게시글
		map.put("myBoardList", us.myBoardList(map));
		map.put("listCount", us.listCount(map));

		// 게시글
		myPagePageMaker myPagePageMaker = new myPagePageMaker();
		myPagePageMaker.setCri(mscri);
		myPagePageMaker.setTotalCount(us.listCount(map));

		model.addAttribute("mypage", map);
		model.addAttribute("mscri", mscri);
		model.addAttribute("myPagePageMaker", myPagePageMaker);

		return "user/myPage/myContent";
	}

	@RequestMapping("/myPoint")
	public String myPoint(Model model, UserVO userVO, HttpSession session,
			@ModelAttribute("mscri") MypageSearchCriteria mscri) throws Exception {
		logger.info("page to myContent");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);
		userVO.setUser_id(user.getUser_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", userVO.getUser_id());
		map.put("mscri", mscri);
		map.put("scrapCount", us.ScrapCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));
		map.put("messageRes", us.receiveCount(map));
		map.put("messageSen", us.sendCount(map));
		map.put("listCount", us.listCount(map));
		map.put("reviewListCount", us.reviewListCount(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("joinClassCount", us.joinClassCount(map));
		map.put("scrapEatingCount", us.scrapEatingCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));

		/// 포인트
		map.put("pointList", us.pointList(map));
		map.put("pointCount", us.pointCount(map));

		// 포인트 페이징
		myPagePageMaker myPagePageMaker = new myPagePageMaker();
		myPagePageMaker.setCri(mscri);
		myPagePageMaker.setTotalCount(us.pointCount(map));

		model.addAttribute("mypage", map);
		model.addAttribute("mscri", mscri);
		model.addAttribute("myPagePageMaker", myPagePageMaker);

		return "user/myPage/myPoint";
	}

	@RequestMapping("/myClass")
	public String class1(Model model, UserVO userVO, HttpSession session,
			@ModelAttribute("mscri") MypageSearchCriteria mscri,
			@RequestParam(value = "tabType", required = false, defaultValue = "") String tabType) throws Exception {
		logger.info("page to class");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);
		userVO.setUser_id(user.getUser_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", userVO.getUser_id());
		map.put("tabType", tabType);
		map.put("mscri", mscri);
		map.put("scrapCount", us.ScrapCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));
		map.put("messageRes", us.receiveCount(map));
		map.put("messageSen", us.sendCount(map));
		map.put("listCount", us.listCount(map));
		map.put("reviewListCount", us.reviewListCount(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("joinClassCount", us.joinClassCount(map));
		map.put("scrapEatingCount", us.scrapEatingCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));

		model.addAttribute("mypage", map);
		model.addAttribute("tabType", tabType);

		if (tabType.equals("myClassJoin")) {
			// 가입한 클래스
			map.put("joinClass", us.joinClass(map));
			map.put("joinClassCount", us.joinClassCount(map));
			// 가입한 클래스
			myPagePageMaker myPagePageMaker = new myPagePageMaker();
			myPagePageMaker.setCri(mscri);
			myPagePageMaker.setTotalCount(us.joinClassCount(map));
			model.addAttribute("myPagePageMaker", myPagePageMaker);

		} else if (tabType.equals("myClassOpen")) {
			// 개설한 클래스
			map.put("openClass", us.openClass(map));
			map.put("openClassCount", us.openClassCount(map));
			// 개설한 클래스
			myPagePageMaker myPagePageMaker = new myPagePageMaker();
			myPagePageMaker.setCri(mscri);
			myPagePageMaker.setTotalCount(us.openClassCount(map));
			model.addAttribute("myPagePageMaker", myPagePageMaker);
		}

		return "user/myPage/myClass";
	}

	@RequestMapping("/myScrap")
	public String myScrap(Model model, UserVO userVO, HttpSession session,
			@RequestParam(value = "tabType", required = false, defaultValue = "") String tabType,
			@ModelAttribute("mscri") MypageSearchCriteria mscri) throws Exception {
		logger.info("page to myScrap");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);
		userVO.setUser_id(user.getUser_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", userVO.getUser_id());
		map.put("mscri", mscri);
		map.put("tabType", tabType);
		map.put("scrapCount", us.ScrapCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));
		map.put("messageRes", us.receiveCount(map));
		map.put("messageSen", us.sendCount(map));
		map.put("listCount", us.listCount(map));
		map.put("reviewListCount", us.reviewListCount(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("joinClassCount", us.joinClassCount(map));
		map.put("scrapEatingCount", us.scrapEatingCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));

		// 게시판 스크랩
		if (tabType.equals("myScrapBoard")) {
			map.put("scrapCount", us.ScrapCount(map));
			map.put("scrapList", us.scrapList(map));

			myPagePageMaker myPagePageMaker = new myPagePageMaker();
			myPagePageMaker.setCri(mscri);
			myPagePageMaker.setTotalCount(us.ScrapCount(map));
			model.addAttribute("myPagePageMaker", myPagePageMaker);

			// 클래스 스크랩
		} else if (tabType.equals("myScrapClass")) {
			map.put("scrapClassCount", us.scrapClassCount(map));
			map.put("ClassscrapList", us.ClassscrapList(map));

			myPagePageMaker myPagePageMaker = new myPagePageMaker();
			myPagePageMaker.setCri(mscri);
			myPagePageMaker.setTotalCount(us.scrapClassCount(map));
			model.addAttribute("myPagePageMaker", myPagePageMaker);

			// 맛집 스크랩
		} else if (tabType.equals("myScrapEating")) {
			map.put("EatingScrapList", us.EatingScrapList(map));
			map.put("scrapEatingCount", us.scrapEatingCount(map));

			myPagePageMaker myPagePageMaker = new myPagePageMaker();
			myPagePageMaker.setCri(mscri);
			myPagePageMaker.setTotalCount(us.scrapEatingCount(map));
			model.addAttribute("myPagePageMaker", myPagePageMaker);
		}

		model.addAttribute("mypage", map);
		model.addAttribute("tabType", tabType);
		model.addAttribute("mscri", mscri);

		return "user/myPage/myScrap";
	}

	@RequestMapping("/myReview")
	public String myReview(Model model, UserVO userVO, HttpSession session,
			@ModelAttribute("mscri") MypageSearchCriteria mscri) throws Exception {
		logger.info("page to myReview");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);
		userVO.setUser_id(user.getUser_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", userVO.getUser_id());
		map.put("mscri", mscri);
		map.put("scrapCount", us.ScrapCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));
		map.put("messageRes", us.receiveCount(map));
		map.put("messageSen", us.sendCount(map));
		map.put("listCount", us.listCount(map));
		map.put("reviewListCount", us.reviewListCount(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("joinClassCount", us.joinClassCount(map));
		map.put("scrapEatingCount", us.scrapEatingCount(map));
		map.put("scrapClassCount", us.scrapClassCount(map));

		// 내가 쓴 리뷰
		map.put("reviewList", us.reviewList(map));
		map.put("reviewListCount", us.reviewListCount(map));

		// 리뷰 페이징
		myPagePageMaker myPagePageMaker = new myPagePageMaker();
		myPagePageMaker.setCri(mscri);
		myPagePageMaker.setTotalCount(us.reviewListCount(map));

		model.addAttribute("myPagePageMaker", myPagePageMaker);
		model.addAttribute("mscri", mscri);
		model.addAttribute("mypage", map);

		return "user/myPage/myReview";
	}

	@RequestMapping("/mypage")
	public String myInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserVO userVO,
			Model model) throws IOException {
		logger.info("mypage");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);

		if (loginSession == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인 해주세요'); location.href='/eepp/login/login.do';</script>");
			out.flush();

		} else {

			userVO.setUser_id(user.getUser_id());

			Map<String, Object> map = new HashMap<String, Object>();
			// 유저 아이디
			map.put("user_id", userVO.getUser_id());
			// 게시글
			map.put("listCount", us.listCount(map));
			// 메세지
			map.put("messageRes", us.receiveCount(map));
			map.put("messageSen", us.sendCount(map));
			// 포인트
			map.put("pointCount", us.pointCount(map));
			// 내가 쓴 리뷰
			map.put("reviewListCount", us.reviewListCount(map));
			// 가입한 클래스
			map.put("joinClassCount", us.joinClassCount(map));
			// 개설한 클래스
			map.put("openClassCount", us.openClassCount(map));
			// 스크랩 - 클래스
			map.put("scrapClassCount", us.scrapClassCount(map));
			// 스크랩 - 게시글
			map.put("scrapCount", us.ScrapCount(map));
			// 스크랩 - 맛집
			map.put("scrapEatingCount", us.scrapEatingCount(map));
			model.addAttribute("mypage", map);
		}
		return "user/myPage/myInfo";

	}

	// 관리자 페이지
	@RequestMapping(value = "/admin/adminPage")
	public String adminPage(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			UserVO userVO, Model model, @ModelAttribute("memcri") MemberSearchCriteria memcri, NoticeCriteria Ncri,
			UserReportCriteria ureportcri, BoardReportCriteria breportcri, ReplyReportCriteria rreportcri,
			ClassVO classVO, @ModelAttribute("mscri") MypageSearchCriteria mscri,
			@RequestParam(value = "tabType", required = false, defaultValue = "") String tabType,
			@RequestParam(value = "success", required = false, defaultValue = "") String success,
			
			@RequestParam(value = "sortType", required = false, defaultValue = "bWrittenDate") String sortType,
			@RequestParam(value = "bCategory", required = false, defaultValue = "") String bCategory)
			throws IOException {
		logger.info("my contents List");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		System.out.println("loginsession : " + loginSession);

		if (loginSession == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인 해주세요'); location.href='/eepp/login/login.do';</script>");
			out.flush();

		} else {

			userVO.setUser_id(user.getUser_id());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memcri", memcri);
			map.put("tabType", tabType);
			map.put("success", success);
			map.put("Ncri", Ncri);
			map.put("mscri", mscri);
			map.put("sortType", sortType);
			map.put("bCategory", bCategory);
			map.put("user_id", userVO.getUser_id());

			// 왼쪽
			map.put("messageRes", us.receiveCount(map));
			map.put("messageSen", us.sendCount(map));
			map.put("BListALL", us.BListALL(map));
			map.put("BListIT", us.BListIT(map));
			map.put("BListService", us.BListService(map));
			map.put("BListFinancial", us.BListFinancial(map));
			map.put("BListDesign", us.BListDesign(map));
			map.put("BListOfficer", us.BListOfficer(map));
			map.put("BListEtc", us.BListEtc(map));
			map.put("CListALL", us.CListALL(map));
			map.put("CListIt_dev", us.CListIt_dev(map));
			map.put("CListEtc", us.CListEtc(map));
			map.put("CListWorkSkill", us.CListWorkSkill(map));
			map.put("CListFinacialTech", us.CListFinacialTech(map));
			map.put("CListDaily", us.CListDaily(map));
			map.put("UserReportList", us.UserReportList(map));
			map.put("UserReportListCount", us.UserReportListCount(map));
			map.put("BoardReportList", us.BoardReportList(map));
			map.put("BoardReportListCount", us.BoardReportListCount(map));
			map.put("ReplyReportList", us.ReplyReportList(map));
			map.put("ReplyReportCount", us.ReplyReportListCount(map));

			// 오른쪽
			map.put("noticeList", us.noticeList(map));
			map.put("noticeListCount", us.noticeListCount(map));
			map.put("MemberList", us.MemberList(map));
			map.put("MemberListCount", us.MemberListCount(map));

			// 회원 목록
			MemberPageMaker MemberPageMaker = new MemberPageMaker();
			MemberPageMaker.setCri(memcri);
			MemberPageMaker.setTotalCount(us.MemberListCount(map));

			// 공지 사항
			NoticePageMaker NoticePageMaker = new NoticePageMaker();
			NoticePageMaker.setCri(Ncri);
			NoticePageMaker.setTotalCount(us.noticeListCount(map));

			if (tabType.equals("ReportUser") || tabType.equals("")) {
				
				map.put("UserReportList", us.UserReportList(map));
				map.put("UserReportListCount", us.UserReportListCount(map));

				// 유저신고
				myPagePageMaker myPagePageMaker = new myPagePageMaker();
				myPagePageMaker.setCri(mscri);
				myPagePageMaker.setTotalCount(us.UserReportListCount(map));
				model.addAttribute("myPagePageMaker", myPagePageMaker);

			} else if (tabType.equals("ReportContent")) {
				
				map.put("BoardReportList", us.BoardReportList(map));
				map.put("BoardReportListCount", us.BoardReportListCount(map));
				
				// 게시글 신고
				myPagePageMaker myPagePageMaker = new myPagePageMaker();
				myPagePageMaker.setCri(mscri);
				myPagePageMaker.setTotalCount(us.BoardReportListCount(map));
				model.addAttribute("myPagePageMaker", myPagePageMaker);

			} else if (tabType.equals("ReportReply")) {

				map.put("ReplyReportList", us.ReplyReportList(map));
				map.put("ReplyReportCount", us.ReplyReportListCount(map));
				
				// 댓글 신고
				myPagePageMaker myPagePageMaker = new myPagePageMaker();
				myPagePageMaker.setCri(mscri);
				myPagePageMaker.setTotalCount(us.ReplyReportListCount(map));
				model.addAttribute("myPagePageMaker", myPagePageMaker);
			}

			model.addAttribute("mscri", mscri);
			model.addAttribute("map", map);
			model.addAttribute("sortType", sortType);
			model.addAttribute("bCategory", bCategory);
			model.addAttribute("tabType", tabType);
			model.addAttribute("NoticePageMaker", NoticePageMaker);
			model.addAttribute("MemberPageMaker", MemberPageMaker);
			model.addAttribute("success", success);

		}
		return "admin/adminPage";

	}

	@RequestMapping("/profileUpdate")
	public String mypage(Model model) throws Exception {
		logger.info("head to mypage");
		return "user/myPage/newlymypage";
	}

	// 마이페이지 프로필 업데이트
	@RequestMapping(value = ("/profileUpdate"), method = RequestMethod.POST)
	public String postGoodsRegister(BoardVO boardvo, ScrapVO scrapvo, HttpSession session, UserVO userVO,
			MultipartFile file, Model model) throws Exception {
		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		userVO.setUser_id(user.getUser_id());

		// 프로필 업로드
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			userVO.setUprofile(ymdPath + File.separator + fileName);
		} else {
			if (user.getuEmail().equals("bit.eepp@gmail.com")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "admin.jpg";
				userVO.setUprofile(fileName);
			} else {
				fileName = "/eepp" + File.separator + "img" + File.separator + "headerLogin.png";
				userVO.setUprofile(fileName);
			}
		}
		System.out.println("=================");
		System.out.println("img = " + userVO.getUprofile());
		System.out.println("=================");

		// 프로필 업데이트한 부분 세션 다시 받아오기
		user.setUprofile(userVO.getUprofile());
		session.setAttribute("loginUser", user);

		fs.profileUpdate(userVO);

		return "redirect:/mypage";
	}

	// 닉네임 중복 체크
	@ResponseBody
	@RequestMapping(value = "mypagenickNameCheck", method = { RequestMethod.GET, RequestMethod.POST })
	public int mypagenickNameCheck(UserVO userVO, HttpServletRequest request) throws IOException {

		int result = us.mypagenickNameCheck(userVO);

		if (result != 0) {
			logger.info("DB에 등록되어있는 닉네임.");
			return 1;
		} else {
			logger.info("DB에 등록되지않은 닉네임.");
			return 0;
		}
	}

	// 닉네임 업데이트
	@RequestMapping("updateNickName")
	public void updateNickName(HttpServletRequest request, Model model, HttpSession session, UserVO userVO,
			HttpServletResponse response) throws IOException {

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		userVO.setUser_id(user.getUser_id());

		us.myNickNameUpdate(userVO);

		// nickname 업데이트한 부분 세션 다시 받아오기
		user.setuNickname(userVO.getuNickname());
		session.setAttribute("loginUser", user);

		System.out.println("=================");
		System.out.println("업데이트 된 닉네임 = " + userVO.getuNickname());
		System.out.println("=================");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('닉네임 변경 완료!!'); location.href='/eepp/mypage' ;</script>");
		out.close();
		;
	}

	// 회원 탈퇴 get
	@RequestMapping(value = "/withdrawal", method = RequestMethod.GET)
	public String getWithdrawal() throws Exception {
		logger.info("get withdrawal");

		return "user/myPage/withdrawal";
	}

	// 회원 탈퇴 post
	@RequestMapping(value = "/withdrawal", method = RequestMethod.POST)
	public String postWithdrawal(HttpSession session, UserVO userVO, RedirectAttributes rttr) throws Exception {
		logger.info("post withdrawal");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		userVO.setUser_id(user.getUser_id());
		userVO.setSnsType(user.getSnsType());

		if (user.getSnsType() == null) {
			// 일반 로그인 회원 탈퇴 방법
			String oldPass = user.getuPassword();
			String newPass = userVO.getuPassword();

			boolean checkPW = pwEncoder.matches(newPass, oldPass);

			if (checkPW == true) {

				us.withdrawal(userVO);
				System.out.println("회원탈퇴완료");
				session.invalidate();
				return "redirect:/";

			} else {
				rttr.addFlashAttribute("msg", false);
				return "redirect:/withdrawal";
			}
		} else {
			// SNS 로그인 회원 탈퇴 방법
			String oldEmail = user.getuEmail();
			String newEmail = userVO.getuEmail();

			String oldNickname = user.getuNickname();
			String newNickname = userVO.getuNickname();

			if ((!(oldEmail.equals(newEmail)) && (!(oldNickname.equals(newNickname))))) {
				rttr.addFlashAttribute("msg", false);

				return "redirect:/withdrawal";
			}

			us.withdrawal(userVO);
			session.invalidate();

			return "redirect:/";
		}
	}

	/* 회원정보 보기 */
	@RequestMapping(value = "/memInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public String memberInfo(Model model, HttpSession session, UserVO userVO, HttpServletRequest request,
			@RequestParam(value = "memberWho", required = false, defaultValue = "") String memberWho) {

		logger.info("load member Info pop-up");
		userVO.getUser_id();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("memberWho", memberWho);
		map.put("user_id", userVO.getUser_id());
		map.put("listCount", us.listCount(map));
		map.put("memgrade", us.memberInfograde(map));
		map.put("mInfoProfile", us.mInfoProfile(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("memberInfoJDate", us.memberInfoJDate(map));

		model.addAttribute("member", map);

		System.out.println("User_id : " + userVO.getUser_id());
		System.out.println("nickName : " + memberWho);

		return "user/memInfo/memberInfo";

	}

	/* 클래스 가입회원 */
	@RequestMapping(value = "/classjoin_list", method = { RequestMethod.GET, RequestMethod.POST })
	public String classjoin_list(Model model, ClassVO classVO, HttpSession session, UserVO userVO,
			HttpServletRequest request, @RequestParam(value = "cId", required = false, defaultValue = "") String cId) {

		logger.info("load classjoin_list pop-up");
		userVO.getUser_id();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cId", classVO.getcId());
		map.put("cId", cId);
		map.put("classjoinlist", us.classjoinList(map));

		model.addAttribute("member", map);
		model.addAttribute("classjoinlist", us.classjoinList(map));
		model.addAttribute("classList", classservice.classView(classVO));

		return "user/memInfo/classjoin_list";

	}

	// 스크랩 삭제
	@RequestMapping(value = "/deleteScrap", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteScrap(Model model, UserVO userVO, ScrapVO scrapVO, HttpSession session,
			HttpServletRequest request) {

		logger.info("delectScrap Method Active");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		userVO.setUser_id(user.getUser_id());

		if (request.getParameter("checkRow") != null) {
			String[] checkIdx = request.getParameter("checkRow").toString().split(",");
			for (int i = 0; i < checkIdx.length; i++) {
				System.out.println("sId는 : " + Integer.parseInt(checkIdx[i]));
				scrapVO.setsId(Integer.parseInt(checkIdx[i]));
				scrapVO.setUser_id(user.getUser_id());
				us.deleteScrap(scrapVO);

				logger.info("스크랩 선택 삭제 완료");
			}
		} else {
			us.deleteScrap(scrapVO);
			logger.info("스크랩 삭제 완료");
		}
		return "redirect:/mypage";
	}

	// 등급 변경
	@RequestMapping(value = "/changeGrade", method = { RequestMethod.GET, RequestMethod.POST })
	public String changeGrade(Model model, UserVO userVO, HttpServletRequest request) {

		logger.info("changeGrade Method Active");

		if (request.getParameter("checkRow") != null) {
			String[] checkIdx = request.getParameter("checkRow").toString().split(",");

			for (int i = 0; i < checkIdx.length; i++) {
				System.out.println("유저는 : " + Integer.parseInt(checkIdx[i]));
				userVO.setUser_id(Integer.parseInt(checkIdx[i]));

				String selectgrade = request.getParameter("selectgrade");
				userVO.setGrade_Id(Integer.parseInt(selectgrade));

				System.out.println("등급" + userVO.getGrade_Id());
				us.UpdateGrade(userVO);
				logger.info("선택 업데이트 완료");
			}
		}

		return "redirect:/";
	}

}