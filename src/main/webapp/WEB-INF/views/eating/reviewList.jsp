<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>

		<script>
		var uNickname = $("#userNickname").val();
		var userId = $("#userId").val();
		/* var eId = ${eContentView.eId}; */
		//var eating_id = $("#eContentViewEid").val();
		var eating_id = $('#eId').val();
		
			// 해당 게시물의 댓글수를 불러오는 JS메서드(Ajax-Json)
			function reviewCount(eId) {
				$.ajax({
					url: 'http://localhost:8282/eepp/review/reviewCount',
					type: 'get',
					data: {'eating_id' : eId},
					success: function(data){
						console.log("리뷰 수 : " +data)
						rvCount = data;
						var a = data;
						$('.reviewCount').html(a)
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			function reviewPagePrint(rvPageMaker) {
				console.log(rvPageMaker);
				console.log('totalCount : ' +rvPageMaker[0]);
				console.log('startPage : ' +rvPageMaker[1]);
				console.log('endPage : ' +rvPageMaker[2]);
				console.log('prev : ' +rvPageMaker[3]);
				console.log('next : ' +rvPageMaker[4]);
				console.log('displayPageNum' +rvPageMaker[5]);
				console.log('tempEndPage' +rvPageMaker[6]);				
				console.log('page : ' +rvPageMaker[7].page);
				console.log('perPageNum : ' +rvPageMaker[7].perPageNum);
				console.log('startNum : ' +rvPageMaker[7].startNum);
				console.log('endNum : ' +rvPageMaker[7].endNum);
				console.log('pageStart : ' +rvPageMaker[7].pageStart);
				
				// 댓글 페이징 처리를 위한 변수
				var startPage = rvPageMaker[1];
				var endPage = rvPageMaker[2];
				var prev = rvPageMaker[3];
				var next = rvPageMaker[4];
				var tempEndPage = rvPageMaker[6];
				var page = rvPageMaker[7].page;
			
				var paging = '';
					paging += '<a style="text-decoration: none" href="javascript:reviewList(1)">처음으로</a>&nbsp;&nbsp;';
				 
				if(prev){
					paging +='<a style="text-decoration: none" href="javascript:reviewList('+(startPage - 1) +')"> « </a>';
				}
					paging += '[&nbsp;';
				
				for(var i = startPage; i <= endPage; i++){
					var strClass = page == i ? 'class="active"' : '';
				 	paging += '<a style="text-decoration: none"'+strClass +'href="javascript:reviewList(' +i +')">' +i +'</a>&nbsp;&nbsp;';
				}
					paging += ']';
				 
				if(next){
					paging +='<a style="text-decoration: none" href="javascript:reviewList(' +(endPage + 1) +')"> » </a>&nbsp;&nbsp;';
				}
				 
				if(page < tempEndPage){
					paging += '<a style="text-decoration: none" href="javascript:reviewList(' +tempEndPage +')">마지막으로</a>';
				}
			
				$('.reviewPaging').html(paging);
			}
			
			// 해당 게시글의 댓글들을 출력하는 JS메서드(Ajax-Json)
			function reviewList(page) {
				var page = Number(page);
				if(isNaN(page)) {
					page = 0;
				}
				
				$.ajax({
					url: 'http://localhost:8282/eepp/review/reviewList',
					type: 'GET',
					dataType:'json',
					data: {'eating_id' : eating_id,
							'page' : page < 1 ? 1 : page
							},
					success: function(data){
						console.log(data);
						console.log(data.reviewAVG);
						
						$('.reviewAVG').html(data.reviewAVG);
						// 댓글 페이징
						var rvPageMaker = Object.values(data["rvPageMaker"]);
						reviewPagePrint(rvPageMaker);
						
						// 댓글 리스트 
						var reviewList =  Object.values(data["reviewList"]);
						$('.reviewList').children().remove();
						
						$.each(reviewList, function(key, value){

								var b = '<div class=rv_'+value.rvId +'>';
									b += '<table border="1">';
									b += '<tr>';
									
									b += '<td width="100">';	
									b += value.rvId;
									b += '</td>';
									
									b += '<td width="100">';	
									b += value.rvScore;
									b += '</td>';
									
									b += '<td width="300" class="rvComment_'+value.rvId +'">';
									b += value.rvComment;
									b += '</td>';
									
									b += '<td width="150">';
									b += '<h4>' + value.uNickname +'</h4>';
									b += '<h6>' +value.rvWrittenDate +'</h6>';
									b += '</td>';
									b += '<td width="100">';
									if(uNickname == value.uNickname){
									b += '<a onclick="reviewModify(' +value.rvId +',' +value.rvScore+',\''+value.rvComment+'\');" style="color : blue">[수정] </a>';
									b += '<br>';
									b += '<a onclick="reviewDelete(' +value.rvId +');" style="color : blue">[삭제] </a>';
									}
									b += '</td>';
									b += '</tr>';
									b += '</table>';
									b += '</div>'
									
								$(".reviewList").append(b);	
							
				        });
					},
					error : function(request, status, error) {
						console.log(request.responseText);
						console.log(error);
					}
				});
			}
			
			
			// 댓글 작성 버튼눌렀을때 이벤트 메서드
			$('#reviewBtn').click(function(){
				if(!uNickname){
					alert("로그인 해주세요.");
					return false;
				}
				reviewWrite();
			});
			
			// 해당 게시물에 대해 댓글을 작성하는 JS메서드(Ajax-Json) 
			function reviewWrite() {
				var rvComment = $("#rvComment").val();
				var rvScore = $(".rvScore").val();
				var insertData = $('[name=rvform]').serialize();
				console.log(rvComment)
				console.log(rvScore)
				if(rvComment == '') {
					alert("내용을 작성해주세요");
					document.rvform.rvComment.focus();
					return false;	
				}else if(rvScore == ''){
					alert("평점을 선택해주세요.");
					document.rvform.rvScore.focus();
					return false;
				} else {
					$.ajax({
						url: 'http://localhost:8282/eepp/review/reviewWrite',
						type: 'POST',
						data: insertData,	
						success: function(insertData){
							alert("::리뷰 등록::")
							reviewCount(eating_id);
							reviewList();
							$("#rvComment").val("");
						},
						error : function(request, status, error) {
							console.log(request.responseText);
							console.log(error);
						}
					});
				}
			}
			
			// 댓글 수정 view JS메서드(Ajax-Json)
			function reviewModify(rvId, rvScore, rvComment){
				var a ='';
			    a += '<div class="modifyCommentBox">';
			    a += '<input type="text" name="rvComment_' +rvId +'" value="' +rvComment +'"/>';
			    a += '<input type="text" name="rvScore_'+rvId+'" value="' +rvScore +'"/>';
			    a += '<a class="modifyConfirm" onclick="reviewModifyPrc(' +rvId +');">수정</a>';
				a += '<a class="modifyCancle" onclick="reviewList();">취소</a>';
			    a += '</div>';
		    $('.rvComment_'+rvId).html(a);	  	    
			}
			
			// 댓글 수정 JS메서드(Ajax-Json)
			function reviewModifyPrc(rvId) {
				var rvComment = $('[name=rvComment_' +rvId +']').val();
				var rvScore = $('[name=rvScore_'+rvId+']').val();
				if(rvComment == '') {
					alert("내용이 비어있습니다.");
					$('[name=rvComment_' +rvId +']').focus();
					return false;
				} else {
					var modify_rvContent = $('[name=rvComment_'+rvId +']').val();
					$.ajax({
						url: 'http://localhost:8282/eepp/review/reviewModify',
						type: 'post',
						data: {
							'rvComment' : rvComment,
							'rvId' : rvId,
							'rvScore' : rvScore
							},
						success: function(data){
							reviewList();
						},
						error : function(request, status, error) {
							console.log(request.responseText);
							console.log(error);
						}
					});
				}
			}
			
			// 댓글 삭제 JS메서드(Ajax-Json)
 			function reviewDelete(rvId) {
					if(confirm("정말 삭제 하시겠습니까?")){
						$.ajax({
							url: 'http://localhost:8282/eepp/review/reviewDelete',
							type: 'post',
							data: {'rvId' : rvId},
							success: function(data){
								reviewCount(eating_id);
								reviewList();
							},
							error : function(request, status, error) {
								console.log(request.responseText);
								console.log(error);
							}
						});
					}
					
			}
		</script>
	</head>
	<body>
	
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
	<input type="hidden" id="userId" name="user_id" value="${loginUser.user_id}">

	</body>
</html>