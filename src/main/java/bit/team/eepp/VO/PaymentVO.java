package bit.team.eepp.VO;

import java.sql.Date;

public class PaymentVO {
	private int paId;
	private int class_id;
	private Date paDate;
	private String paInfo;
	private int user_id;
	private int point_io;
	
	public PaymentVO() {}
	
	public PaymentVO(int paId, int class_id, Date paDate, String paInfo, int user_id, int point_io) {
		this.paId = paId;
		this.class_id = class_id;
		this.paDate = paDate;
		this.paInfo = paInfo;
		this.user_id = user_id;
		this.point_io = point_io;
	}
	
	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getPoint_io() {
		return point_io;
	}

	public void setPoint_io(int point_io) {
		this.point_io = point_io;
	}



	public String getPaInfo() {
		return paInfo;
	}

	public void setPaInfo(String paInfo) {
		this.paInfo = paInfo;
	}

	public int getPaId() {
		return paId;
	}
	public void setPaId(int paId) {
		this.paId = paId;
	}
	public int getClass_id() {
		return class_id;
	}
	public void setClass_id(int class_id) {
		this.class_id = class_id;
	}
	public Date getPaDate() {
		return paDate;
	}
	public void setPaDate(Date paDate) {
		this.paDate = paDate;
	}

}
