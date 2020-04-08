<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Eating : Store Information view</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>

<style>
    .customoverlay {
				position:relative;
				bottom:85px;
				border-radius:6px;
				border: 1px solid #ccc;
				border-bottom:2px solid #ddd;
				float:left;
			}
			
			.customoverlay:nth-of-type(n) {
				border:0; 
				box-shadow:0px 1px 2px #888;
			}
			
			.customoverlay a {
				display:block;
				text-decoration:none;
				color:#000;
				text-align:center;
				border-radius:6px;
				font-size:14px;
				font-weight:bold;
				overflow:hidden;
				background: #e7438b;
				background: #e7438b url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
			}
			.customoverlay .title {
				display:block;
				text-align:center;
				background:#fff;
				margin-right:35px;
				padding:10px 15px;
				font-size:14px;
				font-weight:bold;
			}
			.customoverlay:after {
				content:'';
				position:absolute;
				margin-left:-12px;
				left:50%;
				bottom:-12px;
				width:22px;
				height:12px;
				background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png');
			}
</style>
<script type="text/javascript">
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

/* ***************** */
/*	 content View 	 */
/* **************** */

$(document).ready(function(){

var rvCount;				// 해당 게시글의 댓글 수 
var uNickname = $("#userNickname").val();
var userId = $('#userId').val();
var eating_id = $('#eId').val();

	reviewCount(eating_id);
	reviewList();
		
	var formObj = $('form[role="form"]');
		
	$('.list').on('click', function(){
		formObj.attr('method','get');
		formObj.attr('action','eatingList');
		formObj.submit();
	});
		
	$('.modify').on('click', function(){
		formObj.attr('method','get');
		formObj.attr('action','modifyView');
		formObj.submit();
	});
		
	$('.delete').on('click', function(){
		deleteConfirm();
	});
		
	//가게 정보는 삭제, 신고 불가. 스크랩 가능.
	
	if(!uNickname){
		$('.reviewBtn').remove();
	}

window.onload = showClock;
function showClock(){
    var currentDate = new Date();
    var divClock = document.getElementById("divClock");
     
    var nowMassage = ""+currentDate.getMonth()+"월"
   		nowMassage += currentDate.getDate()+"일";
    	nowMassage += currentDate.getHours()+"시";
    	nowMassage += currentDate.getMinutes()+"분";
     
    divClock.innerText = nowMassage;
    setTimeout(showClock,1000);
}

function rpResetForm(rpId) {
	$('#rpModalForm_' +rpId).on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}
	
// 해당 게시글 삭제 후 글목록으로 전환
function reset() {
	location.href='eatingList?page='+$("#scriPage").val()+'&perPageNum='+$("#scriPageNum").val()+'&searchType='+$("#scriSearchType").val()
	+'&keyword='+$("#scriKeyword").val()+'&sortType='+$("#boardSortType").val()+'&bCategory='+$("#bCategory").val();
}
				
/* 교육장소 map 부분 */
var ad_new = $('#ad_new').val();
var eatingAddress = ad_new;
var mapContainer = document.getElementById('map'), // 지도 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도 중심좌표
    level: 3 // 지도 확대레벨
};


// 지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 주소-좌표 변환 객체 생성
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색
geocoder.addressSearch(eatingAddress, function(result, status) {
	// 정상적으로 검색이 완료됐으면 
	if (status === kakao.maps.services.Status.OK) {

		var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		var imageSrc = getContextPath() +'/img/eating/base/ePlaceMarker.png', // 마커이미지의 주소입니다    
	    	imageSize = new kakao.maps.Size(55, 45), // 마커이미지의 크기입니다
	    	imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    	
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

		// 결과값으로 받은 위치를 마커로 표시
		var marker = new kakao.maps.Marker({
		    map: map,
		    position: coords,
		    image: markerImage
		});
		
		console.log('eatingAddress : ' +eatingAddress);
		console.log('coords : ' +coords);
		console.log(result[0].y);
		console.log(result[0].x);

		// 마커가 지도 위에 표시
		marker.setMap(map);
		
		// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var content = '<div class="customoverlay">';
			content += '<a href="https://map.kakao.com/link/map/' +eatingAddress +',' +result[0].y +',' +result[0].x +'" target="_blank">';
			content += '<span class="title"><i class="fab fa-leanpub" style="color:#e7438b;"></i> ${eContentView.eTitle} 위치 </span>';
			content += '</a>';
			content += '</div>';

		// 커스텀 오버레이를 생성합니다
		var customOverlay = new kakao.maps.CustomOverlay({
		    map: map,
		    position: coords,
		    content: content,
		    yAnchor: 1 
		});

		// 지도중심을 결과값으로 받은 위치 이동
		map.setCenter(coords); 

	} 
}); 
/* 교육장소 map 부분 끝*/
			});

