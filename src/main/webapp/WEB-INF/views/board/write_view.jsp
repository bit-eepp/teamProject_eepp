<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>새 글 쓰기</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		
		<!-- <script language="javascript" type="text/javascript">
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
				
				// 게시판 리스트로 다시 돌아가기
				var formObj = $('form[role="form"]');
				
				$('.list').on('click', function(){
			        // self.location : 현재 창 변경하는 JQuery 메서드
				    formObj.attr('method','get');
				    formObj.attr('action','boardList');
				    formObj.submit();
			    });
			});
			
			function checkForm() {
				var bCategory = document.wform.bCategory;
				var bSubject = document.wform.bSubject;
				var bTitle = document.wform.bTitle;
				
				if(bCategory.value == '') {
					alert("게시판 카테고리를 선택 해주세요.");
					document.wform.bCategory.focus();
					return false;
				} else if(bSubject.value == '') {
					alert("주제를 선택해주세요.");
					document.wform.bSubject.focus();
					return false;
				} else if(bTitle.value == '') {
					alert("제목을 입력해주세요");
					document.wform.bTitle.focus();
					return false;
				} else {
					return true;
				}
			}
		</script> -->
	</head>
	
	<body>
		<h1>새 글 쓰기</h1>
		<form name="wform" action="writeContent" method="post" onsubmit="return writeCheckForm();">
			<input type="hidden" name="page" value="${scri.page}" />
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
			<input type="hidden" name="searchType" value="${scri.searchType}" />
			<input type="hidden" name="keyword" value="${scri.keyword}" />
			<input type="hidden" name="sortType" value="${sortType}" />
			
			<table border="1">		
				<tr>
					<td>게시판 카테고리</td>
					<td>
						<select name="bCategory"> 
							<option value="" disabled selected>게시판을 선택해주세요</option>
							<option value="it_dev">IT/개발</option>
							<option value="service">서비스</option>
							<option value="finance" >금융</option>
							<option value="design">디자인</option>
							<option value="official">공무원</option>
							<option value="etc">기타</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td>주제</td>
					<td>
						<select name="bSubject">
							<option value="" disabled selected>주제를 선택해주세요</option>
							<option value="qna">Q&A</option>
							<option value="info">정보</option>
							<option value="daily">일상</option>
						</select>
					</td>
				</tr>
			
				<tr>
					<td> 작성자 </td>
					<td> <input type="hidden" name="user_id" size = "50" value="${loginUser.user_id}">${loginUser.uNickname}</td>
				</tr>
				
				<tr>
					<td> 글제목 </td>
					<td> <input type="text" name="bTitle" size = "50" placeholder="제목"> </td>
				</tr>
				
				<tr>
					<td> 내용 </td>
					<td><textarea id="summernote" name="bContent"></textarea></td>
				</tr>
				
				<tr>
					<td colspan="2"> 
						<input type="submit" value="등록">&nbsp;&nbsp; 
						<button class="list" type="button">취소</button>
					</td>
				</tr>
			</table>
		</form>
		
		<form name="form1" role="form" method="post">
			<input type="hidden" name="page" value="${scri.page}" />
			<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
			<input type="hidden" name="searchType" value="${scri.searchType}" />
			<input type="hidden" name="keyword" value="${scri.keyword}" />
			<input type="hidden" name="sortType" value="${sortType}" />
			<input type="hidden" name="bCategory" value="${bCategory}" />
		</form>
		
		<script src="${pageContext.request.contextPath}/js/board/boardWrite.js"></script>
	</body>
</html>