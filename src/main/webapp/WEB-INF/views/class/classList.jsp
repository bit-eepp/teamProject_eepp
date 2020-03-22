<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="now" class="java.util.Date"/>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>Class Main</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
	</head>

	<body>
	
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
		<input type="hidden" id="classPageMaker" value="${classPageMaker.makeQuery(1)}" />
		<input type="hidden" id="cCategory" value="${cCategory}" />
		<input type="hidden" id="classTotalCount" value="${classPageMaker.totalCount}" />
		<input type="hidden" id="classCriPage" value="${classPageMaker.cri.page}" />
		<input type="hidden" id="classSearchType" value="${cscri.searchType}" />
		<input type="hidden" id="classCriPage" value="${classPageMaker.cri.page}" />
	
		<h1 class="classTitle"></h1>
		<button type="button" onclick="location.href='/eepp/board/boardList'">직무 Community</button>
		<button type="button" id="openNewClass" onclick="location.href='classOpenView${classPageMaker.makeQuery(classPageMaker.cri.page)}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'">강좌개설</button>
		<button type="button" onclick="location.href='/eepp/scrap/myScrapList'">스크랩 확인</button>
		<hr>
		<br>
		
		<!--Class강좌 카테고리 -->
		<div>
			<button onclick="location.href='classList'">All</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=it_dev'">IT/개발</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=workSkill'">업무스킬</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=financialTechnology'">재테크</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=daily'">일상</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=etc'">기타</button>
		</div>
		<hr>
		<br>
		
		<!-- class강좌 n개씩 보기 -->
		<div>
			<select id="cntPerPage" name="perPageNum">
				<option value="3"  <c:out value="${classPageMaker.cri.perPageNum eq '3' ? 'selected' : ''}"/>>3개씩 보기</option>
				<option value="6" <c:out value="${classPageMaker.cri.perPageNum eq '6' ? 'selected' : ''}"/>>6개씩 보기</option>
				<option value="9" <c:out value="${classPageMaker.cri.perPageNum eq '9' ? 'selected' : ''}"/>>9개씩 보기</option>
				<option value="12" <c:out value="${classPageMaker.cri.perPageNum eq '12' ? 'selected' : ''}"/>>12개씩 보기</option>
				<option value="15" <c:out value="${classPageMaker.cri.perPageNum eq '15' ? 'selected' : ''}"/>>15개씩보기</option>
				<option value="18" <c:out value="${classPageMaker.cri.perPageNum eq '18' ? 'selected' : ''}"/>>18개씩 보기</option>
			</select>&nbsp;&nbsp;&nbsp;
		</div>
		<hr>
		<br>
		
		<!-- 검색 부분  -->
		<div class="search">
			<select name="searchType">
				<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
				<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>개설자</option>
				<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>강좌명</option>
				<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>강좌내용</option>
				<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>강좌명 + 강좌내용</option>
			</select> 
			
			<input type="text" name="keyword" id="keywordInput" value="${cscri.keyword}" />
			<button id="classSearchBtn" type="button">검색</button>
		</div>
		<!-- 검색 부분 끝  -->
		<hr>
		
		<!-- 페이징 -->
		<div>
			<c:if test="${classPageMaker.prev}">
				<a style="text-decoration: none" href="classList${classPageMaker.makeSearch(classPageMaker.startPage - 1)}&cCategory=${cCategory}"> « </a>
			</c:if>
			
			[<c:forEach begin="${classPageMaker.startPage}" end="${classPageMaker.endPage}" var="idx">
				<a style="text-decoration: none" href="classList${classPageMaker.makeSearch(idx)}&cCategory=${cCategory}">${idx}</a>
			</c:forEach>]
	
			<c:if test="${classPageMaker.next && classPageMaker.endPage > 0}">
				<a style="text-decoration: none" href="classList${classPageMaker.makeSearch(classPageMaker.endPage + 1)}&cCategory=${cCategory}"> » </a>&nbsp;&nbsp;
			</c:if>
		</div>
		
		<!-- 클래스 리스트 -->
		<div>
			<c:choose>
				<c:when test="${fn:length(classList) > 0 }">
					<c:forEach items="${classList}" var="cl">
						<table border="1">
							<tr>
								<td colspan="2"><img src="${cl.cThumnail}" style="width:300px; height: auto;">
								</td>
							</tr>
							<tr>
								<td>클래스 강좌번호</td>
								<td>${cl.cId}</td>
							</tr>
							<tr>
								<td>클래스 강좌명</td>
								<td>${cl.cTitle}</td>
							</tr>
							<tr>
								<td>한줄요약</td>
								<td>${cl.cSummary}</td>
							</tr>
							<tr>
								<td>개설자</td>
								<td>${cl.uNickname}</td>
							</tr>
							
							<tr>
								<td>신청기간</td>
								<td><fmt:formatDate value="${cl.cOpenDate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${cl.cEndDate}" pattern="yyyy.MM.dd" /></td>
							</tr>

							<tr>
								<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
								<fmt:parseNumber value="${cl.cEndDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
								
								<td>남은신청기간</td>
								<td>
									<c:choose>
										<c:when test="${endDate - nowDate <= 0}">
											수강신청기간 종료
										</c:when>
										<c:otherwise>
											${endDate - nowDate}일
										</c:otherwise>
									</c:choose>
								
								</td>
							</tr>
							
							<tr>
								<td>포인트 가격</td>
								<td>${cl.cPrice}</td>
							</tr>
							<tr>
								<td colspan="2"><button type="button" onclick="location.href='classView${classPageMaker.makeQuery(classPageMaker.cri.page)}&cId=${cl.cId}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'">상세정보</button></td>
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
		<hr>
		<script src="${pageContext.request.contextPath}/js/class/classMain.js"></script>
	</body>
</html>