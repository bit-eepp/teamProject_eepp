package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ScrapVO {
	private int sId;
	private int board_id;
	private int class_id;
	private int user_id;
	private int eating_id;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp sDate;
	private String bTitle;
	private String cTitle;
	private String uNickname;
	private String eTitle;
	private String ecategory;
	private String eThema;

	public ScrapVO() {
	}

	public ScrapVO(int sId, int board_id, int class_id, int user_id, int eating_id, Timestamp sDate, String bTitle,
			String cTitle, String uNickname,String eTitle,String ecategory, String eThema) {
		this.sId = sId;
		this.board_id = board_id;
		this.class_id = class_id;
		this.user_id = user_id;
		this.eating_id = eating_id;
		this.sDate = sDate;
		this.bTitle = bTitle;
		this.cTitle = cTitle;
		this.uNickname = uNickname;
		this.eTitle = eTitle;
		this.ecategory = ecategory;
		this.eThema = eThema;
	}
	

	public String geteThema() {
		return eThema;
	}

	public void seteThema(String eThema) {
		this.eThema = eThema;
	}

	public String getEcategory() {
		return ecategory;
	}

	public void setEcategory(String ecategory) {
		this.ecategory = ecategory;
	}

	public String geteTitle() {
		return eTitle;
	}

	public void seteTitle(String eTitle) {
		this.eTitle = eTitle;
	}

	public String getcTitle() {
		return cTitle;
	}

	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

	public int getsId() {
		return sId;
	}

	public void setsId(int sId) {
		this.sId = sId;
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

	public int getEating_id() {
		return eating_id;
	}

	public void setEating_id(int eating_id) {
		this.eating_id = eating_id;
	}

	public Timestamp getsDate() {
		return sDate;
	}

	public void setsDate(Timestamp sDate) {
		this.sDate = sDate;
	}

}
