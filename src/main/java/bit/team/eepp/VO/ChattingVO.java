package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ChattingVO {
	private int chId;
	private int user_id;
	private String chTitle;
	@JsonFormat(pattern = "YYYY.MM.dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp chDate;
	private String uNickname;
	private int chTotalPeopleCount;
	private String chPlace;
	private String chMeetTime;
	private int pCount;

	public ChattingVO() {
	}

	public ChattingVO(int chId, int user_id, String chTitle, Timestamp chDate, String uNickname, int chTotalPeopleCount,
			String chPlace, String chMeetTime, int pCount) {
		this.chId = chId;
		this.user_id = user_id;
		this.chTitle = chTitle;
		this.chDate = chDate;
		this.uNickname = uNickname;
		this.chTotalPeopleCount = chTotalPeopleCount;
		this.chPlace = chPlace;
		this.chMeetTime = chMeetTime;
		this.pCount = pCount;
	}

	public int getpCount() {
		return pCount;
	}

	public void setpCount(int pCount) {
		this.pCount = pCount;
	}

	public String getChPlace() {
		return chPlace;
	}

	public void setChPlace(String chPlace) {
		this.chPlace = chPlace;
	}

	public String getChMeetTime() {
		return chMeetTime;
	}

	public void setChMeetTime(String chMeetTime) {
		this.chMeetTime = chMeetTime;
	}

	public int getChTotalPeopleCount() {
		return chTotalPeopleCount;
	}

	public void setChTotalPeopleCount(int chTotalPeopleCount) {
		this.chTotalPeopleCount = chTotalPeopleCount;
	}

	public int getChId() {
		return chId;
	}

	public void setChId(int chId) {
		this.chId = chId;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getChTitle() {
		return chTitle;
	}

	public void setChTitle(String chTitle) {
		this.chTitle = chTitle;
	}

	public Timestamp getChDate() {
		return chDate;
	}

	public void setChDate(Timestamp chDate) {
		this.chDate = chDate;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

}
