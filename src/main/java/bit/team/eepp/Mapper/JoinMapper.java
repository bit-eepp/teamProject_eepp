package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import bit.team.eepp.VO.UserVO;

public interface JoinMapper {

	// SNS회원가입
	@Insert("insert into users (user_id, grade_id, uEmail, uNickname, uJoinDate, uPhone, snsType) values (users_seq.nextval, 2, #{uEmail}, #{uNickname}, SYSDATE, #{uPhone}, #{snsType})")
	public void JoinWithSNS(UserVO userVO);
	
	// 보통 회원가입
	@Insert("insert into users (user_id, grade_id, uEmail, uPassword, uNickname, uJoinDate, uPhone) values (users_seq.nextval, 2, #{uEmail}, #{uPassword}, #{uNickname}, SYSDATE, #{uPhone})")
	public void joinNormal(UserVO userVO);
	
	// 이메일 중복확인
	@Select("select count(*) from users where uEmail = #{uEmail}")
	public int checkDuplicate(@Param("uEmail") String uEmail);
	
	// 이메일 인증
	public boolean send(String subject, String text, String from, String to, String filePath);
	
	// 닉네임 중복확인
	@Select("select count(*) from users where uNickname = #{uNickname}")
	public int nickNameCheck(UserVO userVO);
}
