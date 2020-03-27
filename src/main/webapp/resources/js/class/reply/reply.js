var uNickname = $("#userNickname").val();
var userId = $("#userId").val();
var cId = $('#classId').val();
		
// 해당 class강좌의 문의수를 불러오는 JS메서드(Ajax-Json)
function questionCnt() {
	console.log("cId : " +cId);
	
	$.ajax({
		url: getContextPath() + '/question/questionCount',
		type: 'post',
		data: {'class_id' : cId},
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

function questionPagePrint(rpPageMaker) {
	/* console.log(rpPageMaker);
	console.log('totalCount : ' +rpPageMaker[0]);
	console.log('startPage : ' +rpPageMaker[1]);
	console.log('endPage : ' +rpPageMaker[2]);
	console.log('prev : ' +rpPageMaker[3]);
	console.log('next : ' +rpPageMaker[4]);
	console.log('displayPageNum' +rpPageMaker[5]);
	console.log('tempEndPage' +rpPageMaker[6]);				
	console.log('page : ' +rpPageMaker[7].page);
	console.log('perPageNum : ' +rpPageMaker[7].perPageNum);
	console.log('startNum : ' +rpPageMaker[7].startNum);
	console.log('endNum : ' +rpPageMaker[7].endNum);
	console.log('pageStart : ' +rpPageMaker[7].pageStart); */
	
	// 댓글 페이징 처리를 위한 변수
	var startPage = rpPageMaker[1];
	var endPage = rpPageMaker[2];
	var prev = rpPageMaker[3];
	var next = rpPageMaker[4];
	var tempEndPage = rpPageMaker[6];
	var page = rpPageMaker[7].page;

	var paging = '';
		paging += '<a style="text-decoration: none" href="javascript:questionList(1)">처음으로</a>&nbsp;&nbsp;';
	 
	if(prev){
		paging +='<a style="text-decoration: none" href="javascript:questionList('+(startPage - 1) +')"> « </a>';
	}
		paging += '[&nbsp;';
	
	for(var i = startPage; i <= endPage; i++){
		var strClass = page == i ? 'class="active"' : '';
	 	paging += '<a style="text-decoration: none"'+strClass +'href="javascript:questionList(' +i +')">' +i +'</a>&nbsp;&nbsp;';
	}
		paging += ']&nbsp;&nbsp;';
	 
	if(next){
		paging +='<a style="text-decoration: none" href="javascript:questionList(' +(endPage + 1) +')"> » </a>&nbsp;&nbsp;';
	}
	 
	if(page < tempEndPage){
		paging += '<a style="text-decoration: none" href="javascript:questionList(' +tempEndPage +')">마지막으로</a>';
	}

	$('.questionPaging').html(paging);
}

// 해당 게시글의 댓글들을 출력하는 JS메서드(Ajax-Json)
function questionList(page) {
	var page = Number(page);
	if(isNaN(page)) {
		page = 0;
	}
	
	$.ajax({
		url: getContextPath() + '/question/questionList',
		type: 'post',
		dataType:'json',
		data: {'class_id' : cId,
				'page' : page < 1 ? 1 : page
				},
		success: function(data){
			console.log(data);
			
			// 문의사항 페이징
			var rpPageMaker = Object.values(data["rpPageMaker"]);
			questionPagePrint(rpPageMaker);
			
			// 문의사항 리스트 
			var questionList = Object.values(data["questionList"]);		
			$('.questionList').children().remove();
			
			$.each(questionList, function(key, value){
				var indent = value.rpIndent;
				var re = '';
				
				for(var i = 0; i < indent; i++) {
					re += '└ RE ';
				}
				
				var b = '<div class=q_'+value.rpId +'>';
					b += '<table border="1">';
					b += '<tr>';
					
					b += '<td width="100">';	
					b += value.rpId;
					b += '</td>';

					b += '<td width="300" class="qContent_'+value.rpId +'">';
					b += re;
					b += value.rpContent;
					b += '</td>';
					
					b += '<td width="150">';
					if(value.uNickname == uNickname || value.uNickname == '운영자' || value.uNickname == 'admin2'){
						b += '<a class="userBtn">'+value.uNickname+'</a>';
					} else{
						b += '<div class="dropdown">';
						b += '<a href="#" class="userBtn" id="user_btn_'+value.rpId+value.user_id+'" data-toggle="dropdown">'+value.uNickname+'</a>';
						b += '<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_'+value.rpId+value.user_id+'">';
						b += '<li><a href="#">회원정보</a></li>';
						b += '<li><a onclick="sendMessage('+'\''+value.uNickname+'\','+value.user_id+');">쪽지 보내기</a></li>';
                		b += '<li><a data-toggle="modal" data-target="#report_rp_user_'+value.rpId+value.user_id+'" data-backdrop="static" data-keyboard="false">신고하기</a></li>';
                		b += '</ul></div>';
                		b += '<div class="modal fade" id="report_rp_user_'+value.rpId+value.user_id+'" role="dialog"><div class="modal-dialog"><div class="modal-content">';
                		b += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
               			b += '<h4 class="modal-title">'+value.uNickname+'님 신고</h4></div>';
               			b += '<div class="modal-body">';
               			b += '<form id="declaration_rp_user_'+value.rpId+value.user_id+'" role="formDeclaration_rp_user_'+value.rpId+value.user_id+'" name="dform">'
			            b += '<input type="hidden" name="reporter_id" value="${loginUser.user_id}">';
			            b += '<input type="hidden" name="reported_id" value="'+value.user_id+'">';
			            b += '<div class="form-group"><label for="inputMessage">신고사유</label><br>';
			            b += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">부적절한 홍보 게시글<br>';
			            b += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">음란성 또는 청소년에게 부적합한 내용<br>';
			            b += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">명예훼손/사생활 침해 및 저작권침해등<br>';
			            b += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_'+value.rpId+'.disabled=false">기타<br>';
			            b += '<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etcRp_'+value.rpId+'" name="dReason" disabled></textarea>';
			            b += '</div></form></div>';
			            b += '<div class="modal-footer">';
			            b += '<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reset()">취소</button>';
			            b += '<button type="button" class="btn reportBtn" onclick="reportRpUser('+value.rpId+value.user_id+',\''+value.uNickname+'\');">신고</button>';
			            b += '</div>';
			            b += '</div></div></div>';	
					}
					/* b += '<h4>' +value.uNickname +'</h4>'; */
					b += '<h6>' +value.rpWrittenDate +'</h6>';
					b += '</td>';
					
					b += '<td width="100">';
					if(uNickname != value.uNickname){
						if(uNickname == $("#classUserNickname").val()){
							b += '<a onclick="reQuestionView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');" style="color : blue">[답변]</a><br>';
						}
					}else{
					b += '<a onclick="questionModify('+value.rpId +',\''+value.rpContent+'\');" style="color : blue">[수정] </a>';
					b += '<br>';
					b += '<a onclick="reQuestionView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');" style="color : blue">[댓글]</a>';
					b += '<br>';
					b += '<a onclick="questionDelete(' +value.rpId +','+value.gCount+',' +value.rpStep +',' +value.rpIndent +');" style="color : blue">[삭제] </a>';
					}
					b += '</td>';

					b += '</tr>';
					b += '</table>';
					b += '</div>'
				
				$(".questionList").append(b);	
	        });
		},
		
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}

// 문의에 대한 답변을 작성하기 위한  view 화면 불러오는 JS메서드
function reQuestionView(rpId, rpGroup, rpStep, rpIndent) {
	var a = '<div>';
		a += '<form name="reQform">'
		a += '<table border="1">';
		a += '<tr>';
		a += '<td>';
		a += '<input type="hidden" name="q_user_id" value='+userId+'>&nbsp;&nbsp;&nbsp;&nbsp;';
		a += uNickname;
		a += '<input type="button" value="등록" onclick="reQuestionWrite('+rpGroup +','+rpStep +','+rpIndent +')">&nbsp;&nbsp;';
		a += '<button type="button" onclick="questionList();">취소</button>';
		a += '</td>';
		a += '</tr>';
		a += '<tr>';
		a += '<td>';
		a += '<textarea type="text" name="reQuestion" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>';
		a += '</td>';
		a += '</tr>';
		a += '</table>';
		a += '</form>';
		a += '</div>';
	$('.q_'+rpId).append(a);
}

// 문의에 대한 답변 작성 JS메서드(Ajax-Json)
function reQuestionWrite(rpGroup, rpStep, rpIndent) {
	var reQuestion = document.reQform.reQuestion;
	
	if(reQuestion.value == '') {
		alert("내용을 작성해주세요");
		document.reQform.reQuestion.focus();
		return false;
	} else{
		var rpContent = $('[name=reQuestion]').val();
		
		$.ajax({
			url: getContextPath() + '/question/reQuestionWrite',
			type: 'POST',
			data: {'rpContent' : rpContent,
					'rpGroup' : rpGroup,
					'rpStep' : rpStep,
					'rpIndent' : rpIndent,
					'class_id' : cId, 
					'user_id' : $("#userId").val()},	
			success: function(data){
				alert("댓글이 등록되었습니다.")
				questionCnt();
				questionList();
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}

// class강좌문의 버튼눌렀을때 이벤트 JS메서드
$('[name=qBtn]').click(function(){
	if(!uNickname){
		alert("로그인 해주세요.");
		location.href = "/eepp/login/login.do";
		return false;
	}
	
	var insertData = $('[name=qForm]').serialize();				
	questionWrite(insertData);
});

// 해당 class강좌에 대해 문의를 작성하는 JS메서드(Ajax-Json) 
function questionWrite(insertData) {
	var rpContent = document.qForm.rpContent;
	
	if(rpContent.value == '') {
		alert("문의하실 내용을 작성해주세요");
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
    var a ='';
	    a += '<div>';
	    a += '<input type="text" name="qContent_' +rpId +'" value="' +rpContent +'"/>';
	    a += '<button type="button" onclick="questionModifyPrc(' +rpId +');">수정</button>';
		a += '<button type="button" onclick="questionList();">취소</button>';
	    a += '</div>';
    $('.qContent_'+rpId).html(a);	    
}

// class 강좌문의 수정 JS메서드(Ajax-Json)
function questionModifyPrc(rpId) {
	var rpContent = $('[name=qContent_' +rpId +']').val();
	if(rpContent == '') {
		alert("내용이 비어있습니다.");
		$('[name=qContent_' +rpId +']').focus();
		return false;
	} else {
		var modify_qContent = $('[name=qContent_'+rpId +']').val();
		$.ajax({
			url: 'http://localhost:8282/eepp/question/questionModify',
			type: 'post',
			data: {'rpContent' : modify_qContent, 'rpId' : rpId},
			success: function(data){
				questionList();
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
	if(gCount > 1 && rpStep == 0 && rpIndent == 0) {
		alert("답변이 달린 문의글은 삭제 할 수 없습니다.");	
		return;
	} else {
		if(confirm("정말 삭제 하시겠습니까?")){
			$.ajax({
				url: getContextPath() + '/question/questionDelete',
				type: 'post',
				data: {'rpId' : rpId},
				success: function(data){
					questionCnt();
					questionList();
				},
				error : function(request, status, error) {
					console.log(request.responseText);
					console.log(error);
				}
			});
		}
	}	
}