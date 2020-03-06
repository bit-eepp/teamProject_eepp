<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시글보기</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<script>
			var bId = ${content.bId};	// 게시글 번호
			var rpCount;				// 해당 게시글의 댓글 수 
			var uNickname = $("#userNickname").val();
			
			$(document).ready(function() {
				replyCount(bId);
				replyList();
				likeCount(bId);		// 추천수
				unlikeCount(bId);	// 비추천수
				
				var formObj = $('form[role="form"]');
				
				$('.list').on('click', function(){
				    formObj.attr('method','get');
				    formObj.attr('action','boardList');
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
				
				// 해당 게시글이 공지사항이면 게시물 신고 버튼 안보이게 하기
				var bSubject = '${content.bSubject}';

				if(bSubject == '공지') {
					$('.declarationForm').remove();
				}
				//로그인 하지않은 경우, 새글쓰기 버튼 삭제
				if(!uNickname){
					$('.writeBtn').remove();
				}
				// 자기가 작성한 게시글일 경우 게시물 신고버튼 표시안됨
				if(uNickname == $("#content_uNickname").val()){
					$('.declarationForm').remove();
				}
				
			});

			// 해당 댓글 신고 메서드
			function submitRpDeclarationForm(rpId) {
				var dReasonRp =  document.getElementById("rpDeclaration_"+rpId).dReason;
				
				if(dReasonRp.value == "") {
					alert("신고사유를 선택 해주세요.");
					return false;
				} else {
					$.ajax({
						type:'POST',
						url:'http://localhost:8282/eepp/declaration/doRpDeclaration',
						data:$('#rpDeclaration_'+rpId  +'[role=formRpDeclaration_' +rpId +']').serialize(),
						success:function(msg){
							alert(rpId +'번 댓글이 신고되었습니다.');
							$('#rpModalForm_' +rpId).modal('hide');
							rpResetForm(rpId);
							replyList(); 
						}
			        });
				}
			}
			
			function rpResetForm(rpId) {
				$('#rpModalForm_' +rpId).on('hidden.bs.modal', function (e) {
				  $(this).find('form')[0].reset()
				});
			}
			
			// 해당 게시글 신고 JS메서드
			function submitDeclarationForm(){
				var dReason = document.dform.dReason;
					
				if(dReason.value == "") {
					alert("신고사유를 선택 해주세요.");
					return false;
				} else {
					$.ajax({
						type:'POST',
						url:'http://localhost:8282/eepp/declaration/doDeclaration',
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
					url: 'http://localhost:8282/eepp/board/deleteContent',
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
			
			// 해당 게시글 삭제 후 글목록으로 전환
			function reset() {
				location.href='boardList?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}';
			}
						
			// 해당 게시글의 추천수를 불러오는  JS메서드(Ajax-Json)
			function likeCount(bId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/blikeCount',
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
				
			// 해당 게시글의 추천수를 올려주는  JS메서드(Ajax-Json)
			function like(bId) {
				if(!uNickname){
					alert("로그인 해주세요.");
				}else{
					$.ajax({
						url: 'http://localhost:8282/eepp/recommend/blikeUp',
						type: 'get',
						data: {'bId' : bId,
							'user_id' : $("#userId").val()
							},
						success: function(data){
							if (data == 0) {
								alert(bId + "번 글을 추천하셨습니다.");
							} else if (data != 0) {
								alert("추천은 한번만 가능합니다.");
							}
								likeCount(bId);
						},
						error : function(request, status, error) {
							console.log(request.responseText);
							console.log(error);
						}
					});
				}
			}
				
			// 해당 게시글의 비추천수를 불러오는  JS메서드(Ajax-Json)
			function unlikeCount(bId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/bUnlikeCount',
					type: 'get',
					data: {'bId' : bId},
					success: function(data){
						console.log("게시글 비추천수 : "+data)
						var a = '<div>';
							a += data;
							a += '</div>';
							$('.unlike').html(a)		
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			// 해당 게시글의 비추천수를 올려주는  JS메서드(Ajax-Json)
			function unlike(bId) {
				if(!uNickname){
					alert("로그인 해주세요.");
				}else{
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/bUnlikeUp',
					type: 'get',
					data: {'bId' : bId,
						'user_id' : $("#userId").val()
						},
					success: function(data){
						if (data == 0) {
							alert(bId + "번 글을 비추천하셨습니다.");
						} else if (data != 0) {
							alert("비추천은 한번만 가능합니다.");
						}
						unlikeCount(bId);
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
				}
			}
			
			// 해당 게시글 스크랩  JS메서드(Ajax-Json)
			function bScrap(bId) {
				if(!uNickname){
					alert("로그인 해주세요.");
					return false;
				}else{
				$.ajax({
					url: 'http://localhost:8282/eepp/scrap/doBoardScrap',
					type: 'post',
					data: {'board_id' : bId},
					success: function(data){
						console.log(data)
						alert(bId +"번 게시글이 스크랩 되었습니다.");
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
				}
			}
		</script>
	</head>

	<body>

	<input type="hidden" id="userNickname" name="uNickname" value="${loginUser.uNickname}">
	<input type="hidden" id="userId" name="user_id" value="${loginUser.user_id}">
	<input type="hidden" id="content_uNickname" value="${content.uNickname}" />
	
		<div>
			<h1>#${content.bId}번 게시글</h1>
			<br>
			<button type="button" class="writeBtn" onclick="location.href='writeView?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}'">새 글 쓰기</button><br>
		</div>
		<hr>
		
		<!-- 게시글 신고 -->
		<div class="declarationForm">
			<button class="btn btn-success btn-lg" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false" id="modalFormBtn">게시글 신고</button>
			
			<div class="modal fade" id="modalForm" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
           
			            <!-- Modal Header -->
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal">
			                    <span aria-hidden="true">&times;</span>
			                    <span class="sr-only">Close</span>
			                </button>
			                <h4 class="modal-title" id="myModalLabel">#${content.bId}번 게시글 신고</h4>
			            </div>
            
			            <!-- Modal Body -->
			            <div class="modal-body">
			                <p class="statusMsg"></p>
			                <c:choose>
			                <c:when test="${not empty loginUser.uNickname}">
			                <form id="declaration" role="formDeclaration" name="dform">
			                    <input type="hidden" name="reporter_id" value=121>
			                    <input type="hidden" name="board_id" value="${content.bId}">
			                    <div class="form-group">
			                        <label for="inputMessage">신고사유</label><br>
			                        <input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc.disabled=true">  부적절한 홍보 게시글<br>
									<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
									<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
									<input type="radio" name="dReason" value="etc" onclick="this.form.etc.disabled=false">  기타<br>
									<textarea cols="30" rows="10" class="form-control" id="etc" name="dReason" disabled></textarea>
			                    </div>
			                </form>
			                </c:when>
			                
			                <c:otherwise>
			                <h3>해당 게시글 신고를 원하시면 로그인 해주세요.</h3>
			                </c:otherwise>
			                </c:choose>
			            </div>
            
			            <!-- Modal Footer -->
			            <div class="modal-footer">
			                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="resetForm()">취소</button>
			                <button type="button" class="btn btn-primary submitBtn" onclick="submitDeclarationForm()">신고</button>
			            </div>
			        </div>
    			</div>
			</div>
		</div>
		<br>
			
		<!-- 게시글 세부출력 -->
		<div>
			<table border="1">
				<tr>
					<td>글번호</td>
					<td>#${content.bId}</td>
				</tr>
				<tr>
					<td>조회수</td>
					<td>${content.bHit}</td>
				</tr>
				<tr>
					<td>추천</td>
					<td class="like"></td>
				</tr>
				<tr>
					<td>비추천</td>
					<td class="unlike"></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${content.bWrittenDate} 작성</td>
				</tr>
				<tr>
					<td>최종수정일</td>
					<td>${content.bModifyDate} 수정됨</td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td>${content.uNickname}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${content.bTitle}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td width="500" height="300">${content.bContent}</td>
				</tr>
				<tr>
					<td colspan="2">
					<c:choose>
						<c:when test="${loginUser.uNickname == content.uNickname}">
						<button type="button" onclick="bScrap(${content.bId})">스크랩</button>&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<button type="button" onclick="like(${content.bId})">추천</button>&nbsp;&nbsp;
						<button type="button" onclick="unlike(${content.bId})">비추천</button>&nbsp;&nbsp;
						<button type="button" onclick="bScrap(${content.bId})">스크랩</button>&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<c:choose>
						<c:when test="${loginUser.uNickname == content.uNickname}">
							<button class="modify" type="button">수정</button>&nbsp;&nbsp;
							<button class="list" type="button">글목록</button>&nbsp;&nbsp;
							<button class="delete" type="button">삭제</button>
						</c:when>
						<c:otherwise>
							<button class="list" type="button">글목록</button>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</table>
			
			<form name="form1" role="form" method="post">
				<input type='hidden' name='bId' value="${content.bId}">
				<input type="hidden" name="page" value="${scri.page}" />
				<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
				<input type="hidden" name="searchType" value="${scri.searchType}" />
				<input type="hidden" name="keyword" value="${scri.keyword}" />
				<input type="hidden" name="sortType" value="${sortType}" />
				<input type="hidden" name="bCategory" value="${bCategory}" />
			</form>
		</div>
		<hr>
		
		<!-- 댓글처리 -->
		<div>
			<h2>댓글(<b class="replyCount"></b>)</h2>
			<form name="rpform">
				<input type="hidden" name="board_id" value="${content.bId}" />
				<input type="hidden" name="user_id" value="${loginUser.user_id}">
				<table border="1">
					<tr>
						<td>
						<c:choose>
						<c:when test="${not empty loginUser.uNickname}">
						${loginUser.uNickname}
							<button type="button" name="replyBtn">등록</button>
						</c:when>
						<c:otherwise>
							<input type="text" value="GUEST" disabled>
							<button type="button" name="replyBtn">등록</button>
						</c:otherwise>
					</c:choose>
						</td>
					<tr>
						<td>
							<textarea id="rpContent" type="text" name="rpContent" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<hr>
	
		<div>
			<div class="replyPaging"></div>
			<div class="replyList"></div>
		</div>
	
		<%@ include file="/WEB-INF/views/board/replyList.jsp"%>
	
	</body>
</html>