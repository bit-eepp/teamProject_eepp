package bit.team.eepp.VO;

public class EatingVO {
	
	private int eId;
	private int user_id;
	private String eTitle;
	private String eCategory;
	private String eDate;
	private String eContent;
	private String eTel;
	private String eAddress_new;
	private String eAddress_old;
	private String eGrade;
	private String eMap_1;
	private String eMap_2;
	private String eSearch_1;
	private String eSearch_2;
	private String eSearch_3;
	private int rvCount;
	
	public EatingVO(){
		
	}

	public EatingVO(int eId, int user_id, String eTitle, String eCategory, String eDate, String eContent, String eTel,
			String eAddress_new, String eAddress_old, String eGrade, String eMap_1, String eMap_2, String eSearch_1,
			String eSearch_2, String eSearch_3, int rvCount) {
		this.eId = eId;
		this.user_id = user_id;
		this.eTitle = eTitle;
		this.eCategory = eCategory;
		this.eDate = eDate;
		this.eContent = eContent;
		this.eTel = eTel;
		this.eAddress_new = eAddress_new;
		this.eAddress_old = eAddress_old;
		this.eGrade = eGrade;
		this.eMap_1 = eMap_1;
		this.eMap_2 = eMap_2;
		this.eSearch_1 = eSearch_1;
		this.eSearch_2 = eSearch_2;
		this.eSearch_3 = eSearch_3;
		this.rvCount = rvCount;
	}

	public int getRvCount() {
		return rvCount;
	}

	public void setRvCount(int rvCount) {
		this.rvCount = rvCount;
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

	public String geteTitle() {
		return eTitle;
	}

	public void seteTitle(String eTitle) {
		this.eTitle = eTitle;
	}

	public String geteCategory() {
		return eCategory;
	}

	public void seteCategory(String eCategory) {
		this.eCategory = eCategory;
	}

	public String geteDate() {
		return eDate;
	}

	public void seteDate(String eDate) {
		this.eDate = eDate;
	}

	public String geteContent() {
		return eContent;
	}

	public void seteContent(String eContent) {
		this.eContent = eContent;
	}

	public String geteTel() {
		return eTel;
	}

	public void seteTel(String eTel) {
		this.eTel = eTel;
	}

	public String geteAddress_new() {
		return eAddress_new;
	}

	public void seteAddress_new(String eAddress_new) {
		this.eAddress_new = eAddress_new;
	}

	public String geteAddress_old() {
		return eAddress_old;
	}

	public void seteAddress_old(String eAddress_old) {
		this.eAddress_old = eAddress_old;
	}

	public String geteGrade() {
		return eGrade;
	}

	public void seteGrade(String eGrade) {
		this.eGrade = eGrade;
	}

	public String geteMap_1() {
		return eMap_1;
	}

	public void seteMap_1(String eMap_1) {
		this.eMap_1 = eMap_1;
	}

	public String geteMap_2() {
		return eMap_2;
	}

	public void seteMap_2(String eMap_2) {
		this.eMap_2 = eMap_2;
	}

	public String geteSearch_1() {
		return eSearch_1;
	}

	public void seteSearch_1(String eSearch_1) {
		this.eSearch_1 = eSearch_1;
	}

	public String geteSearch_2() {
		return eSearch_2;
	}

	public void seteSearch_2(String eSearch_2) {
		this.eSearch_2 = eSearch_2;
	}

	public String geteSearch_3() {
		return eSearch_3;
	}

	public void seteSearch_3(String eSearch_3) {
		this.eSearch_3 = eSearch_3;
	}
	
	
	
	
}