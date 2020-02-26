<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Class 상세 페이지</title>
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<script>
			var cId = ${clView.cId};
			var questionCount;
			
			$(document).ready(function() {
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
			
			// 해당 class강좌 신청 JS메서드
			function classJoinForm(){
				var cjIntroduce = document.cjform.cjIntroduce;
					
				if(cjIntroduce.value == "") {
					alert("Class강좌 가입을 위한 간단한 본인소개를 작성해주세요");
					document.cjform.cjIntroduce.focus();
					return false;
				} else {
					$.ajax({
						type:'POST',
						url:'http://localhost:8282/eepp/class/classJoin',
						data:$('#classJoin[role=classJoinRole]').serialize(),
						success:function(msg){
							alert(cId +'번 클래스 수강신청이 완료되었습니다.');
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
			
			// 해당 class 강좌 삭제 확인 JS메서드(댓글이 있는 강좌의 경우 삭제 불가)
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
					url: 'http://localhost:8282/eepp/class/deleteClass',
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
				location.href='classList?page=${cscri.page}&perPageNum=${cscri.perPageNum}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}';
			}
			
			// 해당 class강좌 스크랩  JS메서드(Ajax-Json)
			function cScrap(cId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/scrap/doClassScrap',
					type: 'post',
					data: {'class_id' : cId},
					success: function(data){
						console.log(data)
						alert(cId +"번 class강좌가 스크랩 되었습니다.");
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
		<h1>#${clView.cId}번 Class강좌</h1>
		<hr>
		<br>
		
		<!-- class강좌 신청 -->
		<div class="classJoinForm">
			<button class="btn btn-success btn-lg" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false">강좌 신청</button>
			
			<div class="modal fade" id="modalForm" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
           
			            <!-- Modal Header -->
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal">
			                    <span aria-hidden="true">&times;</span>
			                    <span class="sr-only">Close</span>
			                </button>
			                <h4 class="modal-title" id="myModalLabel">강좌명 : ${clView.cTitle} 신청</h4>
			            </div>
            
			            <!-- Modal Body -->
			            <div class="modal-body">
			                <p class="statusMsg"></p>
			                <form id="classJoin" role="classJoinRole" name="cjform">
			      				<input type="hidden" name="class_id" value="${clView.cId}">
			                    <label>신청자 id</label><br>  <!-- 로그인합치면 없어질예정 -->
			                    <input type="text" name="user_id"><br><br> <!-- 로그인합치면 없어질예정 -->
			                    <label>간단한 자기소개</label><br>  <!-- 로그인합치면 없어질예정 -->
			                    <textarea cols="40" rows="2" name="cjIntroduce"></textarea>
			                </form>
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
				<td>Class 강좌 번호</td>
				<td>#${clView.cId}</td>
			</tr>
			<tr>
				<td>Class 대문이미지</td>
				<td><img src="data:image/jpeg;base64,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"></td>
			</tr>
			<tr>
				<td>Class 카테고리</td>
				<td>${clView.cCategory}</td>
			</tr>
			<tr>
				<td>Class 강좌명</td>
				<td>${clView.cTitle}</td>
			</tr>
			<tr>
				<td>강좌 개설일</td>
				<td><fmt:formatDate value="${clView.cOpenDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>강좌 신청기간</td>
				<td>
					<fmt:formatDate value="${clView.cOpenDate}" pattern="yyyy-MM-dd"/> ~ 
					<fmt:formatDate value="${clView.cEndDate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp;&nbsp;
				${clView.cTerm} 일</td>
			</tr>
			<tr>
				<td>강좌 POINT</td>
				<td>${clView.cPrice}</td>
			</tr>
			<tr>
				<td>강좌 참여인원</td>
				<td>${clView.cCurrentPeopleCount} / ${clView.cTotalPeopleCount}</td>
			</tr>
			<tr>
				<td>강좌 난이도</td>
				<td>${clView.cDifficulty}</td>
			</tr>
			<tr>
				<td>강좌 준비물</td>
				<td>${clView.cMaterials}</td>
			</tr>
			<tr>
				<td>강좌 상세내용</td>
				<td width="500" height="300">${clView.cContent}</td>
			</tr>
			<tr>
				<td colspan="2">
					<button class="classModify" type="button">class강좌 수정</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button class="classDelete" type="button">class강좌 삭제</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button class="classList" type="button" >class강좌 목록</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" onclick="cScrap(${clView.cId})">class 스크랩</button>
				</td>
			</tr>
		</table>
		
		<form name="form1" role="form" method="post">
			<input type='hidden' name='cId' value="${clView.cId}">
			<input type="hidden" name="page" value="${cscri.page}" />
			<input type="hidden" name="perPageNum" value="${cscri.perPageNum}" />
			<input type="hidden" name="searchType" value="${cscri.searchType}" />
			<input type="hidden" name="keyword" value="${cscri.keyword}" />
			<input type="hidden" name="cCategory" value="${cCategory}" />
		</form>
		
		<!-- 수업문의 작성 -->
		<div>
			<h2>Class강좌 문의(<b class="qCount"></b>)</h2>
			<form name="qForm">
				<input type="hidden" name="class_id" value="${clView.cId}" /> 
				<table border="1">
					<tr>
						<td>
							<input type="text" name="user_id" placeholder="작성자">&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" name="qBtn">등록</button>
						</td>
					<tr>
						<td>
							<textarea type="text" name="rpContent" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<hr>
		
		<div>
			<div class="questionPaging"></div>
			<div class="questionList"></div>
		</div>
		
		<%@ include file="/WEB-INF/views/class/classQuestionList.jsp"%>
	</body>
</html>