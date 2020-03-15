package bit.team.eepp.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.team.eepp.Service.ChattingService;
import bit.team.eepp.VO.ChattingMemberVO;
import bit.team.eepp.VO.ChattingVO;

@RequestMapping("/chat")
@Controller
public class ChattingController {
	@Autowired
	private ChattingService chattingService;
	
	@RequestMapping("/chatRoomList")
	public String test() {
		return "/chat/chatRoomList";
	}
	
	@RequestMapping("/getTotalChatCount")
	@ResponseBody
	public int getTotalChatCount() {
		System.out.println("getTotalChatCount() method");
		return chattingService.getTotalChatCount();
	}

	@RequestMapping("/getChatRoomList")
	@ResponseBody
	public List<ChattingVO> getChatRoomList() {
		System.out.println("getChatRoomList() method");
		return chattingService.getChatRoomList();
	}

	@RequestMapping("/getMoreChatList")
	@ResponseBody
	public List<ChattingVO> getMoreChatList(@RequestParam(value = "startNum") int startNum, @RequestParam(value = "endNum") int endNum) {
		return chattingService.getMoreChatList(startNum, endNum);
	}

	@RequestMapping("/chatRoomSelect")
	public String chatRoomSelect(Model model, ChattingVO chattingVO, HttpServletRequest request) {
		System.out.println("chatRoomSelect() method");

		ChattingVO chatRoom = chattingService.chatRoomSelect(chattingVO.getChId());

		int currentCount = chattingService.getPeopleCount(chattingVO.getChId());
		int totalCount = chatRoom.getChTotalPeopleCount();

		if (currentCount < totalCount) {
			HttpSession session = request.getSession();

			String chatRoomId = Integer.toString(chattingVO.getChId());
			session.setAttribute("chatRoomId", chatRoomId);

			chattingService.addMember(chattingVO.getChId(), chattingVO.getUser_id());

			model.addAttribute("user_id", chattingVO.getUser_id());
			model.addAttribute("chatRoomSelect", chattingService.chatRoomSelect(chattingVO.getChId()));

			return "/chat/chatRoomPage";
		} else {
			return "redirect:/chat/chatRoomList";
		}
	}

	@RequestMapping("/chatRoomMake")
	@ResponseBody
	public int chatRoomMake(ChattingVO chattingVO) {
		System.out.println("chatRoomMake() method");

		if (chattingVO.getChPlace().equals("")) {
			chattingVO.setChPlace("상의 후 결정");
		}

		if (chattingVO.getChMeetTime().equals("")) {
			chattingVO.setChMeetTime("상의 후 결정");
		} else {
			String meetTime = chattingVO.getChMeetTime();
			meetTime = meetTime.replace("T", " ");
			chattingVO.setChMeetTime(meetTime);
		}

		chattingService.chatRoomMake(chattingVO);

		return chattingVO.getChId();
	}

	@RequestMapping("/chatRoomExit")
	@ResponseBody
	public void chatRoomExit(ChattingVO chattingVO) {
		System.out.println("chatRoomExit() method");
		chattingService.removeMember(chattingVO.getUser_id());
	}

	@RequestMapping("/chatRoomDelete")
	@ResponseBody
	public void chatRoomDelete(ChattingVO chattingVO) {
		System.out.println("chatRoomDelete() method");
		chattingService.removeMember(chattingVO.getUser_id());
		chattingService.chatRoomDelete(chattingVO.getChId());
	}

	@RequestMapping("/getPeopleCount")
	@ResponseBody
	public int getPeopleCount(ChattingMemberVO chattingMemberVO) {
		System.out.println("getPeopleCount() method");
		return chattingService.getPeopleCount(chattingMemberVO.getChatting_id());
	}

	@RequestMapping("/getMemberList")
	@ResponseBody
	public List<ChattingMemberVO> getMemberList(ChattingMemberVO chattingMemberVO) {
		System.out.println("getMemberList() method");
		return chattingService.getMemberList(chattingMemberVO.getChatting_id());
	}

	@RequestMapping("/getUserIdList")
	@ResponseBody
	public List<ChattingMemberVO> getUserIdList(ChattingMemberVO chattingMemberVO) {
		System.out.println("getUserIdList() method");
		return chattingService.getUserIdList(chattingMemberVO.getChatting_id());
	}
}
