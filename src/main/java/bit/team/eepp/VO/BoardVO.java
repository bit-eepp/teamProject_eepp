package bit.team.eepp.VO;

import java.sql.Timestamp;

public class BoardVO {
	private int bId;
	private int user_id;
	private String bTitle;
	private String bContent;
	private String bSubject;
	private String bCategory;
	private Timestamp bWrittenDate;
	private Timestamp bModifyDate;
	private int bHit;
	private int bLike;
	private int bUnlike;
	private String bBlind;

	public BoardVO() {
	}

	public BoardVO(int bId, int user_id, String bTitle, String bContent, String bSubject, String bCategory,
			Timestamp bWrittenDate, Timestamp bModifyDate, int bHit, int bLike, int bUnlike, String bBlind) {
		this.bId = bId;
		this.user_id = user_id;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bSubject = bSubject;
		this.bCategory = bCategory;
		this.bWrittenDate = bWrittenDate;
		this.bModifyDate = bModifyDate;
		this.bHit = bHit;
		this.bLike = bLike;
		this.bUnlike = bUnlike;
		this.bBlind = bBlind;
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public String getbSubject() {
		return bSubject;
	}

	public void setbSubject(String bSubject) {
		this.bSubject = bSubject;
	}

	public String getbCategory() {
		return bCategory;
	}

	public void setbCategory(String bCategory) {
		this.bCategory = bCategory;
	}

	public Timestamp getbWrittenDate() {
		return bWrittenDate;
	}

	public void setbWrittenDate(Timestamp bWrittenDate) {
		this.bWrittenDate = bWrittenDate;
	}

	public Timestamp getbModifyDate() {
		return bModifyDate;
	}

	public void setbModifyDate(Timestamp bModifyDate) {
		this.bModifyDate = bModifyDate;
	}

	public int getbHit() {
		return bHit;
	}

	public void setbHit(int bHit) {
		this.bHit = bHit;
	}

	public int getbLike() {
		return bLike;
	}

	public void setbLike(int bLike) {
		this.bLike = bLike;
	}

	public int getbUnlike() {
		return bUnlike;
	}

	public void setbUnlike(int bUnlike) {
		this.bUnlike = bUnlike;
	}

	public String getbBlind() {
		return bBlind;
	}

	public void setbBlind(String bBlind) {
		this.bBlind = bBlind;
	}

}
