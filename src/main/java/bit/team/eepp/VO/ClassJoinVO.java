package bit.team.eepp.VO;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ClassJoinVO {
	private int cjId;
	private int class_id;
	private int user_id;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp cjJoinDate;

	public ClassJoinVO() {
	}

	public ClassJoinVO(int cjId, int class_id, int user_id, Timestamp cjJoinDate) {
		this.cjId = cjId;
		this.class_id = class_id;
		this.user_id = user_id;
		this.cjJoinDate = cjJoinDate;
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

}
