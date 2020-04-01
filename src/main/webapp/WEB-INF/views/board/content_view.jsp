<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글보기</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/board/boardView.css">
	</head>

	<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<div id="boardContentWrapper">
	<div class="contentSideWrap col-sm-2">
	<!-- 직무 게시판 카테고리 -->
		<a class="category ct-all" href="boardList">All</a>
		<a class="category ct-notice" href="boardList?&bCategory=notice">공지사항</a>
		<a class="category ct-it" href="boardList?&bCategory=it_dev">IT & 개발</a>
		<a class="category ct-service" href="boardList?&bCategory=service">서비스</a>
		<a class="category ct-finance" href="boardList?&bCategory=finance">금융</a>
		<a class="category ct-design" href="boardList?&bCategory=design">디자인</a>
		<a class="category ct-offi" href="boardList?&bCategory=official">공무원</a>
		<a class="category ct-etc" href="boardList?&bCategory=etc">기타</a>
	</div>
	
	<div class="contentMainWrap col-sm-9">
		<input type="hidden" id="userNickname" name="uNickname" value="${loginUser.uNickname}">
		<input type="hidden" id="userId" name="user_id" value="${loginUser.user_id}">
		<input type="hidden" id="content_uNickname" value="${content.uNickname}" />
		<input type="hidden" id="content_bSubject" value="${content.bSubject}" />
	
		<div class="content-header">
			<div class="headerInner">
				<p class="bId">#${content.bId}번 게시글</p>
				<h3 class="bContentTitle">${content.bTitle}</h3>
			</div>
			<!-- contentNum -->
			<div class="writeBtnWrap">
				<button type="button" class="writeBtn btn" onclick="location.href='writeView?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}'">새 글 쓰기</button>
			</div>
		</div>
		<!-- content header -->
	
		<div class="bContentTop">
		<div class="bContentInfo">
			<div class="writeUserInfo">
			<h2 class="userProfile"><img src="${content.uprofile}" /></h2>
			<div class="boardInfo">
				<c:choose>
				<c:when test="${content.uNickname eq loginUser.uNickname or content.uNickname eq '운영자' or content.uNickname eq 'admin2'}">
					<a class="userBtn">${content.uNickname}</a>
				</c:when>
				
				<c:otherwise>
					<div class="dropdown">
						<a href="#" class="userBtn" id="user_btn_${content.uNickname}" data-toggle="dropdown">${content.uNickname}</a>
           				 <ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_${content.uNickname}">
                			<li><a href="#">회원정보</a></li>
                			<li><a onclick="sendMessage('${content.uNickname}',${content.user_id});">쪽지 보내기</a></li>
                			<li><a data-toggle="modal" data-target="#report_user_${content.user_id}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
                		</ul>
					</div>
					<!-- 유저 신고 modal -->	
                	<div class="modal fade" id="report_user_${content.user_id}" role="dialog">
                		<div class="modal-dialog">
                		<div class="modal-content">
                						
                			<!-- Modal Header -->
                			<div class="modal-header">
                				<button type="button" class="close" data-dismiss="modal">
                				<span aria-hidden="true">&times;</span>
			                    <span class="sr-only">Close</span>
			                	</button>
			               		<h4 class="modal-title">${content.uNickname}님 신고</h4>
			            	</div>
			            	<!-- Header -->
			            				
			            	<!-- Modal Body -->
			            	<div class="modal-body">
			            		<form id="declaration_user_${content.user_id}" role="formDeclaration_user_${content.user_id}" name="dform">
			            		<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
			            		<input type="hidden" name="reported_id" value="${content.user_id}">
			            				
			            		<div class="form-group">
			            		<label for="inputMessage">신고사유</label><br>
			            		<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${content.user_id}.disabled=true">  부적절한 홍보 게시글<br>
			            		<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${content.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
			            		<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${content.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
			            		<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${content.user_id}.disabled=false">  기타<br>
			            		<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${content.user_id}" name="dReason" disabled></textarea>
			            		</div>
			                	</form>
			                	<!-- declaration -->
			           		 </div>
			           		 <!-- modal-body -->
            
			            	<!-- Modal Footer -->
			            	<div class="modal-footer">
			                	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="ResetForm(${content.user_id})">취소</button>
			                	<button type="button" class="btn reportBtn" onclick="reportUser(${content.user_id},'${content.uNickname}');">신고</button>
			            	</div>
			            	<!-- Footer --> 		
			        	</div>
			        	<!-- modal-content -->
    				</div>
    				<!-- modal-dialog -->
				</div>
				<!-- modal -->
			</c:otherwise>
			</c:choose>
			
			<p class="bDate">${content.bWrittenDate} 작성
			<c:choose>
				<c:when test="${not empty content.bModifyDate}"> ${content.bModifyDate} 수정됨</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
			</p>
		</div>
		<!-- boardInfo -->
	</div>
	<!-- writeUserInfo -->
	
			<div class="infoIcons">
				<p class="title-icon"><i class="fas fa-eye"></i> ${content.bHit}</p>
				<p class="title-icon blike"></p>
				<p class="title-icon bunlike"></p>
				<c:choose>
					<c:when test="${loginUser.uNickname == content.uNickname}">
						<p class="modifyBtn"><a class="modify">수정</a></p>
						<p class="deleteBtn"><a class="delete">삭제</a></p>
					</c:when>
					<c:otherwise>
					<!-- 게시글 신고 -->
					<div class="declarationForm reportBtn">
					<a class="report" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false" id="modalFormBtn">신고</a>
					<div class="modal fade" id="modalForm" role="dialog">
						<div class="modal-dialog">
						<div class="modal-content">
           
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal">
			                    <span aria-hidden="true">&times;</span>
			                    <span class="sr-only">Close</span>
			                </button>
			                <h4 class="modal-title" id="myModalLabel">#${content.bId}번 게시글 신고</h4>
			            </div>
			            <!-- Modal Header -->
            
			            <!-- Modal Body -->
			            <div class="modal-body">
			                <p class="statusMsg"></p>
			                <c:choose>
			                <c:when test="${not empty loginUser.uNickname}">
			                <form id="declaration" role="formDeclaration" name="dform">
			                    <input type="hidden" name="reporter_id" value="${loginUser.user_id}">
			                    <input type="hidden" name="board_id" value="${content.bId}">
			                    <div class="form-group">
			                        <label for="inputMessage">신고사유</label><br>
			                        <input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc.disabled=true">  부적절한 홍보 게시글<br>
									<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
									<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
									<input type="radio" name="dReason" value="etc" onclick="this.form.etc.disabled=false">  기타<br>
									<textarea cols="30" rows="10" class="form-control" id="etc" name="dReason" disabled></textarea>
			                    </div>
			                </form>
			                </c:when>
			                
			                <c:otherwise>
			                <h3>해당 게시글 신고를 원하시면 로그인 해주세요.</h3>
			                </c:otherwise>
			                </c:choose>
			            </div>
			            <!-- Modal Body -->
            
			            <div class="modal-footer">
			                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="resetForm()">취소</button>
			                <button type="button" class="btn btn-primary submitBtn" onclick="submitDeclarationForm()">신고</button>
			            </div>
			            <!-- Modal Footer -->
			        </div>
			        <!--  modal-content -->
    			</div>
    			<!--  modal dialog -->
			</div>
			<!--  modal -->
		</div>
		<!-- declarationForm -->
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- contentInfo -->
	</div>

			
		<!-- 게시글 세부출력 -->
		<div class="contentWrap">
			<div class="contentMain">
				${content.bContent}
			</div>
			<!-- contentMain -->
			
			<div class="btnWrap">
				<c:choose>
					<c:when test="${loginUser.uNickname == content.uNickname}">
						<button type="button" class="btn scrapBtn" onclick="bScrap(${content.bId})">
							<i class="fas fa-bookmark fa-2x"></i>
						</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn scrapBtn" onclick="bScrap(${content.bId})">
							<i class="fas fa-bookmark fa-2x"></i>
						</button>
						<button type="button" class="btn likeBtn" onclick="like(${content.bId})">
							<i class="far fa-thumbs-up"></i>
						</button>
						<button type="button" class="btn unlikeBtn" onclick="unlike(${content.bId})">
							<i class="far fa-thumbs-down"></i>
						</button>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- btnWrap -->
			
			<div class="listBtn">
				<a class="list">글목록</a>
			</div>
		</div>
		<form name="form1" role="form" method="post">
			<input type='hidden' name='bId' id="contentBid" value="${content.bId}">
			<input type="hidden" name="page" id="scriPage" value="${scri.page}">
			<input type="hidden" name="perPageNum" id="scriPageNum" value="${scri.perPageNum}">
			<input type="hidden" name="searchType" id="scriPSearchType" value="${scri.searchType}">
			<input type="hidden" name="keyword" id="scriKeyword" value="${scri.keyword}">
			<input type="hidden" name="sortType" id="boardSortType" value="${sortType}">
			<input type="hidden" name="bCategory" id="bCategory" value="${bCategory}">
		</form>
		
		<!-- 댓글처리 -->
		<div class="replyWrapper">
			<p class="replyTitle">댓글 <b class="replyCount"></b></p>
			<form name="rpform">
				<input type="hidden" name="board_id" value="${content.bId}" />
				<input type="hidden" name="user_id" value="${loginUser.user_id}">
				<table class="replyTable">
					<tr>
						<td class="replyWriter">
						<c:choose>
							<c:when test="${not empty loginUser.uNickname}">
							${loginUser.uNickname}
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td>
						<c:choose>
							<c:when test="${not empty loginUser.uNickname}">
							<textarea id="rpContent" name="rpContent" style="resize:none;height:80px;width:100%;" placeholder="내용을 작성해주세요."></textarea>
							</c:when>
							<c:otherwise>
							<textarea id="rpContent" style="resize:none;height:80;width:100%;" placeholder="로그인 후 댓글을 작성하실 수 있습니다."></textarea>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
				</table>
				<div class="replyBtnWrap"><a id="replyBtn">등록</a></div>
			</form>
		</div>
	
		<div>
			<div class="replyList"></div>
			<div class="replyPaging"></div>
		</div>
</div>

	
		<%-- <%@ include file="/WEB-INF/views/board/replyList.jsp"%> --%>
	</div>

<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->
	<script src="${pageContext.request.contextPath}/js/board/reply/reply.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/boardContent.js"></script>
	<script src="${pageContext.request.contextPath}/js/common.js"></script>
	</body>
</html>