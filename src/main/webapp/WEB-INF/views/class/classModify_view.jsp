<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Class 수정 페이지</title>
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.css" rel="stylesheet">
	    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.js"></script>
		
		<script>
			$(document).ready(function() {
				$('#summernote').summernote({
					height: 500,   // set editor height
					minHeight : null,
					maxHeight : null,
					focus : true,
					lang: 'ko-KR', // 언어 세팅
					placeholder: '내용을 작성해 주세요',
					tabsize: 2,
					toolbar: [
						['style', ['style']],
						['font', ['bold', 'underline','superscript', 'subscript', 'strikethrough', 'clear']],
						['fontname', ['fontname']],
				        ['fontsize', ['fontsize']],
						['color', ['color']],
						['para', ['ul', 'ol', 'paragraph']],
						['table', ['table']],
						['insert', ['link', 'picture', 'video']],
						['view', ['fullscreen', 'codeview', 'help']]
					],
					fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
					fontNamesIgnoreCheck : [ '맑은고딕' ]
				});
			});
			
			function checkForm() {
				var cTitle = document.mform.cTitle;
				var cSummary = document.mform.cSummary;
				var cTerm = document.mform.cTerm;			
				var cTotalPeopleCount = document.mform.cTotalPeopleCount;
				var cPrice = document.mform.cPrice;
				var cCategory = $('input:radio[name="cCategory"]:checked').val();
				var cDifficulty = $('input:radio[name="cDifficulty"]:checked').val();
				
				if(cTitle.value == '') {
					alert("class 강좌명을 입력해주세요.");
					document.mform.cTitle.focus();
					return false;
				} else if(cSummary.value == '') {
					alert("class 강좌 한줄소개를 입력해주세요");
					document.mform.cSummary.focus();
					return false;
				} else if(cTotalPeopleCount.value == 0) {
					alert("class 강좌 참여인원을 입력해주세요");
					document.mform.cTotalPeopleCount.focus();
					return false;
				} else if(cCategory == undefined) {
					alert("class 강좌 카테고리를 선택해주세요");
					return false;
				} else if(cTerm.value == '') {
					alert("class 강좌 개설기간을 선택해주세요");
					document.mform.cTerm.focus();
					return false;
				} else if(cDifficulty == undefined) {
					alert("class 강좌 난이도를 선택해주세요");
					return false;
				} else if(cPrice.value == 0) {
					alert("class 강좌 포인트 가격을 입력해주세요");
					document.mform.cPrice.focus();
					return false;
				}  else {
					return true;
				} 
			}
		</script>
		
		<style type="text/css">
			main {
				display: flex;
				align-items: center;
				flex-direction: column;
				position: absolute;
				top: 80px;
				left: 50%;
				transform: translateX(-50%);
			}
			
			div.radio-box {
				width: 450px;
				display: flex;
				align-items: center;
				justify-content: space-around;
			}
			
			input[name="cCategory"], input[name="cDifficulty"] {
				display: none
			}
			
			input[name="cCategory"]+label, input[name="cDifficulty"]+label {
				width: 80px;
				display: inline-block;
				text-align: center;
				cursor: pointer;
				user-select: none;
			}
			
			input[name="cCategory"]+label, input[name="cDifficulty"]+label {
				transition: all 200ms cubic-bezier(.4, .25, .3, 1);
				padding: 20px 0;
				color: #59bfbf;
				background-color: transparent;
				border: 2px solid #59bfbf; &:
				hover {opacity: .65}
			}
			
			input[name="cCategory"]+label:active, input[name="cDifficulty"]+label:active {
				transition: none;
				transform: scale(.925);
			}
			
			input[name="cCategory"]:checked+label, input[name="cCategory"]:checked+label:hover, input[name="cDifficulty"]:checked+label, input[name="cDifficulty"]:checked+label:hover {
				background-color: #FFF;
				color: #ff578f;
				opacity: 1;
				font-weight: bold;
			}
		</style>
	</head>

	<body>
		<h1>#${modifyClass.cId}번 Class강좌 수정페이지</h1>
		<hr>
		<br>
		
		<!-- partial:index.partial.html -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
			
		<form name="mform" action="modifyClass" method="post" onsubmit="return checkForm();">
			<input type="hidden" name="cId" value="${modifyClass.cId}">
			<input type="hidden" name="page" value="${cscri.page}">
			<input type="hidden" name="perPageNum" value="${cscri.perPageNum}">
			<input type="hidden" name="searchType" value="${cscri.searchType}">
			<input type="hidden" name="keyword" value="${cscri.keyword}">

			<div class="form-group row">
				<label for="text" class="col-4 col-form-label">Class강좌명</label>
				<div class="col-8">
					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text"></div>
						</div>
						<input id="text" name="cTitle" type="text" aria-describedby="textHelpBlock" class="form-control" value="${modifyClass.cTitle}">
					</div>
					<span id="textHelpBlock" class="form-text text-muted">40자 이내로 입력해 주세요.</span>
				</div>
			</div>
			<br>

			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 한 줄 소개</label>
				<div class="col-8">
					<textarea id="transport_instructions" name="cSummary" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control">${modifyClass.cSummary}</textarea>
					<span id="transport_instructionsHelpBlock" class="form-text text-muted">100자 이내로 입력해 주세요.</span>
				</div>
			</div>
			<br>
			
			<!-- 첨부파일이 완료되면 수정 -->
			<div class="form-group row">
				<label for="text" class="col-4 col-form-label">Class강좌 대표 이미지</label>
				<div class="form-group row">
					<div class="offset-2 col-9">
						<button onclick="#" class="btn btn-info">사진업로드</button>
					</div>
				</div>
			</div>
			<br>

			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 참여 인원</label>
				<div class="col-8">
					<input value="${modifyClass.cTotalPeopleCount}" style="width:300px; height:30px;" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control" type="number" name="cTotalPeopleCount" min="1" max="50" step="1">
				</div>
			</div>
			<br>
			
			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 카테고리</label>
				<div class="col-8">
					<div class="container">
			   		    <div class="radio-box">
							<input id="radio-1" type="radio" name="cCategory" value="it_dev" <c:out value="${modifyClass.cCategory eq 'it_dev' ? 'checked' : ''}"/>>
							<label for="radio-1">IT/개발</label>
							<input id="radio-2" type="radio" name="cCategory" value="workSkill" <c:out value="${modifyClass.cCategory eq 'workSkill' ? 'checked' : ''}"/>> 
							<label for="radio-2">업무스킬</label>
							<input id="radio-3" type="radio" name="cCategory" value="daily" <c:out value="${modifyClass.cCategory eq 'daily' ? 'checked' : ''}"/>>
							<label for="radio-3">일상</label>
							<input id="radio-4" type="radio" name="cCategory" value="financialTechnology" <c:out value="${modifyClass.cCategory eq 'financialTechnology' ? 'checked' : ''}"/>>
							<label for="radio-4">재테크</label>
							<input id="radio-5" type="radio" name="cCategory" value="etc" <c:out value="${modifyClass.cCategory eq 'etc' ? 'checked' : ''}"/>>
							<label for="radio-5">기타</label>
						</div>
					</div>
				</div>
			</div>
			<br>


			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 개설기간</label>
				<div class="col-8">
					<select name="cTerm">
						<option value="" disabled selected>class강좌 개설기간</option>
						<option value=3 <c:out value="${modifyClass.cTerm eq 3 ? 'selected' : ''}"/>>3일</option>
						<option value=5 <c:out value="${modifyClass.cTerm eq 5 ? 'selected' : ''}"/>>5일</option>
						<option value=7 <c:out value="${modifyClass.cTerm eq 7 ? 'selected' : ''}"/>>7일</option>
						<option value=10 <c:out value="${modifyClass.cTerm eq 10 ? 'selected' : ''}"/>>10일</option>
					</select>
				</div>
			</div>
			<br>
			
			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 난이도</label>
				<div class="col-8">
					<div class="radio-box">
						<input id="radio-6" type="radio" name="cDifficulty" value="easy" <c:out value="${modifyClass.cDifficulty eq 'easy' ? 'checked' : ''}"/>>
						<label for="radio-6">쉬움</label>
						<input id="radio-7" type="radio" name="cDifficulty" value="normal" <c:out value="${modifyClass.cDifficulty eq 'normal' ? 'checked' : ''}"/>>
						<label for="radio-7">보통</label>
						<input id="radio-8" type="radio" name="cDifficulty" value="hard" <c:out value="${modifyClass.cDifficulty eq 'hard' ? 'checked' : ''}"/>>
						<label for="radio-8">어려움</label>
					</div>
				</div>
			</div>
			<br>	

			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 포인트 가격</label>
				<div class="col-8">
					<input value="${modifyClass.cPrice}" style="width: 300px; height: 30px;" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control" type="number" name="cPrice">
				</div>
			</div>
			<br>

			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 준비물</label>
				<div class="col-8">
					<textarea id="transport_instructions" name="cMaterials" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control">${modifyClass.cMaterials}</textarea>
					<span id="transport_instructionsHelpBlock" class="form-text text-muted">없을 시 공란으로 제출해 주세요.</span>
				</div>
			</div>
			<br>

			<div class="form-group row">
				<label for="transport_instructions" class="col-4 col-form-label">Class강좌 상세정보 </label>
				<div class="col-8">
					<textarea id="summernote" name="cContent">${modifyClass.cContent}</textarea>
					<span id="transport_instructionsHelpBlock" class="form-text text-muted">Class강좌에 대한 상세정보를 입력해 주세요.</span>
				</div>
			</div>
			<br>

			<div class="form-group row">
				<div class="offset-5 col-8">
					<input class="btn btn-primary active" type="submit" value="수정">
					<button class="btn btn-danger" type="button" onclick="location.href='classView?cId=${modifyClass.cId}&page=${cscri.page}&perPageNum=${cscri.perPageNum}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'">수정취소</button>
				</div>
			</div>
		</form>
	</body>
</html>