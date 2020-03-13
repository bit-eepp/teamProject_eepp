package bit.team.eepp.Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.ScrapVO;
import bit.team.eepp.VO.UserActiveVO;
import bit.team.eepp.VO.UserVO;

public interface UserMapper {
	
	@Select("select count(*) from users where uEmail = #{uEmail}")
	public int CheckStatus(@Param("uEmail") String uEmail);
	
	@Select("select * from users where uEmail = #{uEmail}")
	public UserVO UserInfo(@Param("uEmail") String uEmail);
	
	// board 추천 or 비추천시 테이블에 이력 저장
	@Insert("insert into useractive (active_id, user_id, bId, active_type) values(SEQ_useractive.nextval, #{user_id}, #{bId}, #{active_type})")
	public void boardActive(UserActiveVO activeVO);
	
	// board 추천 or 비추천 중복 검사
	@Select("select count(*) from useractive where user_id = #{user_id} and active_type = #{active_type} and bid = #{bId}")
	public int haveBoardActive(UserActiveVO activeVO);
	
	// reply 추천 or 비추천시 테이블에 이력 저장
	@Insert("insert into useractive (active_id, user_id, rpId, active_type) values(SEQ_useractive.nextval, #{user_id}, #{rpId}, #{active_type})")
	public void replyActive(UserActiveVO activeVO);
	
	// reply 추천 or 비추천 중복 검사
	@Select("select count(*) from useractive where user_id = #{user_id} and active_type = #{active_type} and rpId = #{rpId}")
	public int haveReplyActive(UserActiveVO activeVO);
	
	// 쪽지 수 count
	public int messageListCount(Map<String, Object> map);
		
	// 받은 쪽지 출력
	public List<MessageVO> messageList(Map<String, Object> map);
		
	// 받은 쪽지 상세 출력
	@Select("select * from message inner join users on sender_id = user_id AND sender_id = #{sender_id} where mid = #{mid}")
	public MessageVO showMyReceiveMessage(MessageVO messageVO);
		
	// 보낸 쪽지 상세 출력
	@Select("select * from message inner join users on receiver_id = user_id AND receiver_id = #{receiver_id} where mid = #{mid}")
	public MessageVO showMySendMessage(MessageVO messageVO);
		
	// 쪽지 삭제
	@Select("delete message where mid = #{mid}")
	public void deleteMessage(MessageVO messageVO);
		
	// 쪽지 확인 상태 변경
	@Select("update message set status = '확인' where mid = #{mid}")
	public void changeMessageStatus(MessageVO messageVO);
		
	// 쪽지 보내기
	@Select("insert into message (mid, sender_id, receiver_id, mcontent, mdate) values (message_seq.nextval, #{sender_id}, #{receiver_id}, #{mcontent}, sysdate)")
	public void replyMessage(MessageVO messageVO);
	
	/*
	 * 마이페이지
	 */

	// 프로필 넣기
	@Update("UPDATE users SET uprofile = '${uprofile}' WHERE user_id = ${user_id}")
	public void profileUpdate(UserVO userVO) throws Exception;

	// 닉네임 중복체크
	@Select("select count(*) from users where uNickname = #{uNickname}")
	public int mypagenickNameCheck(UserVO userVO);

	// 닉네임 변경
	@Update("UPDATE users SET uNickname = '${uNickname}' WHERE user_id = ${user_id}")
	public void myNickNameUpdate(UserVO userVO);

	// 내가 쓴 게시물 총 개수
	public abstract int listCount(Map<String, Object> map);

	// 내가 쓴 댓글 총 개수
	public abstract int replyCount(Map<String, Object> map);

	// 내가 내 스크랩 개수
	public abstract int scrapCount(Map<String, Object> map);

	// 내가 쓴 게시물 리스트 + paging, 정렬 : 시간순
	public abstract List<BoardVO> myBoardList(Map<String, Object> map);

	// 회원탈퇴
	public abstract void withdrawal(UserVO userVO);
	
	// 내 스크랩 리스트
	public List<ScrapVO> scrapList(UserVO userVO);
}
