package bit.team.eepp.VO;

import java.sql.Timestamp;

public class DeclarationVO {
	private int dId;
	private int reporter_id;
	private int reported_id;
	private int board_id;
	private int reply_id;
	private int mid;
	private Timestamp dDate;
	private String dReason;
	
	public DeclarationVO() {}
	
	public DeclarationVO(int dId, int reporter_id, int reported_id, int board_id, int reply_id, int mid, Timestamp dDate, String dReason) {
		this.dId = dId;
		this.reporter_id = reporter_id;
		this.reported_id = reported_id;
		this.board_id = board_id;
		this.reply_id = reply_id;
		this.mid = mid;
		this.dDate = dDate;
		this.dReason = dReason;
	}

	public int getdId() {
		return dId;
	}

	public void setdId(int dId) {
		this.dId = dId;
	}

	public int getReporter_id() {
		return reporter_id;
	}

	public void setReporter_id(int reporter_id) {
		this.reporter_id = reporter_id;
	}

	public int getReported_id() {
		return reported_id;
	}

	public void setReported_id(int reported_id) {
		this.reported_id = reported_id;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public Timestamp getdDate() {
		return dDate;
	}

	public void setdDate(Timestamp dDate) {
		this.dDate = dDate;
	}

	public String getdReason() {
		return dReason;
	}

	public void setdReason(String dReason) {
		this.dReason = dReason;
	}

}
