package bit.team.eepp;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

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

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {
		logger.info("Access Main Page");
		
		ModelAndView mv = new ModelAndView();
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
