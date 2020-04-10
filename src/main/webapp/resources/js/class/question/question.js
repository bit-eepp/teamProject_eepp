var uNickname = $("#userNickname").val();
var userId = $("#userId").val();
var cId = $('#classId').val();

// 해당 class강좌의 문의수를 불러오는 JS메서드(Ajax-Json)
function questionCnt() {
	$.ajax({
		url: getContextPath() + '/question/questionCount',
		type: 'post',
		data: {
			'class_id' : cId
		},
		success: function(data){
			questionCount = data;
			var a = data;
			$('.qCount').html(a)
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}

// 강좌문의 페이징 코드
function questionPagePrint(rpPageMaker) {
	
	// 댓글 페이징 처리를 위한 변수
	var startPage = rpPageMaker[1];
	var endPage = rpPageMaker[2];
	var prev = rpPageMaker[3];
	var next = rpPageMaker[4];
	var tempEndPage = rpPageMaker[6];
	var page = rpPageMaker[7].page;
	
	var paging = '';
	paging += '<ul class="pagination justify-content-center">';
					
	if(tempEndPage != 0) {
		paging += '<li class="page-item">';
		paging += '<a class="page-link" href="javascript:questionList(1)"><i class="fas fa-angle-left"></i></a>';
		paging += '</li>';
	}
					
	for(var i = startPage; i <= endPage; i++){
		paging += '<li class="page-item">';
		paging += '<a id="clQuestionPageNum_' +i +'" class="page-link" href="javascript:questionList(' +i +')">' +i +'</a>';
		paging += '</li>';
	}
					
	if(page < tempEndPage){
		paging += '<li class="page-item">';
		paging += '<a class="page-link" href="javascript:questionList(' +tempEndPage +')"><i class="fas fa-angle-right"></i></a>';
		paging += '</li>';
	}
	
	$('.clQuestionPage').html(paging);
}

// 해당 게시글의 댓글들을 출력하는 JS메서드(Ajax-Json)
function questionList(page) {	
	var page = Number(page);
	
	if(isNaN(page)) {
		page = 1;
	}
	
	$.ajax({
		url: getContextPath() + '/question/questionList',
		type: 'post',
		dataType:'json',
		data: {
			'class_id' : cId,
			'page' : page <= 1 ? 1 : page
		},
		success: function(data){
			
			// 문의사항 페이징
			var rpPageMaker = Object.values(data["rpPageMaker"]);
			questionPagePrint(rpPageMaker);
						
			// 문의사항 리스트 
			var questionList = Object.values(data["questionList"]);		
			$('.questionList').children().remove();
			
				$.each(questionList, function(key, value){
					var indent = value.rpIndent;
					var tag = '';
							
					if(indent > 0) {
						var re = 'RE : ';
								
						tag += '<div class="classQuestionA q_'+value.rpId +'">';
						tag += '<div class="card-body">';
						tag += '<div class="card card-inner">';		//card-inner
						tag += '<div class="card-body">';		//card-body
						tag += '<div class="row">';			//row
						tag += '<div class="col-md-2" align="center">';
						tag += '<img class="qprofile" src="' +value.uProfile +'" alt="userProfile"/>';
													
							if(value.uNickname == uNickname || value.uNickname == '운영자' 
								|| value.uNickname == 'admin2' || uNickname == ''){
								
								tag += '<div>'
								tag += '<a class="userBtn"><b style="color:#e7438b; font-size:100%;">'+value.uNickname+'</b></a>';
								tag += '</div>'
							} else{
								tag += '<div class="dropdown">';
								tag += '<a href="#" class="userBtn" id="user_btn_'+value.rpId+value.user_id+'" data-toggle="dropdown"><b style="color:#59bfbf; font-size:100%;">'+value.uNickname+'</b></a>';
								tag += '<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_'+value.rpId+value.user_id+'">';
								tag += '<li><a onclick="memberInfo(' +'\'' +value.uNickname +'\',' +value.user_id +');">회원정보</a></li>';
								tag += '<li><a onclick="sendMessage('+'\''+value.uNickname+'\','+value.user_id+');">쪽지 보내기</a></li>';
								tag += '<li><a data-toggle="modal" data-target="#report_rp_user_'+value.rpId+value.user_id+'" data-backdrop="static" data-keyboard="false">신고하기</a></li>';
								tag += '</ul></div>';
								tag += '<div class="modal fade reportModalBox" id="report_rp_user_'+value.rpId+value.user_id+'" role="dialog"><div class="modal-dialog"><div class="modal-content">';
								tag += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
								tag += '<h4 class="modal-title">&#8988;'+value.uNickname+'&#8991;님 신고</h4></div>';
								tag += '<p class="reportBoxIcon"><img style="max-width:35%;" src="' +getContextPath() +'/img/reportBoxIcon.png"></p>';
								tag += '<div class="modal-body">';
								tag += '<form id="declaration_rp_user_'+value.rpId+value.user_id+'" role="formDeclaration_rp_user_'+value.rpId+value.user_id+'" name="dform">'
								tag += '<input type="hidden" name="reporter_id" value="${loginUser.user_id}">';
								tag += '<input type="hidden" name="reported_id" value="'+value.user_id+'">';
								tag += '<div class="form-group" align="left">';
								tag += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">부적절한 홍보 게시글<br>';
								tag += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">음란성 또는 청소년에게 부적합한 내용<br>';
								tag += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">명예훼손/사생활 침해 및 저작권침해등<br>';
								tag += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_'+value.rpId+'.disabled=false">기타<br>';
								tag += '<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etcRp_'+value.rpId+'" name="dReason" disabled></textarea>';
								tag += '</div></form></div>';
								tag += '<div class="modal-footer">';
								tag += '<button type="button" class="btn reportBtn" onclick="reportRpUser('+value.rpId+value.user_id+',\''+value.uNickname+'\');">신고</button>';
								tag += '</div>';
								tag += '</div></div></div>';	
							}
							
							tag += '<p class="text-secondary text-center">' +value.rpWrittenDate +'</p>';
							tag += '</div>';
							tag += '<div class="col-md-10">';
							tag += '<div class="clQcontent qContent_'+value.rpId +'"><p><b>' +re +value.rpContent +'</b></p></div>';
							tag += '<div class="cqMenuBtn">';
								if(uNickname != value.uNickname){
									if(uNickname == $("#classOpenner").val()){
										tag += '<a title="답변" class="float-right btn btn btn-info ml-2 reBtn" onclick="reQuestionView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');"><i class="fas fa-reply"></i></a><br>';
									}
								} else {
									var enter = /\r\n/g;
									var tempContent = value.rpContent.replace(enter, " ");
									
									tag += '<a title="삭제" class="float-right btn btn btn-info ml-2 delBtn" onclick="questionDelete(' +value.rpId +','+value.gCount+',' +value.rpStep +',' +value.rpIndent +');"><i class="fas fa-eraser"></i></a>';
									tag += '<a title="수정" class="float-right btn btn btn-info ml-2 editBtn" onclick="questionModify('+value.rpId +',\'' +tempContent +'\');"><i class="far fa-edit"></i></a>';
								}
							tag += '</div>';
							tag += '</div>';
							tag += '</div>';	//row
							tag += '</div>';	//card-body
							tag += '</div>';	//card-inner
							tag += '</div>';	//card-body
							tag += '</div>';
							
							} else {
								var re = '';
								tag += '<div class="classQuestionB q_'+value.rpId +'">';
								tag += '<div class="card-body">';	// card-body
								tag += '<div class="row">';			//row
								tag += '<div class="col-md-2" align="center">';
								tag += '<img class="qprofile" src="' +value.uProfile +'" alt="userProfile"/>';

									if(value.uNickname == uNickname || value.uNickname == '운영자' || value.uNickname == 'admin2' || uNickname == ''){
										tag += '<div>'
										tag += '<a class="userBtn"><b style="color:#e7438b; font-size:100%;">'+value.uNickname+'</b></a>';
										tag += '</div>'
									} else{
										tag += '<div class="dropdown">';
										tag += '<a href="#" class="userBtn" id="user_btn_'+value.rpId+value.user_id+'" data-toggle="dropdown"><b style="color:#59bfbf; font-size:100%; ">'+value.uNickname+'</b></a>';
										tag += '<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_'+value.rpId+value.user_id+'">';
										tag += '<li><a onclick="memberInfo(' +'\'' +value.uNickname +'\',' +value.user_id +');">회원정보</a></li>';
										tag += '<li><a onclick="sendMessage('+'\''+value.uNickname+'\','+value.user_id+');">쪽지 보내기</a></li>';
										tag += '<li><a data-toggle="modal" data-target="#report_rp_user_'+value.rpId+value.user_id+'" data-backdrop="static" data-keyboard="false">신고하기</a></li>';
										tag += '</ul></div>';
										tag += '<div class="modal fade reportModalBox" id="report_rp_user_'+value.rpId+value.user_id+'" role="dialog"><div class="modal-dialog"><div class="modal-content">';
										tag += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
										tag += '<h4 class="modal-title">&#8988;'+value.uNickname+'&#8991;님 신고</h4></div>';
										tag += '<p class="reportBoxIcon"><img style="max-width:35%;" src="' +getContextPath() +'/img/reportBoxIcon.png"></p>';
										tag += '<div class="modal-body">';
										tag += '<form id="declaration_rp_user_'+value.rpId+value.user_id+'" role="formDeclaration_rp_user_'+value.rpId+value.user_id+'" name="dform">'
										tag += '<input type="hidden" name="reporter_id" value="${loginUser.user_id}">';
										tag += '<input type="hidden" name="reported_id" value="'+value.user_id+'">';
										tag += '<div class="form-group" align="left">';
										tag += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">부적절한 홍보 게시글<br>';
										tag += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">음란성 또는 청소년에게 부적합한 내용<br>';
										tag += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">명예훼손/사생활 침해 및 저작권침해등<br>';
										tag += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_'+value.rpId+'.disabled=false">기타<br>';
										tag += '<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etcRp_'+value.rpId+'" name="dReason" disabled></textarea>';
										tag += '</div></form></div>';
										tag += '<div class="modal-footer">';
										tag += '<button type="button" class="btn reportBtn" onclick="reportRpUser('+value.rpId+value.user_id+',\''+value.uNickname+'\');">신고</button>';
										tag += '</div>';
										tag += '</div></div></div>';	
									}

								tag += '<p class="text-secondary text-center">' +value.rpWrittenDate +'</p>';
								tag += '</div>';
								tag += '<div class="col-md-10">';  	       
								tag += '<div class="clQcontent qContent_'+value.rpId  +'"><p><b>' +value.rpContent +'</b></p></div>';
								tag += '<div class="cqMenuBtn">';
									if(uNickname != value.uNickname){
										if(uNickname == $("#classOpenner").val()){
											tag += '<a title="답변" class="float-right btn btn btn-info ml-2 reBtn" onclick="reQuestionView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');"><i class="fas fa-reply"></i></a><br>';
										}
									} else {
										var enter = /\r\n/g;
										var tempContent = value.rpContent.replace(enter, " ");
										
										tag += '<a title="삭제" class="float-right btn btn btn-info ml-2 delBtn" onclick="questionDelete(' +value.rpId +','+value.gCount+',' +value.rpStep +',' +value.rpIndent +');"><i class="fas fa-eraser"></i></a>';
										tag += '<a title="수정" class="float-right btn btn btn-info ml-2 editBtn" onclick="questionModify('+value.rpId +',\'' +tempContent +'\');"><i class="far fa-edit"></i></a>';
									}
								tag += '</div>';
								tag += '</div>';	//col-md-10
								tag += '</div>';	//row
								tag += '</div>';	//card-body
								tag += '</div>';
							}
						
							var tempTag = '<input type=hidden id="currentPageNum" value=' +page +'>';	
							$("#clCurrentPageNum").html(tempTag);
								
							$(".questionList").append(tag);
							
							$('#clQuestionPageNum_'+page).css("background-color", "#59bfbf");
							$('#clQuestionPageNum_'+page).css("color", "#ffffff");
				        });
					},
					
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
	
// 문의에 대한 답변을 작성하기 위한  view 화면  : 개설자만
function reQuestionView(rpId, rpGroup, rpStep, rpIndent) {
	
	var cn = $('#currentPageNum').val();
	var tag = '';
	var nowTime = getTimeStamp();
	
	function getTimeStamp() {
		var d = new Date();
		var s = leadingZeros(d.getFullYear(), 4) + '-' +
				leadingZeros(d.getMonth() + 1, 2) + '-' +
				leadingZeros(d.getDate(), 2) + ' ' +
					
				leadingZeros(d.getHours(), 2) + ':' +
				leadingZeros(d.getMinutes(), 2) + ':' +
				leadingZeros(d.getSeconds(), 2);
			
				return s;
	}
				
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();
			
			if (n.length < digits) {
				for (i = 0; i < digits - n.length; i++) {
					zero += '0';
				}	
			}
		return zero + n;
	}
				
	tag += '<div class="comment">';
	tag += '<div class="card card-inner">';				//card-inner
	tag += '<div class="card-body">';				// card-body
	tag += '<form name="reQform">';				//form
	tag += '<div class="row">';				//row
	tag += '<div class="col-md-2" align="center">';
	tag += '<img src="' +$('#uProfile').val() +'" alt="userProfile"/>';
	tag += '<div class="commentUser"><b>' +uNickname + '</b></div>';
	tag += '<p class="text-secondary text-center">' +nowTime +'</p>'; 
	tag += '</div>';
								
	tag += '<div class="col-md-10">'; 	       
	tag += '<input type="hidden" name="q_user_id" value=' +userId +'>';
	tag += '<textarea style="resize:none;" class="form-control" type="text" name="reQuestion" placeholder="답변을 입력하세요." rows="5"></textarea>';		
	tag += '<br>';
										
	tag += '<p>';
	tag += '<button class="float-right btn btn btn-info ml-2 cancelBtn" title="취소" type="button" onclick="questionList('+cn +');"><i class="fas fa-times"></i></button>';
	tag += '<button class="float-right btn btn btn-info ml-2 submitBtn" title="답변등록" type="button" onclick="reQuestionWrite('+rpGroup +','+rpStep +','+rpIndent +')"><i class="fas fa-check"></i></button>';	
	tag += '</p>';
	tag += '</div>';	//col-md-10
	
	tag += '</div>';		//row
	tag += '</form>';			//form
	tag += '</div>';				//card-body
	tag += '</div>';
	tag += '</div>';
	
	$('.q_'+rpId).append(tag);
}
	
// 문의에 대한 답변 작성 : 개설자만 
function reQuestionWrite(rpGroup, rpStep, rpIndent) {
	var reQuestion = document.reQform.reQuestion;
	var cn = $('#currentPageNum').val();
				
	if(reQuestion.value == '') {
		alert("내용을 작성해주세요");
		document.reQform.reQuestion.focus();
		return false;
	} else{
		var rpContent = $('[name=reQuestion]').val();
			$.ajax({
				url: getContextPath() + '/question/reQuestionWrite',
				type: 'POST',
				data: {
					'rpContent' : rpContent,
					'rpGroup' : rpGroup,
					'rpStep' : rpStep,
					'rpIndent' : rpIndent,
					'class_id' : cId, 
					'user_id' : $("#userId").val()
				},	
				success: function(data){
					alert("답변이 등록되었습니다.");
					questionCnt();
					questionList(cn);
				},
				error : function(request, status, error) {
					console.log(request.responseText);
					console.log(error);
				}
			});
		}
}
	
// 해당 class강좌에 대해 문의를 작성하는 JS메서드(Ajax-Json) : 개설자, 비로그인 유저를 제외한 유저만 해당
$('[name=qBtn]').click(function(){
	if(!uNickname){
		alert("로그인 해주세요.");
		return false;
	}
				
	var insertData = $('[name=qForm]').serialize();				
	questionWrite(insertData);
});

function questionWrite(insertData) {
	var rpContent = document.qForm.rpContent;
				
	if(rpContent.value == '') {
		alert("문의사항을 작성해주세요");
		document.qForm.rpContent.focus();
		return false;
	} else {
		$.ajax({
			url: getContextPath() + '/question/questionWrite',
			type: 'POST',
			data: insertData,	
			success: function(insertData){
				alert("문의사항이 등록되었습니다.")
				questionCnt();
				questionList();
				$('#cqInputform').val("");
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}
	
// class 강좌문의 수정 view JS메서드(Ajax-Json)
function questionModify(rpId, rpContent){
	var cn = $('#currentPageNum').val();
	
	$('.delBtn').remove();
	$('.editBtn').remove();

	var a ='';
	a += '<div class="commentModify">';
	a += '<textarea rows="4" type="text" name="qContent_' +rpId +'">' +rpContent +'</textarea>';
	a += '<br>';
	a += '<p>';
	a += '<button class="btn btn btn-info ml-2 updateBtn" title="답변수정" type="button" onclick="questionModifyPrc(' +rpId +');"><i class="fas fa-check"></i></button>';
	a += '<button class="btn btn btn-info ml-2 cancelBtn" title="수정취소" type="button" onclick="questionList(' +cn +');"><i class="fas fa-times"></i></button>';
	a += '</p>';
	a += '</div>';
				    
	$('.qContent_'+rpId).html(a);	    
}
	
// class 강좌문의 수정 JS메서드(Ajax-Json)
function questionModifyPrc(rpId) {
	var rpContent = $('[name=qContent_' +rpId +']').val();
	var cn = $('#currentPageNum').val();
	
	if(rpContent == '') {
		alert("내용이 비어있습니다.");
		$('[name=qContent_' +rpId +']').focus();
		return false;
	} else {
		var modify_qContent = $('[name=qContent_'+rpId +']').val();
		
		$.ajax({
			url: getContextPath() + '/question/questionModify',
			type: 'post',
			data: {
				'rpContent' : modify_qContent,
				'rpId' : rpId
			},
			success: function(data){
				questionList(cn);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}
	
// class 강좌문의 삭제 JS메서드(Ajax-Json)
function questionDelete(rpId, gCount, rpStep, rpIndent) {
	var cn = $('#currentPageNum').val();

	if(gCount > 1 && rpStep == 0 && rpIndent == 0) {
		alert("답변이 달린 댓글은 삭제 할 수 없습니다.");	
		return;
	} else {
		if(confirm(rpId +"번 문의를 삭제 하시겠습니까?")){
			$.ajax({
				url: getContextPath() + '/question/questionDelete',
				type: 'post',
				data: {'rpId' : rpId},
				success: function(data){
					questionCnt();
					questionList(cn);
				},
				error : function(request, status, error) {
					console.log(request.responseText);
					console.log(error);
				}
			});
		}
	}
}	
