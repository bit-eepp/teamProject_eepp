package bit.team.eepp.VO;

import java.sql.Date;

public class PaymentVO {
	private int paId;
	private int class_id;
	private Date paDate;
	private String paInfo;	// 포인트 내역 : 충전(+), 입금(+), 사용(-)
	private int user_id;	// 본인의 user_id
	private int point_io;	// + 또는 -되는 포인트 양(충전, 사용, 입금)
	private int totalPoint; // 해당 결제내역마다의 개인별 포인트 총액

	public PaymentVO() {
	}

	public PaymentVO(int paId, int class_id, Date paDate, String paInfo, int user_id, int point_io, int totalPoint) {
		this.paId = paId;
		this.class_id = class_id;
		this.paDate = paDate;
		this.paInfo = paInfo;
		this.user_id = user_id;
		this.point_io = point_io;
		this.totalPoint = totalPoint;
	}

	public int getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
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
