package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.PathVariable;

import bit.team.eepp.Page.ReplyCriteria;
import bit.team.eepp.VO.ReplyVO;

public interface ReplyMapper {
	public abstract int replyCount(@Param("board_id") int board_id);
	
	public abstract List<ReplyVO> replyList(@Param("rpCriteria") ReplyCriteria rpCriteria, @Param("board_id") int board_id);

	public abstract void replyWrite(@Param("replyVO") ReplyVO replyVO);

	public abstract void replyModify(@Param("replyVO") ReplyVO replyVO);
	
	public abstract void replyDelete(@Param("rpId") int rpId);

	public abstract void replyShape(@Param("rpGroup") int rpGroup, @Param("rpStep") int rpStep);

	public abstract void reReplyWrite(@Param("replyVO") ReplyVO replyVO);


}
