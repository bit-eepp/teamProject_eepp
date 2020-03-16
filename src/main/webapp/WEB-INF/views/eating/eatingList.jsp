<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<title>Eating Main</title>
	<%@ include file="/WEB-INF/include/forImport.jspf"%>
	</head>

	<body>
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
	<input type="hidden" id="eatingPageMaker" value="${eatingPageMaker.makeQuery(1)}" />
	<input type="hidden" id="eCategory" value="${eCategory}" />
	<input type="hidden" id="eatingTotalCount" value="${eatingPageMaker.totalCount}" />
	<input type="hidden" id="eatingCriPage" value="${eatingPageMaker.cri.page}" />
	<input type="hidden" id="eatingSearchType" value="${escri.searchType}" />
	<input type="hidden" id="eatingCriPage" value="${eatingPageMaker.cri.page}" />
		<br>
		<h1 type="text" class="eatingTitle" onclick="location.href='eatingList'">오늘 뭐 먹지?</h1>
		<hr>
		<br>
		
		<!-- 검색 부분  -->
		<div class="search">
			<select name="searchType">
				<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
				<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>지역</option>
				<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>상호</option>
				<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>카테고리</option>
				<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>가게 이름/카테고리</option>
			</select> 
			
			<input type="text" name="keyword" id="keywordInput" value="${escri.keyword}" />
			<button id="eatingSearchBtn" type="button">검색</button>
		</div>
		<!-- 검색 부분 끝  -->
		<hr>

	<!-- 테마 리스트 -->
	<div class="temaList">
		<!--맛집 카테고리 -->
		<div>
			<button onclick="location.href='eatingList'">All</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList?&eCategory=american_food'">양식</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList?&eCategory=korean_food'">한식</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList?&eCategory=japanese_food'">일식</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList?&eCategory=chinese_food'">중식</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList?&eCategory=asian_food'">아시안</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList?&eCategory=etc'">기타</button>
		</div>
		<br>
		<!-- 지역 카테고리 -->
		<div>
			<button onclick="location.href='eatingList'">All</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList'">서울 동쪽</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList'">서울 남쪽</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList'">서울 북쪽</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='eatingList'">서울 서쪽</button>

		</div>
		<hr>
		<br>
	</div>
	<hr>
		<!-- 맛집 리스트 -->
		<div>
			<c:choose>
				<c:when test="${fn:length(eatingList) > 0 }">
					<c:forEach items="${eatingList}" var="el">
						<span>
							<table width="300" align="center" style="float: left; width: 33%; padding: 10px; font-size: 10pt;" cellspacing="2" cellpadding="1" border="1">
								<tr>
									<td colspan="2">
									<img style="width:33%;" src="${pageContext.request.contextPath}/img/eating_list_icon1.png">
									</td>
								</tr>
								<tr>
									<td>상호명</td>
									<td>${el.eTitle}</td>
								</tr>
								<tr>
									<td>평점</td>
									<td>${el.eGrade}</td>
								</tr>
								<tr>
									<td>주소</td>
									<td>${el.eAddress_new}</td>
								</tr>
								<tr>
									<td colspan="2"><button type="button" onclick="location.href='eatingView${eatingPageMaker.makeQuery(eatingPageMaker.cri.page)}&eId=${el.eId}&searchType=${escri.searchType}&keyword=${escri.keyword}&eCategory=${eCategory}'">더 보기!</button></td>
								</tr>
							</table>
						</span>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td colspan="9">해당하는 곳이 없습니다!</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</div>
		<br>
		
		<!-- 페이징 -->
		<div>
			
			<c:if test="${eatingPageMaker.prev}">
				<a style="text-decoration: none" href="eatingList${eatingPageMaker.makeSearch(eatingPageMaker.startPage - 1)}&eCategory=${eCategory}"> « </a>
			</c:if>
			
			[<c:forEach begin="${eatingPageMaker.startPage}" end="${eatingPageMaker.endPage}" var="idx">
				<a style="text-decoration: none" href="eatingList${eatingPageMaker.makeSearch(idx)}&eCategory=${eCategory}">${idx}</a>
			</c:forEach>]
	
			<c:if test="${eatingPageMaker.next && eatingPageMaker.endPage > 0}">
				<a style="text-decoration: none" href="eatingList${eatingPageMaker.makeSearch(eatingPageMaker.endPage + 1)}&eCategory=${eCategory}"> » </a>&nbsp;&nbsp;
			</c:if>
			
		</div>
		
		<script src="${pageContext.request.contextPath}/js/eating/eatingMain.js"></script>
	</body>
</html>