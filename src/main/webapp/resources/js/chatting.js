$('.chatBtn').on('click',function(){
	$('.chatBtn').addClass('side_chat_btn');
	$('#chatRoomListWrap').addClass('side_chat_show');
	$('.side_bar_overlay').fadeIn();
	
	if($('#mySidenav').hasClass('side_show')){
		$('#mySidenav').removeClass('side_show');
		$('.side_overlay').fadeOut();	
	}
});

$('.side_bar_overlay').on('click',function(){
	$('.chatBtn').removeClass('side_chat_btn');
	$('#chatRoomListWrap').removeClass('side_chat_show');
	$('.side_bar_overlay').fadeOut();
});

$('.closeChatbtn').on('click', function(){
	$('.chatBtn').removeClass('side_chat_btn');
	$('#chatRoomListWrap').removeClass('side_chat_show');
	$('.side_bar_overlay').fadeOut();
});

$('#headerAll').on('click', function(){
	$('.chatBtn').removeClass('side_chat_btn');
	$('#chatRoomListWrap').removeClass('side_chat_show');
	$('.side_bar_overlay').fadeOut();
});
$('section').on('click', function(){
	$('.chatBtn').removeClass('side_chat_btn');
	$('#chatRoomListWrap').removeClass('side_chat_show');
	$('.side_bar_overlay').fadeOut();
});

