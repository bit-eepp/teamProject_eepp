var uNickname = $("#userNickname").val();
var eating_id = $('#eId').val();

function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
};

$(document).ready(function() {
	var rvCount; // 해당 게시글의 댓글 수 
	var eating_id = $('#eId').val();
	
	reviewCount(eating_id);
	reviewList();
	
	var formObj = $('form[role="form"]');
	
	$('.eList').on('click', function(){
		formObj.attr('method','post');
		formObj.attr('action','eatingList');
		formObj.submit();
	});


	/* 음식점 map 부분 */
	var eatingAddress = $('#ad_new').val();
	
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
			
			var eTitle = $('#eTitle').val();

			// 커스텀 오버레이에 표출될 내용
			var content = '<div class="customoverlay">';
				content += '<a href="https://map.kakao.com/link/map/' +eatingAddress +',' +result[0].y +',' +result[0].x +'" target="_blank">';
				content += '<span class="title"><i class="fas fa-store" style="color:#ff9007;"></i>' +eTitle +'</span>';
				content += '</a>';
				content += '</div>';

			// 커스텀 오버레이를 생성
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

//음식사진 슬라이드 부분
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

// 해당 맛집 스크랩 JS메서드(Ajax-Json)
function eScrap(eId, userId) {
	if(userId == null) {
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

// 리뷰쪽
function reviewCount(eating_id) {
	$.ajax({
		url: 'http://localhost:8282/eepp/review/reviewCount',
		type: 'post',
		data: {'eating_id' : eating_id},
		success: function(data){
			console.log("리뷰 수 : " +data)
			rvCount = data;
			var a = data;
			$('.reviewCount').html(a);
			$('.eReview').html(a);
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}

function reviewPagePrint(rvPageMaker) {
	// 댓글 페이징 처리를 위한 변수
	var startPage = rvPageMaker[1];
	var endPage = rvPageMaker[2];
	var prev = rvPageMaker[3];
	var next = rvPageMaker[4];
	var tempEndPage = rvPageMaker[6];
	var page = rvPageMaker[7].page;
	
	var paging = '';
	paging += '<ul class="pagination justify-content-center">';
					
	if(tempEndPage != 0) {
		paging += '<li class="page-item">';
		paging += '<a class="page-link" href="javascript:reviewList(1)"><i class="fas fa-angle-left"></i></a>';
		paging += '</li>';
	}
					
	for(var i = startPage; i <= endPage; i++){
		paging += '<li class="page-item">';
		paging += '<a id="eReviewPageNum_' +i +'" class="page-link" href="javascript:reviewList(' +i +')">' +i +'</a>';
		paging += '</li>';
	}
					
	if(page < tempEndPage){
		paging += '<li class="page-item">';
		paging += '<a class="page-link" href="javascript:reviewList(' +tempEndPage +')"><i class="fas fa-angle-right"></i></a>';
		paging += '</li>';
	}
	
	$('.reviewPaging').html(paging);
}

// 해당 게시글의 댓글들을 출력하는 JS메서드(Ajax-Json)
function reviewList(page) {
	var eating_id = $('#eId').val();
	var page = Number(page);
	
	if(isNaN(page)) {
		page = 1;
	}
	
	$.ajax({
		url: 'http://localhost:8282/eepp/review/reviewList',
		type: 'post',
		dataType:'json',
		data: {'eating_id' : eating_id,
				'page' : page <= 1 ? 1 : page
				},
		success: function(data){
			console.log(data);
			
			if(data.reviewAVG == null) {
				data.reviewAVG = 0;
			}

			console.log(data.reviewAVG.toFixed(1));
			$('.reviewAVG').html(data.reviewAVG.toFixed(1));
			
			// 리뷰 페이징
			var rvPageMaker = Object.values(data["rvPageMaker"]);
			reviewPagePrint(rvPageMaker);
			
			// 리뷰 리스트 
			var reviewList = Object.values(data["reviewList"]);
			$('.reviewList').children().remove();
			
			$.each(reviewList, function(key, value){			
				var tag = '';
					tag += '<div class="eReviewList rv_'+value.rvId +'">';
					tag += '<div class="card-body">';	// card-body
					tag += '<div class="row">';			//row
					tag += '<div class="col-md-2 section1" align="center">';
					tag += '<img class="rProfile" src="' +value.uProfile +'" alt="userProfile"/>';

						if(value.uNickname == uNickname || value.uNickname == '운영자' || value.uNickname == 'admin2' || uNickname == ''){
							tag += '<div>'
							tag += '<a class="userBtn"><b style="color:#e7438b; font-size:100%;">'+value.uNickname+'</b></a>';
							tag += '</div>'
						} else{
							tag += '<div class="dropdown">';
							tag += '<a href="#" class="userBtn" id="user_btn_'+value.rpId+value.user_id+'" data-toggle="dropdown"><b style="color:#59bfbf; font-size:100%; ">'+value.uNickname+'</b></a>';
							tag += '<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_'+value.rpId+value.user_id+'">';
							tag += '<li><a onclick="memberInfo(' +'\'' +value.uNickname +'\',' +value.user_id +');">회원정보</a></li>';
							tag += '<li><a onclick="sendMessage('+'\''+value.uNickname+'\','+value.user_id+');">쪽지 보내기</a></li>';
							tag += '<li><a data-toggle="modal" data-target="#report_rp_user_'+value.rpId+value.user_id+'" data-backdrop="static" data-keyboard="false">신고하기</a></li>';
							tag += '</ul></div>';
							tag += '<div class="modal fade reportModalBox" id="report_rp_user_'+value.rpId+value.user_id+'" role="dialog"><div class="modal-dialog"><div class="modal-content">';
							tag += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
							tag += '<h4 class="modal-title">&#8988;'+value.uNickname+'&#8991;님 신고</h4></div>';
							tag += '<p class="reportBoxIcon"><img style="max-width:35%;" src="' +getContextPath() +'/img/reportBoxIcon.png"></p>';
							tag += '<div class="modal-body">';
							tag += '<form id="declaration_rp_user_'+value.rpId+value.user_id+'" role="formDeclaration_rp_user_'+value.rpId+value.user_id+'" name="dform">'
							tag += '<input type="hidden" name="reporter_id" value="${loginUser.user_id}">';
							tag += '<input type="hidden" name="reported_id" value="'+value.user_id+'">';
							tag += '<div class="form-group" align="left">';
							tag += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">부적절한 홍보 게시글<br>';
							tag += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">음란성 또는 청소년에게 부적합한 내용<br>';
							tag += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">명예훼손/사생활 침해 및 저작권침해등<br>';
							tag += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_'+value.rpId+'.disabled=false">기타<br>';
							tag += '<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etcRp_'+value.rpId+'" name="dReason" disabled></textarea>';
							tag += '</div></form></div>';
							tag += '<div class="modal-footer">';
							tag += '<button type="button" class="btn reportBtn" onclick="reportRpUser('+value.rpId+value.user_id+',\''+value.uNickname+'\');">신고</button>';
							tag += '</div>';
							tag += '</div></div></div>';	
						}

					tag += '<p class="text-secondary text-center">' +value.rvWrittenDate +'</p>';
					tag += '</div>';	//section1
					
					tag += '<div class="col-md-8 section2">';  	       
					tag += '<div class="rv rvContent_'+value.rvId  +'"><p><b>' +value.rvComment +'</b></p></div>';
					tag += '</div>';	//section2
					
					
					tag += '<div class="col-md-2 section3" align="center">';
					tag += '<div class="rvMenu">';
					tag += '<p class="rScore_' +value.rvId +'"><b><i>' +value.rvScore.toFixed(1) +'</i></b></p><br><br>';
					tag += '<div class="menuBtn">';
					if(uNickname == value.uNickname){
						var re = /\r\n/g;
						var tempComment = value.rvComment.replace(re, " ");
						
						tag += '<a title="리뷰삭제" class="btn btn btn-info ml-2 delBtn" onclick="reviewDelete(' +value.rvId +');"><i class="fas fa-eraser"></i></a>';
						tag += '<a title="리뷰수정" class="btn btn btn-info ml-2 editBtn" onclick="reviewModify('+value.rvId +',' +value.rvScore +',\'' +tempComment +'\');"><i class="far fa-edit"></i></a>';
					} 
					tag += '</div>';
					tag += '</div>';
					tag += '</div>';	//section3
					
					
					tag += '</div>';	//row
					tag += '</div>';	//card-body
					tag += '</div>';
					tag += '<hr>';
			
				var tempTag = '<input type=hidden id="currentPageNum" value=' +page +'>';	
				$("#eCurrentPageNum").html(tempTag);
				
				$(".reviewList").append(tag);
				
				$('#eReviewPageNum_'+page).css("background-color", "#59bfbf");
				$('#eReviewPageNum_'+page).css("color", "#ffffff");
				
	        });
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}

// 리뷰 작성 버튼눌렀을때 이벤트 메서드
function eReviewWrite() {
	var eating_id = $('#eId').val();
	var rvComment = $("#rvComment").val();
	var rvScore = $("#rvScore").val();
	var insertData = $('[name=rvform]').serialize();
	
	console.log(rvComment);
	console.log(rvScore);
	
	if(rvComment == '') {
		alert("내용을 작성해주세요");
		document.rvform.rvComment.focus();
		return false;	
	}else if(rvScore == ''){
		alert("평점을 선택해주세요.");
		document.rvform.rvScore.focus();
		return false;
	} else {
		$.ajax({
			url: 'http://localhost:8282/eepp/review/reviewWrite',
			type: 'POST',
			data: insertData,	
			success: function(insertData){
				alert("::리뷰 등록::")
				reviewCount(eating_id);
				reviewList();
				$("#rvComment").val("");
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
		
		$('#eReviewModalForm').modal('hide');
		$('.modal-backdrop').remove();
		eResetForm();
	}
}

function eResetForm() {
	$('#eReviewModalForm').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset();
	});
}

// 리뷰 수정 view JS메서드(Ajax-Json)
function reviewModify(rvId, rvScore, rvComment){
	var cn = $('#currentPageNum').val();

	$('.delBtn').remove();
	$('.editBtn').remove();

	var a ='';
	    a += '<div class="modifyCommentBox">';
	    a += '<textarea rows="4" type="text" name="rvComment_' +rvId +'">' +rvComment +'</textarea>';
	    a += '<br>';
		a += '</div>';
	    
	var b = '';
		b += '<div class="modifyScoreBox">';
		b += '<select type="number" name="rvScore_' +rvId +'" class="rvScore">';
		b += '<option value="" selected="selected">평점</option>';
		b += '<option value="0.5">0.5</option>';
		b += '<option value="1.0">1.0</option>';
		b += '<option value="1.5">1.5</option>';
		b += '<option value="2.0">2.0</option>';
		b += '<option value="2.5">2.5</option>';
		b += '<option value="3.0">3.0</option>';
		b += '<option value="3.5">3.5</option>';
		b += '<option value="4.0">4.0</option>';
		b += '<option value="4.5">4.5</option>';
		b += '<option value="5.0">5.0</option>';
		b += '</select><br><br>';
		
		b += '<p>';
		b += '<button class="btn btn btn-info ml-2 updateBtn" title="리뷰수정" type="button" onclick="reviewModifyPrc(' +rvId +');"><i class="fas fa-check"></i></button>';
		b += '<button class="btn btn btn-info ml-2 cancelBtn" title="수정취소" type="button" onclick="reviewList(' +cn +');"><i class="fas fa-times"></i></button>';
		b += '</p>';

		b += '</div>';
		
	$('.rScore_' +rvId).html(b);
	$('.rvContent_' +rvId).html(a);
	
}

// 댓글 수정 JS메서드(Ajax-Json)
function reviewModifyPrc(rvId) {
	var cn = $('#currentPageNum').val();
	var rvComment = $('[name=rvComment_' +rvId +']').val();
	var rvScore = $('[name=rvScore_'+rvId+']').val();
	
	if(rvComment == '') {
		alert("내용이 비어있습니다.");
		$('[name=rvComment_' +rvId +']').focus();
		return false;
	} else if(rvScore == '') {
		alert("평점을 선택해 주세요.");
		$('[name=rvScore_' +rvId +']').focus();
		return false;
	} else {
		var modify_rvContent = $('[name=rvComment_'+rvId +']').val();
		$.ajax({
			url: 'http://localhost:8282/eepp/review/reviewModify',
			type: 'post',
			data: {
				'rvComment' : rvComment,
				'rvId' : rvId,
				'rvScore' : rvScore
				},
			success: function(data){
				reviewList(cn);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}

// 리뷰 삭제 JS메서드(Ajax-Json)
function reviewDelete(rvId) {
	var eating_id = $('#eId').val();
	var cn = $('#currentPageNum').val();
	
	if(confirm("해당 리뷰를 삭제 하시겠습니까?")){
		$.ajax({
			url: 'http://localhost:8282/eepp/review/reviewDelete',
			type: 'post',
			data: {'rvId' : rvId},
			success: function(data){
				reviewCount(eating_id);
				reviewList(cn);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}	
} 