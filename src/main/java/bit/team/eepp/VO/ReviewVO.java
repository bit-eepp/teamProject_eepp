package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReviewVO {
	private int rvId;
	private int eId;
	private int user_id;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp rvWrittenDate;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp rvModifyDate;
	private String rvComment;
	private int rvScore;
	private String uNickname;

	public ReviewVO() {
	}

	public ReviewVO(int rvId, int eId, int user_id, Timestamp rvWrittenDate, Timestamp rvModifyDate, String rvComment,
			int rvScore, String uNickname) {
		this.rvId = rvId;
		this.eId = eId;
		this.user_id = user_id;
		this.rvWrittenDate = rvWrittenDate;
		this.rvModifyDate = rvModifyDate;
		this.rvComment = rvComment;
		this.rvScore = rvScore;
		this.uNickname = uNickname;
	}

	public int getRvId() {
		return rvId;
	}

	public void setRvId(int rvId) {
		this.rvId = rvId;
	}

	public int geteId() {
		return eId;
	}

	public void seteId(int eId) {
		this.eId = eId;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Timestamp getRvWrittenDate() {
		return rvWrittenDate;
	}

	public void setRvWrittenDate(Timestamp rvWrittenDate) {
		this.rvWrittenDate = rvWrittenDate;
	}

	public Timestamp getRvModifyDate() {
		return rvModifyDate;
	}

	public void setRvModifyDate(Timestamp rvModifyDate) {
		this.rvModifyDate = rvModifyDate;
	}

	public String getRvComment() {
		return rvComment;
	}

	public void setRvComment(String rvComment) {
		this.rvComment = rvComment;
	}

	public int getRvScore() {
		return rvScore;
	}

	public void setRvScore(int rvScore) {
		this.rvScore = rvScore;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}
	
	
}
