package bit.team.eepp.VO;

import java.sql.Timestamp;

public class PointVO {
	
	private int poId;
	private int user_id;
	private int poCharge;
	private int poBalance;
	private Timestamp poDate;
	
	public PointVO() {}
	
	public PointVO(int poId, int user_id, int poCharge, int poBalance, Timestamp poDate) {
		this.poId = poId;
		this.user_id = user_id;
		this.poCharge = poCharge;
		this.poBalance = poBalance;
		this.poDate = poDate;
	}
	
	public Timestamp getPoDate() {
		return poDate;
	}

	public void setPoDate(Timestamp poDate) {
		this.poDate = poDate;
	}

	public int getPoId() {
		return poId;
	}
	public void setPoId(int poId) {
		this.poId = poId;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getPoCharge() {
		return poCharge;
	}
	public void setPoCharge(int poCharge) {
		this.poCharge = poCharge;
	}
	public int getPoBalance() {
		return poBalance;
	}
	public void setPoBalance(int poBalance) {
		this.poBalance = poBalance;
	}
	
}
