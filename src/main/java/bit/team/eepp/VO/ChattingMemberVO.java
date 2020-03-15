package bit.team.eepp.VO;

public class ChattingMemberVO {
	private int cmId;
	private int chatting_id;
	private int user_id;
	private String uNickname;

	public ChattingMemberVO() {
	}

	public ChattingMemberVO(int cmId, int chatting_id, int user_id, String uNickname) {
		this.cmId = cmId;
		this.chatting_id = chatting_id;
		this.user_id = user_id;
		this.uNickname = uNickname;
	}

	public String getuNickname() {
		return uNickname;
	}

	public void setuNickname(String uNickname) {
		this.uNickname = uNickname;
	}

	public int getCmId() {
		return cmId;
	}

	public void setCmId(int cmId) {
		this.cmId = cmId;
	}

	public int getChatting_id() {
		return chatting_id;
	}

	public void setChatting_id(int chatting_id) {
		this.chatting_id = chatting_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

}
