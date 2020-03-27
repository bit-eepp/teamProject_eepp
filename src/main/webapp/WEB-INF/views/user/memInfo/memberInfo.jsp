<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css"> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/memberInfo.css">
</head>
<body>
	<section id="memberInfo" class="memberInfoView">
	<br>
		<div class="container">
			<img id="logo"
				src="${pageContext.request.contextPath}/img/EE_logo.png"><br><hr>
				<img src="${member.mInfoProfile}" class = "profile_Img"><br><br>
			<p>'${member.memberWho}' 님의 회원 정보</p>
			<table class="table">
				<tr>
					<th><span class="required">&#8226;</span>닉네임</th>
						<td>${member.memberWho}</td>
				</tr>
				<tr>
					<th><span class="required">&#8226;</span>게시글</th>
					<td><a href="${pageContext.request.contextPath}/board/boardList?page=1&perPageNum=20&searchType=w&keyword=${member.memberWho}&sortType=bWrittenDate&bCategory=" target="_blank">${member.listCount} 개</a></td>
				</tr>
				<tr>
					<th><span class="required">&#8226;</span>등&nbsp;&nbsp;&nbsp;&nbsp;급</th>
					<td>
						  <c:choose>
						  	<c:when test = "${member.memgrade == 2}">정회원</c:when>
						  	<c:when test = "${member.memgrade == 41}">정지회원</c:when>
						  	<c:when test = "${member.memgrade == 21}">부운영자</c:when>
						  	<c:otherwise>운영자</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th><span class="required">&#8226;</span>가입일</th>
					<td><fmt:formatDate value="${member.memberInfoJDate}" type="both" pattern="yyyy년 MM월 dd일"/></td> 
				</tr>
				<tr>
					<th><span class="required">&#8226;</span>클래스</th>
					<td><a href="${pageContext.request.contextPath}/class/classList?page=1&perPageNum=9&searchType=w&keyword=${member.memberWho}&cCategory=" target="_blank">${member.openClassCount} 건</a></td>
				</tr>
			</table><hr>
		</div>
	</section>
</body>
</html>