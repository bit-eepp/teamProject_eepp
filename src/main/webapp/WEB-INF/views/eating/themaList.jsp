<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>오늘 뭐 먹지? 장소 테마로 보기!</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/common.css">
<style>
.themaList-totalWrap {
	padding-top: 100px;
	paddint-bottom: 20px;
}

/* 테마 타이틀 영역 */
.thema-title-info {
	padding: 200px 60px 140px;
	background-color: #59bfbf;
	position: relative;
	background-size: cover;
	backgroung-potion: bottom;
}

.thema-title-info .title-comment h1, h5 {
	z-index: 1;
	position: relative;
	text-align: center;
	color: #fff;
	line-height: 62px;
}

.thema-title-info .title-comment h1 {
	font-size: 4.0rem;
	font-weight: 700;
}

/* 테마 리스트 영역 */
.thema-list-wrap {
	position: relative;
	margin: 0 auto;
}

.thema-list-wrap h3 {
	z-index: 1;
	position: relative;
	text-align: center;
	line-height: 62px;
}

.thema-list-wrap .thema-list-box {
	position: relative;
	overflow: hidden;
	margin: 40px 0;
}

.thema-list-box a ul {
	list-style: none;
	display: flex;
	margin-bottom: 0;
}

.thema-list-box a {
	display: block;
	text-decoration: none;
	margin: 40px 0;
}

.thema-list-box a:hover {
	border: 3px solid #ccc;
}

.thema-list-box a ul .thema-list-thumb img {
	width: 150%;
}

table{
	color : black;
}

.thema-list-box table p {
	text-align : center;
} 

.thema-list-wrap .thema-list-box a ul .thema-list-info {
	position: relative;
	text-decoration: none;
	color: black;
	padding-top: 40px;
	margin-left: 10%;
}

.thema-list-box a ul .thema-list-info .storeName {
	font-size: 40px;
	font-weight: 800;
	display: inline-block;
	color: black;
}

.thema-list-box a ul .thema-list-info .storeAVG {
	font-size: 30px;
	font-weight: 600;
	margin: 5px 15px;
	color: #59bfbf;
	display: inline-block;
}

.thema-list-box a ul .thema-list-info .storeMore {
	font-size: 12px;
}
</style>
</head>

