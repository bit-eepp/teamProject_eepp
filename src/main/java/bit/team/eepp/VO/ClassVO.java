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
	private String cDifficulty;
	private String cSummary;
	private int cTerm;
	private int questionCount;
	private String cThumnail;
	private String uProfile;
	private String cAddress1;
	private String cAddress2;
	private String cAddress3;
	private int totalcount;

	public ClassVO() {
	}

	public ClassVO(int cId, int user_id, String cTitle, String cContent, Timestamp cOpenDate, Timestamp cEndDate,
			int cPrice, String cCategory, String uNickname, int cTotalPeopleCount, String cDifficulty, String cSummary,
			int cTerm, int questionCount, String cThumnail, String uProfile, String cAddress1, String cAddress2,
			String cAddress3,int totalcount) {
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
		this.cDifficulty = cDifficulty;
		this.cSummary = cSummary;
		this.cTerm = cTerm;
		this.questionCount = questionCount;
		this.cThumnail = cThumnail;
		this.uProfile = uProfile;
		this.cAddress1 = cAddress1;
		this.cAddress2 = cAddress2;
		this.cAddress3 = cAddress3;
		this.totalcount = totalcount;
	}
	public int getTotalcount() {
		return totalcount;
	}
	
	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public String getcAddress1() {
		return cAddress1;
	}


	public void setcAddress1(String cAddress1) {
		this.cAddress1 = cAddress1;
	}

	public String getcAddress2() {
		return cAddress2;
	}

	public void setcAddress2(String cAddress2) {
		this.cAddress2 = cAddress2;
	}

	public String getcAddress3() {
		return cAddress3;
	}

	public void setcAddress3(String cAddress3) {
		this.cAddress3 = cAddress3;
	}

	public String getuProfile() {
		return uProfile;
	}

	public void setuProfile(String uProfile) {
		this.uProfile = uProfile;
	}

	public String getcThumnail() {
		return cThumnail;
	}

	public void setcThumnail(String cThumnail) {
		this.cThumnail = cThumnail;
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

	public String getcDifficulty() {
		return cDifficulty;
	}

	public void setcDifficulty(String cDifficulty) {
		this.cDifficulty = cDifficulty;
	}

	public String getcSummary() {
		return cSummary;
	}

	public void setcSummary(String cSummary) {
		this.cSummary = cSummary;
	}

}
