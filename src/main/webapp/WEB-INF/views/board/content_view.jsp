<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글보기</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
	</head>

	<body>

	<input type="hidden" id="userNickname" name="uNickname" value="${loginUser.uNickname}">
	<input type="hidden" id="userId" name="user_id" value="${loginUser.user_id}">
	<input type="hidden" id="content_uNickname" value="${content.uNickname}" />
	<input type="hidden" id="content_bSubject" value="${content.bSubject}" />
	
		<div>
			<h1>#${content.bId}번 게시글</h1>
			<br>
			<button type="button" class="writeBtn" onclick="location.href='writeView?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}'">새 글 쓰기</button><br>
		</div>
		<hr>
		
		<!-- 게시글 신고 -->
		<div class="declarationForm">
			<button class="btn btn-success btn-lg" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false" id="modalFormBtn">게시글 신고</button>
			
			<div class="modal fade" id="modalForm" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
           
			            <!-- Modal Header -->
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal">
			                    <span aria-hidden="true">&times;</span>
			                    <span class="sr-only">Close</span>
			                </button>
			                <h4 class="modal-title" id="myModalLabel">#${content.bId}번 게시글 신고</h4>
			            </div>
            
			            <!-- Modal Body -->
			            <div class="modal-body">
			                <p class="statusMsg"></p>
			                <c:choose>
			                <c:when test="${not empty loginUser.uNickname}">
			                <form id="declaration" role="formDeclaration" name="dform">
			                    <input type="hidden" name="reporter_id" value=121>
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
            
			            <!-- Modal Footer -->
			            <div class="modal-footer">
			                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="resetForm()">취소</button>
			                <button type="button" class="btn btn-primary submitBtn" onclick="submitDeclarationForm()">신고</button>
			            </div>
			        </div>
    			</div>
			</div>
		</div>
		<br>
			
		<!-- 게시글 세부출력 -->
		<div>
			<table border="1">
				<tr>
					<td>글번호</td>
					<td>#${content.bId}</td>
				</tr>
				<tr>
					<td>조회수</td>
					<td>${content.bHit}</td>
				</tr>
				<tr>
					<td>추천</td>
					<td class="like"></td>
				</tr>
				<tr>
					<td>비추천</td>
					<td class="unlike"></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${content.bWrittenDate} 작성</td>
				</tr>
				<tr>
					<td>최종수정일</td>
					<td>${content.bModifyDate} 수정됨</td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td>${content.uNickname}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${content.bTitle}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td width="500" height="300">${content.bContent}</td>
				</tr>
				<tr>
					<td colspan="2">
					<c:choose>
						<c:when test="${loginUser.uNickname == content.uNickname}">
						<button type="button" onclick="bScrap(${content.bId})">스크랩</button>&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<button type="button" onclick="like(${content.bId})">추천</button>&nbsp;&nbsp;
						<button type="button" onclick="unlike(${content.bId})">비추천</button>&nbsp;&nbsp;
						<button type="button" onclick="bScrap(${content.bId})">스크랩</button>&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<c:choose>
						<c:when test="${loginUser.uNickname == content.uNickname}">
							<button class="modify" type="button">수정</button>&nbsp;&nbsp;
							<button class="list" type="button">글목록</button>&nbsp;&nbsp;
							<button class="delete" type="button">삭제</button>
						</c:when>
						<c:otherwise>
							<button class="list" type="button">글목록</button>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</table>
			
			<form name="form1" role="form" method="post">
				<input type='hidden' name='bId' id="contentBid" value="${content.bId}">
				<input type="hidden" name="page" id="scriPage" value="${scri.page}" />
				<input type="hidden" name="perPageNum" id="scriPageNum" value="${scri.perPageNum}" />
				<input type="hidden" name="searchType" id="scriPSearchType" value="${scri.searchType}" />
				<input type="hidden" name="keyword" id="scriKeyword" value="${scri.keyword}" />
				<input type="hidden" name="sortType" id="boardSortType" value="${sortType}" />
				<input type="hidden" name="bCategory" id="bCategory" value="${bCategory}" />
			</form>
		</div>
		<hr>
		
		<!-- 댓글처리 -->
		<div>
			<h2>댓글(<b class="replyCount"></b>)</h2>
			<form name="rpform">
				<input type="hidden" name="board_id" value="${content.bId}" />
				<input type="hidden" name="user_id" value="${loginUser.user_id}">
				<table border="1">
					<tr>
						<td>
						<c:choose>
						<c:when test="${not empty loginUser.uNickname}">
						${loginUser.uNickname}
							<button type="button" name="replyBtn">등록</button>
						</c:when>
						<c:otherwise>
							<input type="text" name="user_id" value="GUEST" disabled>
							<button type="button" name="replyBtn">등록</button>
						</c:otherwise>
					</c:choose>
						</td>
					<tr>
						<td>
							<textarea id="rpContent" type="text" name="rpContent" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<hr>
	
		<div>
			<div class="replyPaging"></div>
			<div class="replyList"></div>
		</div>
	
		<%@ include file="/WEB-INF/views/board/replyList.jsp"%>
	<script src="${pageContext.request.contextPath}/js/board/boardContent.js"></script>
	</body>
</html>