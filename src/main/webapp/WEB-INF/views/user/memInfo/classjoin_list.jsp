<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/memberInfo.css">
</head>

<body>
	<section id="memberInfo" class="memberInfoView">
	<br>
		<div class="container">
			<img id="logo" src="${pageContext.request.contextPath}/img/EE_logo.png" />
				<br>
				<hr>
				<br>
 				<img src="${classList.cThumnail}" class = "class_img" /><br><br>
				<a style="text-decoration: none" class="cName" target="_blank" href="/eepp/class/classView?cId=${classList.cId}&cCategory=${cCategory}">'${classList.cTitle}' &nbsp;클래스 신청 회원 목록</a>
				<br>
				<br>
				<table class="table table-bordered">
					<tr>
						<th style="width:25%">회원 닉네임</th>
						<th>클래스 가입일</th>
						<th>회원 연락처</th>
					</tr>
				<c:choose>
					<c:when test="${fn:length(classjoinlist) > 0 }">
						<c:forEach items="${classjoinlist}" var="classjoinlist">
							<tr>
								<td class="cj_info"><a style="cursor: pointer;" onclick="memberInfo('${classjoinlist.usernick}',${classjoinlist.user_id});">${classjoinlist.usernick}</a></td>
								<td class="cj_info"><fmt:formatDate value="${classjoinlist.cjJoinDate}" pattern="yyyy년 MM월 dd일"/></td>
								<td class="cj_info">${classjoinlist.uPhone}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="9">클래스를 신청한 회원이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</table>
			</div>
	</section>
	
	<script src="${pageContext.request.contextPath}/js/common.js"></script>
</body>
</html>