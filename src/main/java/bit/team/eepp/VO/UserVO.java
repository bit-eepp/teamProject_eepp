package bit.team.eepp.VO;

import java.sql.Timestamp;

public class UserVO {
	
	private int user_id;
	private int grade_Id;
	private String uEmail;
	private String uPassword;
	private String uNickname;
	private Timestamp uJoinDate;
	private Timestamp uModifyDate;
	private String uaccessToken;
	private String urefrechToken;
	private String uPhone;
	private String snsType;
	private String session_key;
	private Timestamp session_limit;
	private String uprofile;
	private int point;
	
	public UserVO() {}

	public UserVO(int user_id, int grade_Id, String uEmail, String uPassword, String uNickname, Timestamp uJoinDate,
			Timestamp uModifyDate, String uaccessToken, String urefrechToken, String uPhone, String snsType,
			String session_key, Timestamp session_limit, String uprofile, int point) {
		this.user_id = user_id;
		this.grade_Id = grade_Id;
		this.uEmail = uEmail;
		this.uPassword = uPassword;
		this.uNickname = uNickname;
		this.uJoinDate = uJoinDate;
		this.uModifyDate = uModifyDate;
		this.uaccessToken = uaccessToken;
		this.urefrechToken = urefrechToken;
		this.uPhone = uPhone;
		this.snsType = snsType;
		this.session_key = session_key;
		this.session_limit = session_limit;
		this.uprofile = uprofile;
		this.point = point;
	}
	
	
	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getUprofile() {
		return uprofile;
	}
	
	public void setUprofile(String uprofile) {
		this.uprofile = uprofile;
	}
	
	public String getSession_key() {
		return session_key;
	}

	public void setSession_key(String session_key) {
		this.session_key = session_key;
	}

	public Timestamp getSession_limit() {
		return session_limit;
	}

	public void setSession_limit(Timestamp session_limit) {
		this.session_limit = session_limit;
	}

	public String getSnsType() {
		return snsType;
	}

	public void setSnsType(String snsType) {
		this.snsType = snsType;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getGrade_Id() {
		return grade_Id;
	}

	public void setGrade_Id(int grade_Id) {
		this.grade_Id = grade_Id;
	}

	public String getuEmail() {
		return uEmail;
	}

	public void setuEmail(String uEmail) {
		this.uEmail = uEmail;
	}

	public String getuPassword() {
		return uPassword;
	}

	public void setuPassword(String uPassword) {
		this.uPassword = uPassword;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

	public Timestamp getuJoinDate() {
		return uJoinDate;
	}

	public void setuJoinDate(Timestamp uJoinDate) {
		this.uJoinDate = uJoinDate;
	}

	public Timestamp getuModifyDate() {
		return uModifyDate;
	}

	public void setuModifyDate(Timestamp uModifyDate) {
		this.uModifyDate = uModifyDate;
	}

	public String getUaccessToken() {
		return uaccessToken;
	}

	public void setUaccessToken(String uaccessToken) {
		this.uaccessToken = uaccessToken;
	}

	public String getUrefrechToken() {
		return urefrechToken;
	}

	public void setUrefrechToken(String urefrechToken) {
		this.urefrechToken = urefrechToken;
	}

	public String getuPhone() {
		return uPhone;
	}

	public void setuPhone(String uPhone) {
		this.uPhone = uPhone;
	}
	
	

}
