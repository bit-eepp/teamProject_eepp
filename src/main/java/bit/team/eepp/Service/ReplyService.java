package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.ReplyMapper;
import bit.team.eepp.Page.ReplyCriteria;
import bit.team.eepp.VO.ReplyVO;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper replyMapper;

	public int replyCount(int board_id) {
		return replyMapper.replyCount(board_id);
	}

	public List<ReplyVO> replyList(ReplyCriteria rpCriteria, int board_id) {
		return replyMapper.replyList(rpCriteria, board_id);
	}

	public void replyWrite(ReplyVO replyVO) {
		replyMapper.replyWrite(replyVO);
	}

	public void replyModify(ReplyVO replyVO) {
		replyMapper.replyModify(replyVO);
	}

	public void replyDelete(int rpId) {
		replyMapper.replyDelete(rpId);
	}

	public void reReplyWrite(ReplyVO replyVO) {
		replyMapper.replyShape(replyVO.getRpGroup(), replyVO.getRpStep());
		replyMapper.reReplyWrite(replyVO);
	}
}
