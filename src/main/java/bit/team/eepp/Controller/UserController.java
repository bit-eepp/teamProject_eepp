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

import bit.team.eepp.Page.JoinClassCriteria;
import bit.team.eepp.Page.JoinClassPageMaker;
import bit.team.eepp.Page.MessageCriteria;
import bit.team.eepp.Page.MessagePageMaker;
import bit.team.eepp.Page.OpenClassCriteria;
import bit.team.eepp.Page.OpenClassPageMaker;
import bit.team.eepp.Page.PointCriteria;
import bit.team.eepp.Page.PointPageMaker;
import bit.team.eepp.Page.ScrapClassCriteria;
import bit.team.eepp.Page.ScrapClassPageMaker;
import bit.team.eepp.Page.ScrapPageMaker;
import bit.team.eepp.Page.ScrapboardCriteria;
import bit.team.eepp.Page.ScrapboardPageMaker;
import bit.team.eepp.Page.myPagePageMaker;
import bit.team.eepp.Search.MypageSearchCriteria;
import bit.team.eepp.Search.ScrapSearchCriteria;
import bit.team.eepp.Service.ClassService;
import bit.team.eepp.Service.FileService;
import bit.team.eepp.Service.ScrapService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.DeclarationVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.PaymentVO;
import bit.team.eepp.VO.ScrapVO;
import bit.team.eepp.VO.UserVO;

@Controller
public class UserController {

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

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	/*
	 * ------- mypage part -------
	 */

