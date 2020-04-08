package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyVO {
	private int rpId;
	private String rpContent;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp rpWrittenDate;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp rpModifyDate;
	private int rpLike;
	private int rpUnlike;
	private int rpGroup;
	private int rpStep;
	private int rpIndent;
	private int board_id;
	private int class_id;
	private int user_id;
	private String uNickname;
	private int gCount;
	private int rpDcount;
	private String uProfile;
	private String rDeleted;

	public ReplyVO() {
	}

	public ReplyVO(int rpId, String rpContent, Timestamp rpWrittenDate, Timestamp rpModifyDate, int rpLike,
			int rpUnlike, int rpGroup, int rpStep, int rpIndent, int board_id, int class_id, int user_id,
			String uNickname, int gCount, int rpDcount, String uProfile, String rDeleted) {
		this.rpId = rpId;
		this.rpContent = rpContent;
		this.rpWrittenDate = rpWrittenDate;
		this.rpModifyDate = rpModifyDate;
		this.rpLike = rpLike;
		this.rpUnlike = rpUnlike;
		this.rpGroup = rpGroup;
		this.rpStep = rpStep;
		this.rpIndent = rpIndent;
		this.board_id = board_id;
		this.class_id = class_id;
		this.user_id = user_id;
		this.uNickname = uNickname;
		this.gCount = gCount;
		this.rpDcount = rpDcount;
		this.uProfile = uProfile;
		this.rDeleted = rDeleted;
	}
	

	public String getrDeleted() {
		return rDeleted;
	}

	public void setrDeleted(String rDeleted) {
		this.rDeleted = rDeleted;
	}

	public String getuProfile() {
		return uProfile;
	}

	public void setuProfile(String uProfile) {
		this.uProfile = uProfile;
	}

	public int getRpDcount() {
		return rpDcount;
	}

	public void setRpDcount(int rpDcount) {
		this.rpDcount = rpDcount;
	}

	public int getgCount() {
		return gCount;
	}

	public void setgCount(int gCount) {
		this.gCount = gCount;
	}

	public int getRpId() {
		return rpId;
	}

	public void setRpId(int rpId) {
		this.rpId = rpId;
	}

	public String getRpContent() {
		return rpContent;
	}

	public void setRpContent(String rpContent) {
		this.rpContent = rpContent;
	}

	public Timestamp getRpWrittenDate() {
		return rpWrittenDate;
	}

	public void setRpWrittenDate(Timestamp rpWrittenDate) {
		this.rpWrittenDate = rpWrittenDate;
	}

	public Timestamp getRpModifyDate() {
		return rpModifyDate;
	}

	public void setRpModifyDate(Timestamp rpModifyDate) {
		this.rpModifyDate = rpModifyDate;
	}

	public int getRpLike() {
		return rpLike;
	}

	public void setRpLike(int rpLike) {
		this.rpLike = rpLike;
	}

	public int getRpUnlike() {
		return rpUnlike;
	}

	public void setRpUnlike(int rpUnlike) {
		this.rpUnlike = rpUnlike;
	}

	public int getRpGroup() {
		return rpGroup;
	}

	public void setRpGroup(int rpGroup) {
		this.rpGroup = rpGroup;
	}

	public int getRpStep() {
		return rpStep;
	}

	public void setRpStep(int rpStep) {
		this.rpStep = rpStep;
	}

	public int getRpIndent() {
		return rpIndent;
	}

	public void setRpIndent(int rpIndent) {
		this.rpIndent = rpIndent;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
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

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

}