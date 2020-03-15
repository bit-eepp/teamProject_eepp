package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import bit.team.eepp.VO.ChattingMemberVO;
import bit.team.eepp.VO.ChattingVO;

public interface ChattingMapper {

	public abstract List<ChattingVO> getChatRoomList();

	public abstract int getTotalChatCount();

	public abstract List<ChattingVO> getMoreChatList(@Param("startNum") int startNum, @Param("endNum") int endNum);

	public abstract ChattingVO chatRoomSelect(@Param("chId") int chId);

	public abstract void chatRoomMake(@Param("chattingVO") ChattingVO chattingVO);

	public abstract void chatRoomDelete(@Param("chId") int chId);

	public abstract int getPeopleCount(@Param("chatting_id") int chId);

	public abstract void addMember(@Param("chId") int chId, @Param("user_id") int user_id);

	public abstract void removeMember(@Param("user_id") int user_id);

	public abstract List<ChattingMemberVO> getMemberList(@Param("chatting_id") int chatting_id);

	public abstract List<ChattingMemberVO> getUserIdList(@Param("chId") int chId);

}
