package bit.team.eepp.Service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
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
	
//	public void classActive(UserActiveVO activeVO) {
//		userMapper.classActive(activeVO);
//	}
	
	public void replyActive(UserActiveVO activeVO) {
		userMapper.replyActive(activeVO);
	}
	
	public int haveReplyActive(UserActiveVO activeVO) {
		return userMapper.haveReplyActive(activeVO);
	}
	
	public List<MessageVO> myReceiveMessage(MessageVO messageVO) {
		return userMapper.myReceiveMessage(messageVO);
	}
	
	public List<MessageVO> mySendMessage(MessageVO messageVO) {
		return userMapper.mySendMessage(messageVO);
	}

}
