/* ***************** */
/*	  class Modify 	 */
/* **************** */

$(document).ready(function() {
	$('#summernote').summernote({
		height: 500,   // set editor height
		minHeight : null,
		maxHeight : null,
		focus : true,
		lang: 'ko-KR', // 언어 세팅
		placeholder: '개설예정인 강좌에 대한 상세정보를 입력해 주세요.',
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
	
	var slider = document.getElementById("myRange");
	var output = document.getElementById("clOpenTerm");
	output.innerHTML = slider.value;

	slider.oninput = function() {
		output.innerHTML = this.value;
	}
	
	$(document).on("change", ".file-input", function(){ 
        $filename = $(this).val();

        if($filename == "")
            $filename = "클래스 대표사진을 선택해주세요.";

        $(".filename").text($filename);
    })
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

//프로필 사진 업로드시 미리보기
function LoadImg(value) {
	if (value.files && value.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#loadImg').attr('src', e.target.result);
		}
		reader.readAsDataURL(value.files[0]);
	}
}