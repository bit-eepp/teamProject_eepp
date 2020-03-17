<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/msg.css">
</head>

<body class="message_body">

<!-- message tab -->
<div class="messageForm">

	<ul class="nav nav-tabs">
		<li class="nav-item">
			<a class="nav-link linkToreceive" href="message?messageType=myReceiveMsg">받은쪽지</a>
		</li>
		<li class="nav-item">
			<a class="nav-link linkTosend" href="message?messageType=mySendMsg">보낸쪽지</a>
		</li>
	</ul>

	<div class="tab-content">
		<div class="tab-pane fade show active">
		
			<div class="notelist">
				<ul class="notelist_head note_title" id="m-title">
					<li class="note_cont note_check">
						<!--  전체선택 -->
						<input type="checkbox" class="allCheck">
					</li>
					<li class="note_cont note_type" id="messageType_title"></li>
					<li class="note_cont note_content">내용</li>
					<li class="note_cont note_mdate" id="messageType_date"></li>
					<li class="note_cont note_mstatus">확인</li>
					<li class="note_cont note_active" id="messageType_active"></li>
				</ul>
			</div>
			<!-- notelist -->
			
			<div id="showMyMessage" class="notelist">
			<c:choose>
			<%-- 메세지가 없을경우 --%>
			<c:when test="${empty messageList}">
				<input type="hidden" class="messageType" value="${messageType}">
				<ul class="massageIsEmpty"><li class="note_cont"></li></ul>
			</c:when>
			<%-- 메세지가 없을경우 --%>
			
			<%-- 메세지가 있을경우 --%>
			<c:otherwise>
				<c:forEach items="${messageList}" var="msg" varStatus="idx">
				
				<form>
				<input type="hidden" class="messageType" value="${messageType}">
				<input type="hidden" class="mid" name="mid" value="${msg.mid}">
				<input type="hidden" class="uNickname" name="uNickname" value="${msg.uNickname}">
						
					<ul class="notelist_head">
						<li class="note_cont note_check">
							<!--  쪽지선택 -->
							<input type="checkbox" name="pickCheck" class="pickCheck" value="${msg.mid}" />
						</li>
						<li class="note_cont note_type">
							<!-- 닉네임 클릭 버튼 -->
							<div class="dropdown">
							<a href="#" class="userBtn" id="user_${msg.uNickname}${idx.index}" data-toggle="dropdown">${msg.uNickname}</a>
           					<ul class="dropdown-menu" role="menu" aria-labelledby="user_${msg.uNickname}${idx.index}">
                				<li><a href="#">회원정보</a></li>
                				<li><a onclick="sendMessage('${msg.uNickname}',${msg.user_id},'mySendMsg');">쪽지 보내기</a></li>
                				<li><a data-toggle="modal" data-target="#userForm_user_${msg.user_id}${idx.index}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
                			</ul>
							</div>
							<!-- 유저 신고 modal -->	
                			<div class="modal fade" id="userForm_user_${msg.user_id}${idx.index}" role="dialog">
                				<div class="modal-dialog">
                				<div class="modal-content">
                						
                				<!-- Modal Header -->
                				<div class="modal-header">
                					<button type="button" class="close" data-dismiss="modal">
                					<span aria-hidden="true">&times;</span>
			                    	<span class="sr-only">Close</span>
			                		</button>
			               			<h4 class="modal-title">${msg.uNickname}님 신고</h4>
			            		</div>
			            		<!-- Header -->
			            				
			            		<!-- Modal Body -->
			            		<div class="modal-body">
			            			<div class="declaration">
			            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
			            			<input type="hidden" name="reported_id" value="${msg.user_id}">
			            				
			            			<div class="form-group">
			            			<label for="inputMessage">신고사유</label><br>
			            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${msg.user_id}${idx.index}.disabled=true">  부적절한 홍보 게시글<br>
			            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${msg.user_id}${idx.index}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
			            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${msg.user_id}${idx.index}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
			            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${msg.user_id}${idx.index}.disabled=false">  기타<br>
			            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${msg.user_id}${idx.index}" name="dReason" disabled></textarea>
			            			</div>
			                		</div>
			                		<!-- declaration -->
			           		 	</div>
			           		 	<!-- modal-body -->
            
			            		<!-- Modal Footer -->
			            		<div class="modal-footer">
			                		<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reset()">취소</button>
			                		<button type="button" class="btn reportBtn" onclick="reportUser('${msg.user_id}')">신고</button>
			            		</div>
			            		<!-- Footer -->
			            		
			        			</div>
			        			<!-- modal-content -->
    							</div>
    							<!-- modal-dialog -->
							</div>
							<!-- modal -->
						</li>
						<!-- li.note_type -->
							
						<c:choose>
						<%-- 보낸 쪽지함 --%>
						<c:when test="${messageType eq 'myReceiveMsg'}">
						<li class="note_cont note_content">
							<a class="openMsgView" onclick="openReceiveMsg(${msg.mid},${msg.sender_id});">
								<c:choose>
								<c:when test="${msg.mblind eq 1}">
									신고된 쪽지입니다.
								</c:when>
								
								<c:when test="${fn:length(msg.mcontent) >= 22}">
									${fn:substring(msg.mcontent, 0, 22)}...
								</c:when>
								
								<c:otherwise>
									${msg.mcontent}
								</c:otherwise>
								</c:choose>
							</a>
						</li>
						<li class="note_cont note_mdate">${msg.mdate}</li>
						<li class="note_cont note_mstatus">${msg.status}</li>
						<li class="note_cont note_active">
							<a class="reportMsg" data-toggle="modal" data-target="#modalForm_msg_${msg.mid}${btn.index}" data-backdrop="static" data-keyboard="false">신고</a>
							
							<!-- 쪽지 신고 폼 -->
							<div class="modal fade" id="modalForm_msg_${msg.mid}${btn.index}" role="dialog">
								<div class="modal-dialog">
								<div class="modal-content">
								
								<!-- Modal Header -->
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times;</span>
									<span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">${msg.uNickname}님의 쪽지 신고</h4>
								</div>
								
								<!-- Modal Body -->
								<div class="modal-body">
								<div id="messageDeclaration_${msg.mid}" role="formMsgDeclaration_${msg.mid}">
									<input type="hidden" name="reporter_id" class="reporterId" value="${loginUser.user_id}">
									<input type="hidden" name="reported_id" class="reportedId" value="${msg.user_id}">
									
									<div class="form-group">
									<label for="inputMessage">신고사유</label><br>
									<input type="radio" name="dReason_msg" value="부적절한 홍보 내용" onclick="this.form.etc_msg_${msg.mid}.disabled=true">  부적절한 홍보 내용<br>
									<input type="radio" name="dReason_msg" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_msg_${msg.mid}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
									<input type="radio" name="dReason_msg" value="명예훼손/사생활 침해 등" onclick="this.form.etc_msg_${msg.mid}.disabled=true">  명예훼손/사생활 침해 등<br>
									<input type="radio" name="dReason_msg" value="etc" onclick="this.form.etc_msg_${msg.mid}.disabled=false">  기타<br>
									<textarea style="resize:none;height:80px;width:100%;" class="form-control" id="etc_msg_${msg.mid}" name="dReason_msg" disabled></textarea>
									</div>
									<!-- form-group -->
								</div>
								<!-- messageDeclaration -->
								</div>
								<!-- modal-body -->
											 
								<!-- Modal Footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reset()">취소</button>
									<button type="button" class="btn btn-primary submitBtn" onclick="submitDeclarationForm(${msg.mid},'${msg.uNickname}')">신고</button>
								</div>
								<!-- Modal Footer -->
								</div>
								<!-- modal-content -->
								</div>
								<!-- modal-dialog -->
							</div>
							<!-- modal -->
						</li>
						<!-- li.note_active -->
						</c:when>
						<%-- 받은 쪽지함 --%>
						
						<%-- 보낸 쪽지함 --%>
						<c:when test="${messageType eq 'mySendMsg'}">
						<li class="note_cont note_content">
							<a class="openMsgView" onclick="openSendMsg(${msg.mid},${msg.receiver_id});">
								<c:choose>
								<c:when test="${msg.mblind eq 1}">
									신고된 쪽지입니다.
								</c:when>
								
								<c:when test="${fn:length(msg.mcontent) >= 22}">
									${fn:substring(msg.mcontent, 0, 22)}...
								</c:when>
								
								<c:otherwise>
									${msg.mcontent}
								</c:otherwise>
								</c:choose>
							</a>
						</li>
						<li class="note_cont note_mdate">${msg.mdate}</li>
						<li class="note_cont note_mstatus">${msg.status}</li>
						<li class="note_cont note_active">
							<c:choose>
							<c:when test="${msg.status eq '읽음'}"></c:when>
							
							<c:otherwise>
								<a class="send_cancle" onclick="sendCancle(${msg.mid},'${msg.uNickname}');">발송취소</a>
							</c:otherwise>
							</c:choose>
						</li>
						</c:when>
						<%-- 보낸 쪽지함 --%>
						</c:choose>
					</ul>
					<!-- notelist_head -->
				</form>
				</c:forEach>
			</c:otherwise>
			<%-- 메세지가 있을경우 --%>
		</c:choose>
		</div>
		<!-- #showMyMessage -->
		</div>
		<!-- tab-pane -->
	</div>
	<!-- tab-content -->
</div>
<!-- messageForm -->
	
<div class="message_footer">
	<button type="button" class="selectDeleteBtn">삭제</button>

	<!-- 페이징 -->
	<div>
		<c:if test="${pageMaker.prev}">
			<a style="text-decoration: none" href="message${pageMaker.makeQuery(pageMaker.startPage - 1)}&messageType=${messageType}">
				«
			</a>
		</c:if>
		[
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			<a style="text-decoration: none" href="message${pageMaker.makeQuery(idx)}&messageType=${messageType}">${idx}</a>
		</c:forEach>
		]
		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<a style="text-decoration: none" href="message${pageMaker.makeQuery(pageMaker.endPage + 1)}&messageType=${messageType}">
				» 
			</a>&nbsp;&nbsp;
		</c:if>
	</div>
	<!-- 페이징 -->
</div>
<!-- message_footer-->
<script src="${pageContext.request.contextPath}/js/user/message/message.js"></script>
</body>
</html>