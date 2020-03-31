<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글 수정</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/board/boardView.css">
	</head>
	<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<div class="modifyViewWrap">
	<section class="sc-writeView col-sm-8">

		<h1 class="sc-title">#${modify.bId}번 글 수정</h1>
		
		<form name="mform" action="modifyContent" method="post" onsubmit="return checkForm();">
			<input type="hidden" name="bId" value="${modify.bId}">
			<input type="hidden" name="page" value="${scri.page}">
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}">
			<input type="hidden" name="searchType" value="${scri.searchType}">
			<input type="hidden" name="keyword" value="${scri.keyword}">
			<input type="hidden" name="sortType" value="${sortType}">
			<input type="hidden" name="bCategory" value="${bCategory}">
			
			<table class="viewTable">
				<tr>
					<td class="tb-title"> 게시글 번호 </td>
					<td> #${modify.bId} </td>
				</tr>
				<tr>
					<td class="tb-title"> 조회수 </td>
					<td> ${modify.bHit} </td>
				</tr>
				<tr>
					<td class="tb-title"> 작성자 </td>
					<td class="tb-writer"> ${modify.uNickname} </td>
				</tr>
				<tr>
					<td class="tb-title"> 글제목 </td>
					<td> <input type="text" name="bTitle" size = "50" class="boardSelector tb-boardTitle" placeholder="${modify.bTitle}"> </td>
				</tr>
				<tr>
					<td class="tb-title"> 내용 </td>
					<td>
						<textarea id="summernote" name="bContent">${modify.bContent}</textarea>
					</td>
				</tr>
			</table>
			<div class="btnWrap">
				<div class="cancleBtn-wrap"><button class="list btn" type="button" onclick="location.href='contentView?bId=${modify.bId}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}'">취소</button></div>
				<div class="submitBtn-wrap"><button class="btn" type="submit">수정</button></div>
			</div>
		</form>
		</section>
		</div>

<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->
<script src="${pageContext.request.contextPath}/js/board/boardModify.js"></script>
	</body>
</html>