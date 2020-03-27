<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>No.${clView.cId} CLASS강좌</title>
		
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		
		<style type="text/css">
			.hr-sect {
				display: flex;
				flex-basis: 100%;
				align-items: center;
				color: #59bfbf;
				font-size: 120%;
				margin: 8px 0px;
			}
			
			.hr-sect::before,.hr-sect::after {
				content: "";
				flex-grow: 1;
				background: #59bfbf;
				height: 2px;
				margin: 0px 16px;
			}
		</style>
		
		<script>
			function getContextPath() {
				var hostIndex = location.href.indexOf( location.host ) + location.host.length;
				return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
			};

			var uNickname = '${loginUser.uNickname}';
			var openner = '${clView.uNickname}';
			var userId = $('#userId').val();
			var cId = $('#classId').val();
			var myPoint = $('#myPoint').val();
			var totalPeopleCount = $('#totalPeopleCount').val();

			$(document).ready(function() {		
				$('#summernote').summernote({
					height: 400,  
					toolbar: []
				});
				
				$('.note-editor').width($('.clContentView').width());
				$('#summernote').summernote('disable');
				
				var endDate = $('#classEndDate').val();
				var countDownDate = new Date(endDate).getTime();
				var now = new Date().getTime();
				var distance = countDownDate - now;
				
				if(distance <= 0 || uNickname == openner || uNickname == '') {
					$('.classJoinForm').remove();
				}

				var x = setInterval(function() {
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
					} 
				}, 1000);

				var questionCount;	
				
				getCurrentUserCount();
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
			});
	
			function getCurrentUserCount() {
				$.ajax({
					type:'POST',
					url: getContextPath() + '/class/getCurrentUserCount',
					async: false,
					data:{"class_id" : cId},
					success:function(data) {
						console.log("현재 신청자수 : " +data);
						var tag = '<b class="classCurrentPeople">' +data  +'</b>';
						$('.classCurrentPeople').html(tag);
					}	
				});
			}

			// 해당 class강좌 신청 JS메서드
			function classJoinForm() {
				var cPrice = ${clView.cPrice};
				var tempArr = new Array();

				if(cPrice > myPoint) {
					if(confirm("포인트 잔액이 부족합니다.\n\n현재 보유포인트 : " +myPoint +"P\n결제 포인트 금액 : " +cPrice +"P\n포인트를 충전하시겠습니까?") == true) {
						return false;
					} else {
						return false;
					}
				} else {
					if(confirm("이 클래스를 수강신청 하시겠습니까?") == true) {
						$.ajax({
							type:'POST',
							url: getContextPath() + '/class/getUserIdList',
							data:{"class_id" : cId},
							success:function(data){						
								if(data.length == 0) {
									classJoin();
								} else if(data.length == 1){
									if(Object.values(data[0]).includes(userId) == true) {
			    						alert("해당 Class를 신청하셨습니다.");
			    						return false;
			    					} else {
			    						classJoin();
			    					}
								} else if(data.length > 1 && data.length < totalPeopleCount) {
									for(var i = 0; i< data.length; i++) {
			    						tempArr.push(data[i].user_id);
			    					}
									
									if(Object.values(tempArr).includes(userId) == true) {
										alert("해당 Class를 신청하셨습니다.");
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
				if(questionCount > 0){
					alert("문의가 있는 class강좌는 삭제 할 수 없습니다.");	
					return;
				} else {
					if(confirm("Class 강좌를 정말 삭제 하시겠습니까?")){
						deleteContent(cId);
					}
				}
			}
	
			// 해당  class 강좌 삭제하는  JS메서드(Ajax-Json)
			function deleteContent(cId) {
				$.ajax({
					url: getContextPath() + '/class/deleteClass',
					type: 'get',
					data: {'cId' : cId},
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
						
			// 해당 class강좌 삭제 후 class강좌목록으로 전환
			function reset() {
				location.href='classList?page='+$("#cscriPage").val()+'&perPageNum='+$("#cscriPageNum").val()+'&searchType='+$("#cscriSearchType").val()
				+'&keyword='+$("#cscriKeyword").val()+'&cCategory='+$("#cCategory").val();
			}
	
			// 해당 class강좌 스크랩  JS메서드(Ajax-Json)
			function cScrap(cId) {
				$.ajax({
					url: getContextPath() + '/scrap/doClassScrap',
					type: 'post',
					data: {'class_id' : cId, 'user_id' : userId},
					success: function(data){
						if(data == 1){
							alert("이미 스크랩한 게시글입니다.");
						}else{
							alert(cId +"번 게시글이 스크랩 되었습니다.");
						}
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
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
	
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
		<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}" />
		<input type="hidden" id="classId" value="${clView.cId}" />
		<input type="hidden" id="myPoint" value="${loginUser.point}" />
		<input type="hidden" id="totalPeopleCount" value="${clView.cTotalPeopleCount}" />
		<input type="hidden" id="classEndDate" value="<fmt:formatDate value="${clView.cEndDate}" pattern="yyyy-MM-dd HH:MM:ss"/>">
		
		<section>
			<div class="container clView">
				<div class="row clContent">
					<div class="col-8 clContentLeft" style="width:100%; height: auto;">
						<div class="input-group clContentTitle" style="width:100%; height: auto; font-weight: 1000;">
							<p style="color:#59bfbf; font-size: 180%"><b>${clView.cTitle}</b></p>
						</div>
						
						<div class="input-group clContentSummary" style="width:100%; height: auto; font-weight: 1000;">
							<p style="color:#4c5454; font-size: 100%"><b>${clView.cSummary}</b></p>
						</div>

						<div class="input-group clContentThumnail" style="width:100%; height: auto;">
							<img class="" alt="ClassImg" src="${clView.cThumnail}" style="width: 100%; border-radius: 5px;">
						</div>
						<br>
						
						<div class="input-group hr-sect" style="width:100%;">
							<b>강 좌 소 개</b>
						</div>
						
						<div class="input-group clContentView" style="width:100%;">
							<textarea id="summernote">${clView.cContent}</textarea>
						</div>
						<hr style="border: 1px solid #59bfbf;">
						
					</div>

					
					<div class="col-4 clContentRight" style="border: 1px solid; width:100%; height: auto;">
						<div class="input-group clContentDetailHaed">
							<button class="btn btn-default" type="button" style="background-color: #59bfbf; color: #ffffff; border-radius: 0;">세 부 정 보</button>
						</div>
						
						<div class="input-group clContentDetailBody" style="border: 2px solid #59bfbf; width:100%; height: auto;">
							<div class="clOpener" style="border: 1px solid; width:100%; height: auto;">
								<ul class="list-group list-group-flush">
									<li class="list-group-item">
										<%-- <img class="clOpennerProfile" alt="userProfile" src="${clView.uProfile}" style="border-radius: 50%; width: 20%; height: auto;"> --%>
										<c:choose>
											<c:when test="${clView.uNickname eq loginUser.uNickname or clView.uNickname eq '운영자' or clView.uNickname eq 'admin2' or loginUser.uNickname == null}">
												<div>
													<span>개설자 : <a class="userBtn"><b>${clView.uNickname}</b></a></span>
												</div>
											</c:when>
												
											<c:otherwise>
												
												<div class="dropdown">
													<span>개설자 : <a href="#" class="userBtn" id="user_btn_${clView.user_id}${clView.cId}" data-toggle="dropdown"><b>${clView.uNickname}</b></a></span>
													
							           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_${clView.uNickname}${clView.cId}">
							                			<li><a href="#">회원정보</a></li>
							                			<li><a onclick="sendMessage('${clView.uNickname}',${clView.user_id});">쪽지 보내기</a></li>
							                			<li><a data-toggle="modal" data-target="#report_user_${clView.user_id}${clView.cId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
							                		</ul>
												</div>
												
												
												<!-- 유저 신고 modal -->	
					                			<div class="modal fade" id="report_user_${clView.user_id}${clView.cId}" role="dialog">
					                				<!-- modal-dialog -->
					                				<div class="modal-dialog">
					                					<!-- modal-content -->
						                				<div class="modal-content">
							                				<!-- Modal Header -->
							                				<div class="modal-header">
							                					<button type="button" class="close" data-dismiss="modal">
							                					<span aria-hidden="true">&times;</span>
										                    	<span class="sr-only">Close</span>
										                		</button>
										               			<h4 class="modal-title">${clView.uNickname}님 신고</h4>
										            		</div>
										            		<!-- Header -->
										            				
										            		<!-- Modal Body -->
										            		<div class="modal-body">
										            			<!-- declaration -->
										            			<form id="declaration_user_${clView.user_id}${clView.cId}" role="formDeclaration_user_${clView.user_id}${clView.cId}" name="dform">
											            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
											            			<input type="hidden" name="reported_id" value="${clView.user_id}">
										            				
											            			<div class="form-group">
												            			<label for="inputMessage">신고사유</label><br>
												            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${clView.cId}.disabled=true">  부적절한 홍보 게시글<br>
												            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${clView.cId}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
												            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${clView.cId}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
												            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${clView.cId}.disabled=false">  기타<br>
												            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${clView.cId}" name="dReason" disabled></textarea>
											            			</div>
										                		</form>
										                		<!-- declaration -->
										           		 	</div>
										           		 	<!-- modal-body -->
							            
										            		<!-- Modal Footer -->
										            		<div class="modal-footer">
										                		<button type="button" class="btn btn-default" data-dismiss="modal" onclick="ResetForm()">취소</button>
										                		<button type="button" class="btn reportBtn" onclick="reportUser(${clView.user_id}${clView.cId},'${clView.uNickname}');">신고</button>
										            		</div>
										            		<!-- Footer -->
						                				</div>
									        			<!-- modal-content -->
					    							</div>
					    							<!-- modal-dialog -->
													</div>
												<!-- modal -->
											</c:otherwise>
										</c:choose>
									
									</li>
									<li class="list-group-item">Second item</li>
									<li class="list-group-item">Third item</li>
									<li class="list-group-item">Fourth item</li>
								</ul>
								
								
								
								
								
								
								
								
								
							</div>
						
						
							
							
							
						</div>
								
							
							
					</div>
				</div>
					
					
			</div>
			

			<!-- class강좌 신청 : 본인이 개설한 강좌에는 보이지 않기-->
			<div class="classJoinForm">
				<button class="btn btn-success btn-lg" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false">강좌 신청</button>
				
				<div class="modal fade" id="modalForm" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
	           
				            <!-- Modal Header -->
				            <div class="modal-header">
				                <h4 class="modal-title" id="myModalLabel">강좌명 : ${clView.cTitle} 신청</h4>
				            </div>
	            
				            <!-- Modal Body -->
				            <div class="modal-body">
				                <p class="statusMsg"></p>
				                
				                <c:choose>
					                <c:when test="${empty loginUser.uNickname}">
					                	<h3>강좌 신청을 원하시면 로그인 해주세요.</h3>
				                	</c:when>
				                	
					                <c:otherwise>
						                <form id="classJoin" role="classJoinRole" name="cjform">
						      				<input type="hidden" name="class_id" value="${clView.cId}">
						      				<input type="hidden" name="user_id" value="${loginUser.user_id}">		<!-- 신청자 user_id -->
						      				<input type="hidden" name="opennerUser_id" value="${clView.user_id}">	<!-- 개설자 user_id -->
						      				<input type="hidden" name="classPrice" value="${clView.cPrice}">
						      				
						      				
											강좌명 : ${clView.cTitle}<br>
											개설자 : ${clView.uNickname}<br>
											개설자 user_id : ${clView.user_id}<br>
											수강 POINT :  ${clView.cPrice}<br>
											
											신청자 닉네임 : ${loginUser.uNickname}<br>
											신청자 user_id : ${loginUser.user_id}<br>
											신청자 point 보유액 : ${loginUser.point}<br>
											
						                </form>
					                </c:otherwise>
				                </c:choose>
				
				            </div>
	            
				            <!-- Modal Footer -->
				            <div class="modal-footer">
				                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="resetForm()">취소</button>
				                <button type="button" class="btn btn-primary submitBtn" onclick="classJoinForm()">강좌신청</button>
				            </div>
				            
				        </div>
	    			</div>
				</div>
				
			</div>
			<br>
				
				
				
			<!-- Class 강좌 세부출력 -->
			<table border="1">
		
				<tr>
					<td>Class 카테고리</td>
					<td>${clView.cCategory}</td>
				</tr>

				<tr>
					<td>Class 개설자</td>
					<td>${clView.uNickname}
					
					
						
						
						
					</td>
				</tr>
				<tr>
					<td>강좌 수강신청 기간</td>
					<td>
						<fmt:formatDate value="${clView.cOpenDate}" pattern="yyyy/MM/dd"/> ~ <fmt:formatDate value="${clView.cEndDate}" pattern="yyyy/MM/dd"/>
					</td>
				</tr>
				<tr>
					<td>수강신청 종료 기한</td>
					<td><b id="classEndCountDown" style="color: #e7438b"></b></td>
				</tr>
				<tr>
					<td>강좌 POINT</td>
					<td>${clView.cPrice}</td>
				</tr>
				<tr>
					<td>강좌 참여인원</td>
					<td><b class="classCurrentPeople"></b> / ${clView.cTotalPeopleCount}</td>
				</tr>
				<tr>
					<td>강좌 난이도</td>
					<td>${clView.cDifficulty}</td>
				</tr>


				<tr>
					<td colspan="2">
						<c:choose>
							<c:when test="${loginUser.uNickname == clView.uNickname}">
								<button class="classModify" type="button">class강좌 수정</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="classDelete" type="button">class강좌 삭제</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="classList" type="button" >class강좌 목록</button>
							</c:when>
							<c:otherwise>
								<button class="classList" type="button" >class강좌 목록</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" onclick="cScrap(${clView.cId})">class 스크랩</button>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
			<br>
			
			<form name="form1" role="form" method="post">
				<input type='hidden' name='cId' value="${clView.cId}">
				<input type="hidden" name="page" id="cscriPage" value="${cscri.page}" />
				<input type="hidden" name="perPageNum" id="cscriPageNum" value="${cscri.perPageNum}" />
				<input type="hidden" name="searchType" id="cscriSearchType" value="${cscri.searchType}" />
				<input type="hidden" name="keyword" id="cscriKeyword" value="${cscri.keyword}" />
				<input type="hidden" name="cCategory" id="cCategory" value="${cCategory}" />
			</form>
			
			<!-- 수업문의 작성 -->
			<div>
				<h2>Class강좌 문의(<b class="qCount"></b>)</h2>
				<!-- 개설자일경우 안보임-->
				<c:choose>
					<c:when test="${loginUser.uNickname == clView.uNickname}">
					</c:when>
				
					<c:otherwise>
						<form name="qForm">
							<input type="hidden" name="class_id" value="${clView.cId}" /> 
							<table border="1">
								<tr>
									<td>
										<input type="hidden" name="user_id" value="${loginUser.user_id}">${loginUser.uNickname}&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" name="qBtn">등록</button>
									</td>
								<tr>
									<td>
										<textarea type="text" name="rpContent" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>
									</td>
								</tr>
								
							</table>
						</form>
					</c:otherwise>
				</c:choose>
			</div>
			<hr>
			
			<div>
				<div class="questionPaging"></div>
				<div class="questionList"></div>
			</div>
		
		</section>
		
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->
		
		
		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/js/class/reply/reply.js"></script>
	</body>
</html>