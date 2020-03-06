package bit.team.eepp.VO;

public class UserActiveVO {
	private int active_id;
	private int user_id;
	private int cId;
	private int rpId;
	private int bId;
	private String active_type;

	public UserActiveVO() {}
	
	public UserActiveVO(int active_id, int user_id, int cId, int rpId, int bId, String active_type) {
		this.active_id = active_id;
		this.user_id = user_id;
		this.cId = cId;
		this.rpId = rpId;
		this.bId = bId;
		this.active_type = active_type;
	}

	public int getActive_id() {
		return active_id;
	}

	public void setActive_id(int active_id) {
		this.active_id = active_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getcId() {
		return cId;
	}

	public void setcId(int cId) {
		this.cId = cId;
	}

	public int getRpId() {
		return rpId;
	}

	public void setRpId(int rpId) {
		this.rpId = rpId;
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public String getActive_type() {
		return active_type;
	}

	public void setActive_type(String active_type) {
		this.active_type = active_type;
	}
	
	
}
