<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Class Open Page</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.css" rel="stylesheet">
		<link rel="stylesheet" ref="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
				
				// class강좌 리스트로 다시 돌아가기
				var formObj = $('form[role="form"]');
				
				$('#classList').on('click', function(){
				    formObj.attr('method','post');
				    formObj.attr('action','classList');
				    formObj.submit();
			    });
			});
			
			function classCheckForm() {
				var cTitle = document.cform.cTitle;
				var cSummary = document.cform.cSummary;
				var cTerm = document.cform.cTerm;			
				var cTotalPeopleCount = document.cform.cTotalPeopleCount;
				var cPrice = document.cform.cPrice;
				var cCategory = $('input:radio[name="cCategory"]:checked').val();
				var cDifficulty = $('input:radio[name="cDifficulty"]:checked').val();
				
				if(cTitle.value == '') {
					alert("class 강좌명을 입력해주세요.");
					document.cform.cTitle.focus();
					return false;
				} else if(cSummary.value == '') {
					alert("class 강좌 한줄소개를 입력해주세요");
					document.cform.cSummary.focus();
					return false;
				} else if(cTotalPeopleCount.value == 0) {
					alert("class 강좌 참여인원을 입력해주세요");
					document.cform.cTotalPeopleCount.focus();
					return false;
				} else if(cCategory == undefined) {
					alert("class 강좌 카테고리를 선택해주세요");
					return false;
				} else if(cTerm.value == '') {
					alert("class 강좌 개설기간을 선택해주세요");
					document.cform.cTerm.focus();
					return false;
				} else if(cDifficulty == undefined) {
					alert("class 강좌 난이도를 선택해주세요");
					return false;
				} else if(cPrice.value == 0) {
					alert("class 강좌 포인트 가격을 입력해주세요");
					document.cform.cPrice.focus();
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
		<h1 align="center">CLASS Open Page</h1>
		<br>
		<br>
		
		<!-- partial:index.partial.html -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
		<div class="container mt-5">
			<form action="classOpen" name="cform" method="post" onsubmit="return classCheckForm();">
				<input type="hidden" name="page" value="${cscri.page}" />
				<input type="hidden" name="perPageNum" value="${cscri.perPageNum}" />
				<input type="hidden" name="searchType" value="${cscri.searchType}" />
				<input type="hidden" name="keyword" value="${cscri.keyword}" />
			
				<div class="form-group row">
					<label for="text" class="col-4 col-form-label">Class 개설자</label>
					<div class="col-8">
						<div class="input-group">
							<div class="input-group-prepend">
								<div class="input-group-text"></div>
							</div>
							<input id="text" name="user_id" type="text" aria-describedby="textHelpBlock" class="form-control">
						</div>
						<span id="textHelpBlock" class="form-text text-muted">로그인 붙이면 없어질 예정.</span>
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="text" class="col-4 col-form-label">Class강좌명</label>
					<div class="col-8">
						<div class="input-group">
							<div class="input-group-prepend">
								<div class="input-group-text"></div>
							</div>
							<input id="text" name="cTitle" type="text" aria-describedby="textHelpBlock" class="form-control">
						</div>
						<span id="textHelpBlock" class="form-text text-muted">40자 이내로 입력해 주세요.</span>
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="transport_instructions" class="col-4 col-form-label">Class강좌 한 줄 소개</label>
					<div class="col-8">
						<textarea id="transport_instructions" name="cSummary" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control"></textarea>
						<span id="transport_instructionsHelpBlock" class="form-text text-muted">100자 이내로 입력해 주세요.</span>
					</div>
				</div>
				<br>
	
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
						<input style="width:300px; height:30px;" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control" type="number" name="cTotalPeopleCount" min="1" max="50" step="1">
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="transport_instructions" class="col-4 col-form-label">Class강좌 카테고리</label>
					<div class="col-8">
						<div class="container">
				   		    <div class="radio-box">
								<input id="radio-1" type="radio" name="cCategory" value="it_dev"/>
								<label for="radio-1">IT/개발</label>
								<input id="radio-2" type="radio" name="cCategory" value="workSkill"> 
								<label for="radio-2">업무스킬</label>
								<input id="radio-3" type="radio" name="cCategory" value="daily">
								<label for="radio-3">일상</label>
								<input id="radio-4" type="radio" name="cCategory" value="financialTechnology">
								<label for="radio-4">재테크</label>
								<input id="radio-5" type="radio" name="cCategory" value="etc">
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
							<option value=3>3일</option>
							<option value=5>5일</option>
							<option value=7>7일</option>
							<option value=10>10일</option>
						</select>
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="transport_instructions" class="col-4 col-form-label">Class강좌 난이도</label>
					<div class="col-8">
						<div class="radio-box">
							<input id="radio-6" type="radio" name="cDifficulty" value="easy">
							<label for="radio-6">쉬움</label>
							<input id="radio-7" type="radio" name="cDifficulty" value="normal">
							<label for="radio-7">보통</label>
							<input id="radio-8" type="radio" name="cDifficulty" value="hard">
							<label for="radio-8">어려움</label>
						</div>
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="transport_instructions" class="col-4 col-form-label">Class강좌 포인트 가격</label>
					<div class="col-8">
						<input style="width: 300px; height: 30px;" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control" type="number" name="cPrice">
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="transport_instructions" class="col-4 col-form-label">Class강좌 준비물</label>
					<div class="col-8">
						<textarea id="transport_instructions" name="cMaterials" cols="40" rows="2" aria-describedby="transport_instructionsHelpBlock" class="form-control"></textarea>
						<span id="transport_instructionsHelpBlock" class="form-text text-muted">없을 시 공란으로 제출해 주세요.</span>
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<label for="transport_instructions" class="col-4 col-form-label">Class강좌 상세정보 </label>
					<div class="col-8">
						<textarea id="summernote" name="cContent"></textarea>
						<span id="transport_instructionsHelpBlock" class="form-text text-muted">Class강좌에 대한 상세정보를 입력해 주세요.</span>
					</div>
				</div>
				<br>
	
				<div class="form-group row">
					<div class="offset-5 col-8">
						<input class="btn btn-primary active" type="submit" value="개설">
						<button id="classList" class="btn btn-danger" type="button">개설취소</button>
					</div>
				</div>
			</form>
			
			<form name="form1" role="form" method="post">
				<input type="hidden" name="page" value="${cscri.page}" />
				<input type="hidden" name="perPageNum" value="${cscri.perPageNum}" />
				<input type="hidden" name="searchType" value="${cscri.searchType}" />
				<input type="hidden" name="keyword" value="${cscri.keyword}" />
				<input type="hidden" name="cCategory" value="${cCategory}" />
			</form>
		</div>
	</body>
</html>