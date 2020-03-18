package bit.team.eepp.VO;

import java.sql.Date;

public class PaymentVO {
	private int paId;
	private int class_id;
	private int point_id;
	private Date paDate;
	private String paInfo;
	
	
	public PaymentVO(int paId, int class_id, int point_id, Date paDate, String paInfo) {
		this.paId = paId;
		this.class_id = class_id;
		this.point_id = point_id;
		this.paDate = paDate;
		this.paInfo = paInfo;
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
	public int getPoint_id() {
		return point_id;
	}
	public void setPoint_id(int point_id) {
		this.point_id = point_id;
	}
	public Date getPaDate() {
		return paDate;
	}
	public void setPaDate(Date paDate) {
		this.paDate = paDate;
	}

}
