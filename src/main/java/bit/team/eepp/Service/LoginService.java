package bit.team.eepp.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.LoginMapper;
import bit.team.eepp.VO.UserVO;

@Service("ls")
public class LoginService{
	
	
	@Autowired
	LoginMapper loginMapper;

	public UserVO normalLogin(UserVO userVO) {
		return loginMapper.normalLogin(userVO);
	}
	
	// 자동 로그인 = 로그인 유지
	public void keepLogin(UserVO userVO) {
		loginMapper.keepLogin(userVO);
	}
		
	// 자동 로그인을위한 세션키 검증
	public UserVO checkLoginBefore(String cookie_key) {
		return loginMapper.checkLoginBefore(cookie_key);
	}
	
	// 가입 이메일 찾기
	public UserVO findRegisterEmail(UserVO userVO) {
		return loginMapper.findRegisterEmail(userVO);
	}
	
	// 비밀번호 재설정
	public int resetPassword(UserVO userVO) {
		return loginMapper.resetPassword(userVO);
	}
}
