package bit.team.eepp.Controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bit.team.eepp.API.SMSconfig;
import bit.team.eepp.Service.JoinService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.UserVO;

@Controller
public class JoinController {
	
	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Inject
	UserService us;
	@Inject
	JoinService js;
	@Inject
	BCryptPasswordEncoder pwEncoder;
	
	/* NaverLogin */
	private NaverController naverLogin;
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
	/* Google Login */
	
	@RequestMapping(value = "join/register", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView register(HttpSession session)throws IOException {
	
	/* 구글code 발행 */
	OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
    /* SNS 로그인 인증을 위한 url 생성 */
  	String GoogleUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
	String naverUrl = naverLogin.getAuthorizationUrl(session);
	String kakaoUrl = KakaoController.getAuthorizationUri(session);
	
	/* 생성한 url 전달 */
	ModelAndView mav = new ModelAndView();
	mav.setViewName("join/register");
	mav.addObject("kakao_url", kakaoUrl);
	mav.addObject("naver_url", naverUrl);
	mav.addObject("google_url", GoogleUrl);
	
	return mav;
}
	
	@RequestMapping(value = "join/joinForm", method = { RequestMethod.GET, RequestMethod.POST })
		public String joinForm(HttpSession session, Model model)throws IOException {
		
		// 이메일 인증번호 확인을 위한 랜덤숫자 생성
		int ran = new Random().nextInt(900000) + 100000;
		model.addAttribute("random", ran);
		
		return "join/joinForm";
	}
	
	@RequestMapping("join/join")
	public void join1() throws Exception{
		logger.info("head to joinpage");
	}

	@RequestMapping("join/join.me")
	public void join(HttpServletRequest request, HttpSession session, UserVO userVO, RedirectAttributes redirectAttributes, HttpServletResponse response,MultipartFile file) throws Exception{
		
		System.out.println("회원 등록 페이지");
		
		String uPhone1 = request.getParameter("uPhone_1");
		String uPhone2 = request.getParameter("uPhone_2");
		String uPhone3 = request.getParameter("uPhone_3");
		String uEmail = request.getParameter("email_01") + "@" + request.getParameter("email_02");
		userVO.setuEmail(uEmail);
		userVO.setuPhone(uPhone1 + "-" + uPhone2 + "-" + uPhone3);
		System.out.println("핸드폰번호 맞게 출력하는지 확인" + uPhone1 + "-" + uPhone2 + "-" + uPhone3);
		//프로필 업로드
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			userVO.setUprofile(ymdPath + File.separator + fileName);
		} else {
			fileName = "/eepp"+File.separator + "img" + File.separator + "headerLogin.png";
			userVO.setUprofile(fileName);
		}
		System.out.println("=================");
		System.out.println("img = " + userVO.getUprofile());
		System.out.println("=================");
		//프로필 업로드 끝
		
		
		String inputPass = userVO.getuPassword();
		String encodingPW = pwEncoder.encode(inputPass);
		userVO.setuPassword(encodingPW);
		System.out.println("비밀번호 암호화 완료");
		
		js.joinNormal(userVO);
		System.out.println("회원 등록 완료");
		
		System.out.println("회원 정보 가져오기");
		UserVO user = new UserVO();
		user = us.UserInfo(uEmail);
		session.setAttribute("loginUser", user);
		System.out.println("회원 정보 session 등록 완료");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('회원가입 완료');location.href='/eepp/';</script>");
		out.close();

}
	
	@RequestMapping("join/joinWithSns.me")
	public String joinWithSns(HttpServletRequest request, Model model,HttpSession session, UserVO userVO, MultipartFile file) throws Exception{
		
		System.out.println("회원 등록 페이지");
		
		String uPhone1 = request.getParameter("uPhone_1");
		String uPhone2 = request.getParameter("uPhone_2");
		String uPhone3 = request.getParameter("uPhone_3");
		
		userVO.setuPhone(uPhone1 + "-" + uPhone2 + "-" + uPhone3);
		userVO.setuEmail(request.getParameter("uEmail"));
		System.out.println(userVO.getuPhone() + userVO.getuEmail() + userVO.getuNickname());
		
		//프로필 업로드
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			userVO.setUprofile(ymdPath + File.separator + fileName);
		} else {
			fileName = "/eepp"+File.separator + "img" + File.separator + "headerLogin.png";
			userVO.setUprofile(fileName);
		}
		System.out.println("=================");
		System.out.println("img = " + userVO.getUprofile());
		System.out.println("=================");
		//프로필 업로드 끝
		
		//회원정보 DB에 등록
		js.JoinWithSNS(userVO);
		
		System.out.println("회원등록 완료");
		
		//등록된 회원 정보를 m/에 전달
		UserVO user = new UserVO();
		user = us.UserInfo(request.getParameter("uEmail")); // 이미 등록된 이메일이면 DB에서 정보 가져오기
		session.setAttribute("loginUser", user);
		
