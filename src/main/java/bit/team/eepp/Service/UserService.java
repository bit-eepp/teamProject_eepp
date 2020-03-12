package bit.team.eepp.Service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.UserMapper;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.UserActiveVO;
import bit.team.eepp.VO.UserVO;

@Service("us")
public class UserService{

	@Inject
	UserMapper userMapper;

	public int CheckStatus(String uEmail) {
		return userMapper.CheckStatus(uEmail);
	}

	public UserVO UserInfo(String uEmail) {
		return userMapper.UserInfo(uEmail);
	}
	
	public void boardActive(UserActiveVO activeVO) {
		userMapper.boardActive(activeVO);
	}
	
	public int haveBoardActive(UserActiveVO activeVO) {
		return userMapper.haveBoardActive(activeVO);
	}
	
	public void replyActive(UserActiveVO activeVO) {
		userMapper.replyActive(activeVO);
	}
	
	public int haveReplyActive(UserActiveVO activeVO) {
		return userMapper.haveReplyActive(activeVO);
	}
	
	public int messageListCount(Map<String, Object> map) {
		return userMapper.messageListCount(map);
	}
	
	public List<MessageVO> messageList(Map<String, Object> map) {
		return userMapper.messageList(map);
	}
	
	public MessageVO showMyReceiveMessage(MessageVO messageVO) {
		return userMapper.showMyReceiveMessage(messageVO);
	}
	
	public MessageVO showMySendMessage(MessageVO messageVO) {
		return userMapper.showMySendMessage(messageVO);
	}
	
	public void deleteMessage(MessageVO messageVO) {
		userMapper.deleteMessage(messageVO);
	}
	
	public void changeMessageStatus(MessageVO messageVO) {
		userMapper.changeMessageStatus(messageVO);
	}
	
	public void replyMessage(MessageVO messageVO) {
		userMapper.replyMessage(messageVO);
	}

}
