/* ***************** */
/*	 modify View 	 */
/* **************** */

$(document).ready(function() {
	
	$('#summernote').summernote({
		height: 450,   // set editor height
		minHeight : '450px',
		maxHeight : '600px',
		focus : true,
		lang: 'ko-KR', // 언어 세팅
		tabsize: 2,
		disableResize: true,
	    disableResizeEditor: true,
	    resize: false,
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