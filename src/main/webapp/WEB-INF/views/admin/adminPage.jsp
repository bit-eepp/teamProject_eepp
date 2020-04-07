<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>관리자 페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<style>
	
	*{
		font-size:14px;
		Padding-top : 160px;
	}
	.chanagebtn{
		display: inline-block;
	}
</style>
</head>
<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
		
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
	<input type="hidden" id="MemberMakerTotalCount" value="${MemberPageMaker.totalCount}">
	<input type="hidden" id="MemberCriPage" value="${MemberPageMaker.cri.page}">
	<input type="hidden" id="MemberMakeQuery" value="${MemberPageMaker.makeQuery(1)}">
	 
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<br>
			<div class="container">
				<br>
				<br>
				<div class="row">
					<div class="col-sm-4">
						<table class="text-wrap">
						<tr>
							<td class="text_bold"><span class="required">• </span>회원 현황</td>
						</tr>
						<tr class="bordered">
							<td><a href="#mpPoBtn">${map.MemberListCount} 명</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>컨텐츠 현황</td>
							</tr>
							
							<tr class="bordered">
							<td>
								<a href="${pageContext.request.contextPath}/board/boardList" target="_blank" class= "b_all"><b>전체 - ${map.BListALL} 개</b></a><br>
								<a href="${pageContext.request.contextPath}/board/boardList?&bCategory=it_dev" target="_blank">IT / 개발 - ${map.BListIT} 개 </a><br>
								<a href="${pageContext.request.contextPath}/board/boardList?&bCategory=service" target="_blank">서비스 - ${map.BListService} 개</a><br>
								<a href="${pageContext.request.contextPath}/board/boardList?&bCategory=finance" target="_blank">금융 - ${map.BListFinancial} 개</a><br>
								<a href="${pageContext.request.contextPath}/board/boardList?&bCategory=design" target="_blank">디자인 - ${map.BListDesign} 개</a><br>
								<a href="${pageContext.request.contextPath}/board/boardList?&bCategory=official" target="_blank">공무원 - ${map.BListOfficer} 개</a><br>
								<a href="${pageContext.request.contextPath}/board/boardList?&bCategory=etc" target="_blank">기타 - ${map.BListEtc} 개</a><br>
							</td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>클래스 현황</td>
							</tr>
							
							<tr class="bordered">
							<td>
								<div class="content_count">
								<a href="${pageContext.request.contextPath}/class/classList" target="_blank" class="c_all"><b>전체 - ${map.CListALL} 개</b><br></a>
								<a href="${pageContext.request.contextPath}/class/classList?&cCategory=it_dev" target="_blank">IT/개발 - ${map.CListIt_dev} 개<br></a>
								<a href="${pageContext.request.contextPath}/class/classList?&cCategory=workSkill" target="_blank">업무스킬 - ${map.CListEtc} 개<br></a>
								<a href="${pageContext.request.contextPath}/class/classList?&cCategory=financialTechnology" target="_blank">재테크 - ${map.CListWorkSkill} 개</a><br>
								<a href="${pageContext.request.contextPath}/class/classList?&cCategory=daily" target="_blank">일상 - ${map.CListFinacialTech} 개</a><br>
								<a href="${pageContext.request.contextPath}/class/classList?&cCategory=etc" target="_blank">기타 - ${map.CListDaily} 개<br></a>
								</div>
							</td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>신고 현황</td>
							</tr>
							
							<tr class="bordered">
							<td><div class="scrap_count"><a href="#mpScBtn">유저 - &nbsp;${map.UserReportListCount}건 <br> 
																			게시글 - &nbsp;${map.UserReportListCount}건 <br>
																			댓글 - &nbsp;${map.ReplyReportCount}건</a></div></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 쪽지</td>
							</tr>
							
							<tr class="bordered">
							<td class="liwrap" value="open_message" style="cursor:pointer" onclick="openMsg();">받은
								쪽지 ${map.messageRes}&nbsp;&nbsp;&nbsp;&nbsp;보낸 쪽지 ${map.messageSen}</td>
							</tr>
							
						</table>

					</div><!-- col-sm-4 -->

					<div class="col-sm-8">
						<div class="myNotice-wrap">
							<h3 id="mpNoBtn">공지사항</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="mynoticebtn" onclick = "location.href = '/eepp/board/writeView'; ">공지 작성</button>
							</div>
							<p>'EE'에서 작성하신 공지사항을 확인 할 수 있습니다.</p>
							<br>
							<br>

							<div class="notice_list">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>글 번호</th>
											<th>카테고리</th>
											<th>말머리</th>
											<th>글 제목</th>
											<th>작성일</th>
											<th>조회수</th>
											<th>추천/비추천</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(map.noticeList) > 0 }">
											<c:forEach items="${map.noticeList}" var="vo">
												<tr class="boardList_tr">
													<td>${vo.bId}</td>
													<td>${vo.bCategory}</td>
													<td>${vo.bSubject}</td>
													<td class="Title"><c:choose>
															<c:when test="${vo.dCount > 10}">${vo.bTitle}</c:when>
															<c:otherwise>
																<a style="text-decoration: none"
																	href="/eepp/board/contentView?${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${vo.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}&board=yes">
																	${vo.bTitle} [${vo.rpCount}]</a>
															</c:otherwise>
														</c:choose></td>

													<td>${vo.bWrittenDate}</td>
													<td>${vo.bHit}</td>
													<td>${vo.bLike}//${vo.bUnlike}</td>
												</tr>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<tr>
												<td colspan="9">조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
									<!-- </div> -->
								</table>
								<br>
									<!-- 페이징 시작 -->
								<div class="boardpaging">
										<ul class="pagination justify-content-center">
											<li class="page-item">
													<a class="page-link" href="adminPage${NoticePageMaker.makeQuery(NoticePageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${NoticePageMaker.startPage}" end="${NoticePageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id ="boardpaging_${idx}" class="page-link" href="adminPage${NoticePageMaker.makeQuery(idx)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="adminPage${NoticePageMaker.makeQuery(NoticePageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
									<br>
								</div><!-- paging -->
							</div>
						</div>
						
						<div class="myReport-wrap">
							<h3 id="mpReBtn">신고 목록</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="myReportbtn">확인</button>
							</div>
							<p>'EE'에서 신고 리스트를 확인 할 수 있습니다.</p>
							<br>
							<br>

							<div class="Report_list">
								<div class="col">
			<nav>
				  <div class="nav nav-tabs" id="nav-tab" role="tablist">
				    <a class="nav-item nav-link active" id="nav-user-tab" data-toggle="tab" href="#report_user" role="tab" aria-controls="nav-user" aria-selected="true">유저 신고</a>
				    <a class="nav-item nav-link" id="nav-board-tab" data-toggle="tab" href="#report_board" role="tab" aria-controls="nav-board" aria-selected="false">게시글 신고</a>
				    <a class="nav-item nav-link" id="nav-reply-tab" data-toggle="tab" href="#report_reply" role="tab" aria-controls="nav-reply" aria-selected="false">댓글 신고</a>
				  </div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
			  <div class="tab-pane fade show active" id="report_user" role="tabpanel" aria-labelledby="nav-user-tab">
		<!--  게시판 스크랩 -->
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<!-- <th> <input type="checkbox" class="allCheck"></th> -->
											<th>신고 번호</th>
											<th>신고인</th>
											<th>피신고인</th>
											<th>신고 이유</th>
											<th>신고일자</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(map.UserReportList) > 0 }">
											<c:forEach items="${map.UserReportList}" var="URL">
												<tr class="scrapList_tr">
													<!--  신고 목록 선택 -->
													<%-- <td><input type="checkbox" name="pickCheck" class="pickCheck" value="${URL.dId}" /></td> --%>
													<td>${URL.dId}</td>
													<td class="Title">${URL.reporter_nick}</td>
													<td class="Title">${URL.reported_nick}</td>
													<td class="RTitle">${URL.dReason}</td>
													<td><fmt:formatDate value="${URL.dDate}" pattern="yyyy/MM/dd HH:mm"/></td>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<tr>
												<td colspan="9">조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</table>
								<!-- <div class="delbtn"> <button type="button" id="selectDeleteBtn1" class="btn btn-submit">삭제</button> </div>	 -->
									
								<div class="URLP">
										   <ul class="pagination justify-content-center">
										      <li class="page-item">
													<a class="page-link"href="adminPage${UserReportPageMaker.makeQuery(UserReportPageMaker.startPage - 1)}&URL=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${UserReportPageMaker.startPage}" end="${UserReportPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="URLP_${idx}" class="page-link" href="adminPage${UserReportPageMaker.makeQuery(idx)}&URL=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="adminPage${UserReportPageMaker.makeQuery(UserReportPageMaker.endPage + 1)}&URL=yes">
														<i class="fas fa-angle-right"></i>
													</a>
											</li>
										</ul>
									<br>
								</div><!-- paging -->
  						</div><!-- class="tab-pane fade show active" -->
  						
		<!--  게시글 신고 -->
		  	<div class="tab-pane fade" id="report_board" role="tabpanel" aria-labelledby="nav-board-tab">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<!-- <th> <input type="checkbox" class="allCheck1"></th> -->
											<th>신고 번호</th>
											<th>신고인</th>
											<th>신고 게시물</th>
											<th>신고 이유</th>
											<th>신고 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(map.BoardReportList) > 0 }">
											<c:forEach items="${map.BoardReportList}" var="BRL">
												<tr class="scrapCList_tr">
													<%-- <td><input type="checkbox" name="pickCheck1" class="pickCheck1" value="${BRL.dId}" /></td> --%>
													<td>${BRL.dId}</td>
													<td class="Title">${BRL.reporter_nick}</td>
													<td class="Title"><a style="text-decoration: none"
														href="/eepp/board/contentView?bId=${BRL.board_id}&searchType=&keyword=&sortType=&bCategory=">${BRL.board_id}</a></td>
													<td class="RTitle">${BRL.dReason}</td>
													<td><fmt:formatDate value="${BRL.dDate}" pattern="yyyy/MM/dd HH:mm"/></td>
													
												</tr>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<tr>
												<td colspan="9">조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</table>
								<div class="delbtn"> <button type="button" id="selectDeleteBtn1" class="btn btn-submit">삭제</button> </div>
									<div class="BRLP">
										   <ul class="pagination justify-content-center">
										      <li class="page-item">
													<a class="page-link"href="adminPage${BoardReportPageMaker.makeQuery(BoardReportPageMaker.startPage - 1)}}&scrap=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${BoardReportPageMaker.startPage}" end="${BoardReportPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="BRLP_${idx}" class="page-link" href="adminPage${BoardReportPageMaker.makeQuery(idx)}&scrap=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="adminPage${BoardReportPageMaker.makeQuery(BoardReportPageMaker.endPage + 1)}&scrap=yes">
														<i class="fas fa-angle-right"></i>
													</a>
											</li>
										</ul>
									<br>
								</div><!-- paging -->
  						</div><!-- class="tab-pane fade show active" -->
  						
		<!--  eating 스크랩 -->
		  	<div class="tab-pane fade" id="report_reply" role="tabpanel" aria-labelledby="nav-reply-tab">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<!-- <th> <input type="checkbox" class="allCheck2"></th> -->
											<th>신고 번호</th>
											<th>신고인</th>
											<th>신고 댓글</th>
											<th>신고 이유</th>
											<th>신고 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(map.ReplyReportList) > 0 }">
											<c:forEach items="${map.ReplyReportList}" var="RRL">
												<tr class="scrapEList_tr">
													<%-- <td><input type="checkbox" name="pickCheck1" class="pickCheck1" value="${RRL.dId}" /></td> --%>
													<td>${RRL.dId}</td>
													<td class="Title">${RRL.reporter_nick}</td>
													<td class="Title">${RRL.rpContent}</td>
													<td class="RTitle">${RRL.dReason}</td>
													<td><fmt:formatDate value="${RRL.dDate}" pattern="yyyy/MM/dd HH:mm"/></td>
												</tr>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<tr>
												<td colspan="9">조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</table>
						<div class="delbtn"> <button type="button" id="selectDeleteBtn1" class="btn btn-submit">삭제</button> </div>
								
									<div class="RRLP">
										   <ul class="pagination justify-content-center">
										      <li class="page-item">
													<a class="page-link"href="adminPage${ReplyReportPageMaker.makeQuery(ReplyReportPageMaker.startPage - 1)}&scrap=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${ReplyReportPageMaker.startPage}" end="${ReplyReportPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="RRLP_${idx}" class="page-link" href="adminPage${ReplyReportPageMaker.makeQuery(idx)}&scrap=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="adminPage${ReplyReportPageMaker.makeQuery(ReplyReportPageMaker.endPage + 1)}&scrap=yes">
														<i class="fas fa-angle-right"></i>
													</a>
											</li>
										</ul>
									<br>
								</div><!-- paging -->
								
  						</div><!-- class="tab-pane fade show active" -->
					</div><!-- class="tab-content" id="nav-tabContent" -->
				</div><!-- col -->
				</div>
			</div>
			<!-- 회원관리 -->	
			<div class="myinfo-wrap">
					<h3 id="mpMemBtn">회원 목록</h3>
						<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="mycontentbtn">확인</button>
							</div>
							<p>'EE'에 가입하신 회원들을 확인 할 수 있습니다.</p>
							<br>
							<br>

							<div class="member_list">
								<br>
								<!-- 검색 부분  -->
								<div class="search">
									<select name="searchType" class="selectSearchType">
										<option value="n"
											<c:out value="${memcri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
										<option value="k"
											<c:out value="${memcri.searchType eq 'k' ? 'selected' : ''}"/>>닉네임</option>
										<option value="g"
											<c:out value="${memcri.searchType eq 'g' ? 'selected' : ''}"/>>등급</option>
										<option value="i"
											<c:out value="${memcri.searchType eq 'i' ? 'selected' : ''}"/>>유저번호</option>
										<option value="in"
											<c:out value="${memcri.searchType eq 'in' ? 'selected' : ''}"/>>유저번호+닉네임</option>
									</select>
									
									<div class="input-group md-form form-sm form-2 pl-0">
									<input class="form-control my-0 py-1 amber-border" type="text"placeholder="검색어" aria-label="Search" name="keyword1" id="keywordInput1" value="${memcri.keyword}">
										<a id="searchBtn1">
										<span class="input-group-text lighten-3" id="basic-text2"><i class="fas fa-search" aria-hidden="true"></i></span>
										</a>
									</div>
								</div>
								<!-- 검색 부분 끝  -->
								<br>
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th> <input type="checkbox" class="allCheck3"></th>
											<th>유저 번호</th>
											<th>닉네임</th>
											<th>등급</th>
											<th>이메일</th>
											<th>가입일</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(map.MemberList) > 0 }">
											<c:forEach items="${map.MemberList}" var="ML">
												<tr class="boardList_tr">
													<td><input type="checkbox" name="pickCheck3" class="pickCheck3" value="${ML.user_id}" /></td>
													<td>${ML.user_id}</td>
													<td style="color:#000; cursor: pointer;"><a onclick="memberInfo('${ML.uNickname}','${ML.user_id}');">${ML.uNickname}</a></td>
													<td>
													<c:choose>
													  	<c:when test = "${ML.grade_Id == 2}">정회원</c:when>
													  	<c:when test = "${ML.grade_Id == 3}">정지회원</c:when>
													  	<c:when test = "${ML.grade_Id == 4}">탈퇴회원</c:when>
													  	<c:otherwise>운영자</c:otherwise>
													</c:choose>
													</td>
													<td>${ML.uEmail}</td>
													<td>${ML.uJoinDate}</td>
												</tr>
											</c:forEach>
										</c:when>

										<c:otherwise>
											<tr>
												<td colspan="9">조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
									<!-- </div> -->
								</table>
									<select name="selectgrade" class="selectgrade">
									  <option value="selgrade"selected="selected">등급변경</option>
									  <option value="2">정회원</option>
									  <option value="3">정지회원</option>
									  <option value="4">탈퇴회원</option>
									  <option value="1">운영자</option>
									</select>
								<div class="chanagebtn"> <button type="button"class="btn btn-submit" onclick="changeGrade();">변경</button> </div>	
								<br>
									<!-- 페이징 시작 -->
									
								<div class="boardpaging">
										<ul class="pagination justify-content-center">
											<li class="page-item">
													<a class="page-link" href="adminPage${MemberPageMaker.makeSearch(MemberPageMaker.startPage - 1)}&board=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${MemberPageMaker.startPage}" end="${MemberPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id ="boardpaging_${idx}" class="page-link" href="adminPage${MemberPageMaker.makeSearch(idx)}&board=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="adminPage${MemberPageMaker.makeSearch(MemberPageMaker.endPage + 1)}&board=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
									
									<br>
								</div><!-- paging -->
							</div>
						</div>			
						
						
					</div><!-- col-sm-8 -->
				</div><!-- row -->
			</div><!-- container -->
	<br>
		</c:when>
		<c:otherwise>
			<!-- 로그인 전 -->
			<h3>please login</h3>
			<button type="button" onclick="location.href='login/login.do'">로그인</button>

		</c:otherwise>
	</c:choose>
	<%-- <script src="${pageContext.request.contextPath}/js/user/mypage/mypage.js"></script> --%>
	<script type="text/javascript">
	function openMsg(){
		 var tw = window.open("http://localhost:8282/eepp/message?messageType=myReceiveMsg","message","left="+(screen.availWidth-700)/2
				 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
		}
	</script>
	<script>
	function changeGrade(){
		
		 var checkRow = "";
		$("input[name='pickCheck3']:checked").each(function() {
			checkRow = checkRow + $(this).val() + ",";
		});
		checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); // 맨끝 콤마 지우기
		if (checkRow == '') {
			alert("변경할 대상을 선택하세요.");
			return false;
		}else{
			$.ajax({
				url : getContextPath() + "/changeGrade",
				type : "post",
				data : {
					"checkRow" : checkRow,
					"selectgrade" : $(".selectgrade").val()
				},
				success : function(data) {
					alert("등급이 변경되었습니다.");
					location.href="/eepp/adminPage";
					
				},
				error : function(request, status, error) {
					alert("에러가 발생했습니다.");
					console.log(request.responseText);
					console.log(error);
				}
			})
		}
	} 
