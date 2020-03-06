package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
	@Select("select count(*) from useractive where user_id = #{user_id} and active_type = #{active_type}")
	public int haveBoardActive(UserActiveVO activeVO);
	
	// class 추천 or 비추천시 테이블에 이력 저장
//	@Insert("insert into useractive (active_id, user_id, cId, active_date) values(SEQ_useractive.nextval, #{user_id}, #{cId}, #{active_type})")
//	public void classActive(UserActiveVO activeVO);
//	
//	@Select("select count(*) from useractive where user_id = #{user_id} and active_type = #{active_type}")
//	public int haveClassActive(UserActiveVO activeVO);
	
	// reply 추천 or 비추천시 테이블에 이력 저장
	@Insert("insert into useractive (active_id, user_id, rpId, active_type) values(SEQ_useractive.nextval, #{user_id}, #{rpId}, #{active_type})")
	public void replyActive(UserActiveVO activeVO);
	
	// reply 추천 or 비추천 중복 검사
	@Select("select count(*) from useractive where user_id = #{user_id} and active_type = #{active_type}")
	public int haveReplyActive(UserActiveVO activeVO);
	
}
