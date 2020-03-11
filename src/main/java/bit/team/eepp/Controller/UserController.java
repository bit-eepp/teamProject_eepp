package bit.team.eepp.Controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
    
    @RequestMapping("/message")
	public String message(Model model, MessageVO messageVO){
		logger.info("Message Method Active");

		return "user/message/message";
	}
	
    /* 쪽지 */
    
	@RequestMapping(value = "/message/messageView", method = { RequestMethod.GET, RequestMethod.POST })
	public String messageView(Model model, MessageVO messageVO, HttpServletRequest request){
		logger.info("MessageView Method Active");

		return "user/message/messageView";
	}
	
	@ResponseBody
	@RequestMapping("/sendMessage")
	public Map<String, Object> sendMessage(Model model, MessageVO messageVO){
		logger.info("sendMessage Method Active");
		
		List<MessageVO> message = us.mySendMessage(messageVO);
	    Map<String, Object> messageList = new HashMap<String, Object>();
	    
	   System.out.println(message.toString());
	    messageList.put("messageList", message);

		return messageList;
	}
	
	@ResponseBody
	@RequestMapping("/receiveMessage")
	public Map<String, Object> receiveMessage(Model model, MessageVO messageVO) {
		
		logger.info("receiveMessage Method Active");
		
		List<MessageVO> message = us.myReceiveMessage(messageVO);
	    Map<String, Object> messageList = new HashMap<String, Object>();
	    
	   System.out.println(message.toString());
	    messageList.put("messageList", message);

		return messageList;
	}
}