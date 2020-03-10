package bit.team.eepp.Controller;

import java.io.File;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import bit.team.eepp.Service.FileService;
import bit.team.eepp.Service.ScrapService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.Utils.UploadFileUtils;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ScrapVO;
import bit.team.eepp.VO.UserVO;

@Controller
public class MypageController {

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Inject
	UserService us;

	@Autowired
	FileService fs;
	ScrapService sc;

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	@RequestMapping("/mypage")
	public String mypage(Model model) throws Exception {
		logger.info("head to mypage");
		return "myPage/myPage";
	}

	@RequestMapping(value = ("/mypage"), method = RequestMethod.POST)
	public String postGoodsRegister(HttpSession session, UserVO userVO, MultipartFile file, Model model)
			throws Exception {
		// 유저 세션 받아오기
		Object loginSession = session.getAttribute("loginUser");
		UserVO user = (UserVO) loginSession;
		userVO.setUser_id(user.getUser_id());
		
		//내 포인트 가져오기

				// 스크랩 갯수 받아오기

				// 내가 작성 댓글의 갯수 가져오기

				// 내가 작성한 글 갯수 가져오기
//				int BoardCount = fs.myBoardCount();
//				model.addAttribute("BoardCount", BoardCount);
//				System.out.println(BoardCount);

				// 내가 개설한 클래스의 개수 가져오기

				// 내가 참여한 클래스의 개수 가져오기

		System.out.println("여기까지 오나??????");

		// 프로필 업로드
		String imgUploadPath = uploadPath;
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			userVO.setUprofile(ymdPath + File.separator + fileName);
		} else {
			fileName = "/eepp"+File.separator + "img" + File.separator + "basic_img.png";
			userVO.setUprofile(fileName);
		}
		System.out.println("=================");
		System.out.println("img = " + userVO.getUprofile());
		System.out.println("=================");

		// 프로필 업데이트한 부분 세션 다시 받아오기
		user.setUprofile(userVO.getUprofile());
		session.setAttribute("loginUser", user);

		// 여기서 insert
		fs.profileUpdate(userVO);

		return "redirect:/mypage";
	}
}