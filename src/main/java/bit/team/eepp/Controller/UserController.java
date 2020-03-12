package bit.team.eepp.Controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bit.team.eepp.Page.MessageCriteria;
import bit.team.eepp.Page.MessagePageMaker;
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
    
    @Autowired
    FileService fs;
    ScrapService sc;
    
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    
    @RequestMapping("/mypage")
    public String mypage(Model model) throws Exception{
    	logger.info("head to mypage");
    	return "user/myPage/myPage";
    }
    
    @RequestMapping(value = ( "/mypage" ), method = RequestMethod.POST )
    public String postGoodsRegister(BoardVO boardvo,ScrapVO scrapvo,HttpSession session,UserVO userVO, MultipartFile file,Model model) throws Exception {
    	//유저 세션 받아오기
    	Object loginSession = session.getAttribute("loginUser");
    	UserVO user = (UserVO)loginSession;
    	userVO.setUser_id(user.getUser_id());
    	
    	System.out.println("여기까지 오나??????");
    	
    	//내 포인트 가져오기
    	
    	//스크랩 갯수 받아오기
    	
    	//내가 작성 댓글의 갯수 가져오기
    	
    	//내가 개설한 클래스의 개수 가져오기
    	
    	//내가 참여한 클래스의 개수 가져오기
    	
    	//프로필 업로드
        String imgUploadPath = uploadPath;
        String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
        String fileName = null;
        if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
            fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
            userVO.setUprofile(ymdPath + File.separator + fileName);
        }
        else {
            fileName = File.separator + "img" + File.separator + "basic_img.png";
            userVO.setUprofile(fileName);
        }
        System.out.println("=================");
        System.out.println("img = " + userVO.getUprofile());
        System.out.println("=================");
        
        fs.profileUpdate(userVO);
        
        return "redirect:/mypage";
    }
    
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
		System.out.println("mid는"+request.getParameter("checkRow"));
		System.out.println(request.getParameter("messageType"));
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