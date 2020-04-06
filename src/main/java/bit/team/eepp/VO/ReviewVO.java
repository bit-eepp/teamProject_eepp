package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReviewVO {
	private int rvId;
	private int eating_id;
	private int user_id;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp rvWrittenDate;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp rvModifyDate;
	private String rvComment;
	private float rvScore;
	private float reviewAVG;
	private String ename;
	
	public float getReviewAVG() {
		return reviewAVG;
	}

	public void setReviewAVG(float reviewAVG) {
		this.reviewAVG = reviewAVG;
	}

	private String uNickname;

	public ReviewVO() {
	}

	public ReviewVO(float reviewAVG,int rvId, int eating_id, int user_id, Timestamp rvWrittenDate, Timestamp rvModifyDate, String rvComment,
			float rvScore, String uNickname,String ename) {
		this.rvId = rvId;
		this.reviewAVG = reviewAVG;
		this.eating_id = eating_id;
		this.user_id = user_id;
		this.rvWrittenDate = rvWrittenDate;
		this.rvModifyDate = rvModifyDate;
		this.rvComment = rvComment;
		this.rvScore = rvScore;
		this.uNickname = uNickname;
		this.ename = ename;
	}
	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public int getEating_id() {
		return eating_id;
	}

	public void setEating_id(int eating_id) {
		this.eating_id = eating_id;
	}

	public int getRvId() {
		return rvId;
	}

	public void setRvId(int rvId) {
		this.rvId = rvId;
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

	public float getRvScore() {
		return rvScore;
	}

	public void setRvScore(float rvScore) {
		this.rvScore = rvScore;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}
	
	
}