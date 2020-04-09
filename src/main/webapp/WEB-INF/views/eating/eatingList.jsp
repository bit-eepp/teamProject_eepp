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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/eatingMain.css">
</head>

<body>
<%
double random = Math.random();
int ranImg = (int)(random * 4) + 1;
%>
	<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<!-- header -->
	
	<section class="sc-eatingBanner">
		<p class="sc-title">오늘 뭐먹지?<br>고민 말고 검색!</p>
		
		<div class="search form-control">
			<select name="searchType" class="custom-select et-select">
				<option value="n" <c:out value="${escri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
				<option value="t" <c:out value="${escri.searchType eq 't' ? 'selected' : ''}"/>>상호</option>
				<option value="c" <c:out value="${escri.searchType eq 'c' ? 'selected' : ''}"/>>메뉴</option>
				<option value="a" <c:out value="${escri.searchType eq 's' ? 'selected' : ''}"/>>주소</option>
				<option value="tc" <c:out value="${escri.searchType eq 'tc' ? 'selected' : ''}"/>>상호/메뉴</option>
			</select> 
			
			<div class="searchControl">
  				<input class="form-control" type="text" placeholder="이탈리안" aria-label="Search" name="keyword" id="keywordInput" value="${escri.keyword}">
  				<div class="input-group-append">
  					<a id="eatingSearchBtn">
  						<span class="input-group-text lighten-3" id="basic-text1"><i class="fas fa-search"
       			 		aria-hidden="true"></i></span>
       				</a>
  				</div>
			</div>
			
		</div>
		<!-- search -->
	</section>
	
	<div class="etContentWrap">
	<!-- 테마 리스트 -->
	<div class="themaList col-sm-8">
		<ul>
			<li class="thema1">
				<img src="${pageContext.request.contextPath}/img/eating/1/1.jpg">
				<a href="${pageContext.request.contextPath}/themaList?&eThema=thema_1"><span>신촌 / 홍대</span></a>
			</li>
			<li class="thema2">
				<img src="${pageContext.request.contextPath}/img/eating/2/1.jpg">
				<a href="${pageContext.request.contextPath}/themaList?&eThema=thema_2"><span>여의도</span></a>
			</li>
			<li class="thema3">
				<img src="${pageContext.request.contextPath}/img/eating/3/1.jpg">
				<a href="${pageContext.request.contextPath}/themaList?&eThema=thema_3"><span>용산 / 이태원</span></a>
			</li>
			<li class="thema4">
				<img src="${pageContext.request.contextPath}/img/eating/4/1.jpg">
				<a href="${pageContext.request.contextPath}/themaList?&eThema=thema_4"><span>강남 / 논현</span></a>
			</li>
			<li class="thema5">
				<img src="${pageContext.request.contextPath}/img/eating/5/1.jpg">
				<a href="${pageContext.request.contextPath}/themaList?&eThema=thema_5"><span>건대입구</span></a>
			</li>
			<li class="thema6">
				<img src="${pageContext.request.contextPath}/img/eating/6/1.jpg">
				<a href="${pageContext.request.contextPath}/themaList?&eThema=thema_6"><span>합정 / 망원</span></a>
			</li>
		</ul>
	</div>

	<div id="searchList">
		<c:choose>
			<c:when test="${not empty eatingList && fn:length(eatingList) > 0}">
				<div class="searchResult col-sm-8">
				<h2 class="searchTitle" id="isSearchTitle">${escri.keyword} 맛집 인기 검색순위</h2>
				
				<div class="et-listWrap">
				<c:forEach items="${eatingList}" var="el">
				<div class="et-listBox">
				<a href="eatingView${eatingPageMaker.makeQuery(eatingPageMaker.cri.page_eating)}&eId=${el.eId}&searchType=${escri.searchType}&keyword=${escri.keyword}'">
					<ul>
						<li class="et-list-thumb">
						<img src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${el.eId}.jpg">
						</li>
						<li class="et-list-thumb">
						<p class="storeName">${el.eTitle}</p>
						<p class="storeScore">${el.rvAVG}</p>
						</li>
						<li class="et-list-addr">
						<p class="address">${el.eAddress_new}</p>
						</li>
					</ul>
				</a>
				</div>
				</c:forEach>
				</div>
				<!-- et-listWrap -->
				</div>
				<!-- searchResult -->
				
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
			</c:when>
			<c:when test="${emptyResult eq 'emptyResult'}">조회된 결과가 없습니다.</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
	</div>
	<!-- searchList -->
</div>
<!-- etContentWrap -->

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
	<input type="hidden" id="eatingKeyword" value="${escri.keyword}" />

		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/js/eating/eatingMain.js"></script>
</body>
</html>