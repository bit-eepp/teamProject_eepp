package bit.team.eepp.VO;

import java.sql.Timestamp;

public class ClassJoinVO {
	private int cjId;
	private int class_id;
	private int user_id;
	private Timestamp cjJoinDate;
	private String cTitle;
	private String cCategory;
	private String cPrice;
	private String usernick;
	private String uPhone;


	public ClassJoinVO() {
		
	}
	
	public ClassJoinVO(int cjId, int class_id, int user_id, Timestamp cjJoinDate, String cTitle, String cCategory,
			String cPrice, String usernick,String uPhone) {
		this.cjId = cjId;
		this.class_id = class_id;
		this.user_id = user_id;
		this.cjJoinDate = cjJoinDate;
		this.cTitle = cTitle;
		this.cCategory = cCategory;
		this.cPrice = cPrice;
		this.usernick = usernick;
		this.uPhone = uPhone;
	}
	
	public String getuPhone() {
		return uPhone;
	}

	public void setuPhone(String uPhone) {
		this.uPhone = uPhone;
	}

	public String getUsernick() {
		return usernick;
	}
	
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}

	public int getCjId() {
		return cjId;
	}

	public void setCjId(int cjId) {
		this.cjId = cjId;
	}

	public int getClass_id() {
		return class_id;
	}

	public void setClass_id(int class_id) {
		this.class_id = class_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Timestamp getCjJoinDate() {
		return cjJoinDate;
	}

	public void setCjJoinDate(Timestamp cjJoinDate) {
		this.cjJoinDate = cjJoinDate;
	}

	public String getcTitle() {
		return cTitle;
	}

	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}

	public String getcCategory() {
		return cCategory;
	}

	public void setcCategory(String cCategory) {
		this.cCategory = cCategory;
	}

	public String getcPrice() {
		return cPrice;
	}

	public void setcPrice(String cPrice) {
		this.cPrice = cPrice;
	}
}
