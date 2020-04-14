//contextPath
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var uNickname = $("#userNickname").val();
	
$(document).ready(function() {
	
	var eId = $("#eId").val();
	var baseText = $("#keyword_" +eId).val();

	console.log(baseText);
	
	var tagText = baseText.split(' ');

	for(var i in tagText){
		//document.html('<p> # ' + tagText[i] + ' </p>');
		//document.getElementById('eId').append('<p> # ' + tagText[i] + ' </p>');
		$(".baseText").append('<p> # ' + tagText[i] + ' </p>');

	}
	
	
	// 가게 검색
	$('#eatingSearchBtn').click(function() {
		if($('select[name=searchType]').val() == 'n') {
			alert('검색조건을 지정해주세요');
			return false;
		} else {
			self.location ="eatingList" + $("#eatingMakeQuery").val() + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
			}
	});
	
	$('#keywordInput').keydown(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == 13) {
	    	 if($('select[name=searchType]').val() == 'n') {
	 			alert('검색조건을 지정해주세요');
	 			return false;
	 		} else {
	 			self.location = "eatingList" + $("#eatingMakeQuery").val() + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
	 		}
	     }
	});
	

	
	var page_eating = $('#eatingCriPage').val();
	pageColor(page_eating);
	
});

function pageColor(page_eating) {
	$('#etPage_'+page_eating).css("background-color", "#59bfbf");
	$('#etPage_'+page_eating).css("color", "#ffffff");
}