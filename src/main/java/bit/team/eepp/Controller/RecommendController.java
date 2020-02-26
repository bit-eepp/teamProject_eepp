package bit.team.eepp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Service.RecommendService;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ReplyVO;

@RequestMapping("/recommend")
@RestController
public class RecommendController {
	@Autowired
	private RecommendService recommendService;

	@RequestMapping("/blikeCount")
	public int blikeCount(BoardVO boardVO) {
		System.out.println("likeCount() method");
		return recommendService.blikeCount(boardVO.getbId());
	}

	@RequestMapping("/blikeUp")
	public void blikeUp(BoardVO boardVO) {
		System.out.println("likeUp() method");
		recommendService.blikeUp(boardVO.getbId());
	}
	
	@RequestMapping("/bUnlikeCount")
	public int bUnlikeCount(BoardVO boardVO) {
		System.out.println("unlikeCount() method");
		return recommendService.bUnlikeCount(boardVO.getbId());
	}

	@RequestMapping("/bUnlikeUp")
	public void bUnlikeUp(BoardVO boardVO) {
		System.out.println("unlikeUp() method");
		recommendService.bUnlikeUp(boardVO.getbId());
	}
	
	@RequestMapping("/rplikeCount")
	public int likeCount(ReplyVO replyVO) {
		System.out.println("likeCount() method");
		return recommendService.rplikeCount(replyVO.getRpId());
	}
	
	@RequestMapping("/rplikeUp")
	public void rplikeUp(ReplyVO replyVO) {
		System.out.println("rplikeUp() method");
		recommendService.rplikeUp(replyVO.getRpId());
	}
	
	@RequestMapping("/rpUnlikeCount")
	public int rpUnlikeCount(ReplyVO replyVO) {
		System.out.println("rpUnlikeCount() method");
		return recommendService.rpUnlikeCount(replyVO.getRpId());
	}
	
	@RequestMapping("/rpUnlikeUp")
	public void rpUnlikeUp(ReplyVO replyVO) {
		System.out.println("rplikeUp() method");
		recommendService.rpUnlikeUp(replyVO.getRpId());
	}

}
