<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>EE Chat List</title>
	    <link rel="icon" href="${pageContext.request.contextPath}/img/EE_logo.png" sizes="16x16">
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chat/chatList.css">
	    
	    <script type="text/javascript">
		    var uNickname = $("#userNickname").val();
		    var user_id = $("#userId").val();
			
		    $(document).ready(function(){
		    	//로그인 하지않은 경우, 채팅방 개설 버튼 삭제
		    	if(!$("#userNickname").val()){
		    		$('#chatRoomMakeForm').html('<br><br>');
		    	}
		    	
		    	var totalChatCount = getTotalChatCount();
		    	
		    	//var tag = '<button title="Thunder" class="btn"><i class="fas fa-bolt"></i><br>(' +totalChatCount +')</button>';		
    			//$('#main').append(tag);
		    	
		    	if(totalChatCount == 0) {
		    		$('#moreBtn_div').remove();
		    		
		    		var tag = '<div align=center>';
		    			tag += '<br><br><br>';
		    			tag += '<h5>현재 개설된 EE Chat이 없습니다.</h5><br>';
		    			tag += '<h5>새로운 EE Chat을 개설해보세요.</h5>';
		    			tag += '</div>';
		    			
		    		$('#mySidebar').append(tag);	
		    	}
		    	
		    	$('#mySidebar').scroll(function () { 
		    		if ($(this).scrollTop() > 100) { 
		    			$('#backToTop').fadeIn(500);
		    		} else { 
		    			$('#backToTop').fadeOut('slow'); 
		    		} 
		    	}); 
		    	
		    	$('#backToTop').click(function (e) { 
		    		e.preventDefault(); 
		    		$('#mySidebar').animate({scrollTop: 0}, 300); 
		    	});
		    	
		    	getChatRoomList();
		    });
	
		    function getTotalChatCount() {
		    	var totalCount = 0;
		    	$.ajax({
		    		type:'POST',
		    		url:'/eepp/chat/getTotalChatCount',
		    		async: false,
		    		success:function(data) {
		    			totalCount = data;
		    		}	
		        });
		    	return totalCount;
		    }
	
		    function getChatRoomList() {
		    	$.ajax({
		    		type:'POST',
		    		url:'/eepp/chat/getChatRoomList',
		    		success:function(data) {
		    			console.log(data);
		    			$('#endNum').val(data.length);
		    			
		    			$.each(data, function(key, value) {
	    					var tag = '';
	    						tag += '<div class="chatRoomView" id="chatNo_' +value.chId +'">';
	    						tag += '<ul class="list-group">';
	    						tag += '<li id="ct" class="list-group-item chatRoomTitle">';
	    						tag += '<b>' +value.chTitle +'</b>';
	    						tag += '<span class="f-right">';
	    						tag += '<i class="fas fa-users">  <b class="count_' +value.chId +'">' +value.pCount +'</b> / <b>' +value.chTotalPeopleCount +'</b></i>';
	    						tag += '</span>';
	    						tag += '</li>';
	    						tag += '<li class="list-group-item chatRoomInfo">';
	    						tag += '<p>';
	    						tag += '<i title="모임장" class="fas fa-user-circle" aria-hidden="true"></i>' +value.uNickname;
	    						tag += '<span class="f-right">' +value.chDate; +'</span>';
	    						tag += '</p>';
	    						tag += '<p>';
	    						tag += '<i title="약속장소" class="fas fa-map-marker-alt" aria-hidden="true"></i>';
	    						tag += value.chPlace;
	    						tag += '</p>';
	    						tag += '<p>';
	    						tag += '<i title="약속시간" class="far fa-clock" aria-hidden="true"></i>';
	    						tag += value.chMeetTime;
	    						tag += '</p>';
	    						tag += '<div>';
	    						tag += '<button class="btn joinChatroom" type="button" onclick="chatRoomSelect(' +value.chId +', ' +value.chTotalPeopleCount +')"><b>참여하기</b></button>';
	    						tag += '</div>';
	    						tag += '</li>';
	    						tag += '</ul>';
	    						tag += '</div>';
	    						tag += '<br>';
	    						
	    					$('#chatList').append(tag);
	    				});
		    		}
		        });
		    }
		    
		 	// 채팅방 더보기 페이징
		    function moreChatList() {
		    	var startNum = Number($('#startNum').val());	
		    	var endNum = Number($('#endNum').val());
		    	var moreCnt = 4;
		    	var totalChatCount = getTotalChatCount();
	
		    	if(totalChatCount <= 4) {  
		    		alert("현재 " +totalChatCount +"개의 EE Chat이 개설되어 있습니다.");
		    		return false;
		    	} else if(totalChatCount > Number($('#endNum').val())){	
		    		$('#startNum').val(startNum + moreCnt); 
		    		$('#endNum').val(endNum + moreCnt); 			
		    		
		    		$.ajax({
		    			type:'POST',
		    			url:'/eepp/chat/getMoreChatList',
		    			data:$('#moreListFrom').serialize(),
		    			success:function(data){
		    				console.log(data);
		    				$.each(data, function(key, value) {
		    					var tag = '';
		    						tag += '<div class="chatRoomView" id="chatNo_' +value.chId +'">';
		    						tag += '<ul class="list-group">';
		    						tag += '<li id="ct" class="list-group-item chatRoomTitle">';
		    						tag += '<b>' +value.chTitle +'</b>';
		    						tag += '<span class="f-right">';
		    						tag += '<i class="fas fa-users">  <b class="count_' +value.chId +'">' +value.pCount +'</b> / <b>' +value.chTotalPeopleCount +'</b></i>';
		    						tag += '</span>';
		    						tag += '</li>';
		    						tag += '<li class="list-group-item chatRoomInfo">';
		    						tag += '<p>';
		    						tag += '<i title="모임장" class="fas fa-user-circle" aria-hidden="true"></i> ' +value.uNickname;
		    						tag += '<span class="f-right">' +value.chDate; +'</span>';
		    						tag += '</p>';
		    						tag += '<p>';
		    						tag += '<i title="약속장소" class="fas fa-map-marker-alt" aria-hidden="true"></i>';
		    						tag += value.chPlace;
		    						tag += '</p>';
		    						tag += '<p>';
		    						tag += '<i title="약속시간" class="far fa-clock" aria-hidden="true"></i> ';
		    						tag += value.chMeetTime;
		    						tag += '</p>';
		    						tag += '<div>';
		    						tag += '<button class="btn joinChatroom" type="button" onclick="chatRoomSelect(' +value.chId +', ' +value.chTotalPeopleCount +')"><b>참여하기</b></button>';
		    						tag += '</div>';
		    						tag += '</li>';
		    						tag += '</ul>';
		    						tag += '</div>';
		    						tag += '<br>';
		    						
		    					$('#chatList').append(tag);
		    					$("#mySidebar").animate({scrollTop : $("#mySidebar")[0].scrollHeight}, 500);
		    				});
		    			}
		    		});
		    	} else if(totalChatCount <= endNum) {
		    		alert("EE Chat 목록을 모두 불러왔습니다.");
		    		return false;
		    	}
		    }
		 
		    // 채팅방 개설 메서드
		    function chatRoomMake(user_id) {
		    	var chTitle = document.chForm.chTitle;
		    	var chTotalPeopleCount = document.chForm.chTotalPeopleCount;
		    	
		    	if(chTitle.value == '') {
		    		alert("EE Chat 모임명을 입력해주세요");
		    		document.chForm.chTitle.focus();
		    		return false;
		    	} else if(chTotalPeopleCount.value == 0) {
		    		alert("EE Chat 모집인원을 입력해주세요");
		    		document.chForm.chTotalPeopleCount.focus();
		    		return false;
		    	} else if(chTotalPeopleCount.value < 0 || chTotalPeopleCount.value > 30) {
		    		alert("채팅방 정원은 최소 1명, 최대 30명까지 지정 할 수있습니다.");
		    		document.chForm.chTotalPeopleCount.focus();
		    		return false;
		    	} else {
		    		$.ajax({
		    			type:'POST',
		    			url:'/eepp/chat/chatRoomMake',
		    			data:$("form[name=chForm]").serialize(),
		    			success:function(data) {	
		    				chatRoomSelect(data, chTotalPeopleCount);
		    			}	
		            });
		    		$('#modalForm').modal('hide');
		    		$('.modal-backdrop').remove();
		    		resetForm();
		    	}
		    }
		    	
		    function resetForm() {
		    	$('#modalForm').on('hidden.bs.modal', function (e) {
		    	  $(this).find('form')[0].reset()
		    	});
		    }
	
		    var chatWin = '';
	
		    function chatRoomSelect(chId, totalCount) {
		    	var tempArr = new Array();
		    	var uId = Number($("#userId").val());
		    	getCurrentPeopleCount(chId);
		    	
		    	console.log("user_id : "+uId);
		    	console.log(typeof uId);
		    	
		    	if(!$("#userNickname").val()) {
		    		alert("로그인 하신 후에 EE Chat에 참가하실 수 있습니다.");
		    		location.href = "/eepp/login/login.do";
		    		return false;
		    	} else {
		    		$.ajax({
		    			type:'POST',
		    			url:'/eepp/chat/getUserIdList',
		    			data:{'chatting_id' : chId},
		    			success:function(data) {
		    				if(data.length == 0) {
		    					goChatRoom(chId, uId);
		    				} else if(data.length == 1) {
		    					if(Object.values(data[0]).includes(uId) == true) {
		    						alert("이 EE Chat에 참가중이십니다.");
		    						return false;
		    					} else {
		    						goChatRoom(chId, uId);
		    					}
		    				} else if(data.length > 1 && data.length < totalCount) {
		    					for(var i = 0; i< data.length; i++) {
		    						tempArr.push(data[i].user_id);
		    					}
		    					
		    					if(Object.values(tempArr).includes(uId) == true) {
		    						alert("이 EE Chat에 참가중이십니다.");
		    						return false;
		    					} else {
		    						goChatRoom(chId, uId);
		    					}
	
		    				} else if(data.length >= totalCount){
		    					alert("참여하시려는 EE Chat에 인원이 초과되어 참여가 불가합니다.");
		    					return false;
		    				}
		    			}
		            });
		    	}
		    }
	
		    // 채팅방에 입장하는 메서드
		    function goChatRoom(chId, user_id) {
		    	var chForm = document.createElement('form');
		    	
		    	chatWin = window.open('about:blank', chId, 'width=400, height=800, resizable = no, location = no');
	
		    	chForm.setAttribute('method', 'post');
		    	chForm.setAttribute('action', "/eepp/chat/chatRoomSelect");
		    	chForm.setAttribute('target', chId);
		    	
		    	var objs = document.createElement('input');
		    	
		    	objs.setAttribute('type', 'hidden');
		    	objs.setAttribute('name', 'chId');
		    	objs.setAttribute('value', chId);
		    	chForm.appendChild(objs);
		    	
		    	objs = document.createElement('input');
		    	objs.setAttribute('type', 'hidden');
		    	objs.setAttribute('name', 'user_id');
		    	objs.setAttribute('value', user_id);
		    	chForm.appendChild(objs);
		    	
		    	document.body.appendChild(chForm);
		    	chForm.submit();
		    }
	
		    // 입장하려는 채팅방의 현재인원을 파악하는 메서드
		    function getCurrentPeopleCount(chId) {
		    	$.ajax({
		    		type:'POST',
		    		url:'/eepp/chat/getPeopleCount',
		    		data:{'chatting_id' : chId},
		    		success:function(data){
		    			$('.count_' +chId).html(data);
		    		}
		        });
		    }
	    </script>
	</head>

	<body>
	
	<!-- 채팅방 버튼 -->
	<div id="ThunderBtn">
		<button type="button" class="chatBtn">Thunder<i class="fas thunder_icon fa-bolt"></i></button>
	</div>
	<!-- 채팅방 버튼 -->
	
	<!-- 채팅방 -->
	<div id="chatRoomListWrap">
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
		<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}">
		
			<div id="mySidebar" class="sidebar">
				<a title="close" href="javascript:void(0)" class="closeChatbtn"><i class="fas chat_icon fa-times fa-2x"></i></a>
				
				<div class="chatTitileWrap">
				<div id="chatHead" align="center">
					<img alt="" src="${pageContext.request.contextPath}/img/eechatLogo.png">
				</div>
				<!-- chatHead -->
				
				<div id="chatRoomMakeForm" align="right">
					<button id="mkChatBtn" title="EE Chat 개설" class="btn" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false"><i class="fas fa-comment-dots fa-2x"></i></button>
				</div>
				<!-- chatRoomMakeForm -->
				</div>
				
				<div class="modal fade" id="modalForm" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
		
							<!-- Modal Header -->
							<div class="modal-header" >
								<img class="logo" alt="" src="${pageContext.request.contextPath}/img/EE_logo.png">
								<h5>퇴근 후  <b>EE Chat</b>을 통해 모여봐요</h5>
							</div>
		
							<!-- Modal Body -->
							<div class="modal-body">
								<h5>EE chat 개설을 위해 정보를 입력해주세요.</h5>
								<br>
								
								<form id="chatRoomMake" name="chForm">
									<input type="hidden" name="user_id" value="${loginUser.user_id}">

									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<button class="btn btn-default" type="button"><i class="fas fa-user-alt"></i> 모  임  장</button>
										</div>
										<input type="text" class="form-control" value="${loginUser.uNickname}">
									</div>
								
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<button class="btn btn-default" type="button"><i class="fas fa-heading"></i> 모  임  명</button>
										</div>
										<input type="text" class="form-control" name="chTitle" placeholder="모임을 위한 제목을 입력해주세요(최대 30자)" maxlength="30">
									</div>
								
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<button class="btn btn-default" type="button"><i class="fas fa-map-marker-alt"></i> 모임장소</button>
										</div>
										<input type="text" class="form-control" name="chPlace" placeholder="EE Chat을 통해 결정하시려면 입력하지 마세요." maxlength="30">
									</div>

									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<button class="btn btn-default" type="button"><i class="far fa-clock"></i> 모임시간</button>
										</div>
										<input type="datetime-local" class="form-control" name="chMeetTime" placeholder="EE Chat을 통해 결정하시려면 입력하지 마세요.">
									</div>
									
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<button class="btn btn-default" type="button"><i class="fas fa-sort-numeric-down"></i> 모임인원</button>
										</div>
										<input type="number" class="form-control" name="chTotalPeopleCount" min="1" max="30" placeholder="최소 : 1인, 최대 30인">
									</div>
								</form>
							</div>
							<!-- modal body -->
		
							<!-- Modal Footer -->
							<div class="modal-footer">
								<button type="button" class="btn" data-dismiss="modal" onclick="resetForm()">개설 취소</button>
								<button type="button" class="btn submitBtn" onclick="chatRoomMake(${loginUser.user_id})">채팅방 개설</button>
							</div>
							<!-- Modal Footer -->
							
						</div>
						<!-- modal-content -->
					</div>
					<!-- modal-dialog -->
				</div>
				<!-- modal -->
				
				<form id="moreListFrom">
					<input type="hidden" name="endNum" id="endNum" value="0">
					<input type="hidden" name="startNum" id="startNum" value="1">
				</form>
				
				<div id="chatList"></div>
				
				<div id="moreBtn_div" align="center">
					<a id="moreBtn_a" href="javascript:moreChatList();"><i class="fas fa-angle-double-down fa-3x"></i></a>
				</div>
				
				<div id="upBtn_div" align="right">
					<a id="backToTop" class="scrolltop" href="#"><i class="fas fa-caret-up fa-3x" aria-hidden="true"></i></a>
				</div>
				
			</div>
			<!-- #mySidebar-->
		</div>
		<!-- chatListRoomWrap -->
		<div class="side_bar_overlay"></div>
		<script src="${pageContext.request.contextPath}/js/chatting.js"></script>
	</body>
</html>