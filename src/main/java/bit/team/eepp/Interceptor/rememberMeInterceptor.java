package bit.team.eepp.Interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import bit.team.eepp.Service.LoginService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.PointVO;
import bit.team.eepp.VO.UserVO;

public class rememberMeInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(rememberMeInterceptor.class);
	@Inject
	LoginService ls;
	@Inject
	UserService us;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		logger.info("rememberMeInterceptor preHandle Active()");
		
		if(loginCookie != null) {
			System.out.println("자동 로그인 정보가 있습니다.");
			String cookie_key = loginCookie.getValue();
			UserVO user = ls.checkLoginBefore(cookie_key);
			logger.info("user정보 호출");
			if(user != null) {
				session.setAttribute("loginUser", user);
				System.out.println("session에 유저 정보 저장 완료");
				
				/* 포인트 정보가 있으면 session에 정보 추가 */
				PointVO point = us.haveChargePoint(Integer.toString(user.getUser_id()));
				if(point != null) {
					session.setAttribute("userPoint", point);
					System.out.println("로그인한 유저의 포인트정보 session 추가");
				}
			}
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}


}
