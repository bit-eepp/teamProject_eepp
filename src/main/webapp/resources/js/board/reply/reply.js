
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
					paging += '<a style="text-decoration: none" href="javascript:replyList(1)">처음으로</a>&nbsp;&nbsp;';
				 
				if(prev){
					paging +='<a style="text-decoration: none" href="javascript:replyList('+(startPage - 1) +')"> « </a>';
				}
					paging += '[&nbsp;';
				
				for(var i = startPage; i <= endPage; i++){
					var strClass = page == i ? 'class="active"' : '';
				 	paging += '<a style="text-decoration: none"'+strClass +'href="javascript:replyList(' +i +')">' +i +'</a>&nbsp;&nbsp;';
				}
					paging += ']';
				 
				if(next){
					paging +='<a style="text-decoration: none" href="javascript:replyList(' +(endPage + 1) +')"> » </a>&nbsp;&nbsp;';
				}
				 
				if(page < tempEndPage){
					paging += '<a style="text-decoration: none" href="javascript:replyList(' +tempEndPage +')">마지막으로</a>';
				}
			
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
								
								for(var i = 0; i < indent; i++) {
									re += '└ RE ';
								}

								var b = '<div class=rp_'+value.rpId +'>';
									b += '<table border="1">';
									b += '<tr>';
									
									b += '<td width="100">';	
									b += value.rpId;
									b += '</td>';
									
									b += '<td width="50">';	
									b += value.rpDcount;
									b += '</td>';
									
									b += '<td width="300" class="rpContent_'+value.rpId +'">';
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
									/* b += '<h4>' + value.uNickname +'</h4>'; */
									b += '<h6>' +value.rpWrittenDate +'</h6>';
									b += '</td>';
									
									b += '<td width="100">';
									b += '추천 : <b class="rpLike_' +value.rpId +'">' +value.rpLike +'</b>';
									b += '<br>';
									b += '비추천 : <b class="rpUnlike_' +value.rpId +'">' +value.rpUnlike +'</b>';
									b += '</td>';
									
									b += '<td width="100">';
									if(uNickname == value.uNickname || value.uNickname == isAdmin){
										//자기가 쓴 댓글일 경우 추천, 비추천 불가능
									}else{
									b += '<a onclick="rpLike(' +value.rpId +');" style="color : blue">[추천]</a>';
									b += '<br>';
									b += '<a onclick="rpUnlike('+value.rpId +');" style="color : blue">[비추천] </a>';
									b += '<br>';
									}
									b += '</td>';
									
									b += '<td width="100">';
									if(uNickname != value.uNickname){
									b += '<a onclick="reReplyView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');" style="color : blue">[댓글]</a><br>';
									}else{
									b += '<a onclick="replyModify('+value.rpId +',\''+value.rpContent+'\');" style="color : blue">[수정] </a>';
									b += '<br>';
									b += '<a onclick="reReplyView(' +value.rpId +','+value.rpGroup+','+value.rpStep+','+value.rpIndent +');" style="color : blue">[댓글]</a>'
									b += '<br>';
									b += '<a onclick="replyDelete(' +value.rpId +',' +value.gCount +',' +value.rpStep +',' +value.rpIndent +');" style="color : blue">[삭제] </a>';
									}
									b += '</td>';
									
									// 댓글 신고 부분
										b += '<td width="100" id="rpModalFormBtn">';
										if(uNickname == value.uNickname || value.uNickname == isAdmin){
											//자기가 쓴 댓글일경우 신고버튼 안보임
										}else{
										b += '<button class="btn btn-success btn-lg" data-toggle="modal" data-target="#rpModalForm_' +value.rpId +'" data-backdrop="static" data-keyboard="false">';
										b += '댓글 신고';
										b += '</button>';
										b += '<div class="modal fade" id="rpModalForm_' +value.rpId +'" role="RPdialog">';
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
											b += '<div class="form-group">';
											b += '<label for="inputMessage">신고사유</label><br>';
											b += '<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etcRp_' +value.rpId +'.disabled=true">  부적절한 홍보 게시글<br>';
											b += '<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etcRp_' +value.rpId +'.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>';
											b += '<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etcRp_' +value.rpId +'.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>';
											b += '<input type="radio" name="dReason" value="etc" onclick="this.form.etcRp_' +value.rpId +'.disabled=false">  기타<br>';
											b += '<textarea cols="30" rows="10" class="form-control" id="etcRp_' +value.rpId +'" name="dReason" disabled></textarea>';
											b += '</div>';
											b += '</form>';
										}
										
										b += '</div>';
										b += '<div class="modal-footer">';
										b += '<button type="button" class="btn btn-default" data-dismiss="modal" onclick="rpResetForm(' +value.rpId +')">취소</button>';
										b += '<button type="button" class="btn btn-primary submitBtn" onclick="submitRpDeclarationForm(' +value.rpId +')">신고</button>';
										b += '</div></div></div></div>';
										}
										b += '</td>';
										// 댓글 신고 부분 끝
									
									b += '</tr>';
									b += '</table>';
									b += '</div>'
								
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
						console.log("댓글 추천수 : "+data)
						var a = data;
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
						console.log("댓글 비추천수 : "+data)
						var a = data;
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
				var a = '<div>';
					a += '<form name="Rrpform">'
					a += '<table border="1">';
					a += '<tr>';
					a += '<td>';
					a += '<input type="hidden" name="rp_user_id" value='+userId+'>';
					a += uNickname;
					a += '<input type="button" value="등록" onclick="reReplyWrite('+rpGroup +','+rpStep +','+rpIndent +')">&nbsp;&nbsp;';
					a += '<button type="button" onclick="replyList();">취소</button>';
					a += '</td>';
					a += '</tr>';
					a += '<tr>';
					a += '<td>';
					a += '<textarea type="text" name="rRpContent" placeholder="내용을 입력하세요." rows="5" cols="100"></textarea>';
					a += '</td>';
					a += '</tr>';
					a += '</table>';
					a += '</form>';
					a += '</div>';
				$('.rp_'+rpId).append(a);
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
				if(!uNickname){
					alert("로그인 해주세요.");
					return false;
				}
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
				    a += '<div>';
				    a += '<input type="text" name="rpContent_' +rpId +'" value="' +rpContent +'"/>';
				    a += '<button type="button" onclick="replyModifyPrc(' +rpId +');">수정</button>';
					a += '<button type="button" onclick="replyList();">취소</button>';
				    a += '</div>';
			    $('.rpContent_'+rpId).html(a);	    
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
