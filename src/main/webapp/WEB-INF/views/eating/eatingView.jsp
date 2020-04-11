<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>맛집 상세페이지 : ${eContentView.eTitle}</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/eating/eatingView.css">
		<link href="${pageContext.request.contextPath}/css/eating/ninja-slider.css" rel="stylesheet" type="text/css"/>
		<link href="${pageContext.request.contextPath}/css/eating/star-rating.css" rel="stylesheet" type="text/css"/>
	    <script src="${pageContext.request.contextPath}/js/eating/ninja-slider.js"></script>
	    <script src="${pageContext.request.contextPath}/js/eating/star-rating.js"></script>

	<body>
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}"/>
		<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}"/>
		<input type="hidden" id="eId" value="${eContentView.eId}"/>
		<input type="hidden" id="eTitle" value="${eContentView.eTitle}"/>
		<input type="hidden" id="ad_new" value="${eContentView.eAddress_new}"/>
		<input type="hidden" id="ad_old" value="${eContentView.eAddress_old}"/>
				
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
								<tr class="tr1">
									<td class="tdLeft1">
										${eContentView.eTitle}&nbsp;<b class="reviewAVG" id="reviewAVGScore"></b>
									</td>
									
									<td class="tdRight1" align="right">
										<a id="eReviewMk" data-toggle="modal" data-target="#eReviewModalForm" data-backdrop="static" data-keyboard="false"><i title="리뷰작성" class="fas fa-pen fa-2x"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										
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

										<a onclick="eScrap(${eContentView.eId}, ${loginUser.user_id})"><i title="내맛집등록" class="fas fa-bookmark fa-2x"></i></a>
									</td>
								</tr>
								
								<tr class="tr2">
									<td class="tdLeft2">
										<i title="조회수" class="far fa-eye"></i> <b>${eContentView.eHit}</b>&nbsp;&nbsp;
										<i title="리뷰수" class="fas fa-pen"></i> <b class="eReview"></b>&nbsp;&nbsp;
										<i title="맛집등록수" class="fas fa-bookmark"></i> <b>${eContentView.sCount}</b>
									</td>
									
									<td class="tdRight2" align="right">
										<a class="eMainBtn eList"><i class="fas fa-list-ul fa-2x"></i></a>
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
												<b>한식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'japanese_food'}">
												<b>일식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'western_food'}">
												<b>양식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'chinese_food'}">
												<b>중식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'asian_food'}">
												<b>아시안 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'etc_food'}">
												<b>기타 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'fusion_food'}">
												<b>퓨전 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
										</c:choose>
									</td>
								</tr>
								<tr class="tr4b">
									<td class="tdLeftb4"><i title="주요메뉴" class="fas fa-utensils fa-2x"></i></td>
									<td class="tdRightb4"><pre>${eContentView.eContent}</pre></td>
								</tr>
								
								<tr class="tr5" align="right">
									<td colspan="2">DB등록일 : <fmt:formatDate value="${eContentView.eDate}" pattern="yyyy.MM.dd HH:mm"/></td>									
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
							<h4><i class="fas fa-registered"></i>&nbsp;리뷰(<b class="reviewCount"></b>)</h4>
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