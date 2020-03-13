package bit.team.eepp.VO;

public class MessageVO {
	private int mid;
	private int sender_id;
	private int receiver_id;
	private String mcontent;
	private String status;
	private String mdate;
	private String uNickname;
	private int user_id;
	
	public MessageVO() {}
	
	public MessageVO(int mid, int sender_id, int receiver_id, String mcontent, String status, String mdate,
			String uNickname, int user_id) {
		this.mid = mid;
		this.sender_id = sender_id;
		this.receiver_id = receiver_id;
		this.mcontent = mcontent;
		this.status = status;
		this.mdate = mdate;
		this.uNickname = uNickname;
		this.user_id = user_id;
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

	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getSender_id() {
		return sender_id;
	}
	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}
	public int getReceiver_id() {
		return receiver_id;
	}
	public void setReceiver_id(int receiver_id) {
		this.receiver_id = receiver_id;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	
}
