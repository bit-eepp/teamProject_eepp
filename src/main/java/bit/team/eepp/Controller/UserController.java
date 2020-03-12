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

import bit.team.eepp.Page.MessageCriteria;
import bit.team.eepp.Page.MessagePageMaker;
import bit.team.eepp.Page.myPagePageMaker;
import bit.team.eepp.Search.MypageSearchCriteria;
import bit.team.eepp.Service.FileService;
import bit.team.eepp.Service.ScrapService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.ScrapVO;
import bit.team.eepp.VO.UserVO;

@Controller
public class UserController{
	
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
			fileName = File.separator + "img" + File.separator + "basic_img.png";
			userVO.setUprofile(fileName);
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
	public String mypageList(HttpSession session, UserVO userVO, Model model,
			@ModelAttribute("mscri") MypageSearchCriteria mscri,
			@RequestParam(value = "sortType", required = false, defaultValue = "bWrittenDate") String sortType,
			@RequestParam(value = "bCategory", required = false, defaultValue = "") String bCategory) {
		logger.info("my contents List");

		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		userVO.setUser_id(user.getUser_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mscri", mscri);
		map.put("sortType", sortType);
		map.put("bCategory", bCategory);
		map.put("user_id", userVO.getUser_id());
		map.put("listCount", us.listCount(map));
		map.put("replyCount", us.replyCount(map));
		map.put("scrapCount", us.scrapCount(map));

		myPagePageMaker myPagePageMaker = new myPagePageMaker();
		myPagePageMaker.setCri(mscri);
		myPagePageMaker.setTotalCount(us.listCount(map));
		
		model.addAttribute("scrapList", us.scrapList(userVO));
		model.addAttribute("scrapCount", us.scrapCount(map));
		model.addAttribute("replyCount", us.replyCount(map));
		model.addAttribute("listCount", us.listCount(map));
		model.addAttribute("myBoardList", us.myBoardList(map));
		model.addAttribute("myPagePageMaker", myPagePageMaker);
		model.addAttribute("sortType", sortType);
		model.addAttribute("bCategory", bCategory);

		return "user/myPage/myPage";
	}
	
//	@RequestMapping("scrapList")
//	public String scrapList(HttpSession session, Model model, UserVO userVO) {
//		logger.info("내가 스크랩한 목록");
//		// 유저 세션 받아오기
//		Object loginSession = session.getAttribute("loginUser");
//		UserVO user = (UserVO) loginSession;
//		userVO.setUser_id(user.getUser_id());
//		
//		model.addAttribute("scrapList", us.scrapList(userVO));
//				
//		return "user/myPage/myPage";
//	}

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
	
	
	/*
	 * ------- message part -------
	 */
	
    
    /* 쪽지 */
    @RequestMapping(value="/message",method = { RequestMethod.GET, RequestMethod.POST })
	public String message(MessageCriteria msgCri, Model model, HttpSession session, MessageVO messageVO, @RequestParam(value = "messageType", required = false, defaultValue = "") String messageType){
		logger.info("Message Method Active");
		
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO)loginSession;
		
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
	public String messageView(Model model, MessageVO messageVO, HttpServletRequest request, @RequestParam(value = "messageType", required = false, defaultValue = "") String messageType){
		logger.info("MessageView Method Active");
		
		if(request.getParameter("changeStatus") != null) {
			us.changeMessageStatus(messageVO);
			logger.info("쪽지 확인 상태 변경 완료");
		}
		
		if(request.getParameter("sender_id") != null) {
			model.addAttribute("receiveMsg", us.showMyReceiveMessage(messageVO));
			model.addAttribute("messageType", messageType);
		}else if(request.getParameter("receiver_id") != null) {
			model.addAttribute("sendMsg",us.showMySendMessage(messageVO));
			model.addAttribute("messageType", messageType);
		}
		
		return "user/message/messageView";
	}
	
	@RequestMapping(value="/deleteMessage",method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteMessage(Model model, MessageVO messageVO, HttpServletRequest request, RedirectAttributes rttr) {
		
		logger.info("deleteMessage Method Active");

		if(request.getParameter("checkRow") != null) {
			String[] checkIdx = request.getParameter("checkRow").toString().split(",");
			for (int i=0; i<checkIdx.length; i++) {
				System.out.println("mid는"+Integer.parseInt(checkIdx[i]));
				messageVO.setMid(Integer.parseInt(checkIdx[i]));
			    us.deleteMessage(messageVO);
			    logger.info("쪽지 선택 삭제 완료");
			}
			rttr.addAttribute("messageType", request.getParameter("messageType"));
		}else {
			us.deleteMessage(messageVO);
			rttr.addAttribute("messageType", request.getParameter("messageType"));
			logger.info("쪽지 삭제 완료");
		}

		return "redirect:/message";
	}
	
	@RequestMapping(value="message/sendMessage",method = { RequestMethod.GET, RequestMethod.POST })
	public String sendMessage(Model model, MessageVO messageVO, HttpServletRequest request,@RequestParam(value = "messageType", required = false, defaultValue = "") String messageType) {
		logger.info("sendMessage Method Active");
		
		messageVO.setUnickname(request.getParameter("uNickname"));
		model.addAttribute("sendMessage",messageVO);
		model.addAttribute("messageType", messageType);
		
		return "user/message/sendMessage";
	}
	
	@RequestMapping(value="/messageSuccess",method = { RequestMethod.POST,RequestMethod.POST})
	public String messageSuccess(Model model, MessageVO messageVO, HttpServletRequest request, RedirectAttributes rttr) {
		logger.info("messageSuccess Method Active");
		
		us.replyMessage(messageVO);
		logger.info("쪽지 답장 완료");
		rttr.addAttribute("messageType", "myReceiveMsg");
		
		return "redirect:/message";
	}
	
}