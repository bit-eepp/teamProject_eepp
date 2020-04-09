<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Eating Main</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
</head>

<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<!-- header -->
	
	<section class="pageTitle">
		<h1><a href="${pageContext.request.contextPath}/eatingList">오늘 뭐 먹지?</a></h1>
	</section>
	
	<!-- 검색 부분  -->
	<div class="search">
		<select name="searchType">
			<option value="n" <c:out value="${escri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
			<option value="t" <c:out value="${escri.searchType eq 't' ? 'selected' : ''}"/>>상호</option>
			<option value="c" <c:out value="${escri.searchType eq 'c' ? 'selected' : ''}"/>>메뉴</option>
			<option value="a" <c:out value="${escri.searchType eq 's' ? 'selected' : ''}"/>>주소</option>
			<option value="tc" <c:out value="${escri.searchType eq 'tc' ? 'selected' : ''}"/>>상호/메뉴</option>
		</select> 
		<input type="text" name="keyword" id="keywordInput" value="${escri.keyword}" />
		<button id="eatingSearchBtn" type="button" onclick="location.href='eatingView${eatingPageMaker.makeQuery(eatingPageMaker.cri.page_eating)}&eId=${el.eId}&searchType=${escri.searchType}&keyword=${escri.keyword}'">검색</button>
	</div>
	
	<!-- 테마 리스트 -->
	<div class="themaList">
		<p class="thema1"><a href="${pageContext.request.contextPath}/themaList?&eThema=thema_1">신촌 / 홍대</a></p>
		<p class="thema2"><a href="${pageContext.request.contextPath}/themaList?&eThema=thema_2">여의도</a></p>
		<p class="thema3"><a href="${pageContext.request.contextPath}/themaList?&eThema=thema_3">용산 / 이태원</a></p>
		<p class="thema4"><a href="${pageContext.request.contextPath}/themaList?&eThema=thema_4">강남 / 논현</a></p>
		<p class="thema5"><a href="${pageContext.request.contextPath}/themaList?&eThema=thema_5">건대입구</a></p>
		<p class="thema6"><a href="${pageContext.request.contextPath}/themaList?&eThema=thema_6">합정 / 망원</a></p>
	</div>
	
	<c:choose>
		<c:when test="${not empty eatingList}">
			<div id="searchList">
			<c:choose>
			<c:when test="${fn:length(eatingList) > 0 and escri.keyword != ''}">
				<c:forEach items="${eatingList}" var="el">
				<table class="tb-searchList">
					<tr>
						<td colspan="2">
						<img src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${el.eId}.jpg">
						</td>
					</tr>
					
					<tr>
						<td>상호명</td>
						<td>${el.eTitle}</td>
					</tr>
					
					<tr>
						<td>평점</td>
						<td>${el.rvAVG}</td>
					</tr>
					
					<tr>
						<td>주소</td>
						<td>${el.eAddress_new}</td>
					</tr>
					
					<tr>
						<td colspan="2">
						<button type="button" onclick="location.href='eatingView${eatingPageMaker.makeQuery(eatingPageMaker.cri.page_eating)}&eId=${el.eId}&searchType=${escri.searchType}&keyword=${escri.keyword}'">더 보기!</button></td>
					</tr>
				</table>
				</c:forEach>
			</c:when>
		
			<c:otherwise>
			<tr>
				<td colspan="9">조회된 결과가 없습니다.</td>
			</tr>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- searchList -->
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
	
	<!-- 페이징 -->
	<div class="etPage">
		<ul class="pagination justify-content-center">
			<li class="page-item">
				<a class="page-link" href="eatingList${eatingPageMaker.makeSearch(eatingPageMaker.startPage - 1)}&sortType=${sortType}&eCategory=${eCategory}"><i class="fas fa-angle-left"></i></a>
			</li>

			<c:forEach begin="${eatingPageMaker.startPage}" end="${eatingPageMaker.endPage}" var="idx">
			<li class="page-item">
				<a id="etPage_${idx}" class="page-link" href="eatingList${eatingPageMaker.makeSearch(idx)}&sortType=${sortType}&eCategory=${eCategory}">${idx}</a>
			</li>
			</c:forEach>
						
			<li class="page-item">
				<a class="page-link" href="eatingList${eatingPageMaker.makeSearch(eatingPageMaker.endPage + 1)}&sortType=${sortType}&eCategory=${eCategory}"><i class="fas fa-angle-right"></i></a>
			</li>
		</ul>
	</div>

		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->
		
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
	<input type="hidden" id="eatingMakeQuery" value="${eatingPageMaker.makeQuery(1)}" />
	<input type="hidden" id="eatingTotalCount" value="${eatingPageMaker.totalCount}" />
	<input type="hidden" id="eatingCriPage" value="${eatingPageMaker.cri.page_eating}" />
	<input type="hidden" id="eThema" value="${eThema}" />
	<input type="hidden" id="eatingSearchType" value="${escri.searchType}" />

		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/js/eating/eatingMain.js"></script>
</body>
</html>