package bit.team.eepp.Service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.UserMapper;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.DeclarationVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.PaymentVO;
import bit.team.eepp.VO.ScrapVO;
import bit.team.eepp.VO.UserActiveVO;
import bit.team.eepp.VO.UserVO;

@Service("us")
public class UserService {

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
	public int scrapBoardCount(Map<String, Object> map) {
		return userMapper.scrapBoardCount(map);
	}

	// (마이페이지)내 게시글 리스트
	public List<BoardVO> myBoardList(Map<String, Object> map) {
		return userMapper.myBoardList(map);
	}

	// (마이페이지) 회원탈퇴
	public void withdrawal(UserVO userVO) {
		userMapper.withdrawal(userVO);
	}

	// (마이페이지) 닉네임 중복체크
	public int mypagenickNameCheck(UserVO userVO) {
		return userMapper.mypagenickNameCheck(userVO);
	}

	// (마이페이지) 닉네임 변경
	public void myNickNameUpdate(UserVO userVO) {
		userMapper.myNickNameUpdate(userVO);
	}

	// (마이페이지) 내 스크랩 리스트
	public List<ScrapVO> scrapList(Map<String, Object> map) {
		return userMapper.scrapList(map);
	}

	// (마이페이지) 받은 쪽지
	public int receiveCount(Map<String, Object> map) {
		return userMapper.receiveCount(map);
	}

	// (마이페이지) 보낸 쪽지
	public int sendCount(Map<String, Object> map) {
		return userMapper.sendCount(map);
	}

	// (마이페이지) 포인트 리스트
	public List<PaymentVO> pointList(Map<String, Object> map) {
		return userMapper.pointList(map);
	}

	// (마이페이지) 포인트 개수
	public int pointCount(Map<String, Object> map) {
		return userMapper.pointCount(map);
	}

	// (마이페이지) 클래스 스크랩 개수
	public int scrapClassCount(Map<String, Object> map) {
		return userMapper.scrapClassCount(map);
	}

	// (마이페이지) 클래스 스크랩 리스트
	public List<ScrapVO> ClassscrapList(Map<String, Object> map) {
		return userMapper.ClassscrapList(map);
	}

	// (마이페이지) 가입한 클래스
	public List<ClassJoinVO> joinClass(Map<String, Object> map) {
		return userMapper.joinClass(map);
	}

	// (마이페이지) 개설한 클래스
	public List<ClassVO> openClass(Map<String, Object> map) {
		return userMapper.openClass(map);
	}

	// (마이페이지) 가입한 클래스 개수
	public int joinClassCount(Map<String, Object> map) {
		return userMapper.joinClassCount(map);
	}

	// (마이페이지) 개설한 클래스 개수
	public int openClassCount(Map<String, Object> map) {
		return userMapper.openClassCount(map);
	}

	/* 포인트 */
	public int chargePoint(UserVO userVO) {
		return userMapper.chargePoint(userVO);
	}

	public int getTotalPoint(int user_id) {
		return userMapper.getTotalPoint(user_id);
	}

	public int addPointPayment(PaymentVO paymentVO) {
		return userMapper.addPointPayment(paymentVO);
	}

	public void updateOpennerPoint(int opennerUser_id, int classPrice) {
		userMapper.updateOpennerPoint(opennerUser_id, classPrice);
	}

	public void updateParticipantPoint(int user_id, int classPrice) {
		userMapper.updateParticipantPoint(user_id, classPrice);
	}

	public void opennerPayment(PaymentVO paymentVO) {
		userMapper.opennerPayment(paymentVO);
	}

	public void participantPayment(PaymentVO paymentVO) {
		userMapper.participantPayment(paymentVO);
	}

}
