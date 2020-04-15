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
	background-potion: bottom;
}

.thema-title-info .title-comment p, h5 {
	z-index: 1;
	position: relative;
	text-align: center;
	color: #fff;
	line-height: 62px;
}

.thema-title-info .title-comment p {
	font-size: 2.8rem;
	font-weight: 700;
}

/* 테마 리스트 영역 */
.thema-list-wrap {
	position: relative;
	margin: 0 auto;
}

.thema-list-wrap .thema-list-box {
	position: relative;
	overflow: hidden;
	margin: 40px 0;
}

.thema-list-box a {
	display: block;
	text-decoration: none;
	margin: 40px 0;
}

.thema-list-box a:hover {
	border: 1px none #ccc;
	background-color : #F2F2F2;
	opacity: 0.95;
}

.thema-list-box a ul .thema-list-thumb img {
	width: 100%;
}

.thema-list-box table{

	color : black;
	width : 100%;
}

.thema-list-box a table.thema-infomation tr, td{
	color : black;
	padding : 8px;
	text-align : left;
}

.thema-list-box a table.thema-infomation i{
	color : #59bfbf;
	opacity: 0.8;
	font-size : 14px;

}

.thema-list-box a table.thema-infomation .storeName {
	margin-top : 10px;
	font-size: 40px;
	font-weight: 800;
	display: inline-block;
	color: black;
}

.thema-list-box a table.thema-infomation .storeAVG {
	text-align : center;
	font-size: 18px;
	font-weight: 800;
	color: #59bfbf;
}

.thema-list-box a table.thema-infomation .storeHit {
	text-align : left;
	font-size: 18px;
	font-weight: 600;
	color: #59bfbf;
}

.thema-list-box a table.thema-infomation .storeCate {
	text-align : center;
	font-size: 16px;
	font-weight: 600;
	color: #59bfbf;
}

.thema-list-box a table.thema-infomation .storeTag {
	font-size: 16px;
	font-weight : 700;
	
}

.thema-list-box a table.thema-infomation .storeAddnew {
	font-size: 16px;
	color: #9b9b9b;
}
.thema-list-box a table.thema-infomation .storeMore {
	font-size: 16px;
	font-weight : 700;
	color : #59bfbf;
	opacity: 0.95;
	text-align : left;
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
						<p>신촌 / 홍대 베스트 맛집</p>
					</c:when>
					<c:when test="${eThema == 'thema_2'}">
						<h5>한강과 함께 누리는 도심 속 섬</h5>
						<p>여의도</p>
					</c:when>
					<c:when test="${eThema == 'thema_3'}">
						<h5>인종과 문화가 공존하는 서울 속 작은 지구촌</h5>
						<p>용산 / 이태원 베스트 맛집</p>
					</c:when>
					<c:when test="${eThema == 'thema_4'}">
						<h5>국제 금융과 무역의 중심지</h5>
						<p>강남 / 논현 베스트 맛집</p>
					</c:when>
					<c:when test="${eThema == 'thema_5'}">
						<h5>먹거리와 놀거리로 가득한 놀라움의 거리</h5>
						<p>건대입구 베스트 맛집</p>
					</c:when>
					<c:when test="${eThema == 'thema_6'}">
						<h5>트렌드와 소박함을 동시에 잡는 동네</h5>
						<p>합정 / 망원 베스트 맛집</p>
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
					<div class="thema-list-wrap col-sm-7">
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

									<table class="thema-infomation">
										<tr>
											<td rowspan="4" class="storeIMG"> 
											<img src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${tl.eId}.jpg"></td>
											<td class="storeName">${tl.eTitle}</td>
											<td class="storeCate"><i title="키워드" class="fas fa-utensils fa-2x"></i>
											<c:choose>
													<c:when test="${tl.eCategory == 'korean_food'}">
														한식
													</c:when>
													<c:when test="${tl.eCategory == 'japanese_food'}">
														일식
													</c:when>
													<c:when test="${tl.eCategory == 'western_food'}">
														양식
													</c:when>
													<c:when test="${tl.eCategory == 'chinese_food'}">
														중식
													</c:when>
													<c:when test="${tl.eCategory == 'asian_food'}">
														아시안 음식
													</c:when>
													<c:when test="${tl.eCategory == 'etc_food'}">
														베이커리
													</c:when>
													<c:when test="${tl.eCategory == 'fusion_food'}">
														퓨전 음식
													</c:when>
												</c:choose></td>
											<td class="storeAVG"> ★ ${tl.rvAVG}</td>
											<td class="storeHit"><i title="조회수" class="far fa-eye"></i> ${tl.eHit}</td>
										</tr>
										<tr>
											
											<td class="storeTag" colspan="3">
											　　
													<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
														 #${tlKeyWord} 
													</c:forEach>
												</td>
										</tr>
										<tr>
											<td class="storeAddnew" colspan="3"><i title="주소" class="fas fa-map-marker-alt fa-2x"></i>　${tl.eAddress_new}</td>
										</tr>
										<tr>
											<td colspan="2"></td>
											<td class="storeMore" align = "left">${tl.eTitle} 더 보기 >></td>
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