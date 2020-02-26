package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.QuestionMapper;
import bit.team.eepp.Page.ReplyCriteria;
import bit.team.eepp.VO.ReplyVO;

@Service
public class QuestionService {
	
	@Autowired
	private QuestionMapper questionMapper;

	public int questionCount(int class_id) {
		return questionMapper.questionCount(class_id);
	}

	public List<ReplyVO> questionList(ReplyCriteria rpCriteria, int class_id) {
		return questionMapper.questionList(rpCriteria, class_id);
	}

	public void questionWrite(ReplyVO replyVO) {
		questionMapper.questionWrite(replyVO);
	}

	public void questionModify(ReplyVO replyVO) {
		questionMapper.questionModify(replyVO);
	}

	public void questionDelete(int rpId) {
		questionMapper.questionDelete(rpId);
	}

	public void reQuestionWrite(ReplyVO replyVO) {
		questionMapper.questionShape(replyVO.getRpGroup(), replyVO.getRpStep());
		questionMapper.reQuestionWrite(replyVO);
	}

}