	return "redirect:/";
}
	/* 이메일 중복 확인 */
	@ResponseBody
	@RequestMapping(value="checkEmailDuplicate", method=RequestMethod.POST)
	public int checkEmailDuplicate(HttpServletRequest request){
		
		System.out.println(request.getParameter("uEmail"));
		String uEmail = request.getParameter("uEmail");
		int result = js.checkDuplicate(uEmail);
		
		if(result != 0) {
			logger.info("DB에 등록된 이메일.");
			return 1;
		} else{
			logger.info("DB에 등록되지않은 이메일.");
			return 0;
		}
	
	}

	@ResponseBody
	@RequestMapping(value="checkEmailAuth", method= {RequestMethod.GET, RequestMethod.POST})
	public int emailAuth(HttpSession session, HttpServletRequest request) throws IOException{
		
		String authCode = request.getParameter("authCode");
		String random = request.getParameter("random");
		System.out.println(authCode+"/"+random);
		
		String originalJoinCode = (String) session.getAttribute("authCode");
		String originalRandom = (String) session.getAttribute("random");
		System.out.println(originalJoinCode+"/"+originalRandom);
		
		if(originalJoinCode.equals(authCode) && originalRandom.equals(random)) {
			session.invalidate();
			return 1;
		}
		else {
			session.invalidate();
			return 0;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="nickNameCheck", method= {RequestMethod.GET, RequestMethod.POST})
	public int nickNameCheck(UserVO userVO, HttpServletRequest request) throws IOException{
		
		int result = js.nickNameCheck(userVO);
		
		if(result != 0) {
			logger.info("DB에 등록되어있는 닉네임.");
			return 1;
		}
		else {
			logger.info("DB에 등록되지않은 닉네임.");
			return 0;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="phoneNumCheck", method= {RequestMethod.GET, RequestMethod.POST})
	public int phoneNumCheck(UserVO userVO, HttpServletRequest request) throws IOException{
		
		int result = js.phoneNumCheck(request.getParameter("uPhone"));
		logger.info(request.getParameter("uPhone"));

		if(result != 0) {
			logger.info("DB에 등록되어있는 핸드폰번호.");
			return 1;
		} else {
			logger.info("DB에 등록되지않은 핸드폰번호.");
			return 0;
		}
	}
	
	 @ResponseBody
	 @RequestMapping("/sendSms")
	 public void sendSms(String receiver, HttpSession session) throws IOException{

		String hostname = "api.bluehouselab.com";
        String url = "https://"+hostname+"/smscenter/v1.0/sendsms";

        CredentialsProvider credsProvider = new BasicCredentialsProvider();
        credsProvider.setCredentials(
            new AuthScope(hostname, 443, AuthScope.ANY_REALM),
            new UsernamePasswordCredentials(SMSconfig.appid, SMSconfig.apikey)
        );

        AuthCache authCache = new BasicAuthCache();
        authCache.put(new HttpHost(hostname, 443, "http"), new BasicScheme());

        HttpClientContext context = HttpClientContext.create();
        context.setCredentialsProvider(credsProvider);
        context.setAuthCache(authCache);
        
        CloseableHttpClient client = HttpClientBuilder.create().build();
        
        /*인증번호*/
        int ran = new Random().nextInt(900000) + 100000;
		String authCode = String.valueOf(ran);
		session.setAttribute("smsAuthCode", authCode);

        try {
            HttpPost httpPost = new HttpPost(url);
            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
			
            String json = "{\"sender\":\""+SMSconfig.sender+
            "\",\"receivers\":[\""+ receiver
            +"\"],\"content\":\""+"[Community EE] 본인확인 인증번호 ["+authCode+"]를 화면에 입력해주세요"+"\"}";

            StringEntity se = new StringEntity(json, "UTF-8");
            httpPost.setEntity(se);

            HttpResponse httpResponse = client.execute(httpPost, context);
            System.out.println(httpResponse.getStatusLine().getStatusCode());

            InputStream inputStream = httpResponse.getEntity().getContent();
            if(inputStream != null) {
                BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
                String line = "";
                while((line = bufferedReader.readLine()) != null)
                    System.out.println(line);
                inputStream.close();
            }
        } catch (Exception e) {
            System.err.println("Error: "+e.getLocalizedMessage());
        } finally {
            client.close();
        }
	    }
	 
	 @ResponseBody
	 @RequestMapping("/smsCheck")
	 public String smsCheck(HttpSession session, HttpServletRequest request) throws IOException{
		 String authCode = request.getParameter("authCode");
			System.out.println(authCode);
			
			String originalJoinCode = (String) session.getAttribute("smsAuthCode");
			System.out.println(originalJoinCode);
			
			if(originalJoinCode.equals(authCode)) {
				session.invalidate();
				return "ok";
			}else {
				session.invalidate();
				return "no";
			}
	    }
	

	
}

