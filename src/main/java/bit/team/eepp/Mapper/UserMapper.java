package bit.team.eepp.Mapper;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.DeclarationVO;
import bit.team.eepp.VO.MessageVO;
import bit.team.eepp.VO.PaymentVO;
import bit.team.eepp.VO.ReviewVO;
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

	/*
	 * 쪽지
	 */

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
	@Delete("delete message where mid = #{mid}")
	public void deleteMessage(MessageVO messageVO);

	// 쪽지 발송 취소
	@Delete("delete message where mid = #{mid} AND status = '읽지않음'")
	public int cancleMessage(MessageVO messageVO);

	// 쪽지 확인 상태 변경
	@Update("update message set status = '읽음' where mid = #{mid}")
	public void changeMessageStatus(MessageVO messageVO);

	// 쪽지 신고
	@Update("update message set mblind = 1 where mid = #{mid}")
	public void reportMessage(MessageVO messageVO);

	// 쪽지 신고 내용
	@Select("select m.mid,d.dReason,d.did from message m, declaration d,users u where m.mid = d.mid AND m.mid = #{mid} AND u.user_id = d.reporter_id")
	public DeclarationVO reportMessageInfo(DeclarationVO declarationVO);

	// 쪽지 보내기
	@Insert("insert into message (mid, sender_id, receiver_id, mcontent, mdate) values (message_seq.nextval, #{sender_id}, #{receiver_id}, #{mcontent}, sysdate)")
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

	// 포인트 사용 내역 개수
	@Select("select count(*) from payment where user_id = #{user_id}")
	public int pointCount(Map<String, Object> map);

	// 구매한 클래스
	public abstract List<ClassJoinVO> joinClass(Map<String, Object> map);

	// 구매한 클래스 개수
	@Select("select count(*) from classjoin where user_id = #{user_id}")
	public int joinClassCount(Map<String, Object> map);

	// 개설한 클래스
	public abstract List<ClassVO> openClass(Map<String, Object> map);

	// 개설한 클래스 개수
	@Select("select count(*) from class where user_id = #{user_id} and cDeleted != 'yes'")
	public int openClassCount(Map<String, Object> map);

	// (회원정보) 프로필 보여주기
	@Select("select uprofile from users where user_id = #{user_id}")
	public String mInfoProfile(Map<String, Object> map);

	// (회원정보) 등급 보여주기
	@Select("select grade_id from users where user_id =  #{user_id}")
	public int memberInfograde(Map<String, Object> map);

	// (회원정보) 가입 날짜 보여주기
	@Select("select ujoindate from users where user_id = #{user_id}")
	public Date memberInfoJDate(Map<String, Object> map);

	// 스크랩 삭제
	@Delete("delete Scrap where sId = #{sId} and user_id = #{user_id}")
	public void deleteScrap(ScrapVO scrapVO);

	// 클래스 가입한 인원
	@Select("select cj.user_id,cj.cjjoindate,(select uNickname from users u where u.user_id = cj.user_id) as usernick, "
			+ "(select uphone from users u where u.user_id = cj.user_id) as uPhone from classjoin cj where cj.class_id = #{cId}")
	public abstract List<ClassJoinVO> classjoinList(Map<String, Object> map);

	// 포인트 가져오기
	public abstract List<PaymentVO> pointList(Map<String, Object> map);

	// 받은 쪽지 개수
	public abstract int receiveCount(Map<String, Object> map);

	// 보낸 쪽지 개수
	public abstract int sendCount(Map<String, Object> map);

	// 내가 쓴 게시물 총 개수
	public abstract int listCount(Map<String, Object> map);

	// 내가 쓴 댓글 총 개수
	public abstract int replyCount(Map<String, Object> map);

	// 내 스크랩 개수
	public abstract int ScrapCount(Map<String, Object> map);

	// 내가 쓴 게시물 리스트 + paging, 정렬 : 시간순
	public abstract List<BoardVO> myBoardList(Map<String, Object> map);

	// 회원탈퇴
	public abstract void withdrawal(UserVO userVO);

	// 내 게시물 스크랩 리스트
	public List<ScrapVO> scrapList(Map<String, Object> map);

	// 내 클래스 스크랩 개수
	public abstract int scrapClassCount(Map<String, Object> map);

	// 내 클래스 스크랩 리스트
	public List<ScrapVO> ClassscrapList(Map<String, Object> map);

	// 맛집 스크랩 개수
	public abstract int scrapEatingCount(Map<String, Object> map);

	// 맛집 스크랩 리스트
	public List<ScrapVO> EatingScrapList(Map<String, Object> map);

	// 내가 쓴 리뷰 리스트
	public abstract List<ReviewVO> reviewList(Map<String, Object> map);

	// 내가 쓴 리뷰 카운트
	@Select("select count(*) from eating e, review rv where e.eid = rv.eating_id and rv.rvDeleted = 'no' and rv.user_id = #{user_id}")
	public int reviewListCount(Map<String, Object> map);

	/* 운영자 마이페이지 */

	// 컨텐츠 현황

	// All
	@Select("select count(bId) from board where bDeleted != 'yes'")
	public int BListALL(Map<String, Object> map);

	// IT/개발
	@Select("select count(bId) from board where bcategory ='IT/개발' AND bDeleted != 'yes'")
	public int BListIT(Map<String, Object> map);

	// 서비스
	@Select("select count(bId) from board where bcategory ='서비스' AND bDeleted != 'yes'")
	public int BListService(Map<String, Object> map);

	// 금융
	@Select("select count(bId) from board where bcategory ='금융' AND bDeleted != 'yes'")
	public int BListFinancial(Map<String, Object> map);

	// 디자인
	@Select("select count(bId) from board where bcategory ='디자인' AND bDeleted != 'yes'")
	public int BListDesign(Map<String, Object> map);

	// 공무원
	@Select("select count(bId) from board where bcategory ='공무원' AND bDeleted != 'yes'")
	public int BListOfficer(Map<String, Object> map);

	// 기타
	@Select("select count(bId) from board where bcategory ='기타' AND bDeleted != 'yes'")
	public int BListEtc(Map<String, Object> map);

	// 클래스 현황

	// All
	@Select("select count(cId) from class where cDeleted != 'yes'")
	public int CListALL(Map<String, Object> map);

	// it_dev
	@Select("select count(cId) from class where ccategory = 'it_dev' AND cDeleted != 'yes'")
	public int CListIt_dev(Map<String, Object> map);

	// etc
	@Select("select count(cId) from class where ccategory = 'etc' AND cDeleted != 'yes'")
	public int CListEtc(Map<String, Object> map);

	// workSkill
	@Select("select count(cId) from class where ccategory = 'workSkill' AND cDeleted != 'yes'")
	public int CListWorkSkill(Map<String, Object> map);

	// financialTechnology
	@Select("select count(cId) from class where ccategory = 'financialTechnology' AND cDeleted != 'yes'")
	public int CListFinacialTech(Map<String, Object> map);

	// daily
	@Select("select count(cId) from class where ccategory = 'daily' AND cDeleted != 'yes'")
	public int CListDaily(Map<String, Object> map);

	// 회원 목록
	public abstract List<UserVO> MemberList(Map<String, Object> map);

	// 회원 수 카운트
	@Select("select count(*) from users")
	public int MemberListCount(Map<String, Object> map);

	// 공지사항 목록
	public abstract List<BoardVO> noticeList(Map<String, Object> map);

	// 공지사항 개수 카운트
	@Select("SELECT COUNT(*) FROM BOARD WHERE BCATEGORY='공지' AND bDeleted != 'yes'")
	public int noticeListCount(Map<String, Object> map);

	// 유저신고 목록
	public abstract List<BoardVO> UserReportList(Map<String, Object> map);

	// 유저 신고 개수 카운트
	@Select("select count(*) from declaration where not reported_id is null")
	public int UserReportListCount(Map<String, Object> map);

	// 게시글 신고 목록
	public abstract List<BoardVO> BoardReportList(Map<String, Object> map);

	// 게시글 신고 개수 카운트
	@Select("select count(*) from declaration where not board_id is null")
	public int BoardReportListCount(Map<String, Object> map);

	// 댓글 신고 목록
	public abstract List<BoardVO> ReplyReportList(Map<String, Object> map);

	// 댓글 신고 개수 카운트
	@Select("select  count(*) from declaration where not reply_id is null")
	public int ReplyReportListCount(Map<String, Object> map);

	// 등급 변경
	@Update("UPDATE users SET grade_Id = #{grade_Id} WHERE user_id = #{user_id}")
	public int UpdateGrade(UserVO userVO);

	/*
	 * 포인트
	 */

	// 포인트 충전
	@Update("update users set point = point + #{point} where user_id = #{user_id}")
	public int chargePoint(UserVO userVO);

	// 해당유저의 총 포인트 가져오기
	@Select("SELECT point FROM USERS WHERE user_id = #{user_id}")
	public int getTotalPoint(int user_id);

	// 충전시 결제내역에 추가
	public int addPointPayment(@Param("paymentVO") PaymentVO paymentVO);

	// 개설자의 총 포인트 금액 update, 참여자가 보낸 포인트만큼 추가
	@Update("update users set point = point + #{classPrice} where user_id = #{opennerUser_id}")
	public void updateOpennerPoint(@Param("opennerUser_id") int opennerUser_id, @Param("classPrice") int classPrice);

	// 개설자 포인트 입금내역 추가
	public void opennerPayment(@Param("paymentVO") PaymentVO paymentVO);

	// 참가자의 총 포인트 금액 update, 클래스 금액만큼 차감
	@Update("update users set point = point - #{classPrice} where user_id = #{user_id}")
	public void updateParticipantPoint(@Param("user_id") int user_id, @Param("classPrice") int classPrice);

	// 참가자 포인트 사용내역 추가
	public void participantPayment(@Param("paymentVO") PaymentVO paymentVO);

	// 클래스 개설자의 정보(닉네임, 연락처)
	@Select("select uNickname, uPhone from users where user_id = #{opennerUser_id}")
	public UserVO getOpennerInfo(@Param("opennerUser_id") int opennerUser_id);

	// 신청자 연락처
	@Select("select uPhone from users where user_id = #{user_id}")
	public String getJoinnerInfo(@Param("user_id") int user_id);

}
