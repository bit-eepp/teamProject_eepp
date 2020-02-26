package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import bit.team.eepp.Page.ReplyCriteria;
import bit.team.eepp.VO.ReplyVO;

@Repository
public interface QuestionMapper {

	public abstract int questionCount(@Param("class_id") int class_id);

	public abstract List<ReplyVO> questionList(@Param("rpCriteria") ReplyCriteria rpCriteria, @Param("class_id") int class_id);

	public abstract void questionWrite(@Param("replyVO") ReplyVO replyVO);

	public abstract void questionModify(@Param("replyVO") ReplyVO replyVO);

	public abstract void questionDelete(@Param("rpId") int rpId);
	
	public abstract void questionShape(@Param("rpGroup") int rpGroup, @Param("rpStep") int rpStep);
	
	public abstract void reQuestionWrite(@Param("replyVO") ReplyVO replyVO);
}
