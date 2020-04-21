<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>오늘 뭐 먹지? - 테마리스트</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/eating/eatingThema.css">
	</head>

	<body>
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}"/>
		<input type="hidden" id="eThema" value="${eThema}"/>

		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->

		<section id="themaList-totalWrap">
			<c:choose>
				<c:when test="${eThema == 'thema_1'}">
					<div id="themaBanner" class="sc-themaBanner">
						<p class="thema-title">캠퍼스 낭만이 가득한 카페와 예술의 거리<br>신촌 / 홍대 베스트 맛집</p>
					</div>
				</c:when>
				
				<c:when test="${eThema == 'thema_2'}">
					<div id="themaBanner" class="sc-themaBanner">
						<p class="thema-title">한강과 함께 누리는 도심 속 섬<br>여의도 베스트 맛집</p>
					</div>
				</c:when>
				
				<c:when test="${eThema == 'thema_3'}">
					<div id="themaBanner" class="sc-themaBanner">
						<p class="thema-title">인종과 문화가 공존하는 서울 속 작은 지구촌<br>용산 / 이태원 베스트 맛집</p>
					</div>
				</c:when>
				
				<c:when test="${eThema == 'thema_4'}">
					<div id="themaBanner" class="sc-themaBanner">
						<p class="thema-title">국제 금융과 무역의 중심지<br>강남 / 논현 베스트 맛집</p>
					</div>
				</c:when>
				
				<c:when test="${eThema == 'thema_5'}">
					<div id="themaBanner" class="sc-themaBanner">
						<p class="thema-title">먹거리와 놀거리로 가득한 놀라움의 거리<br>건대입구 베스트 맛집</p>
					</div>
				</c:when>
				
				<c:when test="${eThema == 'thema_6'}">
					<div id="themaBanner" class="sc-themaBanner">
						<p class="thema-title">트렌드와 소박함을 동시에 잡는 동네<br>합정 / 망원 베스트 맛집</p>
					</div>
				</c:when>
			</c:choose>
			<!-- thema list header end -->
			
	
			<!-- thema list body -->
			<div class="container eatingThema">
				<div class="col-sm-12">
					
					<c:forEach items="${themaList}" var="tl">
						<table class="eatList">
						
							<tr class="eatList_tr" >
								<td class="eatList_td1">
									<img src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${tl.eId}.jpg">
								</td>
								
								<td class="eatList_td2">
									<div class="e1">
										<p class="eatTitle"><a href="${pageContext.request.contextPath}/eating/eatingView?eId=${tl.eId}&eThema=${eThema}" target="_blank">${tl.eTitle}</a>&nbsp;&nbsp;<b style="color:#59bfbf;">${tl.rvAVG}</b></p>
										<p class="eatInfo">
											<i title="조회수" class="far fa-eye"></i> ${tl.eHit}&nbsp;&nbsp;
											<i title="리뷰수" class="fas fa-pen"></i> ${tl.rvCount}&nbsp;&nbsp;
											<i title="맛집등록수" class="fas fa-bookmark"></i> ${tl.sCount}
										</p>
									</div>
									<br>
									
									<p class="eatAddress">
										${tl.eAddress_new}
									</p>
									
									<p class="eatCateInfo">
										
										<c:choose>
											<c:when test="${tl.eCategory == 'korean_food'}">
												<b class="eatCategory">한식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													<a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a>
												</c:forEach>
											</c:when>
											
											<c:when test="${tl.eCategory == 'japanese_food'}">
												<b class="eatCategory">일식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													 <a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a>
												</c:forEach>  
											</c:when>
											
											<c:when test="${tl.eCategory == 'western_food'}">
												<b class="eatCategory">양식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													 <a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a>
												</c:forEach>
											</c:when>
											
											<c:when test="${tl.eCategory == 'chinese_food'}">
												<b class="eatCategory">중식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													<a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a>
												</c:forEach>
											</c:when>
											
											<c:when test="${tl.eCategory == 'asian_food'}">
												<b class="eatCategory">아시안 음식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													<a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a>
												</c:forEach>
											</c:when>
											
											<c:when test="${tl.eCategory == 'etc_food'}">
												<b class="eatCategory">기타 음식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													<a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a> 
												</c:forEach>
											</c:when>
											
											<c:when test="${tl.eCategory == 'fusion_food'}">
												<b class="eatCategory">퓨전 음식</b>&nbsp;
												<c:forEach items="${fn:split(tl.eKeyword_food, ' ')}" var="tlKeyWord">
													 <a class="eatTag" href="https://startag.io/search.php?q=${tlKeyWord}" target="_blank">#${tlKeyWord}</a> 
												</c:forEach>
											</c:when>
										</c:choose>
									</p>
									
									<p class="eatMoreBtn" align="right">
										<button title="${tl.eTitle} 더보기" class="btn btn-primary" type="button" onclick="window.open('${pageContext.request.contextPath}/eating/eatingView?eId=${tl.eId}&eThema=${eThema}')"><i class="fas fa-angle-double-right"></i></button>
									</p>
									
								
								</td>
							</tr>
						</table>
						<hr>
					
					</c:forEach>
					
				</div>
			</div>
		</section>
		<br>

		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
	
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->

		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/js/eating/eatingThema.js"></script>
	</body>
</html>