package bit.team.eepp;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	UserService us;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpSession session) {
		logger.info("Access Main Page");
		
		ModelAndView mv = new ModelAndView();
		
		/* 읽지않은 쪽지 알람 띄우기 */
		Object loginSession = session.getAttribute("loginUser");
		if(loginSession != null) {
			UserVO user = (UserVO)loginSession;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("fromMain", "fromMain");
			map.put("user_id", user.getUser_id());
			
			int notReadMessage = us.messageListCount(map);
			if(notReadMessage != 0) {
				mv.addObject("notReadMessage", notReadMessage);
			}
		}
		/* 읽지않은 쪽지 알람 띄우기 */
		
		mv.setViewName("main");
		
		return mv;
	}
	
	/* 접근권한없는 페이지에 접근했을시 back */
	@RequestMapping(value = "/accessDenied", method = {RequestMethod.GET,RequestMethod.POST})
	public void accessDenied(Locale locale, HttpServletResponse response) throws IOException {
		logger.info("접근권한 없는 유저의 접근");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('로그인을 해주세요.'); history.go(-1);</script>");
		out.close();

	}
	
}
