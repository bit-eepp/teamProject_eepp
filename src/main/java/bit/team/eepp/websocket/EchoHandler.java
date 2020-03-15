package bit.team.eepp.websocket;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import bit.team.eepp.VO.UserVO;

public class EchoHandler extends TextWebSocketHandler {

	// 접속한 클라이언트의 웹소켓 세션을 담는 List : webSocketSession
	List<WebSocketSession> webSocketSessionList = new ArrayList<WebSocketSession>();

	// 접속한 유저의 닉네임을 담는 map - key : WebSocketSession / value : uNickname(String)
	Map<WebSocketSession, String> usersMap = new HashMap<WebSocketSession, String>();

	// 채팅방에 접속한 유저가 속해있는 채팅방번호를 담는 map - key : WebSocketSession / value :
	Map<WebSocketSession, String> chatRoomIdMap = new HashMap<WebSocketSession, String>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		webSocketSessionList.add(session); // webSocketSessionList: 접속한 클라이언트등의 웹소켓 세션

		Map<String, Object> map = session.getAttributes();

		UserVO userInfo = new UserVO();
		userInfo = (UserVO) map.get("loginUser");
		String uNickname = userInfo.getuNickname();
		usersMap.put(session, uNickname); // usersMap : key(접속한 클라이언트의 웹소켓 세션), value(접속한 클라이언트의 닉네임)

		String chatRoomId = (String) map.get("chatRoomId");
		chatRoomIdMap.put(session, chatRoomId); // chatRoomIdMap : key(접속한 클라이언트의 웹소켓 세션), value(클라이언트가 접속한 채팅방 번호)

		System.out.println("[Server Message]" + usersMap.get(session) + " 님이 " + chatRoomId + "번 채팅방에 입장하셨습니다."); // 서버메세지
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("[Server Message] " +message.getPayload()); // 서버메세지

		Map<String, Object> map = session.getAttributes();
		String chatRoomId = (String) map.get("chatRoomId");

		// 현재 접속되어있는 클라이언트들에게 메세지 전달 TextMessage
		TextMessage msg = new TextMessage(message.getPayload());

		for (WebSocketSession sess : webSocketSessionList) {
			if (chatRoomIdMap.get(sess).equals(chatRoomId)) {
				sess.sendMessage(msg);
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> map = session.getAttributes();
		String chatRoomId = (String) map.get("chatRoomId");
		System.out.println("[Server Message]" + usersMap.get(session) + "님이  " + chatRoomId + "번 방에서 나가셨습니다.");

		webSocketSessionList.remove(session);
		usersMap.remove(session);
		chatRoomIdMap.remove(session);
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " exception 발생: " + exception.getMessage());
	}

	private void log(String logmsg) {
		System.out.println("[" + new Date() + "] " + logmsg);
	}

}
