<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>새 글 쓰기</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
	</head>
	
	<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

		<h1>새 글 쓰기</h1>
		<form name="wform" action="writeContent" method="post" onsubmit="return writeCheckForm();">
			<input type="hidden" name="page" value="${scri.page}" />
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
			<input type="hidden" name="searchType" value="${scri.searchType}" />
			<input type="hidden" name="keyword" value="${scri.keyword}" />
			<input type="hidden" name="sortType" value="${sortType}" />
			
			<table border="1">		
				<tr>
					<td>게시판 카테고리</td>
					<td>
						<select name="bCategory"> 
							<option value="" disabled selected>게시판을 선택해주세요</option>
							<option value="it_dev">IT/개발</option>
							<option value="service">서비스</option>
							<option value="finance" >금융</option>
							<option value="design">디자인</option>
							<option value="official">공무원</option>
							<option value="etc">기타</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td>주제</td>
					<td>
						<select name="bSubject">
							<option value="" disabled selected>주제를 선택해주세요</option>
							<option value="qna">Q&A</option>
							<option value="info">정보</option>
							<option value="daily">일상</option>
						</select>
					</td>
				</tr>
			
				<tr>
					<td> 작성자 </td>
					<td> <input type="hidden" name="user_id" size = "50" value="${loginUser.user_id}">${loginUser.uNickname}</td>
				</tr>
				
				<tr>
					<td> 글제목 </td>
					<td> <input type="text" name="bTitle" size = "50" placeholder="제목"> </td>
				</tr>
				
				<tr>
					<td> 내용 </td>
					<td><textarea id="summernote" name="bContent"></textarea></td>
				</tr>
				
				<tr>
					<td colspan="2"> 
						<input type="submit" value="등록">&nbsp;&nbsp; 
						<button class="list" type="button">취소</button>
					</td>
				</tr>
			</table>
		</form>
		
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