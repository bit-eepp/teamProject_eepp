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
		<link href="${pageContext.request.contextPath}/css/eating/ninja-slider.css" rel="stylesheet" type="text/css"/>
	    <script src="${pageContext.request.contextPath}/js/eating/ninja-slider.js" type="text/javascript"></script>
	    
	    <script>
	  		var userId = $('#userId').val();
	  		var uNickname = $("#userNickname").val();
			var eating_id = $('#eId').val();
	  		
	  		function getContextPath() {
				var hostIndex = location.href.indexOf(location.host) + location.host.length;
				return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
			};
	
			$(document).ready(function() {
				var rvCount; // 해당 게시글의 댓글 수 

				reviewCount(eating_id);
				reviewList();

				var formObj = $('form[role="form"]');

				$('.list').on('click', function() {
					formObj.attr('method', 'post');
					formObj.attr('action', 'eatingList');
					formObj.submit();
				});

				/* 음식점 map 부분 */
				var ad_new = $('#ad_new').val();
				var eatingAddress = ad_new;
				var mapContainer = document.getElementById('map'), // 지도 표시할 div 
					mapOption = {
						center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도 중심좌표
						level : 3	// 지도 확대레벨
					};
	
				// 지도 생성
				var map = new kakao.maps.Map(mapContainer, mapOption);
	
				// 주소-좌표 변환 객체 생성
				var geocoder = new kakao.maps.services.Geocoder();
	
				// 주소로 좌표를 검색
				geocoder.addressSearch(eatingAddress,function(result, status) {
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
	
						var coords = new kakao.maps.LatLng(result[0].y,result[0].x);
	
						var imageSrc = getContextPath() + '/img/eating/ePlaceMarker.png', 	// 마커이미지의 주소 
							imageSize = new kakao.maps.Size(55, 45), 						// 마커이미지의 크기
							imageOption = {offset : new kakao.maps.Point(27, 69)}; 			// 마커이미지의 옵션 : 마커의 좌표와 일치시킬 이미지 안에서의 좌표
	
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
						// 결과값으로 받은 위치를 마커로 표시
						var marker = new kakao.maps.Marker({
									map : map,
									position : coords,
									image : markerImage
								});
	
						console.log('eatingAddress : '+ eatingAddress);
						console.log('coords : ' + coords);
						console.log(result[0].y);
						console.log(result[0].x);
	
						// 마커가 지도 위에 표시
						marker.setMap(map);
	
						// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						var content = '<div class="customoverlay">';
						content += '<a href="https://map.kakao.com/link/map/' +eatingAddress +',' +result[0].y +',' +result[0].x +'" target="_blank">';
						content += '<span class="title"><i class="fas fa-store" style="color:#ff9007;"></i> ${eContentView.eTitle}</span>';
						content += '</a>';
						content += '</div>';
	
						// 커스텀 오버레이를 생성합니다
						var customOverlay = new kakao.maps.CustomOverlay(
								{
									map : map,
									position : coords,
									content : content,
									yAnchor : 1
								});
						// 지도중심을 결과값으로 받은 위치 이동
						map.setCenter(coords);
					}
				});
			});
	  		
	        function lightbox(idx) {
	            //show the slider's wrapper: this is required when the transitionType has been set to "slide" in the ninja-slider.js
	            var ninjaSldr = document.getElementById("ninja-slider");
	            ninjaSldr.parentNode.style.display = "block";
	
	            nslider.init(idx);
	
	            var fsBtn = document.getElementById("fsBtn");
	            fsBtn.click();
	        }
	
	        function fsIconClick(isFullscreen, ninjaSldr) { //fsIconClick is the default event handler of the fullscreen button
	            if (isFullscreen) {
	                ninjaSldr.parentNode.style.display = "none";
	            }
	        }
	        
	    	 // 해당 맛집 등록 JS메서드(Ajax-Json)
	        function eScrap(eId) {
	        	if(userId == '') {
	        		alert('로그인 후 이용해 주세요.');
	        		return false;
	        	} else {
	        		$.ajax({
	        			url: getContextPath() + '/scrap/doEatingScrap',
	        			type: 'post',
	        			data: {
	        				'eating_id' : eId,
	        				'user_id' : userId
	        			},
	        			success: function(data){
	        				if(data == 1){
	        					alert("이미 등록한 맛집입니다.");
	        				}else{
	        					alert(eId +"번 맛집이 내 맛집으로 등록되었습니다.");
	        				}
	        			},
	        			error : function(request, status, error) {
	        				console.log(request.responseText);
	        				console.log(error);
	        			}
	        		});
	        	}
	        }
	    </script>
	    
		<style>
			.customoverlay {
				position: relative;
				bottom: 85px;
				border-radius: 6px;
				border: 1px solid #ccc;
				border-bottom: 2px solid #ddd;
				float: left;
			}
			
			.customoverlay:nth-of-type(n) {
				border: 0;
				box-shadow: 0px 1px 2px #888;
			}
			
			.customoverlay a {
				display: block;
				text-decoration: none;
				color: #000;
				text-align: center;
				border-radius: 6px;
				font-size: 14px;
				font-weight: bold;
				overflow: hidden;
				background: #ff9007;
				background: #ff9007 url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
			}
			
			.customoverlay .title {
				display: block;
				text-align: center;
				background: #fff;
				margin-right: 35px;
				padding: 10px 15px;
				font-size: 14px;
				font-weight: bold;
			}
			
			.customoverlay:after {
				content: '';
				position: absolute;
				margin-left: -12px;
				left: 50%;
				bottom: -12px;
				width: 22px;
				height: 12px;
				background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png');
			}
			
			.gallery img{
	            cursor:pointer;
	        }

		</style>
	
	</head>

	<body>
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}"/>
		<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}"/>
		<input type="hidden" id="eId" value="${eContentView.eId}"/>
		<input type="hidden" id="ad_new" value="${eContentView.eAddress_new}"/>
		<input type="hidden" id="ad_old" value="${eContentView.eAddress_old}"/>
				
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->

		<section id="eatingViewWrap" style="padding-top:100px;">
			<div class="container-fluid eImg" align="center" style="margin-bottom: 50px;">
				<div style="display:none;">
			        <div id="ninja-slider">
			            <div class="slider-inner">
			                <ul>
			                    <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/1.jpg"></a>
			                        <!-- <div class="caption">
			                            <h3>Dummy Caption 1</h3>
			                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus accumsan purus.</p>
			                        </div> -->
			                    </li>
			                    <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/2.jpg"></a>
			                        <!-- <div class="caption">
			                            <h3>Dummy Caption 2</h3>
			                            <p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet</p>
			                        </div> -->
			                    </li>
			                   <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/3.jpg"></a>
			                        <!-- <div class="caption">
			                            <h3>Dummy Caption 3</h3>
			                            <p>Quisque semper dolor sed neque consequat scelerisque at sed ex. Nam gravida massa.</p>
			                        </div> -->
			                    </li>
			                    <li>
			                        <a class="ns-img" href="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/4.jpg"></a>
			                        <!-- <div class="caption">
			                            <h3>Dummy Caption 4</h3>
			                            <p>Quisque semper dolor sed neque consequat scelerisque at sed ex. Nam gravida massa.</p>
			                        </div> -->
			                    </li>
			                </ul>
			                <div id="fsBtn" class="fs-icon" title="Expand/Close"></div>
			            </div>
			        </div>
			    </div>
			    
			    
			    <div>
			        <div class="gallery">
			        	<div style="height: 400px; width:280px; display:inline-flex; align-items: center; justify-content: center; overflow: hidden;">
			        		<img style="height:400px; width: auto;" onclick="lightbox(0)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/1.jpg">
			        	</div>
			        	
			        	<div style="height: 400px; width:280px; display:inline-flex; align-items: center; justify-content: center; overflow: hidden;">
			        		<img style="height:400px; width: auto;" onclick="lightbox(1)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/2.jpg">
			        	</div>
			        	
			        	<div style="height: 400px; width:280px; display:inline-flex; align-items: center; justify-content: center; overflow: hidden;">
			        		<img style="height:400px; width: auto;" onclick="lightbox(2)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/3.jpg">
			        	</div>
			        	
			        	<div style="height: 400px; width:280px; display:inline-flex; align-items: center; justify-content: center; overflow: hidden;">
			        		<img style="height:400px; width: auto;" onclick="lightbox(3)" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/4.jpg">
			        	</div>

			        </div>
			    </div>
		    </div>

			<div class="container eatingView">
				<div class="row eContent">
				
					<div class="col-6 eContentLeft">
					
						<div class="eContentHead">
							<table style="width: 100%; border-collapse: separate; border-spacing: 0 15px;">
								<tr>
									<td style="width: 80%; font-size: 200%;">
										${eContentView.eTitle}&nbsp;<b style="color:#e7438b" class="reviewAVG" id="reviewAVGScore"></b>
									</td>
									
									<td align="right">
										<a style="color: #e7438b; cursor: pointer;"><i title="리뷰작성" class="fas fa-pen fa-2x"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a style="color: #e7438b; cursor: pointer;" onclick="eScrap(${eContentView.eId})"><i title="내맛집등록" class="fas fa-bookmark fa-2x"></i></a>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="color: #46505ab5; font-size: 90%;">
										<i title="조회수" class="far fa-eye"></i> <b>${eContentView.eHit}</b>&nbsp;&nbsp;
										<i title="리뷰수" class="fas fa-pen"></i> <b class="eReview"></b>&nbsp;&nbsp;
										<i title="맛집등록수" class="fas fa-bookmark"></i> <b>${eContentView.sCount}</b>
									</td>
								</tr>
							</table>
						</div>
						<hr>

						<div class="eContentBody">
							<table border="0" style="width: 100%; border-collapse: separate; border-spacing: 0 30px; vertical-align: middle;">
								<tr>
									<td style="width: 25%; text-align: center; color:#e7438b;"><i title="위치" class="fas fa-map-marker-alt fa-2x"></i></td>
									<td style="color:#464a4e;">
										${eContentView.eAddress_new}<br>
										[지번] ${eContentView.eAddress_old}
									</td>
								</tr>
								<tr>
									<td style="width: 25%; text-align: center; color:#e7438b;"><i title="전화번호" class="fas fa-phone fa-2x"></i></td>
									<td style="color:#464a4e;">${eContentView.eTel}</td>
								</tr>
								<tr>
									<td style="width: 25%; text-align: center; color:#e7438b;"><i title="음식종류" class="fab fa-delicious fa-2x"></i></td>
									<td style="color:#464a4e;">
										<c:choose>
											<c:when test="${eContentView.eCategory == 'korean_food'}">
												<b style="color:#e7438b;">한식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'japanese_food'}">
												<b style="color:#e7438b;">일식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'western_food'}">
												<b style="color:#e7438b;">양식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'chinese_food'}">
												<b style="color:#e7438b;">중식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'asian_food'}">
												<b style="color:#e7438b;">아시안 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'etc_food'}">
												<b style="color:#e7438b;">기타 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
											<c:when test="${eContentView.eCategory == 'fusion_food'}">
												<b style="color:#e7438b;">퓨전 음식</b> / ${eContentView.eKeyword_food}
											</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<td style="width: 25%; text-align: center; color:#e7438b;"><i title="주요메뉴" class="fas fa-utensils fa-2x"></i></td>
									<td><pre style="font-family: 윤고딕540; font-size: 100%; margin-bottom: 0px; color:#464a4e;">${eContentView.eContent}</pre></td>
								</tr>
							</table>
						
						</div>
					

					</div>
					
					<div class="col-6 eContentRight">
						<div id="map" style="width: auto; height: 520px; border-radius: 10px;"></div>
					</div>
				
				</div>
				
				<hr>
			</div>
			

	
			<!-- 댓글처리 -->
			<div class="reviewWrapper">
				<h3><i class="far fa-comment-dots"></i>&nbsp;리뷰(<b class="reviewCount"></b>)</h3>
				
				<form name="rvform">
					<input type="hidden" name="eating_id" value="${eContentView.eId}" />
					<input type="hidden" name="user_id" value="${loginUser.user_id}">
					
					<table class="reviewTable" border="1">
						<tr>
							<td class="reviewWriter">
								<c:choose>
									<c:when test="${not empty loginUser.uNickname}">
										${loginUser.uNickname}
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
						<tr>
							<td>
								<c:choose>
									<c:when test="${not empty loginUser.uNickname}">
										<select id="rvScore" type="number" name="rvScore" class="rvScore">
											<option value="" selected="selected">평점</option>
											<option value="0.5">0.5</option>
											<option value="1.0">1.0</option>
											<option value="1.5">1.5</option>
											<option value="2.0">2.0</option>
											<option value="2.5">2.5</option>
											<option value="3.0">3.0</option>
											<option value="3.5">3.5</option>
											<option value="4.0">4.0</option>
											<option value="4.5">4.5</option>
											<option value="5.0">5.0</option>
										</select>
										
										<textarea id="rvComment" type="text" name="rvComment" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>
									</c:when>
									
									<c:otherwise>
										<textarea id="rvComment" style="resize: none; height: 80px; width: 100%;" placeholder="로그인 후 리뷰를 작성하실 수 있습니다."></textarea>
									</c:otherwise>
								</c:choose></td>
		
							<td>
								<div class="reviewBrnWrap">
									<a id="reviewBtn" style="color: blue">리뷰</a>
								</div>
							</td>
						</tr>
		
					</table>
				</form>
				
				
				
				
				
				
				
				
				
				
				<div>
					<div class="reviewPaging"></div>
					<div class="reviewList"></div>
				</div>
			
				
				
				
				
		

			</div>
			
		
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
				<input type="hidden" name="page" id="escriPage" value="${escri.page_eating}"/>
				<input type="hidden" name="perPageNum" id="escriPageNum" value="${escri.perPageNum}"/>
				<input type="hidden" name="keyword" id="escriKeyword" value="${escri.keyword}"/>
			</form>	
		</section>
		
		<%@ include file="/WEB-INF/views/eating/reviewList.jsp"%>
		
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->

		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		

	</body>

</html>