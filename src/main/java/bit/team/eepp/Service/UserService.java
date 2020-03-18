package bit.team.eepp.Service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.UserMapper;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.DeclarationVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.PointVO;
import bit.team.eepp.VO.ScrapVO;
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
	
	public int cancleMessage(MessageVO messageVO) {
		return userMapper.cancleMessage(messageVO);
	}
	
	public void changeMessageStatus(MessageVO messageVO) {
		userMapper.changeMessageStatus(messageVO);
	}
	
	public void reportMessage(MessageVO messageVO) {
		userMapper.reportMessage(messageVO);
	}
	
	public DeclarationVO reportMessageInfo(DeclarationVO declarationVO) {
		return userMapper.reportMessageInfo(declarationVO);
	}
	
	public void replyMessage(MessageVO messageVO) {
		userMapper.replyMessage(messageVO);
	}
	
	/*
	 * 마이페이지
	 */

	// (마이페이지)프로필 업로드
	public void profileUpdate(UserVO userVO) throws Exception {
		userMapper.profileUpdate(userVO);
	}

	// (마이페이지)내 게시글 갯수
	public int listCount(Map<String, Object> map) {
		return userMapper.listCount(map);
	}

	// (마이페이지)내 댓글 갯수
	public int replyCount(Map<String, Object> map) {
		return userMapper.replyCount(map);
	}

	// (마이페이지)내 댓글 갯수
	public int scrapCount(Map<String, Object> map) {
		return userMapper.scrapCount(map);
	}

	// (마이페이지)내 게시글 리스트
	public List<BoardVO> myBoardList(Map<String, Object> map) {
		return userMapper.myBoardList(map);
	}
	//(마이페이지) 회원탈퇴
	public void withdrawal(UserVO userVO) {
		userMapper.withdrawal(userVO);
	}

	public int mypagenickNameCheck(UserVO userVO) {
		
		return userMapper.mypagenickNameCheck(userVO);
	}
	
	public void myNickNameUpdate(UserVO userVO) {
		userMapper.myNickNameUpdate(userVO);
	}

	public List<ScrapVO> scrapList(UserVO userVO) {
		return userMapper.scrapList(userVO);
	}
	
	/* 포인트 */
	public PointVO haveChargePoint(PointVO pointVO) {
		return userMapper.haveChargePoint(pointVO);
	}

	public int firstChargePoint(PointVO pointVO) {
		return userMapper.firstChargePoint(pointVO);
	}
		
	public int chargePoint(PointVO pointVO) {
		return userMapper.chargePoint(pointVO);
	}
	
	public int addPointPayment(PointVO pointVO) {
		return userMapper.addPointPayment(pointVO);
	}

}
