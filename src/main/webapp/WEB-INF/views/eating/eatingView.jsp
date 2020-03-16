<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Eating : Store Information view</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
	<h1>About that ${elView.eTitle}</h1>
	<hr>
	<br>
	<!-- 오늘 뭐 먹지? 식당 상세 DB -->
	<table border="1">
		<tr>
			<!-- 식당 이미지 -->
			<td><img style="width: 33%;" src="${pageContext.request.contextPath}/img/eating_store_icon.png"></td>
		</tr>
		<tr>
			<!-- 상호, 평점, 카테고리 -->
			<td>store information <br> ${elView.eTitle},
				${elView.eGrade}, ${elView.eCategory}, ${elView.eTel},
				${elView.eAddress_new}
				<button type="button">지번</button>(${elView.eAddress_new})
			</td>
		</tr>
		<tr>
			<td width="500" height="300">
				대표 메뉴, 그 외 정보 <br> 
				${eContentView.eContent} <br> 
				THIS STORE IS MANY JMTGR, BUT ALWAYS CLOSED MORE FOOD ME
			</td>
		</tr>
		<tr>
			<td>DB 등록일 : ${eContentView.eDate} 
		</tr>
	</table>

	<div id="map" style="width: 30%; height: 100px;"></div>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.555185, 126.936907), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);
	</script>

	<div>
		<table>
			<tr>
				<td colspan="2">
					<button class="eatingList" type="button" onclick="location.href='eatingList'">목록으로 돌아가기!</button> 
					
				</td>
			</tr>
		</table>
	</div>

	<form name="form1" role="form" method="post">
		<input type='hidden' name='eId' value="${elView.eId}"> <input
			type="hidden" name="page" id="escriPage" value="${escri.page}" /> <input
			type="hidden" name="perPageNum" id="escriPageNum"
			value="${escri.perPageNum}" /> <input type="hidden"
			name="searchType" id="escriSearchType" value="${escri.searchType}" />
		<input type="hidden" name="keyword" id="escriKeyword"
			value="${escri.keyword}" /> <input type="hidden" name="eCategory"
			id="eCategory" value="${eCategory}" />
	</form>
	<hr>

	<div>
		<div class="reviewPaging"></div>
		<div class="reviewList"></div>
	</div>

	<script src="${pageContext.request.contextPath}/js/eating/eatingContent.js"></script>
</body>
</html>