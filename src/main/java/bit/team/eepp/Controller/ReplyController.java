package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Page.ReplyCriteria;
import bit.team.eepp.Page.ReplyPageMaker;
import bit.team.eepp.Service.ReplyService;
import bit.team.eepp.VO.ReplyVO;

@RequestMapping("/reply")
@RestController
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	@RequestMapping("/replyCount")
	public int replyCount(int board_id) {
		System.out.println(board_id);
		return replyService.replyCount(board_id);
	}

	@RequestMapping("/replyList")
	public Map<String, Object> replyList(ReplyVO replyVO, ReplyCriteria rpCriteria) {
		System.out.println("replyList() method");

		ReplyPageMaker rpPageMaker = new ReplyPageMaker();
		rpPageMaker.setCri(rpCriteria);

		System.out.println("criteria : " + rpCriteria);
		System.out.println("criteria.getPerPageNum() : " + rpCriteria.getPerPageNum());
		System.out.println("criteria.getPage() : " + rpCriteria.getPage_rp());

		int rpCount = replyCount(replyVO.getBoard_id());
		System.out.println("댓글수 : " + rpCount);

		rpPageMaker.setTotalCount(rpCount);
		System.out.println(replyVO.getRpStep());
		
		List<ReplyVO> replyList = replyService.replyList(rpCriteria, replyVO.getBoard_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rpPageMaker", rpPageMaker);
		map.put("replyList", replyList);

		return map;
	}

	@RequestMapping("/replyWrite")
	public void replyWrite(ReplyVO replyVO) {
		System.out.println("replyWrite() method");
		replyService.replyWrite(replyVO);
	}

	@RequestMapping("/replyModify")
	public void replyModify(ReplyVO replyVO) {
		System.out.println("replyModify() method");
		replyService.replyModify(replyVO);
	}

	@RequestMapping("/replyDelete")
	public void replyDelete(ReplyVO replyVO) {
		System.out.println("replyDelete() method");
		replyService.replyDelete(replyVO.getRpId());
	}

	@RequestMapping("/reReplyWrite")
	public void reReplyWrite(ReplyVO replyVO) {
		System.out.println("reReplyWrite() method");
		replyService.reReplyWrite(replyVO);
	}

}
