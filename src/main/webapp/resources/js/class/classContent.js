function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var uNickname = $("#userNickname").val();
var openner =  $("#classOpenner").val();
var userId = $('#userId').val();
var cId = $('#classId').val();
			
$(document).ready(function() {
	
//	// 수강정보 썸머노트 설정
//	$('#summernote').summernote({
//		height: 500,
//		minHeight: 500,
//		maxHeight: 500,
//		toolbar: [],
//		disableResize: true,
//		disableResizeEditor: true,
//		resize: false,
//	});
//				
//	$('.note-editor').width($('.clContentView').width());
//	$('#summernote').css('resize', 'none');
//	$('#summernote').summernote('disable');
				
	// 신청종료일 카운트다운
	var x = setInterval(function() {
	var endDate = $('#classEndDate').val();
	var countDownDate = new Date(endDate).getTime();
	var nowTime = new Date().getTime();
	var difference = countDownDate - nowTime;

	var days = Math.floor(difference / (1000 * 60 * 60 * 24));
	var hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	var minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
	var seconds = Math.floor((difference % (1000 * 60)) / 1000);
					
	document.getElementById("classEndCountDown").textContent = days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초";
	
	if (difference < 0) {
		clearInterval(x);
		document.getElementById("classEndCountDown").textContent = "신청기간 종료";
		
		var tag = '<button class="btn btn-default btn-lg" style="background-color:#e7438b; color:#ffffff; width:100%; cursor:default;">신 청 기 간 종 료</button>';
			$('.classJoinForm').html(tag);
		} 
	}, 1000);

	var questionCount;	
	
	getCurrentUserCount();
	getJoinUserList();
	questionCnt();
	questionList();

	var formObj = $('form[role="form"]');
	
	$('.classList').on('click', function(){
		formObj.attr('method','post');
		formObj.attr('action','classList');
		formObj.submit();
	});
				
	$('.classModify').on('click', function(){
		formObj.attr('method','post');
		formObj.attr('action','classModifyView');
		formObj.submit();
	});
	
	$('.classDelete').on('click', function(){
		deleteConfirm();
	});
				
	
	/* 교육장소 map 부분 */
	var ad2 = $('#ad2').val();
	var classAddress = ad2;
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
	geocoder.addressSearch(classAddress, function(result, status) {
	// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			var imageSrc = getContextPath() +'/img/class/cPlaceMarker.png', // 마커이미지의 주소입니다    
			imageSize = new kakao.maps.Size(55, 45), // 마커이미지의 크기입니다
			imageOption = {offset: new kakao.maps.Point(26, 37)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
				    	
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

			// 결과값으로 받은 위치를 마커로 표시
			var marker = new kakao.maps.Marker({
				map: map,
				position: coords,
				image: markerImage
			});
			
//			console.log('classAddress : ' +classAddress);
//			console.log('coords : ' +coords);
//			console.log(result[0].y);
//			console.log(result[0].x);
			
			// 마커가 지도 위에 표시
			marker.setMap(map);
			
			// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			var content = '<div class="customoverlay">';
			content += '<a href="https://map.kakao.com/link/map/' +classAddress +',' +result[0].y +',' +result[0].x +'" target="_blank">';
			content += '<span class="title"><i class="fab fa-leanpub" style="color:#e7438b;"></i> 교육장소</span>';
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
	

function getCurrentUserCount() {
	$.ajax({
		type:'POST',
		url: getContextPath() + '/class/getCurrentUserCount',
		async: false,
		data:{
			"class_id" : cId
		},
		success:function(data) {
			//console.log("현재 신청자수 : " +data);
			var tag = '<span class="classCurrentPeople">' +data+'</span>';
			tag += '/' + $("#classTotalPeopleCount").val();
			$('.classCurrentPeople').html(tag);
		}	
	});
}
			
function getJoinUserList() {
	var tempArr = new Array();
	
	if(userId == '') {
		return false;
	} else {
		$.ajax({
			type:'POST',
			url: getContextPath() + '/class/getUserIdList',
			data:{
				"class_id" : cId
			},
			success:function(data){
				
				if(data.length > 0) {
					for(var i = 0; i< data.length; i++) {
						tempArr.push(data[i].user_id);
					}
					if(Object.values(tempArr).includes(Number(userId)) == true) {
						var tag = '<button class="btn btn-warning btn-lg clJoinOkBtn">신 청 완 료</button>';
						$('.classJoinForm').html(tag);
		    		}
				}
				
			}
		});
	}
}

// 해당 class강좌 신청 JS메서드
function classJoinForm(myPoint, totalPeopleCount, joinUserId) {
	var cPrice = $("#classPrice").val();
	var tempArr = new Array();
	
	if(cPrice > myPoint) {
		if(confirm("포인트 잔액이 부족합니다.\n\n현재 보유포인트 : " +myPoint +"P\n결제 포인트 금액 : " +cPrice +"P\n포인트를 충전하시겠습니까?") == true) {
			location.href = "/eepp/mypage";
			return false;
		} else {
			return false;
		}
	} else {
		if(confirm("해당 클래스를 수강신청 하시겠습니까?") == true) {
			$.ajax({
				type:'POST',
				url: getContextPath() + '/class/getUserIdList',
				data:{
					"class_id" : cId
				},
				success:function(data){
					
					if(data.length == 0) {
						classJoin();
					} else if(data.length == 1){
						if(Object.values(data[0]).includes(joinUserId) == true) {
							alert("해당 Class를 이미 신청하셨습니다.");
			    			return false;
			    		} else {
			    			classJoin();
			    		} 
					} else if(data.length > 1 && data.length < totalPeopleCount) {
						for(var i = 0; i< data.length; i++) {
							tempArr.push(data[i].user_id);
			    		}
							if(Object.values(tempArr).includes(joinUserId) == true) {
								alert("해당 Class를 이미 신청하셨습니다.");
			    				return false;
			    			} else {
			    				classJoin();
			    			}
					} else if(data.length >= totalPeopleCount){
						alert("이 강좌는 인원이 초과되어 신청이 불가합니다.");
			    		return false;
			    	} 
				}
			});
		} else {
			return false;
		}
	}
}
			

function classJoin() {
	$.ajax({
		type:'POST',
		url: getContextPath() + '/class/classJoin',
		data:$('#classJoin[role=classJoinRole]').serialize(),
		success:function(){
			alert("수강신청이 완료되었습니다.");
			$('#modalForm').modal('hide');
			getCurrentUserCount();
			resetForm();
		}
	});
}

function resetForm() {
	$('#modalForm').on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}

// 해당 class 강좌 삭제 확인 JS메서드(문의가 있는 강좌의 경우 삭제 불가)
function deleteConfirm() {
	if(confirm("Class 강좌를 정말 삭제 하시겠습니까?")){
		deleteContent(cId);
	}
}
	
// 해당  class 강좌 삭제하는  JS메서드(Ajax-Json)
function deleteContent(cId) {
	$.ajax({
		url: getContextPath() + '/class/deleteClass',
		type: 'get',
		data: {
			'cId' : cId
		},
		success: function(data){
//			console.log(data)
			reset();
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
					}
		});
}
						
// 해당 class강좌 삭제 후 class강좌목록으로 전환
function reset() {
	location.href='classList?page='+$("#cscriPage").val()+'&perPageNum='+$("#cscriPageNum").val()+'&searchType='+$("#cscriSearchType").val()
	+'&keyword='+$("#cscriKeyword").val()+'&cCategory='+$("#cCategory").val();
}
	
// 해당 class강좌 스크랩  JS메서드(Ajax-Json)
function cScrap(cId) {
	if(userId == '') {
		alert('로그인 후 이용해 주세요.');
		location.href = "/eepp/login/login.do";
		return false;
	} else {
		$.ajax({
			url: getContextPath() + '/scrap/doClassScrap',
			type: 'post',
			data: {
				'class_id' : cId,
				'user_id' : userId
			},
			success: function(data){
				if(data == 1){
					alert("이미 스크랩한 강좌입니다.");
				}else{
					alert(cId +"번 강좌가 스크랩 되었습니다.");
				}
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}