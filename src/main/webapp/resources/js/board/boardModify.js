/* ***************** */
/*	 modify View 	 */
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
});

function checkForm() {
	var bTitle = document.mform.bTitle;
	
	 if(bTitle.value == '') {
		alert("제목을 입력해주세요");
		document.mform.bTitle.focus();
		return false;
	} else {
		return true;
	}
}