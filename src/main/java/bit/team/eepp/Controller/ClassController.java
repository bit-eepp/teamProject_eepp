package bit.team.eepp.Controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import bit.team.eepp.API.SMSconfig;
import bit.team.eepp.Page.ClassPageMaker;
import bit.team.eepp.Search.ClassSearchCriteria;
import bit.team.eepp.Service.ClassService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.PaymentVO;
import bit.team.eepp.VO.UserVO;

@RequestMapping("/class")
@Controller
public class ClassController {

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Autowired
	private ClassService classService;

	@Autowired
	private UserService us;

	@RequestMapping("/classList")
	public String classList(Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory", required = false, defaultValue = "") String cCategory) {
		System.out.println("classList() method");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cscri", cscri);
		map.put("cCategory", cCategory);

		ClassPageMaker classPageMaker = new ClassPageMaker();
		classPageMaker.setCri(cscri);
		classPageMaker.setTotalCount(classService.classListCount(map));

		model.addAttribute("classList", classService.classList(map));
		model.addAttribute("classPageMaker", classPageMaker);
		model.addAttribute("cCategory", cCategory);
		return "/class/classList";
	}

	@RequestMapping("/classOpenView")
	public String classOpenView(Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory") String cCategory) {
		System.out.println("classOpenView() method");
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/classOpenView";
	}

	@RequestMapping("/classOpen")
	public String classOpen(ClassVO classVO, Model model, MultipartFile file,
			@ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory)
			throws Exception {
		System.out.println("classOpen() method");

		// 클래스 썸네일 파일경로
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			classVO.setcThumnail(ymdPath + File.separator + fileName);

		} else {
			if (classVO.getcCategory().equals("it_dev")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "it_dev.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("workSkill")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "workSkill.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("daily")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "daily.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("financialTechnology")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "financialTechnology.jpg";
				classVO.setcThumnail(fileName);
			} else if (classVO.getcCategory().equals("etc")) {
				fileName = "/eepp" + File.separator + "img" + File.separator + "class" + File.separator + "default"
						+ File.separator + "etc.jpg";
				classVO.setcThumnail(fileName);
			}
		}

		System.out.println("썸네일 저장경로: " + classVO.getcThumnail());
		// 클래스 썸네일 파일경로 끝

