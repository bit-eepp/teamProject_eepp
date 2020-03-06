/* ***************** */
/*	  class Open	 */
/* **************** */
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