</script>
<script>
$(function() {
	// 전체선택 체크박스 클릭
	$(".allCheck3").click(function() {
		if ($(".allCheck3").prop("checked")) {
			$("input:checkbox[name='pickCheck3']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck3']").prop("checked", false);
		}
	})
})
	</script>
	<script>
	// 게시물 검색
	$('#searchBtn1').click(
			function() {
				if ($('select[name=searchType]').val() == 'n') {
					alert('검색조건을 지정해주세요');
					return;
				} else {
					self.location = "adminPage" + $("#MemberMakeQuery").val()
							+ "&searchType=" + $("select[name=searchType]").val()
							+ "&keyword="
							+ encodeURIComponent($('#keywordInput1').val())
							+ "&board=yes"
				}
		});

	// 엔터키로 검색
	$('#keywordInput1').keydown(function(event){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == 13) {
	    	 if($('select[name=searchType]').val() == 'n') {
	 			alert('검색조건을 지정해주세요');
	 			return;
	 		} else {
	 			self.location = "adminPage" + $("#MemberMakeQuery").val() + "&searchType=" + $("select[name=searchType]").val() 
	 			+ "&keyword=" + encodeURIComponent($('#keywordInput1').val()) + "&board=yes";
	 		}
	     }
	});
	</script>
	
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<%@ include file="/WEB-INF/views/footer.jsp"%>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</body>
</html>