package bit.team.eepp.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import bit.team.eepp.API.GoogleOAuthInfo;
import bit.team.eepp.Service.JoinService;
import bit.team.eepp.Service.LoginService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.UserVO;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Inject
	UserService us;
	@Inject
	LoginService ls;
	@Inject
	JoinService js;
	@Inject
	BCryptPasswordEncoder pwEncoder;
	
	/* NaverLogin */
	private NaverController naverLogin;
	private String apiResult = null;
	@Autowired
	private void setNaverController(NaverController naverController) {
		this.naverLogin = naverController;
	}
	/* Naver Login */
	
	/* Google Login */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	@Inject
    private GoogleOAuthInfo authInfo;
	/* Google Login */
	
	
	@RequestMapping(value = "login/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView login(HttpSession session, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
	    /* SNS 로그인 인증을 위한 url 생성 */
	  	String GoogleUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		String naverUrl = naverLogin.getAuthorizationUrl(session);
		String kakaoUrl = KakaoController.getAuthorizationUri(session);
		
		/* 생성한 url 전달 */
		mav.setViewName("login/login");
		mav.addObject("kakao_url", kakaoUrl);
		mav.addObject("naver_url", naverUrl);
		mav.addObject("google_url", GoogleUrl);
		
		return mav;
		}
	
	// 일반 로그인
	@RequestMapping(value = "nomal_login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String nomal_login(HttpSession session, HttpServletResponse response, UserVO userVO, RedirectAttributes redirectAttributes, HttpServletRequest request) throws IOException {

		// DB에 등록된 이메일인지 확인
		int checkEmail = js.checkDuplicate(userVO.getuEmail());
		
		if(checkEmail == 0) {
			redirectAttributes.addFlashAttribute("failedLogin", "failed");
			return "redirect:/login/login.do";
		
		}else {
			UserVO login = ls.normalLogin(userVO.getuEmail());
			logger.info("로그인 정보 조회 uEmail, uPassword");
			boolean checkPW = pwEncoder.matches(userVO.getuPassword(), login.getuPassword());
			logger.info("비밀번호 체크");
			
			// 차단된 회원일시
			if(login.getGrade_Id() == 3) {
				redirectAttributes.addFlashAttribute("loginFailInfo", "grade3");
				return "redirect:/login/login.do";
			// 탈퇴한 회원일시
			}else if(login.getGrade_Id() == 4) {
				redirectAttributes.addFlashAttribute("loginFailInfo", "grade4");
				return "redirect:/login/login.do";
			}else {
			// 로그인 정보가 있고, 비밀번호 체크가 true일 경우
			if(login != null & checkPW == true){
				UserVO user = new UserVO();
				user = ls.normalLogin(userVO.getuEmail());
				session.setAttribute("loginUser", user);
				
				// 로그인할때 rememberMe를 체크한 경우, session정보 DB에 저장
				if(request.getParameter("rememberMe") != null) {
					//7일간
					int amount = 60*60*24*7;
					// session에 유지할 기간
					Timestamp sessionLimit = new Timestamp(System.currentTimeMillis() + (1000 * amount));
					user.setSession_key(session.getId());
					user.setSession_limit(sessionLimit);
					ls.keepLogin(user);
					
					logger.info("rememberMe Cookie 생성");
					// 쿠키 생성
					Cookie loginCookie = new Cookie("loginCookie", session.getId());
					loginCookie.setMaxAge(60*60*24*7);
					loginCookie.setPath("/");
					//전송
					response.addCookie(loginCookie);
					
					logger.info("자동 로그인 정보 저장 완료");
				}

					return "redirect:/";
				
				}else {
					redirectAttributes.addFlashAttribute("failedLogin", "failed");
					return "redirect:/login/login.do";
				}
			}
		}
	}
	
	
	/* 카카오 로그인 성공시 */
	@RequestMapping(value="sns/kakaoLogin", produces="application/json", method= {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLogin(@RequestParam("code") String code, 
	HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model,RedirectAttributes redirectAttributes) throws Exception {
		
		//결과값을 node에 담아줌
		JsonNode node = KakaoController.getAccessToken(code);
		//accessToken에 사용자의 로그인한 모든 정보가 들어있다
		JsonNode accessToken = node.get("access_token");
		//사용자의 정보
		JsonNode KaKaouserInfo = KakaoController.getKaKaoUserInfo(accessToken);
		//DB에 맞게 받을 정보이름 수정
		String uEmail = null;
		String uNickname = null;
		//String image = null;
		
		//유저정보 카카오에서 가져오기
		JsonNode properties = KaKaouserInfo.path("properties");
		JsonNode kakao_account = KaKaouserInfo.path("kakao_account");
		uEmail = kakao_account.path("email").asText();
		uNickname = properties.path("nickname").asText();
		//image = properties.path("profile_image").asText();
		System.out.println(uEmail+"/"+uNickname);
		
		//DB에 등록된 이메일인지 확인
		int check;
		try {
			check = js.checkDuplicate(uEmail);
			
			if(check == 0) {
				logger.info("DB에 등록되지 않은 이메일");

				logger.info("kakao회원가입으로 이동");
				
				Map<String, Object> userInfo = new HashMap<String,Object>();
				userInfo.put("uEmail", uEmail);
				userInfo.put("uNickname", uNickname);
				userInfo.put("snsType", "kakao");
				redirectAttributes.addFlashAttribute("user", userInfo);
				
				return "redirect:/join/joinForm";
				
			} else if(check != 0) {
				System.out.println(check+"이 null이 아닙니다.");
				
				UserVO login = new UserVO();
				login = ls.snsLogin(uEmail); // 이미 등록된 이메일이면 DB에서 정보 가져오기
				System.out.println(login.getSnsType());
				
				// 차단된 회원일시
				if(login.getGrade_Id() == 3) {
					redirectAttributes.addFlashAttribute("loginFailInfo", "grade3");
					return "redirect:/login/login.do";
				// 탈퇴한 회원일시
				}else if(login.getGrade_Id() == 4) {
					redirectAttributes.addFlashAttribute("loginInfo", "grade4");
					return "redirect:/login/login.do";
				}else {
					// sns가 아닌 일반회원가입으로 가입한 이메일일 경우
					if(login.getSnsType() == null) {
						redirectAttributes.addFlashAttribute("loginInfo", "notSns");
						return "redirect:/login/login.do";
					}
					// sns로 가입한 계정일 경우 가입 sns로 접근했는지 검사
					else if(login.getSnsType().equals("kakao")) {
						session.setAttribute("loginUser", login);
					
					}// 다른 sns로 가입한 이메일일 경우
					else{
						redirectAttributes.addFlashAttribute("loginInfo", "otherSNS");
						return "redirect:/login/login.do";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
	}
	
	/* 네이버 로그인 성공시 callback호출 메소드 */
	@RequestMapping(value = "sns/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam(required=false, defaultValue="0") String code, @RequestParam String state, HttpSession session, 
	HttpServletRequest request, RedirectAttributes redirectAttributes, HttpServletResponse response) throws IOException, ParseException {	
		
		//정보동의 취소시 이전페이지로 이동
		if(code.equals("0")) {
			return "redirect:/";
		}
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLogin.getAccessToken(session, code, state);
		//로그인 사용자 정보를 읽어온다.
		apiResult = naverLogin.getUserProfile(oauthToken);
	
		//String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		//데이터 파싱
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		String uEmail = (String)response_obj.get("email");
		String uNickname = (String)response_obj.get("name");
		String uImg = (String)response_obj.get("profile_image");
		System.out.println(uEmail+"/"+uNickname+"/"+uImg);
		
		//DB에 등록된 이메일인지 확인
				int check;
				try {
					check = js.checkDuplicate(uEmail);
					
					if(check == 0) {
						logger.info("DB에 등록되지 않은 이메일");

						logger.info("naver회원가입으로 이동");
						
						Map<String, Object> userInfo = new HashMap<String,Object>();
						userInfo.put("uEmail", uEmail);
						userInfo.put("uNickname", uNickname);
						userInfo.put("snsType", "naver");
						redirectAttributes.addFlashAttribute("user", userInfo);
						return "redirect:/join/joinForm";
						
					} else if(check != 0) {
						System.out.println(check+"이 null이 아닙니다.");
						
						UserVO login = new UserVO();
						login = ls.snsLogin(uEmail); // 이미 등록된 이메일이면 DB에서 정보 가져오기
						System.out.println(login.getSnsType());
						
						// 차단된 회원일시
						if(login.getGrade_Id() == 3) {
							redirectAttributes.addFlashAttribute("loginFailInfo", "grade3");
							return "redirect:/login/login.do";
						// 탈퇴한 회원일시
						}else if(login.getGrade_Id() == 4) {
							redirectAttributes.addFlashAttribute("loginInfo", "grade4");
							return "redirect:/login/login.do";
						}else {
							// sns가 아닌 일반회원가입으로 가입한 이메일일 경우
							if(login.getSnsType() == null) {
								redirectAttributes.addFlashAttribute("loginInfo", "notSns");
								return "redirect:/login/login.do";
							}
							// sns로 가입한 계정일 경우 가입 sns로 접근했는지 검사
							else if(login.getSnsType().equals("naver")) {
								session.setAttribute("loginUser", login);
							}// 다른 sns로 가입한 이메일일 경우
							else{
								redirectAttributes.addFlashAttribute("loginInfo", "otherSNS");
								return "redirect:/login/login.do";
							}
						}
						
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return "redirect:/";
				
			}
	
	
	@RequestMapping("sns/googleLogin")
	public String googleLogin(Model model, @RequestParam(required=false, defaultValue="0") String code, HttpSession session, 
	HttpServletRequest request, RedirectAttributes redirectAttributes, HttpServletResponse response) throws IOException, ParseException {	
		
		String Googlecode = request.getParameter("code");
        System.out.println(Googlecode);
        
        //RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap();
        parameters.add("code", Googlecode);
        parameters.add("client_id", authInfo.getClientId());
        parameters.add("client_secret", authInfo.getClientSecret());
        parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
        parameters.add("grant_type", "authorization_code");
 
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);
        ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token", HttpMethod.POST, requestEntity, Map.class);
        Map<String, Object> responseMap = responseEntity.getBody();
 
        // id_token 라는 키에 사용자가 정보가 존재
        // 받아온 결과는 JWT (Json Web Token) 형식으로 받아옴
        // Base 64로 인코딩 되어 있으므로 디코딩
 
        String[] tokens = ((String)responseMap.get("id_token")).split("\\.");
        Base64 base64 = new Base64(true);
        String body = new String(base64.decode(tokens[1]));
        String tokenInfo = new String(Base64.decodeBase64(tokens[1]), "utf-8");
        
        System.out.println(tokens.length);
        System.out.println(new String(Base64.decodeBase64(tokens[0]), "utf-8"));
        System.out.println(new String(Base64.decodeBase64(tokens[1]), "utf-8"));
 
        //Jackson을 사용한 JSON을 자바 Map 형식으로 변환
		ObjectMapper temp = new ObjectMapper();
		Map<String, String> googleUserInfo = temp.readValue(tokenInfo, Map.class);
//      ObjectMapper mapper = new ObjectMapper();
//      Map<String, String> result = mapper.readValue(body, Map.class);
        System.out.println(googleUserInfo.get("email"));
        System.out.println(googleUserInfo.get("name"));
        
        String uEmail = googleUserInfo.get("email");
        String uNickname = googleUserInfo.get("name");
        
      //DB에 등록된 이메일인지 확인
      		int check;
      		try {
      			check = js.checkDuplicate(uEmail);
      			
      			if(check == 0) {
      				logger.info("DB에 등록되지 않은 이메일");

      				logger.info("google회원가입으로 이동");
      				
      				Map<String, Object> userInfo = new HashMap<String,Object>();
      				userInfo.put("uEmail", uEmail);
      				userInfo.put("uNickname", uNickname);
      				userInfo.put("snsType", "google");
      				redirectAttributes.addFlashAttribute("user", userInfo);
					
					return "redirect:/join/joinForm";
      				
      			} else if(check != 0) {
      				System.out.println(check+"이 null이 아닙니다.");
      				
      				UserVO login = new UserVO();
      				login = ls.snsLogin(uEmail); // 이미 등록된 이메일이면 DB에서 정보 가져오기
      				System.out.println(login.getSnsType());
      				
      			// 차단된 회원일시
					if(login.getGrade_Id() == 3) {
						redirectAttributes.addFlashAttribute("loginFailInfo", "grade3");
						return "redirect:/login/login.do";
					// 탈퇴한 회원일시
					}else if(login.getGrade_Id() == 4) {
						redirectAttributes.addFlashAttribute("loginInfo", "grade4");
						return "redirect:/login/login.do";
					}else {
						// sns가 아닌 일반회원가입으로 가입한 이메일일 경우
						if(login.getSnsType() == null) {
							redirectAttributes.addFlashAttribute("loginInfo", "notSns");
							return "redirect:/login/login.do";
						}
						// sns로 가입한 계정일 경우 가입 sns로 접근했는지 검사
						else if(login.getSnsType().equals("google")) {
							session.setAttribute("loginUser", login);
						}// 다른 sns로 가입한 이메일일 경우
						else{
							redirectAttributes.addFlashAttribute("loginInfo", "otherSNS");
							return "redirect:/login/login.do";
						}
					}
      			}
      		} catch (Exception e) {
      			e.printStackTrace();
      		}
      		
      		return "redirect:/";
      	}
	
	/* 로그아웃 */
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
		public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws IOException {
		
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO)loginSession;
		
		if(session.getAttribute("loginUser") != null) {
			session.removeAttribute("loginUser");
			session.invalidate();
			
			// 자동 로그인 정보가 있을시 삭제
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				loginCookie.setMaxAge(0);
				loginCookie.setPath("/");
				response.addCookie(loginCookie);
				user.setSession_key("none");
				SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
				Calendar cal = Calendar.getInstance();
				String today = null;
				today = formatter.format(cal.getTime());
				user.setSession_limit(Timestamp.valueOf(today));
				ls.keepLogin(user);
				logger.info("자동 로그인 정보 삭제");
			}
		}
		return "redirect:/";
	}
	
	/* 아이디 비밀번호 찾기 */
	@RequestMapping(value = "login/forgotMyInfo", method = { RequestMethod.GET, RequestMethod.POST })
		public String forgotMyEmail(Model model){
		
		// 이메일 인증 검증을 위한 랜덤숫자 생성
		int ran = new Random().nextInt(900000) + 100000;
		model.addAttribute("random", ran);
		
		return "login/forgotMyInfo";
	}
	
	/* 가입 이메일 찾기 */
	@ResponseBody
	@RequestMapping(value="findRegisterEmail", method=RequestMethod.POST)
	public String findRegisterEmail(HttpServletRequest request, UserVO userVO, RedirectAttributes redirectAttributes, HttpSession session){
		
		String uPhone = request.getParameter("uPhone");
		System.out.println(uPhone);
	
		userVO = ls.findRegisterEmail(userVO);
		logger.info(userVO.getuEmail());
		
		String authCode = request.getParameter("authCode");
		System.out.println(authCode);
		String originalJoinCode = (String) session.getAttribute("smsAuthCode");
		System.out.println(originalJoinCode);
		
		if(originalJoinCode.equals(authCode) && userVO.getuEmail() != null) {
			session.invalidate();
			
			String uEmail = "";
			String[] findEmail = userVO.getuEmail().split("");
			
			for(int i=1; i<findEmail.length/4-1; i++) {
				findEmail[i]="*";
			}
			for(int i=0; i<findEmail.length; i++) {
				uEmail += findEmail[i];
			}
			logger.info(uEmail);
			JSONObject data = new JSONObject();
		    data.put("uEmail", uEmail);
    
            return data.toString();
		}else {
			session.invalidate();
			return "";
		}
	}
	
	/* 비밀번호 재설정 인증 메일 전송 */
	@ResponseBody
	@RequestMapping(value="sendPasswordAuth", method=RequestMethod.POST)
	public int sendPasswordAuth(HttpServletRequest request){
		
		String random = request.getParameter("random");
		String uEmail = request.getParameter("uEmail");
		System.out.println(uEmail);
		
		int result = us.CheckStatus(uEmail);
		
		if(result != 0) {
			//이메일 인증
			int ran = new Random().nextInt(900000) + 100000;
			HttpSession session = request.getSession(true);
			String authCode = String.valueOf(ran);
			session.setAttribute("authCode", authCode);
			session.setAttribute("random", random);
			String subject = "비밀번호 재설정을 위한 인증 코드 발급 안내 입니다.";
			StringBuilder sb = new StringBuilder();
			sb.append("Community EE 비밀번호 재설정 인증 안내");
			sb.append("귀하의 인증 코드는 " + authCode + "입니다.");
			
			js.send(subject, sb.toString(), "bit.eepp@gmail.com", uEmail);
			return 1;
		}else {
			return 0;
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="checkPasswordAuth", method= {RequestMethod.GET, RequestMethod.POST})
	public int checkPasswordAuth(HttpSession session, HttpServletRequest request) throws IOException{
		
		String authCode = request.getParameter("authCode");
		String random = request.getParameter("random");
		System.out.println(authCode+"/"+random);
		
		String originalJoinCode = (String) session.getAttribute("authCode");
		System.out.println(originalJoinCode);
		
		if(originalJoinCode.equals(authCode)) {
			session.invalidate();
			return 1;
		}
		else {
			session.invalidate();
			return 0;
		}
		}
	
	/* 비밀번호 재설정 */
	@RequestMapping(value = "login/resetPassword.me", method = { RequestMethod.GET, RequestMethod.POST })
		public void resetPassword(HttpServletResponse response, UserVO userVO) throws IOException{
		
		String inputPass = userVO.getuPassword();
		String encodingPW = pwEncoder.encode(inputPass);
		userVO.setuPassword(encodingPW);
		System.out.println("비밀번호 암호화 완료");
		
		int result = ls.resetPassword(userVO);
		System.out.println(result);
		if(result == 1) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호가 재설정되었습니다. 로그인해주세요.'); location.href='/eepp/login/login.do';</script>");
			out.close();
		}
	}
}
