package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.ChattingMapper;
import bit.team.eepp.VO.ChattingMemberVO;
import bit.team.eepp.VO.ChattingVO;

@Service
public class ChattingService {

	@Autowired
	private ChattingMapper chattingMapper;

	public List<ChattingVO> getChatRoomList() {
		return chattingMapper.getChatRoomList();
	}
	
	public int getTotalChatCount() {
		return chattingMapper.getTotalChatCount();
	}
	
	public List<ChattingVO> getMoreChatList(int startNum, int endNum) {
		return chattingMapper.getMoreChatList(startNum, endNum);
	}
	
	public ChattingVO chatRoomSelect(int chId) {
		return chattingMapper.chatRoomSelect(chId);
	}

	public void chatRoomMake(ChattingVO chattingVO) {
		chattingMapper.chatRoomMake(chattingVO);
	}

	public void chatRoomDelete(int chId) {
		chattingMapper.chatRoomDelete(chId);
	}

	public int getPeopleCount(int chatting_id) {
		return chattingMapper.getPeopleCount(chatting_id);
	}

	public void addMember(int chId, int user_id) {
		chattingMapper.addMember(chId, user_id);
	}

	public void removeMember(int user_id) {
		chattingMapper.removeMember(user_id);
	}

	public List<ChattingMemberVO> getMemberList(int chatting_id) {
		return chattingMapper.getMemberList(chatting_id);
	}

	public List<ChattingMemberVO> getUserIdList(int chId) {
		return chattingMapper.getUserIdList(chId);
	}


}
