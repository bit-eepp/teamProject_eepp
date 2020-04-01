package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import bit.team.eepp.VO.UserVO;

public interface LoginMapper {
	
	// 일반 로그인
	@Select("select * from users where uEmail = #{uEmail}")
	public UserVO normalLogin(@Param("uEmail") String uEmail);
	
	// SNS로그인 (가입한 소셜까지 확인)
	@Select("select * from users where uEmail = #{uEmail}")
	public UserVO snsLogin(@Param("uEmail") String uEmail);
	
	// 자동 로그인 = 로그인 유지
	@Update("update users set session_key = #{session_key}, session_limit = #{session_limit} where uEmail = #{uEmail}")
	public void keepLogin(UserVO userVO);
	
	// 자동 로그인을위한 세션키 검증
	@Select("select * from users where session_key = #{cookie_key}")
	public UserVO checkLoginBefore(@Param("cookie_key") String cookie_key);
	
	// 가입 이메일 찾기
	@Select("select uEmail from users where uPhone = #{uPhone}")
	public UserVO findRegisterEmail(UserVO userVO);
		
	// 비밀번호 재설정
	@Update("update users set uPassword = #{uPassword} where uEmail = #{uEmail}")
	public int resetPassword(UserVO userVO);
	
}
