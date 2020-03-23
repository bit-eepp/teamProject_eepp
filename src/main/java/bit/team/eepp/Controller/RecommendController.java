package bit.team.eepp.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Service.RecommendService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ReplyVO;
import bit.team.eepp.VO.UserActiveVO;

@RequestMapping("/recommend")
@RestController
public class RecommendController {
	@Autowired
	private RecommendService recommendService;
	@Autowired
	private UserService userService;

	@RequestMapping("/blikeCount")
	public int blikeCount(BoardVO boardVO) {
		System.out.println("likeCount() method");
		return recommendService.blikeCount(boardVO.getbId());
	}

	@RequestMapping("/blikeUp")
	public int blikeUp(BoardVO boardVO, UserActiveVO activeVO, HttpSession session) {
		System.out.println("likeUp() method");
		
		activeVO.setActive_type("blike");
		int haveLike = userService.haveBoardActive(activeVO);
		if(haveLike != 0){
			// 추천이력이 있을경우
			return 1;
		} else {
			recommendService.blikeUp(boardVO.getbId());
			userService.boardActive(activeVO);
			return 0;
		}
	}
	
	@RequestMapping("/bUnlikeCount")
	public int bUnlikeCount(BoardVO boardVO) {
		System.out.println("unlikeCount() method");
		return recommendService.bUnlikeCount(boardVO.getbId());
	}

	@RequestMapping("/bUnlikeUp")
	public int bUnlikeUp(BoardVO boardVO, UserActiveVO activeVO) {
		System.out.println("unlikeUp() method");
		
		activeVO.setActive_type("bUnlike");
		int haveLike = userService.haveBoardActive(activeVO);
		if(haveLike != 0){
			// 비추천이력이 있을경우
			return 1;
		} else {
			recommendService.bUnlikeUp(boardVO.getbId());
			userService.boardActive(activeVO);
			return 0;
		}
	}
	
	@RequestMapping("/rplikeCount")
	public int likeCount(ReplyVO replyVO) {
		System.out.println("likeCount() method");
		return recommendService.rplikeCount(replyVO.getRpId());
	}
	
	@RequestMapping("/rplikeUp")
	public int rplikeUp(ReplyVO replyVO, UserActiveVO activeVO) {
		System.out.println("rplikeUp() method");
		
		activeVO.setActive_type("rplike");
		int haveLike = userService.haveReplyActive(activeVO);
		if(haveLike != 0){
			// 비추천이력이 있을경우
			return 1;
		} else {
			recommendService.rplikeUp(replyVO.getRpId());
			userService.replyActive(activeVO);
			return 0;
		}
	}
	
	@RequestMapping("/rpUnlikeCount")
	public int rpUnlikeCount(ReplyVO replyVO) {
		System.out.println("rpUnlikeCount() method");
		return recommendService.rpUnlikeCount(replyVO.getRpId());
	}
	
	@RequestMapping("/rpUnlikeUp")
	public int rpUnlikeUp(ReplyVO replyVO, UserActiveVO activeVO) {
		System.out.println("rplikeUp() method");
		
		activeVO.setActive_type("rpUnlike");
		int haveLike = userService.haveReplyActive(activeVO);
		if(haveLike != 0){
			// 비추천이력이 있을경우
			return 1;
		} else {
			recommendService.rpUnlikeUp(replyVO.getRpId());
			userService.replyActive(activeVO);
			return 0;
		}
	}

}
