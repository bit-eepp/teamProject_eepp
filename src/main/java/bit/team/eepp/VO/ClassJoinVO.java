package bit.team.eepp.VO;

import java.sql.Timestamp;

public class ClassJoinVO {
	private int cjId;
	private int class_id;
	private int user_id;
	private Timestamp cjJoinDate;
	private String cjIntroduce;

	public ClassJoinVO() {
	}

	public ClassJoinVO(int cjId, int class_id, int user_id, Timestamp cjJoinDate, String cjIntroduce) {
		this.cjId = cjId;
		this.class_id = class_id;
		this.user_id = user_id;
		this.cjJoinDate = cjJoinDate;
		this.cjIntroduce = cjIntroduce;
	}

	public int getCjId() {
		return cjId;
	}

	public void setCjId(int cjId) {
		this.cjId = cjId;
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

	public Timestamp getCjJoinDate() {
		return cjJoinDate;
	}

	public void setCjJoinDate(Timestamp cjJoinDate) {
		this.cjJoinDate = cjJoinDate;
	}

	public String getCjIntroduce() {
		return cjIntroduce;
	}

	public void setCjIntroduce(String cjIntroduce) {
		this.cjIntroduce = cjIntroduce;
	}

}
