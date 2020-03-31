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
	
	// class강좌 리스트로 다시 돌아가기
	var formObj = $('form[role="form"]');
	
	$('#classList').on('click', function(){
	    formObj.attr('method','post');
	    formObj.attr('action','classList');
	    formObj.submit();
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

function classCheckForm() {
	var cTitle = document.cform.cTitle;
	var cSummary = document.cform.cSummary;
	var cTerm = document.cform.cTerm;			
	var cTotalPeopleCount = document.cform.cTotalPeopleCount;
	var cPrice = document.cform.cPrice;
	var cCategory = $('input:radio[name="cCategory"]:checked').val();
	var cDifficulty = $('input:radio[name="cDifficulty"]:checked').val();
	var cAddress1 = document.cform.cAddress1;
	var cAddress3 = document.cform.cAddress3;
	
	if(cTitle.value == '') {
		alert("개설할 강좌명을 입력해주세요.");
		document.cform.cTitle.focus();
		return false;
	} else if(cSummary.value == '') {
		alert("개설할 강좌의 한줄소개를 입력해주세요");
		document.cform.cSummary.focus();
		return false;
	} else if(cTotalPeopleCount.value == 0) {
		alert("개설할 강좌의 참여인원을 입력해주세요");
		document.cform.cTotalPeopleCount.focus();
		return false;
	} else if(cCategory == undefined) {
		alert("개설할 강좌의 카테고리를 선택해주세요");
		return false;
	} else if(cTerm.value == '') {
		alert("개설할 강좌의 개설기간을 선택해주세요");
		document.cform.cTerm.focus();
		return false;
	} else if(cDifficulty == undefined) {
		alert("개설할 강좌의 난이도를 선택해주세요");
		return false;
	} else if(cPrice.value == 0) {
		alert("개설할 강좌의 포인트 가격을 입력해주세요");
		document.cform.cPrice.focus();
		return false;
	} else if(cAddress1.value == '') {
		alert("개설할 강좌의 교육장소를 설정하세요");
		document.cform.cAddress1.focus();
		return false;
	} else if(cAddress3.value == '') {
		alert("상세주소를 입력해 주세요");
		document.cform.cAddress3.focus();
		return false;
	} else {
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

function execPostCode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 도로명 조합형 주소 변수
			
			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			    extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if(data.buildingName !== '' && data.apartment === 'Y'){
			   extraRoadAddr += (extraRoadAddr !== '' ? ' ' + data.buildingName : data.buildingName);
			}
			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' ' + extraRoadAddr;
			}
			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if(fullRoadAddr !== ''){
				fullRoadAddr += extraRoadAddr;
			}
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			console.log(data.zonecode);
			console.log(fullRoadAddr);
			
			$("[name=cAddress1]").val(data.zonecode);
			$("[name=cAddress2]").val(fullRoadAddr);
        }
     }).open();
 }	