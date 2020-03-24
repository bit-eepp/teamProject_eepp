<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글 수정 페이지</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
	</head>
	<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

		<h1>#${modify.bId}번 게시글 수정 페이지</h1>
		<br>
		<hr>
		
		<form name="mform" action="modifyContent" method="post" onsubmit="return checkForm();">
			<input type="hidden" name="bId" value="${modify.bId}">
			<input type="hidden" name="page" value="${scri.page}">
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}">
			<input type="hidden" name="searchType" value="${scri.searchType}">
			<input type="hidden" name="keyword" value="${scri.keyword}">
			<input type="hidden" name="sortType" value="${sortType}">
			<input type="hidden" name="bCategory" value="${bCategory}">
			
			<table border="1">
				<tr>
					<td> 게시글 번호 </td>
					<td> #${modify.bId} </td>
				</tr>
				<tr>
					<td> 조회수 </td>
					<td> ${modify.bHit} </td>
				</tr>
				<tr>
					<td> 작성자 </td>
					<td> ${modify.uNickname} </td>
				</tr>
				<tr>
					<td> 글제목 </td>
					<td> <input type="text" name="bTitle" size = "50" value="${modify.bTitle}"> </td>
				</tr>
				<tr>
					<td> 내용 </td>
					<td width="500" height="300"><textarea id="summernote" name="bContent">${modify.bContent}</textarea> </td>
				</tr>
				<tr >
					<td colspan="2"> 
						<input type="submit" value="수정"> &nbsp;&nbsp;
						<button type="button" onclick="location.href='contentView?bId=${modify.bId}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}'">취소</button>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
		<script src="${pageContext.request.contextPath}/js/board/boardModify.js"></script>

<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->
	</body>
</html>