</script>
</head>

<body>
	<!-- 헤더 삽입부 -->
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
		<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}" />
		<input type="hidden" id="eId" value="${eContentView.eId}" />
		<input type="hidden" id="ad_new" value="${eContentView.eAddress_new}"/>
		<input type="hidden" id="ad_old" value="${eContentView.eAddress_old}"/>
		
	<br>
	<h1>About that ${eContentView.eTitle}</h1>
	<hr>
	<br>
	<!-- 오늘 뭐 먹지? 식당 상세 DB -->
	<table border="1">
		<tr>
			<!-- 식당 이미지 -->
			<td><img style="width: 60%;" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/1.jpg"></td>
			<td><img style="width: 60%;" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/2.jpg"></td>
			<td><img style="width: 60%;" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/3.jpg"></td>
			<td><img style="width: 60%;" src="${pageContext.request.contextPath}/img/eating/${eContentView.eId}/4.jpg"></td>
		</tr>
		</table>
		<table border="1">
		<tr>
			<!-- 상호, 평점, 카테고리 -->
			<td>store information <br> ${eContentView.eTitle},
				${eContentView.eThema}, ${eContentView.eCategory},
				${eContentView.eTel}, ${eContentView.eAddress_new}
				<button type="button">지번</button>(${eContentView.eAddress_old})
			</td>
		</tr>
		<tr>
			<td>
			<h4><b id="divClock" class="clock"></b> 현재 ${eContentView.eTitle} 의  평균 평점 : (<div class="reviewAVG" id="reviewAVGScore"> ${eContentView.rvAVG}</div>) </h4>
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

	<li class="list-group-item clPlaceMap">
									<p>
										<i title="가게 장소" class="fas fa-map-marked-alt"></i>&nbsp;가게 주소
									</p>
									<p>
										신주소 : ${eContentView.eAddress_new}<br>
										구주소 : ${eContentView.eAddress_old}<br>
									</p>
									<div id="map" style="width:500px;height:400px;"></div>
								</li>		
	
	<hr>
	
	<!-- 댓글처리 -->
		<div>
			<h2>리뷰1(<b class="reviewCount"></b>) </h2>
			<h2>리뷰2(${eContentView.rvCount}) </h2>
	<!-- 		 <h2>평점 : (<b class="reviewAVG"></b>) </h2> -->
			<form name="rvform">
			<input type="hidden" name="eating_id" value="${eContentView.eId}" /> <input type="hidden" name="user_id" value="${loginUser.user_id}">
				<table border="1">
					<tr>
						<td>
						<c:choose>
						<c:when test="${not empty loginUser.uNickname}">
						${loginUser.uNickname}
							<button type="button" name="reviewBtn">리뷰</button>
						</c:when>
						<c:otherwise>
							<input type="text" name="user_id" value="GUEST" disabled>
							<button type="button" name="reviewBtn">리뷰</button>
						</c:otherwise>
					</c:choose>
						</td>
							</tr>
					<tr>
						<td>
					<div class="reviewPaging"></div>
					<div class="reviewList"></div>	
					<select id="rvScore" type="number" name="rvScore">
							<option value = "avg" selected="selected">평점</option>
							<option value = "0.5" >0.5</option>
							<option value = "1.0" >1.0</option>
							<option value = "1.5" >1.5</option>
							<option value = "2.0" >2.0</option>
							<option value = "2.5" >2.5</option>
							<option value = "3.0" >3.0</option>
							<option value = "3.5" >3.5</option>
							<option value = "4.0" >4.0</option>
							<option value = "4.5" >4.5</option>
							<option value = "5.0" >5.0</option>
						</select>	
						</td>
					</tr>
					<tr>
						<td>
							<textarea id="rvComment" type="text" name="rvComment" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>
						</td>
					</tr>
					</table>	
			</form>
		</div>
		<hr>

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
		<input type="hidden" name="eId" id="eId" value="${eContentView.eId}"> 
		<input type="hidden" name="page" id="escriPage" value="${escri.page}" /> 
		<input type="hidden" name="perPageNum" id="escriPageNum" value="${escri.perPageNum}" />
		<input type="hidden" name="searchType" id="escriSearchType" value="${escri.searchType}" />
		<input type="hidden" name="keyword" id="escriKeyword" value="${escri.keyword}" /> 
		<input type="hidden" name="eCategory" id="eCategory" value="${eCategory}" />
	</form>
	<hr>

	<%@ include file="/WEB-INF/views/eating/reviewList.jsp"%>
	<%-- <script src="${pageContext.request.contextPath}/js/eating/eatingContent.js"></script> --%>
</body>
</html>