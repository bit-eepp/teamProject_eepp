<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>맛집 : ${eContentView.eTitle}</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/eating/eatingView.css">
		<link href="${pageContext.request.contextPath}/css/eating/ninja-slider.css" rel="stylesheet" type="text/css"/>
		<link href="${pageContext.request.contextPath}/css/eating/star-rating.css" rel="stylesheet" type="text/css"/>
	    <script src="${pageContext.request.contextPath}/js/eating/ninja-slider.js"></script>
	    <script src="${pageContext.request.contextPath}/js/eating/star-rating.js"></script>

	<body>
				
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->

		<section id="eatingViewWrap">
		
			<div class="container-fluid eImg" align="center">
				<div class="slideImg">
			        <div id="ninja-slider">
			            <div class="slider-inner">
			                <ul>
			                    <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/1.jpg"></a>
			                    </li>
			                    <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/2.jpg"></a>
			                    </li>
			                   <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/3.jpg"></a>
			                    </li>
			                    <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/4.jpg"></a>
			                    </li>
			                </ul>
			                <div id="fsBtn" class="fs-icon" title="Expand/Close"></div>
			            </div>
			        </div>
			    </div>
			     
			    <div class="eatViewImg">
			        <div class="gallery">
			        	<div class="evImg">
			        		<img onclick="lightbox(0)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/1.jpg">
			        	</div>
			        	
			        	<div class="evImg">
			        		<img onclick="lightbox(1)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/2.jpg">
			        	</div>
			        	
			        	<div class="evImg">
			        		<img onclick="lightbox(2)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/3.jpg">
			        	</div>
			        	
			        	<div class="evImg">
			        		<img onclick="lightbox(3)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/4.jpg">
			        	</div>
			        </div>
			    </div>
			    
		    </div>

			<div class="container eatingView">
				<div class="row eatingContent">				
					
					<div class="col-6 eContentLeft">
						<div class="eContentHead">
							<table>
								<tr class="tr1 eContentMainInfo">
									<td class="tdLeft1">
										<div class="eContentTitle">
											<p>${eContentView.eTitle}</p>
											<span class="reviewAVG" id="reviewAVGScore"></span>
										</div>
										<div class="eContentInfo">
											<p class="eHit"><i title="조회수" class="far fa-eye"></i> ${eContentView.eHit}</p>
											<p class="eReviewCount"><i title="리뷰수" class="fas fa-pen"></i> <span class="eReview"></span></p>
											<p class="eBookmarkCount"><i title="맛집등록수" class="fas fa-bookmark"></i> ${eContentView.sCount}</p>
										</div>
									</td>
									
									<td class="tdRight1" align="right">
										<div class="btnWrap">
											<p class="reviewBtn">
												<a id="eReviewMk" class="reviewBtn" data-toggle="modal" data-target="#eReviewModalForm" data-backdrop="static" data-keyboard="false">
												<i title="리뷰작성" class="fas fa-pen fa-2x"></i>
												</a>
											</p>
											<p class="scrapBtn">
												<a onclick="eScrap(${eContentView.eId}, ${loginUser.user_id})">
												<i title="내맛집등록" class="fas fa-bookmark fa-2x"></i>
												</a>
											</p>
										</div>
										<div class="btnWrap">
											<!-- 카카오링크 공유 -->
											<p class="shareBtn">
												<a class="share" id="kakaoShareBtn">
												<img src="${pageContext.request.contextPath}/img/kakaolink_btn_medium.png"/>
												</a>
											</p>
											<p class="backToList"><a class="eMainBtn eList"><i title="메인" class="fas fa-list-ul fa-2x"></i></a></p>
										</div>
										
										<div class="modal fade" id="eReviewModalForm" role="dialog">
											<div class="modal-dialog">
												<div class="modal-content">
								
													<!-- Modal Header -->
													<div class="modal-header" align="center">
														<h4><b style="color: #e7438b;">${eContentView.eTitle}</b>의 리뷰를 남겨주세요</h4>
													</div>
													
													<c:choose>
														<c:when test="${not empty loginUser.uNickname}">
															<!-- Modal Body -->
															<div class="modal-body" align="center">
																<p class="classImg">
												           			<img alt="eimg" src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${eContentView.eId}.jpg">
												            	</p>
															
																<form name="rvform">
																	<input type="hidden" name="eating_id" value="${eContentView.eId}" />
																	<input type="hidden" name="user_id" value="${loginUser.user_id}">
																	
																	<div align="center">
																		<input id="rvScore" name="rvScore" type="text" class="rating" min="0.5" max="5.0" step="0.5">
																	</div>
																	<br>
																	
																	<textarea id="rvComment" type="text" name="rvComment" placeholder="${loginUser.uNickname}님 맛집 ${eContentView.eTitle}는 어떠셨나요?&#13;&#10;식당의 분위기와 서비스도 궁금해요!" rows="5" cols="100" style="resize: none; height: 200px; width: 100%;"></textarea>
																</form>	
															</div>
															<!-- modal body -->
										
															<!-- Modal Footer -->
															<div class="modal-footer">
																<button style="color: #e7438b;" type="button" class="btn" data-dismiss="modal" onclick="eResetForm()">취소</button>
																<button style="color: #e7438b;" id="eReviewBtn" type="button" class="btn" onclick="eReviewWrite()">작성</button>
															</div>
															<!-- Modal Footer -->
														</c:when>
														
														<c:otherwise>
															<!-- Modal Body -->
															<div class="modal-body" align="center">
																<p class="classImg">
												           			<img alt="eimg" src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${eContentView.eId}.jpg">
												            	</p>
																<br>
																<h5>리뷰를 남기시려면 <b style="color: #e7438b;">로그인</b> 해주세요.</h5>
																<br>
															</div>
															<!-- modal body -->
										
															<!-- Modal Footer -->
															<div class="modal-footer">
																<button style="color: #e7438b;" type="button" class="btn" data-dismiss="modal">취소</button>
															</div>
															<!-- Modal Footer -->
														</c:otherwise>
													</c:choose>
												</div>
												<!-- modal-content -->
											</div>
											<!-- modal-dialog -->
										</div>
										<!-- modal -->
									</td>
								</tr>
							</table>
						</div>
						<hr>

						<div class="eContentBody">
							<table>
								<tr class="tr1b">
									<td class="tdLeftb1"><i title="위치" class="fas fa-map-marker-alt fa-2x"></i></td>
									<td class="tdRightb1">
										${eContentView.eAddress_new}<br>
										[지번] ${eContentView.eAddress_old}
									</td>
								</tr>
								<tr class="tr2b">
									<td class="tdLeftb2"><i title="전화번호" class="fas fa-phone fa-2x"></i></td>
									<td class="tdRightb2">${eContentView.eTel}</td>
								</tr>
								<tr class="tr3b">
									<td class="tdLeftb3"><i title="음식종류" class="fab fa-delicious fa-2x"></i></td>
									<td class="tdRightb3">
										<c:choose>
											<c:when test="${eContentView.eCategory == 'korean_food'}">
												<b class="cCategoryFood">한식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'japanese_food'}">
												<b class="cCategoryFood">일식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'western_food'}">
												<b class="cCategoryFood">양식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'chinese_food'}">
												<b class="cCategoryFood">중식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'asian_food'}">
												<b class="cCategoryFood">아시안 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'etc_food'}">
												<b class="cCategoryFood">기타 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'fusion_food'}">
												<b class="cCategoryFood">퓨전 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
										</c:choose>
									</td>
								</tr>
								<tr class="tr4b">
									<td class="tdLeftb4"><i title="주요메뉴" class="fas fa-utensils fa-2x"></i></td>
									<td class="tdRightb4"><pre>${eContentView.eContent}</pre></td>
								</tr>
								
								<tr class="tr5b">
									<td class="tdLeftb5"><i title="주차정보" class="fas fa-parking fa-2x"></i></td>
									<td class="tdRightb5">${eContentView.eParkInfo}</td>
								</tr>
								
								<tr class="tr6b">
									<td class="tdLeftb6"><i title="영업시간" class="far fa-clock fa-2x"></i></td>
									<td class="tdRightb6">${eContentView.eOpeningHour}</td>
								</tr>
							</table>			
						</div>
					
					</div>
					
					<div class="col-6 eContentRight">
						<div id="map"></div>
					</div>
					
					
					<div class="col eatingReview">
						<br><hr><br>
						<div class="reviewForm">
							<h4>리뷰(<b class="reviewCount"></b>)</h4>
						</div>
						<br>

						<div>
							
							<div class="reviewList"></div>
							<div class="reviewPaging"></div>
						</div>
				
					</div>
				</div>
			</div>
			
			<form name="form1" role="form" method="post">
				<input type="hidden" name="page_eating" id="escriPage" value="${escri.page_eating}" />
				<input type="hidden" name="perPageNum" id="escriPageNum" value="${escri.perPageNum}" />
				<input type="hidden" name="searchType" id="escriSearchType" value="${escri.searchType}" />
				<input type="hidden" name="keyword" id="escriKeyword" value="${escri.keyword}" />
				<input type="hidden" name="eThema" id="eThema" value="${eThema}" />
				<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}"/>
				<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}"/>
				<input type="hidden" id="eId" value="${eContentView.eId}"/>
				<input type="hidden" id="eTitle" value="${eContentView.eTitle}"/>
				<input type="hidden" id="ad_new" value="${eContentView.eAddress_new}"/>
				<input type="hidden" id="ad_old" value="${eContentView.eAddress_old}"/>
			</form>
			
		</section>
		
		<div id="eCurrentPageNum"></div>
		
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->

		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/js/eating/eatingContent.js"></script>

	</body>

</html>