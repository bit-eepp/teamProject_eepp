/* ***************** */
/*	  class List 	 */
/* **************** */

$(document).ready(function() {
	var pageNum = $('#classCriPage').val();
	pageColor(pageNum);
	
	var cCategory = $('#cCategory').val();
	
	if(cCategory == "") {
		$('#cateAll').css('background-color', '#e7438b');
		$('#cateAll').css('color', '#ffffff');
	} else if(cCategory == "it_dev") {
		$('#cateItDev').css('background-color', '#e7438b');
		$('#cateItDev').css('color', '#ffffff');
	} else if(cCategory == "workSkill") {
		$('#cateWorkSkill').css('background-color', '#e7438b');
		$('#cateWorkSkill').css('color', '#ffffff');
	} else if(cCategory == "financialTechnology") {
		$('#cateFinance').css('background-color', '#e7438b');
		$('#cateFinance').css('color', '#ffffff');
	} else if(cCategory == "daily") {
		$('#cateDaily').css('background-color', '#e7438b');
		$('#cateDaily').css('color', '#ffffff');
	} else if(cCategory == "etc") {
		$('#cateEtc').css('background-color', '#e7438b');
		$('#cateEtc').css('color', '#ffffff');
	}
	
	// 게시물 검색
	$('#classSearchBtn').click(function() {
		if($('select[name=searchType]').val() == 'n') {
			alert('검색조건을 지정해주세요');
			return;
		} else {
			self.location = "classList" + $("#classPageMaker").val() + "&searchType=" + $("select[name=searchType]").val() 
			+ "&keyword=" + encodeURIComponent($('#keywordInput').val()) +"&cCategory="+$("#cCategory").val();
		}
	});
	
	$('#keywordInput').keydown(function(event){3
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == 13) {
	    	 if($('select[name=searchType]').val() == 'n') {
	 			alert('검색조건을 지정해주세요');
	 			return;
	 		} else {
	 			self.location = "classList" + $("#classPageMaker").val() + "&searchType=" + $("select[name=searchType]").val() 
	 			+ "&keyword=" + encodeURIComponent($('#keywordInput').val()) +"&cCategory="+$("#cCategory").val();
	 		}
	     }
	});
});

function pageColor(pageNum) {
	$('#clPage_'+pageNum).css("background-color", "#59bfbf");
	$('#clPage_'+pageNum).css("color", "#ffffff");
}