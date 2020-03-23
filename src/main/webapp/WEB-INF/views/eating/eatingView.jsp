<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Eating : Store Information view</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
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

	reviewCount(eId);
	reviewList();
	//likeCount(bId);		// 추천수
	//unlikeCount(bId);	// 비추천수
		
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
		
		
});
	
function rpResetForm(rpId) {
	$('#rpModalForm_' +rpId).on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}
	
/* 해당 게시글 신고 JS메서드
function submitDeclarationForm(){
	var dReason = document.dform.dReason;
			
	if(dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url: getContextPath() + '/declaration/doDeclaration',
			data:$('#declaration[role=formDeclaration]').serialize(),
			success:function(msg){
				alert(bId +'번 글이 신고되었습니다.');
				$('#modalForm').modal('hide');
				resetForm();
			}
	       });
	}
}
	
function resetForm() {
	$('#modalForm').on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}

// 해당 게시글 삭제 확인 JS메서드(댓글이 있는 게시글의 경우 삭제 불가)
function deleteConfirm() {
	if(rpCount > 0){
		alert("댓글이 달린 게시물은 삭제 할 수 없습니다.");	
		return;
	} else {
		if(confirm("정말 삭제 하시겠습니까?")){
			deleteContent(bId);
		}
	}
}
	
// 해당 게시글 삭제하는  JS메서드(Ajax-Json)
function deleteContent(bId) {
	$.ajax({
		url: getContextPath()+'/board/deleteContent',
		type: 'get',
		data: {'bId' : bId},
		success: function(data){
			console.log(data)
			reset();
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}
*/
// 해당 게시글 삭제 후 글목록으로 전환
function reset() {
	location.href='boardList?page='+$("#scriPage").val()+'&perPageNum='+$("#scriPageNum").val()+'&searchType='+$("#scriSearchType").val()
	+'&keyword='+$("#scriKeyword").val()+'&sortType='+$("#boardSortType").val()+'&bCategory='+$("#bCategory").val();
}
				
// 해당 게시글의 추천수를 불러오는  JS메서드(Ajax-Json)
function likeCount(bId) {
	$.ajax({
		url: getContextPath()+'/recommend/blikeCount',
		type: 'get',
		data: {'bId' : bId},
		success: function(data){
			console.log("게시글 추천수 : "+data)
			var a = '<div>';
				a += data;
				a += '</div>';
			$('.like').html(a)
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}

</script>
</head>

<body>
	<br>
	<h1>About that ${eContentView.eTitle}</h1>
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
			<td>store information <br> ${eContentView.eTitle},
				${eContentView.eGrade}, ${eContentView.eCategory},
				${eContentView.eTel}, ${eContentView.eAddress_new}
				<button type="button">지번</button>(${eContentView.eAddress_old})
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
	<hr>
	
	<!-- 댓글처리 -->
		<div>
			<h2>리뷰(<b class="reviewCount"></b>)</h2>
			<form name="rvform">
				<input type="hidden" name="eId" value="${eContentView.eId}" />
				<input type="hidden" name="user_id" value="${loginUser.user_id}">
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