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
	<input type="hidden" id="userNickname" name="loginUser"
		value="${loginUser.uNickname}" />
	<input type="hidden" id="userId" name="loginUserId"
		value="${loginUser.user_id}" />
	<input type="hidden" id="classUserNickname" value="${elView.uNickname}" />

	<h1>About that #${elView.eTitle}</h1>
	<hr>
	<br>
	<!-- 오늘 뭐 먹지? 식당 상세 DB -->
	<table border="1">
		<tr>
			<!-- 식당 이미지 -->
			<td><img style="width: 33%;"
				src="${pageContext.request.contextPath}/img/eating_store_icon.png"></td>
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
			<td width="500" height="300">${clView.eContent} <br> 대표 메뉴,
				그 외 정보 THIS STORE IS MANY JMTGR, BUT ALWAYS CLOSED MORE FOOD ME
			</td>
		</tr>
		<tr>
			<td>DB 등록일 : <fmt:formatDate value="${elView.eDate}"
					pattern="yyyy-MM-dd" /></td>
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
					<button class="eatingList" type="button">목록으로 돌아가기!</button> <!-- <c:choose>
						<c:when test="${loginUser.uNickname == clView.uNickname}">
						<button class="classModify" type="button">class강좌 수정</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="classDelete" type="button">class강좌 삭제</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="classList" type="button" >class강좌 목록</button>
						</c:when>
						<c:otherwise>
						<button class="eatingList" type="button" >class강좌 목록</button>
						<button type="button" onclick="cScrap(${elView.cId})">식당 기억 해두기</button>
						</c:otherwise>
						</c:choose> -->
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

	<!-- 수업문의 작성 -->
	<div>
		<h2>
			리뷰 보기 <b class="rvCount"></b>
		</h2>
		<input type="text" name="rvGradeAVG" value="${elView.eGrade}" />
		<!-- 개설자일경우 안보임-->
		<c:choose>
			<c:when test="${loginUser.uNickname == elView.uNickname}">
			</c:when>

			<c:otherwise>
				<form name="qForm">
					<input type="hidden" name="eating_id" value="${elView.eId}" />
					<table border="1">
						<tr>
							<td>
								<button type="button" name="rBtn">리뷰</button>
							</td>
						<tr>
						<tr>
							<td>
								<h5>이 식당 어땠어요?</h5>
							</td>
							<td>
								<h5>1점 2점 3점 4점 5점</h5>
							</td>
						<tr>
							<td><textarea type="text" name="rvContent"
									placeholder="내용을 입력하세요." rows="5" cols="100"></textarea></td>
						</tr>
					</table>
				</form>
			</c:otherwise>
		</c:choose>

	</div>
	<hr>

	<div>
		<div class="reviewPaging"></div>
		<div class="reviewList"></div>
	</div>

	<%@ include file="/WEB-INF/views/eating/eatingList.jsp"%>
	<script
		src="${pageContext.request.contextPath}/js/eating/eatingContent.js"></script>
</body>
</html>