<body>
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
	<input type="hidden" id="eatingPageMaker"
		value="${eatingPageMaker.makeQuery(1)}" />
	<input type="hidden" id="eThema" value="${eThema}" />
		<input type="hidden" id="eKeyword_food" value="${eKeyword_food}" />
	<input type="hidden" id="eatingTotalCount"
		value="${eatingPageMaker.totalCount}" />
	<input type="hidden" id="eatingCriPage"
		value="${eatingPageMaker.cri.page_eating}" />
	<input type="hidden" id="eatingSearchType" value="${escri.searchType}" />

	<!-- header -->
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<!-- header -->

	<section id="themaList-totalWrap">

		<!-- thema list header -->
		<div class="thema-title-info">
			<div class="title-comment">
				<c:choose>
					<c:when test="${eThema == 'thema_1'}">
						<h5>캠퍼스 낭만이 가득한 카페와 예술의 거리</h5>
						<h1>신촌 / 홍대 베스트 맛집</h1>
					</c:when>
					<c:when test="${eThema == 'thema_2'}">
						<h5>한강과 함께 누리는 도심 속 섬</h5>
						<h1>여의도</h1>
					</c:when>
					<c:when test="${eThema == 'thema_3'}">
						<h5>인종과 문화가 공존하는 서울 속 작은 지구촌</h5>
						<h1>용산 / 이태원 베스트 맛집</h1>
					</c:when>
					<c:when test="${eThema == 'thema_4'}">
						<h5>국제 금융과 무역의 중심지</h5>
						<h1>강남 / 논현 베스트 맛집</h1>
					</c:when>
					<c:when test="${eThema == 'thema_5'}">
						<h5>먹거리와 놀거리로 가득한 놀라움의 거리</h5>
						<h1>건대입구 베스트 맛집</h1>
					</c:when>
					<c:when test="${eThema == 'thema_6'}">
						<h5>트렌드와 소박함을 동시에 잡는 동네</h5>
						<h1>합정 / 망원 베스트 맛집</h1>
					</c:when>
				</c:choose>
			</div>
		</div>
		<!-- thema list header end -->

		<!-- thema list body -->

		<div class="themaList-side-left"></div>

		<div id="themaList" class="themaList">
			<c:choose>
				<c:when test="${fn:length(themaList) > 0}">
					<div class="thema-list-wrap col-sm-8">
						<c:forEach items="${themaList}" var="tl">
						<input id="keyword_${tl.eId}" type="hidden" value="${tl.eKeyword_food}">
						<input id="eId" type="hidden" value="${tl.eId}">
						
							<div class="thema-list-box">
								<a href="eatingView${eatingPageMaker.makeQuery(eatingPageMaker.cri.page_eating)}&eId=${tl.eId}&searchType=${escri.searchType}&keyword=${escri.keyword}&eThema=${eThema}">
								<%--  <ul>
								<li class="thema-list-thumb">
									<img src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${tl.eId}.jpg">
								</li>
								<li class="thema-list-info">
									<div>
									<p class="storeName">${tl.eTitle}</p>
									<p class="storeAVG"> ★ ${tl.rvAVG}</p>
									</div>
									<div>
									 
									 <p class="storeCate">
									 <i title="음식종류" class="fab fa-delicious fa-2x"></i>
									 	<c:choose>
											<c:when test="${tl.eCategory == 'korean_food'}">
												<b>한식</b> <p class="tagText"></p>
											</c:when>
											<c:when test="${tl.eCategory == 'japanese_food'}">
												<b>일식</b> 
											</c:when>
											<c:when test="${tl.eCategory == 'western_food'}">
												<b>양식</b> 
											</c:when>
											<c:when test="${tl.eCategory == 'chinese_food'}">
												<b>중식</b> 
											</c:when>
											<c:when test="${tl.eCategory == 'asian_food'}">
												<b>아시안 음식</b> 
											</c:when>
											<c:when test="${tl.eCategory == 'etc_food'}">
												<b>베이커리</b> 
											</c:when>
											<c:when test="${tl.eCategory == 'fusion_food'}">
												<b>퓨전 음식</b>
											</c:when>
										</c:choose>
									 </p>
									 <p class="storeAddnew">${tl.eAddress_new}</p>
									 <p class="storeMore">　　　　　　　　　　　　　${tl.eTitle} 더 보기 >> </p>
									 </div>
								</li>
							</ul>  --%>
							
									<table>
										<tr>
											<td rowspan="3"><img src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${tl.eId}.jpg"></td>
											<td><p class="storeName">${tl.eTitle}</p></td>
										</tr>
										<tr>
											<td>

													<p class="storeAVG">★ ${tl.rvAVG}</p>
													<p class="storeHit"><i title="조회수" class="far fa-eye"></i> ${tl.eHit}</p>
													<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
														#${tlKeyWord} 
													</c:forEach>
													
													<div class="baseText"></div>
													<p class="storeCate">
														<i title="음식종류" class="fab fa-delicious fa-2x"></i>
														<c:choose>
															<c:when test="${tl.eCategory == 'korean_food'}">
																<b>한식</b> 
															</c:when>
															<c:when test="${tl.eCategory == 'japanese_food'}">
																<b>일식</b> / ${tl.eKeyword_food}
															</c:when>
															<c:when test="${tl.eCategory == 'western_food'}">
																<b>양식</b> / ${tl.eKeyword_food} 
															</c:when>
															<c:when test="${tl.eCategory == 'chinese_food'}">
																<b>중식</b> / ${tl.eKeyword_food}
															</c:when>
															<c:when test="${tl.eCategory == 'asian_food'}">
																<b>아시안 음식</b> / ${tl.eKeyword_food}
															</c:when>
															<c:when test="${tl.eCategory == 'etc_food'}">
																<b>베이커리</b> / ${tl.eKeyword_food}
															</c:when>
															<c:when test="${tl.eCategory == 'fusion_food'}">
																<b>퓨전 음식</b> / ${tl.eKeyword_food}
															</c:when>
														</c:choose>
													</p>
													<p class="storeAddnew">${tl.eAddress_new}</p>
													</td>
										</tr>
										<tr>
											<td><p class="storeMore">${tl.eTitle} 더 보기 >></p></td>
										</tr>
									</table>
								</a>
							</div>
							<!-- thema-list-box end -->
						</c:forEach>
					</div>
					<!-- thema-list-wrap end -->
				</c:when>
			</c:choose>
		</div>

		<div class="themaList-side-right"></div>

	</section>

	<!-- chat -->
	<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
	<!-- chat -->

	<!-- footer -->
	<%@ include file="/WEB-INF/views/footer.jsp"%>
	<!-- footer -->

	<script src="${pageContext.request.contextPath}/js/common.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/eating/eatingThema.js"></script>
</body>
</html>