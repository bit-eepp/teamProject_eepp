package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bit.team.eepp.Page.MessageCriteria;
import bit.team.eepp.Page.MessagePageMaker;
import bit.team.eepp.Service.ClassService;
import bit.team.eepp.Service.FileService;
import bit.team.eepp.Service.ScrapService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.DeclarationVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.PaymentVO;
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
		
		Object user = (Object)session.getAttribute("loginUser");
		UserVO userRefresh = (UserVO)user;
		
		userRefresh.setPoint(userRefresh.getPoint()+userVO.getPoint());
		session.setAttribute("loginUser", userRefresh);
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
	
	/* 읽지않은 쪽지 알람 띄우기 */
	@ResponseBody
	@RequestMapping(value = "/loadNotReadMessage", method = { RequestMethod.POST, RequestMethod.GET })
	public String loadNotReadMessage(HttpSession session) {
		logger.info("loadNotReadMessage Method Active");

		Object loginSession = session.getAttribute("loginUser");
		if (loginSession != null) {
			UserVO user = (UserVO) loginSession;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("fromMain", "fromMain");
			map.put("user_id", user.getUser_id());

			int notReadMessage = us.messageListCount(map);
			if (notReadMessage != 0) {
				System.out.println("안읽은 메세지는 있음" + notReadMessage);
				JSONObject data = new JSONObject();
			    data.put("notReadMessage", notReadMessage);
	            return data.toString();
			}else {
				System.out.println("안읽은 메세지는 없음" + notReadMessage);
				return "0";
			}
		}else {
			return "0";
		}
	}

}