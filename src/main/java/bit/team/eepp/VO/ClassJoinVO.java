package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ClassJoinVO {
	private int cjId;
	private int class_id;
	private int user_id;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp cjJoinDate;
	private String cTitle;
	private String cCategory;
	private String cPrice;

	public ClassJoinVO() {
		
	}
	
	public ClassJoinVO(int cjId, int class_id, int user_id, Timestamp cjJoinDate, String cTitle, String cCategory,
			String cPrice) {
		this.cjId = cjId;
		this.class_id = class_id;
		this.user_id = user_id;
		this.cjJoinDate = cjJoinDate;
		this.cTitle = cTitle;
		this.cCategory = cCategory;
		this.cPrice = cPrice;
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
