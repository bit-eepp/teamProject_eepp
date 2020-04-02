//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

		var uNickname = $("#userNickname").val();
		var userId = $("#userId").val();
		var bId = $("#contentBid").val();
		var isAdmin = '운영자';

			// 해당 게시물의 댓글수를 불러오는 JS메서드(Ajax-Json)
			function replyCount(bId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/reply/replyCount',
					type: 'get',
					data: {'board_id' : bId},
					success: function(data){
						console.log("댓글수 : " +data)
						rpCount = data;
						var a = data;
						$('.replyCount').html(a)
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			function replyPagePrint(rpPageMaker) {
				
				// 댓글 페이징 처리를 위한 변수
				var startPage = rpPageMaker[1];
				var endPage = rpPageMaker[2];
				var prev = rpPageMaker[3];
				var next = rpPageMaker[4];
				var tempEndPage = rpPageMaker[6];
				var page = rpPageMaker[7].page;
			
				var paging = '';
				paging += '<div class="replyListpaging">';
				paging += '<ul class="pagination">';

//				if(prev){
					paging += '<li class="page-item">';
					paging += '<a class="page-link" href="javascript:replyList('+(startPage - 1) +')">';
					paging += '<i class="fas fa-angle-left"></i>';
					paging += '</a>';
					paging += '</li>';
//				}
				
				for(var i = startPage; i <= endPage; i++){
					paging += '<li class="page-item pageNum">';
					paging += '<a class="page-link" href="javascript:replyList(' +i +')">' + i +'</a>';
					paging += '</li>';
				}
				 
//				if(next){
					paging += '<li class="page-item">';
					paging += '<a class="page-link" href="javascript:replyList('+(endPage + 1) +')">';
					paging += '<i class="fas fa-angle-right"></i>';
					paging += '</a>';
					paging += '</li>';
//				}
				
				paging += '</ul>';
				paging += '</div>';
			
				$('.replyPaging').html(paging);
			}

			// 해당 게시글의 댓글들을 출력하는 JS메서드(Ajax-Json)
			function replyList(page) {
				var page = Number(page);
				if(isNaN(page)) {
					page = 0;
				}
				
				$.ajax({
					url: 'http://localhost:8282/eepp/reply/replyList',
					type: 'GET',
					dataType:'json',
					data: {'board_id' : bId,
							'page' : page < 1 ? 1 : page
							},
					success: function(data){
						console.log(data);
						
						// 댓글 페이징
						var rpPageMaker = Object.values(data["rpPageMaker"]);
						replyPagePrint(rpPageMaker);
						
						// 댓글 리스트 
						var rpList =  Object.values(data["replyList"]);
						$('.replyList').children().remove();
						
						$.each(rpList, function(key, value){
							var rpDcount = value.rpDcount;
							
							if(rpDcount >= 10) {
								
							} else {
								var indent = value.rpIndent;
								var re = '';
								var b = '';
								
								if(indent != 0){
									b += '<div class="rp_'+value.rpId +' replyBoxWrapper reReplyBox">';
									b += '<div class="rpContent_'+value.rpId +' rpMain">';
									re += '<p class="isReply">';
									for(var i = 0; i < indent; i++) {
										re += '└';
									}
									re += '</p>';
									b += re;
								}else{
									b += '<div class="rp_'+value.rpId +' replyBoxWrapper">';
									b += '<div class="rpContent_'+value.rpId +' rpMain">';
								}
									b += '<div class="wrapper">';
									b += '<div class="replyWriter">';
									if(value.uNickname == uNickname || value.uNickname == '운영자' || value.uNickname == 'admin2'){
										b += '<a class="userBtn myUserBtn">'+value.uNickname+'</a>';
									} else{
										b += '<div class="dropdown">';
										b += '<a href="#" class="userBtn" id="user_btn_'+value.rpId+value.user_id+'" data-toggle="dropdown">'+value.uNickname+'</a>';
										b += '<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_'+value.rpId+value.user_id+'">';
										b += '<li><a href="#">회원정보</a></li>';
										b += '<li><a onclick="sendMessage('+'\''+value.uNickname+'\','+value.user_id+');">쪽지 보내기</a></li>';
				                		b += '<li><a data-toggle="modal" data-target="#report_rp_user_'+value.rpId+value.user_id+'" data-backdrop="static" data-keyboard="false">신고하기</a></li>';
				                		b += '</ul></div>';
				                		b += '<div class="modal fade reportModalBox" id="report_rp_user_'+value.rpId+value.user_id+'" role="dialog"><div class="modal-dialog"><div class="modal-content">';
				                		b += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
				               			b += '<h4 class="modal-title">'+value.uNickname+'님 신고</h4></div>';
				               			b += '<div class="modal-body">';
				               			b += '<form id="declaration_rp_user_'+value.rpId+value.user_id+'" role="formDeclaration_rp_user_'+value.rpId+value.user_id+'" name="dform">'
							            b += '<input type="hidden" name="reporter_id" value="${loginUser.user_id}">';
							            b += '<input type="hidden" name="reported_id" value="'+value.user_id+'">';
							            b += '<p class="reportBoxIcon"><img src="'+getContextPath()+'/img/reportBoxIcon.png"></p>';
							            b += '<div class="form-group">';
							            b += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">부적절한 홍보 게시글<br>';
							            b += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">음란성 또는 청소년에게 부적합한 내용<br>';
							            b += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_'+value.rpId+'.disabled=true">명예훼손/사생활 침해 및 저작권침해등<br>';
							            b += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_'+value.rpId+'.disabled=false">기타<br>';
							            b += '<textarea class="form-control" id="etcRp_'+value.rpId+'" name="dReason" disabled></textarea>';
							            b += '</div></form></div>';
							            b += '<div class="modal-footer">';
							            b += '<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reset()">취소</button>';
							            b += '<button type="button" class="btn reportBtn" onclick="reportRpUser('+value.rpId+value.user_id+',\''+value.uNickname+'\');">신고</button>';
							            b += '</div>';
							            b += '</div></div></div>';	
									}
									b += '</div>';
									//replyWriter
									b += '<div class="rpContentInner_'+value.rpId+' rpContentInner_">';
									b += value.rpContent;
									b += '</div>';
									b += '</div>';
									//wrapper
									b += '</div>';
									
									b += '<div class="replyDate">';
									b += '<p class="reWrittenDate">' +value.rpWrittenDate +'</p>';
									b += '<div class="replyActive">';
									if(uNickname != value.uNickname){
										b += '<p class="reReplyBtn"><a onclick="reReplyView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');">답댓글</a></p>';
										// 댓글 신고 부분
										b += '<p class="reReportBtn" id="rpModalFormBtn">';
										if(uNickname == value.uNickname || value.uNickname == isAdmin){
										}else{
										b += '<a data-toggle="modal" data-target="#rpModalForm_' +value.rpId +'" data-backdrop="static" data-keyboard="false">';
										b += '신고';
										b += '</a>';
										b += '<div class="modal fade reportModalBox" id="rpModalForm_' +value.rpId +'" role="RPdialog">';
										b += '<div class="modal-dialog">';
										b += '<div class="modal-content">';
										b += '<div class="modal-header">';
										b += '<button type="button" class="close" data-dismiss="modal">';
										b += '<span aria-hidden="true">&times;</span>';
										b += '<span class="sr-only">Close</span>';
										b += '</button>';
										b += '<h4 class="modal-title" id="RpMyModalLabel_' +value.rpId +'">#' +value.rpId +'번 댓글 신고</h4>';
										b += '</div>';
										b += '<div class="modal-body">';
										b += '<p class="statusMsg"></p>';
										
										if(!$("#userNickname").val()){
											b += '<h3>해당 댓글 신고를 원하시면 로그인 해주세요.</h3>'
										}else{
											b += '<form id="rpDeclaration_' +value.rpId +'" role="formRpDeclaration_' +value.rpId +'" name="rpDform_' +value.rpId +'">';
											b += '<input type="hidden" name="reporter_id" value=' +userId +'>';
											b += '<input type="hidden" name="reply_id" value=' +value.rpId +'>';
											b += '<p class="reportBoxIcon"><img src="'+getContextPath()+'/img/reportBoxIcon.png"></p>';
											b += '<div class="form-group">';
											b += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_' +value.rpId +'.disabled=true">  부적절한 홍보 게시글<br>';
											b += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_' +value.rpId +'.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>';
											b += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_' +value.rpId +'.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>';
											b += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_' +value.rpId +'.disabled=false">  기타<br>';
											b += '<textarea class="form-control" id="etcRp_' +value.rpId +'" name="dReason" disabled></textarea>';
											b += '</div>';
											b += '</form>';
										}
										
										b += '</div>';
										b += '<div class="modal-footer">';
										b += '<button type="button" class="btn btn-default" data-dismiss="modal" onclick="rpResetForm(' +value.rpId +')">취소</button>';
										b += '<button type="button" class="btn btn-primary submitBtn" onclick="submitRpDeclarationForm(' +value.rpId +')">신고</button>';
										b += '</div></div></div></div>';
										}
										// 댓글 신고 부분 끝
										}else{
										b += '<p class="reReplyBtn"><a onclick="reReplyView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');">답댓글</a></p>'
										b += '<p class="reModifyBtn"><a onclick="replyModify('+value.rpId +',\''+value.rpContent +'\');">수정</a></p>';
										b += '<p class="reDeleteBtn"><a onclick="replyDelete(' +value.rpId +',' +value.gCount +',' +value.rpStep +',' +value.rpIndent +');">삭제</a></p>';
										}
									b += '</div>';
									// replyActive
									b += '</div>';

									b += '<div class="replyInfo">';
									b += '<p class="infoIncon rpLike_'+value.rpId+' reLike">';
									if(uNickname == value.uNickname || value.uNickname == isAdmin){
										//자기가 쓴 댓글일 경우 추천, 비추천 불가능
										b += '<i class="far fa-thumbs-up"></i> '+value.rpLike
									}else{
										b += '<a onclick="rpLike(' +value.rpId +');">';
										b += '<i class="far fa-thumbs-up"></i> '+value.rpLike;
										b += '</a>';
									}
									b += '</p>';
									
									b += '<p class="infoIncon rpUnlike_'+value.rpId+' reUnlike">';
									if(uNickname == value.uNickname || value.uNickname == isAdmin){
										//자기가 쓴 댓글일 경우 추천, 비추천 불가능
										b += '<i class="far fa-thumbs-down"></i> '+value.rpUnlike
									}else{
										b += '<a onclick="rpUnlike(' +value.rpId +');">';
										b += '<i class="far fa-thumbs-down"></i> '+value.rpUnlike;
										b += '</a>';
									}
									b += '</p>';
									b += '</div>';
									//replyInfo
											
									b += '</div>';
									b += '<div class="rRp_'+value.rpId+'"></div>';
									// replyWrapper
								
								$(".replyList").append(b);	
							}
				        });
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			// 해당 댓글의 추천개수 불러오는 JS메서드(Ajax-Json)
			function rplikeCount(rpId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/rplikeCount',
					type: 'get',
					data: {'rpId' : rpId},
					success: function(data){
						var a = '<i class="far fa-thumbs-up"></i> '+data;
						$('.rpLike_'+rpId).html(a);
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			// 해당 댓글의 추천수 올리는 JS메서드(Ajax-Json)
			function rpLike(rpId) {
				if(!uNickname){
					alert("로그인 해주세요.");
				}else{
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/rplikeUp',
					type: 'get',
					data: {'rpId' : rpId,
						'user_id' : $("#userId").val()
						},
					success: function(data){
						if (data == 0) {
							alert(rpId + "번 댓글을 추천하셨습니다.");
						} else if (data != 0) {
							alert("추천은 한번만 가능합니다.");
						}
						rplikeCount(rpId);
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
				}
			}
			
			// 해당 댓글의 비추천수 불러오는 JS메서드(Ajax-Json)
			function rpUnlikeCount(rpId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/rpUnlikeCount',
					type: 'get',
					data: {'rpId' : rpId},
					success: function(data){
						var a = '<i class="far fa-thumbs-down"></i> '+data;
						$('.rpUnlike_'+rpId).html(a);
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			// 해당댓글의 비추천수를 올리는 JS메서드(Ajax-Json)
			function rpUnlike(rpId) {
				if(!uNickname){
					alert("로그인 해주세요.");
				}else{
				$.ajax({
					url: 'http://localhost:8282/eepp/recommend/rpUnlikeUp',
					type: 'get',
					data: {'rpId' : rpId,
						'user_id' : $("#userId").val()
						},
					success: function(data){
						if (data == 0) {
							alert(rpId + "번 댓글을 비추천하셨습니다.");
						} else if (data != 0) {
							alert("비추천은 한번만 가능합니다.");
						}
						rpUnlikeCount(rpId);
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
				}
			}
			
			// 대댓글을 작성하기 위한  view 화면 불러오는 JS메서드
			function reReplyView(rpId, rpGroup, rpStep, rpIndent) {
				if(!uNickname){
					alert("로그인 해주세요.");
				}else{
				var a = '<div class="rRpWrapper">';
					a += '<form name="Rrpform">'
					a += '<div class="rRpInner">';
					a += '<input type="hidden" name="rp_user_id" value='+userId+'>';
					a += '<p class="rRpWriter">'+uNickname+'</p>';
					a += '<textarea class="rRpContent" name="rRpContent" placeholder="내용을 입력하세요."></textarea>';
					a += '</div>';
					a += '<div class="rRpBtnWrap">';
					a += '<a class="rRpWrite" onclick="reReplyWrite('+rpGroup +','+rpStep +','+rpIndent +')">등록</a>';
					a += '<a onclick="replyList();">취소</a>';
					a += '</div>';
					a += '</form>';
					a += '</div>';
				$('.rRp_'+rpId).append(a);
			}
			}
			
			// 대댓글 작성 JS메서드(Ajax-Json)
			function reReplyWrite(rpGroup, rpStep, rpIndent) {
				var rRpContent = document.Rrpform.rRpContent;
				
				if(rRpContent.value == '') {
					alert("내용을 작성해주세요");
					document.Rrpform.rRpContent.focus();
					return false;
				} else{
					var rpContent = $('[name=rRpContent]').val();
					
					$.ajax({
						url: 'http://localhost:8282/eepp/reply/reReplyWrite',
						type: 'POST',
						data: {'rpContent' : rpContent,
								'rpGroup' : rpGroup,
								'rpStep' : rpStep,
								'rpIndent' : rpIndent,
								'board_id' : bId, 
								'user_id' : $("#userId").val()},	
						success: function(data){
							alert("댓글이 등록되었습니다.")
							replyCount(bId);
							replyList();
						},
						error : function(request, status, error) {
							console.log(request.responseText);
							console.log(error);
						}
					});
				}
			}

			// 댓글 작성 버튼눌렀을때 이벤트 메서드
			$('[name=replyBtn]').click(function(){
				var insertData = $('[name=rpform]').serialize();				
				replyWrite(insertData);
			});
			
			// 댓글 작성 버튼눌렀을때 이벤트 메서드
			$('#replyBtn').click(function(){
				var insertData = $('[name=rpform]').serialize();				
				replyWrite(insertData);
			});
			
			// 해당 게시물에 대해 댓글을 작성하는 JS메서드(Ajax-Json) 
			function replyWrite(insertData) {
				var rpContent = document.rpform.rpContent;
				
				if(rpContent.value == '') {
					alert("내용을 작성해주세요");
					document.rpform.rpContent.focus();
					return false;
				} else {
					$.ajax({
						url: 'http://localhost:8282/eepp/reply/replyWrite',
						type: 'POST',
						data: insertData,	
						success: function(insertData){
							alert("댓글이 등록되었습니다.")
							replyCount(bId);
							replyList();
						},
						error : function(request, status, error) {
							console.log(request.responseText);
							console.log(error);
						}
					});
				}
			}
			
			// 댓글 수정 view JS메서드(Ajax-Json)
			function replyModify(rpId, rpContent){
			    var a ='';
				    a += '<div class="modifyContentBox">';
				    a += '<input type="text" name="rpContent_' +rpId +'" value="' +rpContent +'"/>';
				    a += '<a class="modifyConfirm" onclick="replyModifyPrc(' +rpId +');">수정</a>';
					a += '<a class="modifyCancle" onclick="replyList();">취소</a>';
				    a += '</div>';
			    $('.rpContentInner_'+rpId).html(a);	    
			}
			
			// 댓글 수정 JS메서드(Ajax-Json)
			function replyModifyPrc(rpId) {
				var rpContent = $('[name=rpContent_' +rpId +']').val();
				if(rpContent == '') {
					alert("내용이 비어있습니다.");
					$('[name=rpContent_' +rpId +']').focus();
					return false;
				} else {
					var modify_rpContent = $('[name=rpContent_'+rpId +']').val();
					$.ajax({
						url: 'http://localhost:8282/eepp/reply/replyModify',
						type: 'post',
						data: {'rpContent' : modify_rpContent, 'rpId' : rpId},
						success: function(data){
							replyList();
						},
						error : function(request, status, error) {
							console.log(request.responseText);
							console.log(error);
						}
					});
				}
			}
			
			// 댓글 삭제 JS메서드(Ajax-Json)
 			function replyDelete(rpId, gCount, rpStep, rpIndent) {
				if(gCount > 1 && rpStep == 0 && rpIndent == 0) {
					alert("대댓글이 달린 댓글은 삭제 할 수 없습니다.");	
					return;
				} else {
					if(confirm("정말 삭제 하시겠습니까?")){
						$.ajax({
							url: 'http://localhost:8282/eepp/reply/replyDelete',
							type: 'post',
							data: {'rpId' : rpId},
							success: function(data){
								replyCount(bId);
								replyList();
							},
							error : function(request, status, error) {
								console.log(request.responseText);
								console.log(error);
							}
						});
					}
				}	
			}