	@RequestMapping("/profileUpdate")
	public String mypage(Model model) throws Exception {
		logger.info("head to mypage");
		return "user/myPage/myPage";
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

	@RequestMapping("/mypage")
	public String mypageList(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			UserVO userVO, Model model, @ModelAttribute("mscri") MypageSearchCriteria mscri, JoinClassCriteria joclcri, OpenClassCriteria opclcri,
			@ModelAttribute("scrapcri") ScrapboardCriteria scrapcri, ScrapClassCriteria scrapclasscri, PointCriteria poCri,
			@RequestParam(value = "sortType", required = false, defaultValue = "bWrittenDate") String sortType,
			@RequestParam(value = "bCategory", required = false, defaultValue = "") String bCategory,
			@RequestParam(value = "board", required = false, defaultValue = "") String board,
			@RequestParam(value = "mpPoint", required = false, defaultValue = "") String mpPoint,
//			@RequestParam(value = "mpInfo", required = false, defaultValue = "") String mpInfo,
			@RequestParam(value = "scrap", required = false, defaultValue = "") String scrap,
			@RequestParam(value = "mpclass", required = false, defaultValue = "") String mpclass) throws IOException {
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
			map.put("scrapcri", scrapcri);
			map.put("mscri", mscri);
			map.put("sortType", sortType);
			map.put("bCategory", bCategory);
			map.put("user_id", userVO.getUser_id());
			map.put("listCount", us.listCount(map));
			map.put("replyCount", us.replyCount(map));
			map.put("messageRes", us.receiveCount(map));
			map.put("messageSen", us.sendCount(map));
			map.put("pointList", us.pointList(map));
			map.put("poCri", poCri);
			map.put("scrapclasscri", scrapclasscri);
			map.put("joclcri",joclcri);
			map.put("opclcri", opclcri);
			
			//개설한 클래스
			OpenClassPageMaker OpenClassPageMaker = new OpenClassPageMaker();
			OpenClassPageMaker.setCri(opclcri);
			OpenClassPageMaker.setTotalCount(us.openClassCount(map));
			
			//가입한 클래스
			JoinClassPageMaker JoinClassPageMaker = new JoinClassPageMaker();
			JoinClassPageMaker.setCri(joclcri);
			JoinClassPageMaker.setTotalCount(us.joinClassCount(map));
			
			// 포인트
			PointPageMaker pointpageMaker = new PointPageMaker();
			int poTotal = us.pointCount(map);
			pointpageMaker.setCri(poCri);
			pointpageMaker.setTotalCount(poTotal);
			
			// 게시글 스크랩
			myPagePageMaker myPagePageMaker = new myPagePageMaker();
			myPagePageMaker.setCri(mscri);
			myPagePageMaker.setTotalCount(us.listCount(map));
			
			// 게시판 스크랩
			ScrapboardPageMaker ScrapboardPageMaker = new ScrapboardPageMaker();
			ScrapboardPageMaker.setCri(scrapcri);
			ScrapboardPageMaker.setTotalCount(us.scrapBoardCount(map));
			
			// 클래스 스크랩
			ScrapClassPageMaker ScrapClassPageMaker = new ScrapClassPageMaker();
			ScrapClassPageMaker.setCri(scrapclasscri);
			ScrapClassPageMaker.setTotalCount(us.scrapClassCount(map));
			

			if (board != null) {
				model.addAttribute("board", board);
			}
			if (scrap != null) {
				model.addAttribute("scrap", scrap);
			}
			if (mpPoint != null) {
				model.addAttribute("mpPoint", mpPoint);
			}
//			if (mpInfo != null) {
//				model.addAttribute("mpInfo", mpInfo);
//			}
			model.addAttribute("joinClass", us.joinClass(map));
			model.addAttribute("openClass", us.openClass(map));
			model.addAttribute("joinClassCount", us.joinClassCount(map));
			model.addAttribute("openClassCount", us.openClassCount(map));
			model.addAttribute("ClassscrapList", us.ClassscrapList(map));
			model.addAttribute("pointList", us.pointList(map));
			model.addAttribute("messageRes", us.receiveCount(map));
			model.addAttribute("messageSen", us.sendCount(map));
			model.addAttribute("scrapList", us.scrapList(map));
			model.addAttribute("scrapCount", us.scrapBoardCount(map));
			model.addAttribute("replyCount", us.replyCount(map));
			model.addAttribute("listCount", us.listCount(map));
			model.addAttribute("myBoardList", us.myBoardList(map));
			model.addAttribute("myPagePageMaker", myPagePageMaker);
			model.addAttribute("ScrapboardPageMaker", ScrapboardPageMaker);
			model.addAttribute("ScrapClassPageMaker", ScrapClassPageMaker);
			model.addAttribute("pointpageMaker", pointpageMaker);
			model.addAttribute("JoinClassPageMaker", JoinClassPageMaker);
			model.addAttribute("OpenClassPageMaker", OpenClassPageMaker);
			model.addAttribute("sortType", sortType);
			model.addAttribute("bCategory", bCategory);
		}
		return "user/myPage/newlymypage";

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
	
	/* 회원정보 보기*/
	@RequestMapping(value="/memInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public String memberInfo(Model model, HttpSession session, UserVO userVO,HttpServletRequest request,
			@RequestParam(value = "memberWho", required = false, defaultValue = "") String memberWho) {
		
		logger.info("load member Info pop-up");
		userVO.getUser_id();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("memberWho", memberWho);
		map.put("user_id", userVO.getUser_id());
		map.put("listCount", us.listCount(map));
		map.put("memgrade",us.memberInfograde(map));
		map.put("mInfoProfile", us.mInfoProfile(map));
		map.put("openClassCount", us.openClassCount(map));
		map.put("memberInfoJDate", us.memberInfoJDate(map));
		
		model.addAttribute("member",map);;
		
		System.out.println("User_id : " + userVO.getUser_id());
		System.out.println("nickName : " + memberWho);
		
		return "user/memInfo/memberInfo";
		
	}
	
	/* 클래스 가입회원 */
	@RequestMapping(value = "/classjoin_list", method = { RequestMethod.GET, RequestMethod.POST })
	public String classjoin_list(Model model, ClassVO classVO,HttpSession session, UserVO userVO, HttpServletRequest request,
			@RequestParam(value = "cId", required = false, defaultValue = "") String cId) {

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

	/*
	 * ------- point part -------
	 */

	/* 포인트 충전 */
	@RequestMapping("/chargePoint")
	public String chargePoint(UserVO userVO) {
		logger.info("charge method Active");
		return "user/payment/chargePoint";
	}

	@ResponseBody
	@RequestMapping("/changeToPoint")
	public void changeToPoint(UserVO userVO, PaymentVO paymentVO, HttpSession session) {

		us.chargePoint(userVO); // USERS table에 POINT 컬럼 update : point = point + 충전금액

		paymentVO.setPoint_io(userVO.getPoint()); // payment table : point_io()(충전금액)

		int totalPoint = us.getTotalPoint(userVO.getUser_id());
		paymentVO.setTotalPoint(totalPoint);

		us.addPointPayment(paymentVO);
		System.out.println("포인트 충전 + 충전 내역 추가 완료");
	}

	/*
	 * ------- message part -------
	 */

	/* 쪽지 */
	@RequestMapping(value = "/message", method = { RequestMethod.GET, RequestMethod.POST })
	public String message(MessageCriteria msgCri, Model model, HttpSession session, MessageVO messageVO,
			@RequestParam(value = "messageType", required = false, defaultValue = "") String messageType) {
		logger.info("Message Method Active");

		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("messageType", messageType);
		map.put("user_id", user.getUser_id());

		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("msgCri", msgCri);
		map2.put("messageType", messageType);
		map2.put("user_id", user.getUser_id());

		MessagePageMaker pageMaker = new MessagePageMaker();
		int total = us.messageListCount(map);
		pageMaker.setCri(msgCri);
		pageMaker.setTotalCount(total);

		model.addAttribute("messageList", us.messageList(map2));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("messageType", messageType);

		return "user/message/message";
	}

	@RequestMapping(value = "/message/messageView", method = { RequestMethod.GET, RequestMethod.POST })
	public String messageView(Model model, MessageVO messageVO, DeclarationVO declarationVO, HttpServletRequest request,
			@RequestParam(value = "messageType", required = false, defaultValue = "") String messageType) {
		logger.info("MessageView Method Active");

		if (request.getParameter("sender_id") != null) {
			model.addAttribute("receiveMsg", us.showMyReceiveMessage(messageVO));
			// 받은쪽지 클릭했을경우, 확인상태 변경
			us.changeMessageStatus(messageVO);
			logger.info("쪽지 확인 상태 변경 완료");

			model.addAttribute("messageType", messageType);
		} else if (request.getParameter("receiver_id") != null) {
			model.addAttribute("sendMsg", us.showMySendMessage(messageVO));
			model.addAttribute("messageType", messageType);
		}

		DeclarationVO report = us.reportMessageInfo(declarationVO);
		if (report != null) {
			model.addAttribute("isReported", report);
			System.out.println("신고된 쪽지 정보를 표시합니다.");
		}

		return "user/message/messageView";
	}

	@RequestMapping(value = "/deleteMessage", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteMessage(Model model, MessageVO messageVO, HttpServletRequest request, RedirectAttributes rttr) {

		logger.info("deleteMessage Method Active");

		if (request.getParameter("checkRow") != null) {
			String[] checkIdx = request.getParameter("checkRow").toString().split(",");
			for (int i = 0; i < checkIdx.length; i++) {
				System.out.println("mid는" + Integer.parseInt(checkIdx[i]));
				messageVO.setMid(Integer.parseInt(checkIdx[i]));
				us.deleteMessage(messageVO);
				logger.info("쪽지 선택 삭제 완료");
			}
			rttr.addAttribute("messageType", request.getParameter("messageType"));
		} else {
			us.deleteMessage(messageVO);
			rttr.addAttribute("messageType", request.getParameter("messageType"));
			logger.info("쪽지 삭제 완료");
		}

		return "redirect:/message";
	}

	@ResponseBody
	@RequestMapping(value = "/cancleMessage", method = { RequestMethod.GET, RequestMethod.POST })
	public int cancleMessage(Model model, MessageVO messageVO) {

		logger.info("cancleMessage Method Active");

		int result = us.cancleMessage(messageVO);
		if (result == 1) {
			return 1;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "message/sendMessage", method = { RequestMethod.GET, RequestMethod.POST })
	public String sendMessage(Model model, MessageVO messageVO, HttpServletRequest request,
			@RequestParam(value = "messageType", required = false, defaultValue = "") String messageType) {
		logger.info("sendMessage Method Active");

		if (request.getParameter("receiver") != null) {
			messageVO.setuNickname(request.getParameter("receiver"));
			if (request.getParameter("from").equals("out")) {
				model.addAttribute("from_message", "out");
				System.out.println("다른 페이지에서 쪽지보내기");
			}
		} else {
			messageVO.setuNickname(request.getParameter("uNickname"));
		}
		model.addAttribute("sendMessage", messageVO);
		model.addAttribute("messageType", messageType);

		return "user/message/sendMessage";
	}

	@RequestMapping(value = "/messageSuccess", method = { RequestMethod.POST, RequestMethod.GET })
	public String messageSuccess(Model model, MessageVO messageVO, HttpServletRequest request,
			RedirectAttributes rttr) {
		logger.info("messageSuccess Method Active");

		us.replyMessage(messageVO);
		logger.info("쪽지 답장 완료");
		System.out.println("메세지가 오는곳은..." + request.getParameter("messageType"));
		if (request.getParameter("messageType").equals("out")) {
			return "redirect:/";
		}
		System.out.println("messageType is : " + request.getParameter("messageType"));
		rttr.addAttribute("messageType", request.getParameter("messageType"));
		return "redirect:/message";
	}

}