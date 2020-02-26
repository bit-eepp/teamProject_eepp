package bit.team.eepp.VO;

import java.sql.Timestamp;

public class ClassVO {
	private int cId;
	private int user_id;
	private String cTitle;
	private String cContent;
	private Timestamp cOpenDate;
	private Timestamp cEndDate;
	private int cPrice;
	private String cCategory;
	private String uNickname;
	private int cTotalPeopleCount;
	private int cCurrentPeopleCount;
	private String cDifficulty;
	private String cMaterials;
	private String cSummary;
	private int cTerm;
	private int questionCount;

	public ClassVO() {
	}

	public ClassVO(int cId, int user_id, String cTitle, String cContent, Timestamp cOpenDate, Timestamp cEndDate,
			int cPrice, String cCategory, String uNickname, int cTotalPeopleCount, int cCurrentPeopleCount,
			String cDifficulty, String cMaterials, String cSummary, int cTerm, int questionCount) {
		this.cId = cId;
		this.user_id = user_id;
		this.cTitle = cTitle;
		this.cContent = cContent;
		this.cOpenDate = cOpenDate;
		this.cEndDate = cEndDate;
		this.cPrice = cPrice;
		this.cCategory = cCategory;
		this.uNickname = uNickname;
		this.cTotalPeopleCount = cTotalPeopleCount;
		this.cCurrentPeopleCount = cCurrentPeopleCount;
		this.cDifficulty = cDifficulty;
		this.cMaterials = cMaterials;
		this.cSummary = cSummary;
		this.cTerm = cTerm;
		this.questionCount = questionCount;
	}

	public int getQuestionCount() {
		return questionCount;
	}

	public void setQuestionCount(int questionCount) {
		this.questionCount = questionCount;
	}

	public int getcTerm() {
		return cTerm;
	}

	public void setcTerm(int cTerm) {
		this.cTerm = cTerm;
	}

	public int getcId() {
		return cId;
	}

	public void setcId(int cId) {
		this.cId = cId;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getcTitle() {
		return cTitle;
	}

	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}

	public String getcContent() {
		return cContent;
	}

	public void setcContent(String cContent) {
		this.cContent = cContent;
	}

	public Timestamp getcOpenDate() {
		return cOpenDate;
	}

	public void setcOpenDate(Timestamp cOpenDate) {
		this.cOpenDate = cOpenDate;
	}

	public Timestamp getcEndDate() {
		return cEndDate;
	}

	public void setcEndDate(Timestamp cEndDate) {
		this.cEndDate = cEndDate;
	}

	public int getcPrice() {
		return cPrice;
	}

	public void setcPrice(int cPrice) {
		this.cPrice = cPrice;
	}

	public String getcCategory() {
		return cCategory;
	}

	public void setcCategory(String cCategory) {
		this.cCategory = cCategory;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

	public int getcTotalPeopleCount() {
		return cTotalPeopleCount;
	}

	public void setcTotalPeopleCount(int cTotalPeopleCount) {
		this.cTotalPeopleCount = cTotalPeopleCount;
	}

	public int getcCurrentPeopleCount() {
		return cCurrentPeopleCount;
	}

	public void setcCurrentPeopleCount(int cCurrentPeopleCount) {
		this.cCurrentPeopleCount = cCurrentPeopleCount;
	}

	public String getcDifficulty() {
		return cDifficulty;
	}

	public void setcDifficulty(String cDifficulty) {
		this.cDifficulty = cDifficulty;
	}

	public String getcMaterials() {
		return cMaterials;
	}

	public void setcMaterials(String cMaterials) {
		this.cMaterials = cMaterials;
	}

	public String getcSummary() {
		return cSummary;
	}

	public void setcSummary(String cSummary) {
		this.cSummary = cSummary;
	}

}
