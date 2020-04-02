<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>새 글 쓰기</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/board/boardView.css">
	</head>
	
	<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<div class="writeViewWrap">
	<section class="sc-writeView col-sm-8">
		<h1 class="sc-title">새 글 쓰기</h1>
		<form name="wform" action="writeContent" method="post" onsubmit="return writeCheckForm();">
			<input type="hidden" name="page" value="${scri.page}" />
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
			<input type="hidden" name="searchType" value="${scri.searchType}" />
			<input type="hidden" name="keyword" value="${scri.keyword}" />
			<input type="hidden" name="sortType" value="${sortType}" />
			
			<table class="viewTable">		
				<tr>
					<td class="tb-title">게시판 카테고리</td>
					<td>
						<c:choose>
							<c:when test="${loginUser.uNickname == '운영자' or loginUser.uNickname == 'admin2'}">
								<select name="bCategory" class="boardSelector"> 
									<option value="" disabled selected>게시판을 선택해주세요</option>
									<option value="notice">공지</option>
									<option value="it_dev">IT/개발</option>
									<option value="service">서비스</option>
									<option value="finance" >금융</option>
									<option value="design">디자인</option>
									<option value="official">공무원</option>
									<option value="etc">기타</option>
								</select>
							</c:when>
							
							<c:otherwise>
								<select name="bCategory" class="boardSelector"> 
									<option value="" disabled selected>게시판을 선택해주세요</option>
									<option value="it_dev">IT/개발</option>
									<option value="service">서비스</option>
									<option value="finance" >금융</option>
									<option value="design">디자인</option>
									<option value="official">공무원</option>
									<option value="etc">기타</option>
								</select>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				
				<tr>
					<td class="tb-title">주제</td>
					<td>
						<c:choose>
							<c:when test="${loginUser.uNickname == '운영자' or loginUser.uNickname == 'admin2'}">
								<select name="bSubject" class="boardSelector">
									<option value="" disabled selected>주제를 선택해주세요</option>
									<option value="notice">공지</option>
									<option value="qna">Q&A</option>
									<option value="info">정보</option>
									<option value="daily">일상</option>
								</select>
							</c:when>
						
							<c:otherwise>
								<select name="bSubject" class="boardSelector">
									<option value="" disabled selected>주제를 선택해주세요</option>
									<option value="qna">Q&A</option>
									<option value="info">정보</option>
									<option value="daily">일상</option>
								</select>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			
				<tr>
					<td class="tb-title"> 작성자 </td>
					<td class="tb-writer"> <input type="hidden" name="user_id" size = "50" value="${loginUser.user_id}">${loginUser.uNickname}</td>
				</tr>
				
				<tr>
					<td class="tb-title"> 글제목 </td>
					<td> <input type="text" name="bTitle" size = "50" placeholder="제목" class="boardSelector tb-boardTitle"> </td>
				</tr>
				
				<tr>
					<td class="tb-title"> 내용 </td>
					<td><textarea id="summernote" name="bContent"></textarea></td>
				</tr>
			</table>
			<div class="btnWrap">
				<div class="cancleBtn-wrap"><button class="list btn" type="button">취소</button></div>
				<div class="submitBtn-wrap"><button class="btn" type="submit">등록</button></div>
			</div>
		</form>
	</section>
</div>
		
		<form name="form1" role="form" method="post">
			<input type="hidden" name="page" value="${scri.page}" />
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
			<input type="hidden" name="searchType" value="${scri.searchType}" />
			<input type="hidden" name="keyword" value="${scri.keyword}" />
			<input type="hidden" name="sortType" value="${sortType}" />
			<input type="hidden" name="bCategory" value="${bCategory}" />
		</form>
		
<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->

		<script src="${pageContext.request.contextPath}/js/board/boardWrite.js"></script>
	</body>
</html>