		classService.classOpen(classVO);
		return "redirect:/class/classView?cId=" + classVO.getcId() + "&page=" + cscri.getPage() + "&perPageNum="
				+ cscri.getPerPageNum() + "&cCategory=" + cCategory;

	}

	@RequestMapping("/classView")
	public String classView(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory") String cCategory) {
		System.out.println("classView() method");
		model.addAttribute("clView", classService.classView(classVO));
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/class_view";
	}

	@RequestMapping("/deleteClass")
	public String deleteClass(ClassVO classVO) {
		System.out.println("/deleteClass() method");
		classService.deleteClass(classVO);
		return "redirect:/class/classList";
	}

	@RequestMapping("/classModifyView")
	public String classModifyView(ClassVO classVO, Model model, @ModelAttribute("cscri") ClassSearchCriteria cscri,
			@RequestParam(value = "cCategory") String cCategory) {
		System.out.println("/classModifyView() method");
		model.addAttribute("modifyClass", classService.classModifyView(classVO));
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "/class/classModify_view";
	}

	@RequestMapping("/modifyClass")
	public String modifyClass(ClassVO classVO, Model model, MultipartFile file,
			@ModelAttribute("cscri") ClassSearchCriteria cscri, @RequestParam(value = "cCategory") String cCategory)
			throws Exception {
		System.out.println("/modifyClass() method");

		// 클래스 썸네일 파일경로
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			classVO.setcThumnail(ymdPath + File.separator + fileName);
		} else {
			fileName = classService.getFilePath(classVO.getcId());
			classVO.setcThumnail(fileName);
		}

		System.out.println("썸네일 저장경로: " + classVO.getcThumnail());
		// 클래스 썸네일 파일경로 끝

		classService.modifyClass(classVO);
		model.addAttribute("cscri", cscri);
		model.addAttribute("cCategory", cCategory);
		return "redirect:/class/classView?cId=" + classVO.getcId() + "&page=" + cscri.getPage() + "&perPageNum="
				+ cscri.getPerPageNum();
	}

	@RequestMapping("/getUserIdList")
	@ResponseBody
	public List<ClassJoinVO> getUserIdList(ClassJoinVO classJoinVO) {
		return classService.getUserIdList(classJoinVO.getClass_id());
	}

	@RequestMapping("/getCurrentUserCount")
	@ResponseBody
	public int getCurrentUserCount(ClassJoinVO classJoinVO) {
		return classService.getCurrentUserCount(classJoinVO.getClass_id());
	}

	@RequestMapping("/classJoin")
	@ResponseBody
	public void classJoin(PaymentVO paymentVO, ClassJoinVO classJoinVO,
			@RequestParam(value = "opennerUser_id") int opennerUser_id,
			@RequestParam(value = "classPrice") int classPrice) throws IOException {
		System.out.println("내 user_id : " + classJoinVO.getUser_id());
		System.out.println("class_id : " + classJoinVO.getClass_id());
		System.out.println("개설자 user_id : " + opennerUser_id);
		System.out.println("클래스 가격 : " + classPrice);

		// 개설된 클래스에 신청한 유저 추가
		classService.classJoin(classJoinVO);

		// 개설자의 users 테이블에서 총 포인트 금액 update(+)
		us.updateOpennerPoint(opennerUser_id, classPrice);

		// payment 테이블에 추가 : 개설자
		int opennerTotalPoint = us.getTotalPoint(opennerUser_id); // 업데이트된 클래스 개설자의 총 포인트 금액
		paymentVO.setTotalPoint(opennerTotalPoint);
		paymentVO.setClass_id(classJoinVO.getClass_id());
		paymentVO.setUser_id(opennerUser_id);
		paymentVO.setPoint_io(classPrice);

		us.opennerPayment(paymentVO);

		// 신청자의 users 테이블에서 총 포인트 금액 update(-)
		us.updateParticipantPoint(classJoinVO.getUser_id(), classPrice);

		// payment 테이블에 추가 : 참가자
		int participantTotalPoint = us.getTotalPoint(classJoinVO.getUser_id()); // 업데이트된 클래스 참가자의 총 포인트 금액

		paymentVO.setTotalPoint(participantTotalPoint);
		paymentVO.setClass_id(classJoinVO.getClass_id());
		paymentVO.setUser_id(classJoinVO.getUser_id());
		paymentVO.setPoint_io(classPrice);

		us.participantPayment(paymentVO);

		// 강좌명
		String classTitle = classService.getClassTitle(classJoinVO.getClass_id());

		// 개설자 닉네임, 연락처
		UserVO classOpennerInfo = us.getOpennerInfo(opennerUser_id);
		String opennerNick = classOpennerInfo.getuNickname();
		String opennerCP = classOpennerInfo.getuPhone();

		// 신청일 : 지금 시간
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd(HH:mm:ss)");
		Date time = new Date();
		String nowtime = format.format(time);

		// 신청자 연락처
		String joinnerCP = us.getJoinnerInfo(classJoinVO.getUser_id());
		String joinnerCPEdit = joinnerCP.replace("-", "");
		

		String hostname = "api.bluehouselab.com";
		String url = "https://" + hostname + "/smscenter/v1.0/sendlms";

		System.out.println("classTitle : " + classTitle);
		System.out.println("opennerNick : " + opennerNick);
		System.out.println("opennerCP : " + opennerCP);
		System.out.println("nowtime : " + nowtime);
		System.out.println("joinnerCPEdit : " + joinnerCPEdit);
		System.out.println("participantTotalPoint : " + participantTotalPoint);

		CredentialsProvider credsProvider = new BasicCredentialsProvider();
		credsProvider.setCredentials(new AuthScope(hostname, 443, AuthScope.ANY_REALM), new UsernamePasswordCredentials(SMSconfig.appid, SMSconfig.apikey));

		AuthCache authCache = new BasicAuthCache();
		authCache.put(new HttpHost(hostname, 443, "http"), new BasicScheme());

		HttpClientContext context = HttpClientContext.create();
		context.setCredentialsProvider(credsProvider);
		context.setAuthCache(authCache);

		CloseableHttpClient client = HttpClientBuilder.create().build();

		try {
			HttpPost httpPost = new HttpPost(url);
			httpPost.setHeader("Content-type", "application/json; charset=utf-8");

			String json = "{\"sender\":\"" + SMSconfig.sender +"\",\"receivers\":[\"" + joinnerCPEdit + "\"]," + "\"subject\":\"" +"수강신청알림" 
					+ "\",\"content\":\"" + "수강신청이 완료되었습니다.\\r\\n강좌명 - "+ classTitle + "\\r\\n개설자 - " + opennerNick + "("+ opennerCP + ")" +"\\r\\n신청일 - " + nowtime +"\\r\\n포인트잔액 - " + participantTotalPoint +"\"}";

			StringEntity se = new StringEntity(json, "UTF-8");
			httpPost.setEntity(se);

			HttpResponse httpResponse = client.execute(httpPost, context);
			System.out.println(httpResponse.getStatusLine().getStatusCode());

			InputStream inputStream = httpResponse.getEntity().getContent();
			if (inputStream != null) {
				BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
				String line = "";
				while ((line = bufferedReader.readLine()) != null)
					System.out.println(line);
				inputStream.close();
			}
		} catch (Exception e) {
			System.err.println("Error: " + e.getLocalizedMessage());
		} finally {
			client.close();
		}
	}
}
