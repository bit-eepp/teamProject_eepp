function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

$(document).ready(function() {
	loadNotReaeMessage();
});
	
function openMsg(){
	 var tw = window.open(getContextPath()+"/message?messageType=myReceiveMsg","message","left="+(screen.availWidth-700)/2
			 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
}

function loadNotReaeMessage(){
	$.ajax({
	      dataType : "json",
	      type : "post",
	      url : getContextPath() + "/loadNotReaeMessage",
	      success : function(data) {
	    	  if(data != ""){
	    		  var notReadMessage = JSON.stringify(data.notReadMessage);
	    		  $("#msgAlertNum").html(notReadMessage);
	    	  }
	      }
	  });
}
$('.navbar-toggle').on('click', function () {
    $('#mySidenav').addClass('side_show');
    $('.side_overlay').fadeIn();
    
    if($('#chatRoomListWrap').hasClass('side_chat_show')){
    	$('.chatBtn').removeClass('side_chat_btn');
    	$('#chatRoomListWrap').removeClass('side_chat_show');
        $('.side_bar_overlay').fadeOut();	
    }
    
});

$('.side_overlay').on('click', function () {
    $('#mySidenav').removeClass('side_show');
    $('.side_overlay').fadeOut();
});

$('.closebtn').on('click', function () {
    $('#mySidenav').removeClass('side_show');
    $('.side_overlay').fadeOut();
});



