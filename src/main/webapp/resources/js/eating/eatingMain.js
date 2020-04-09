//contextPath
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var uNickname = $("#userNickname").val();
	
$(document).ready(function() {
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
	
	if($("#eatingKeyword").val() != ""){
		var elmnt = document.getElementById("isSearchTitle")
		elmnt.scrollIntoView();
	}
	
});
