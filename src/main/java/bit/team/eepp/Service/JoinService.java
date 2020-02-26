package bit.team.eepp.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.JoinMapper;
import bit.team.eepp.VO.UserVO;

@Service("js")
public class JoinService{

	@Autowired
	JoinMapper joinMapper;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
		}
	
	// SNS회원가입
	public void JoinWithSNS(UserVO userVO){
		joinMapper.JoinWithSNS(userVO);
	}
	
	public void joinNormal(UserVO userVO) {
		joinMapper.joinNormal(userVO);
	}
	
	// 이메일 중복확인
	public int checkDuplicate(String uEmail) {
		return joinMapper.checkDuplicate(uEmail);
	}
	
	// 이메일 인증
	public boolean send(String subject, String text, String from, String to) {
		
		// javax.mail.internet.MimeMessage
		MimeMessage message = javaMailSender.createMimeMessage();
		
		try {
			// org.springframework.mail.javamail.MimeMessageHelper
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setSubject(subject);
			helper.setText(text, true);
			helper.setFrom(from);
			helper.setTo(to);
			
			javaMailSender.send(message);
			
			return true;
			} catch (MessagingException e) {
				e.printStackTrace();
				}
		return false;
	}
	
	// 닉네임 중복확인
	public int nickNameCheck(UserVO userVO) {
		return joinMapper.nickNameCheck(userVO);
	}
	
	
}
