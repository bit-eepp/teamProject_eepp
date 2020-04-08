<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>MyPage</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
		
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
	<input type="hidden" id="mypageMakerTotalCount" value="${myPagePageMaker.totalCount}">
	<input type="hidden" id="mypageMakeQuery" value="${myPagePageMaker.makeQuery(1)}">
	
	<input type="hidden" id="mypageMakerCriPage" value="${myPagePageMaker.cri.page_my}">
	<input type="hidden" id="OpenClassCriPage" value="${OpenClassPageMaker.cri.page_oc}">
	<input type="hidden" id="JoinClassCriPage" value="${JoinClassPageMaker.cri.page_join}">
	<input type="hidden" id="PointCriPage" value="${PointPageMaker.cri.page_po}">
	<input type="hidden" id="ScrapboardCriPage" value="${ScrapboardPageMaker.cri.page_scb}">
	<input type="hidden" id="ScrapClassCriPage" value="${ScrapClassPageMaker.cri.page_scc}">
	<input type="hidden" id="MyReviewCriPage" value="${MyReviewPageMaker.cri.page_rv}">
		
	 <input type="hidden" id="board" value="${board}">
	 <input type="hidden" id="scrap" value="${scrap}">
	 <input type="hidden" id="mpPoint" value="${mpPoint}">
	 <input type="hidden" id="mpclass" value="${mpclass}">
	 <input type="hidden" id="rv" value="${rv}">
	 
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<br>
			<div class="container">
				<br>
				<br>
				<div class="row">
					<div class="col-sm-3">
						<table class="text-wrap">
						<tr>
							<td class="text_bold"><span class="required">• </span>내 포인트</td>
						</tr>
						<tr class="bordered">
							<td><a href="#mpPoBtn"><fmt:formatNumber value="${loginUser.point}" pattern="###,###,###" /> P</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 쪽지</td>
							</tr>
							
							<tr class="bordered">
							<td class="liwrap" value="open_message" style="cursor:pointer" onclick="openMsg();">받은
								쪽지 ${mypage.messageRes}&nbsp;&nbsp;&nbsp;&nbsp;보낸 쪽지 ${mypage.messageSen}</td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 클래스</td>
							</tr>
							
							<tr class="bordered">
							<td><a href="#mpClBtn">개설 ${mypage.openClassCount}&nbsp;&nbsp;&nbsp;&nbsp;참여 ${mypage.joinClassCount}</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 컨텐츠</td>
							</tr>
							
							<tr class="bordered">
							<td><div class="content_count">
							<a href="#mpBoBtn">게시물 ${mypage.listCount}&nbsp;&nbsp;&nbsp;&nbsp;댓글 ${mypage.replyCount}</a></div></td>
							<!-- <a style="cursor:pointer" onclick="location.href='mypage?board=board'"> -->
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>스크랩</td>
							</tr>
							
							<tr class="bordered">
							<td><div class="scrap_count"><a href="#mpScBtn">${mypage.scrapCount}건</a></div></td>
							</tr>
							<tr>
							<td class="text_bold"><span class="required">• </span>리뷰</td>
							</tr>
							
							<tr class="bordered">
							<td><div class="review_count"><a href="#mpReviewBtn">${mypage.reviewListCount}건</a></div></td>
							</tr>
							<tr>
							<td class="drop"><a href="withdrawal" id=drop onclick="drop();">회원탈퇴</a></td>
							</tr>
							
						</table>

					</div><!-- col-sm-4 -->

					<div class="col-sm-9">

						<!-- <br><br><br><br> -->
						<div class="myinfo-wrap">
							<br>
							<h3 id="mpInBtn">회원 정보</h3>
							<hr>
							<p>닉네임, 비밀번호 변경 등 회원 정보 수정이 가능합니다.</p>
							<div align="right">
								<button type="button" class="btn btn-info" id="myinfobtn">수정</button>
							</div><br>
							<table class="info">
								<tr>
									<th class="input-title"><span class="required">•</span>프로필</th>
									<td style ="padding:0;">
							<br>
							<img src="${loginUser.uprofile}" class="img-circle" alt="profile_img">
							<form role="form" action="profileUpdate" method="post"
								autocomplete="off" enctype="multipart/form-data">
								<br>
								<div class="choosePick">
									 	<input type="text" readonly="readonly" id="file_route">
									 <label>이미지 선택
									 	<input type="file" id="showImg" onchange="javascript:document.getElementById('file_route').value=this.value">
									 </label>
								</div> 
								<br>
								<button type="submit" id="register_Btn" class="btn btn-submit">프로필 업데이트</button>
								<button type="submit" id="changeImg" class="btn btn-submit">기본이미지로</button>
							</form>
							
						<br>
						<br>
									</td>
								</tr>
								<tr>
									<th class="input-title"><span class="required">•</span>이메일</th>
									<td>${loginUser.uEmail}</td>
								</tr>
								<tr>
									<th class="input-title"><span class="required">&#8226;</span>닉네임 변경</th>
									<td>
										<form action="updateNickName">
											<input name="uNickname" id="changeNickname" maxlength="8" placeholder="${loginUser.uNickname}" oninput="nickCheck();">
											<button type="submit" class="btn btn-submit" id="submit">변경</button>
											<span class="checkInfo" id="checkNickInfo"></span>
										</form>
									</td>
								</tr>
								<tr>
									<th class="input-title"><span class="required">&#8226;</span>핸드폰
										번호</th>
									<td>${loginUser.uPhone}</td>
								</tr>
								<tr>
									<th class="input-title"><span class="required">&#8226;</span>비밀번호</th>
									<td>
										<form action="${pageContext.request.contextPath}/login/forgotMyInfo" method="post">
											<button class="btn btn-submit" id="submit">비밀번호 변경</button>
										</form>
									</td>
									
								</tr>
							</table>
						</div>
						<br><br>
						<div class="myinfo-wrap">
							<h3 id="mpBoBtn">게시글 목록</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="mycontentbtn">확인</button>
							</div>
							<p>'EE'에서 작성하신 게시글을 확인 할 수 있습니다.</p>
							<br>
							<br>

							<div class="content_list">
								<br>
								<!-- 검색 부분  -->
								<div class="search">
									<select name="searchType" class="selectSearchType">
										<option value="n"
											<c:out value="${mscri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
										<option value="t"
											<c:out value="${mscri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
										<option value="c"
											<c:out value="${mscri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
										<option value="tc"
											<c:out value="${mscri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
									</select>
									
									<div class="input-group md-form form-sm form-2 pl-0">
									<input class="form-control my-0 py-1 amber-border" type="text"placeholder="검색어" aria-label="Search" name="keyword" id="keywordInput" value="${mscri.keyword}">
										<a id="searchBtn">
										<span class="input-group-text lighten-3" id="basic-text1"><i class="fas fa-search" aria-hidden="true"></i></span>
										</a>
									</div>
								</div>
								<!-- 검색 부분 끝  -->
								<br>
								<table class="table table-bordered" id="mpconttable">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>글 번호</th>
											<th>카테고리</th>
											<th>말머리</th>
											<th>글 제목</th>
											<th>작성자 / 작성일</th>
											<th>조회수</th>
											<th>추천/비추천</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.myBoardList) > 0 }">
											<c:forEach items="${mypage.myBoardList}" var="vo">
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

													<td style="color:#000;"><b>${vo.uNickname}</b><br> ${vo.bWrittenDate}</td>
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
													<a class="page-link" href="mypage${myPagePageMaker.makeSearch(myPagePageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${myPagePageMaker.startPage}" end="${myPagePageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id ="boardpaging_${idx}" class="page-link" href="mypage${myPagePageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="mypage${myPagePageMaker.makeSearch(myPagePageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
									
									<br>
								</div><!-- paging -->
							</div>
						</div>
						<!-- content_list -->
						<div class="myinfo-wrap">
							<h3 id="mpPoBtn">포인트 사용 / 충전내역</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="mypointbtn">확인</button>
							</div>
							<p>'EE'에서 충전하고 사용하신 포인트 내역을 확인 할 수 있습니다.</p>
							<br>
							<br>
							<div id="point_list">
							<span class="required">•</span>나의 포인트 :  
									<%-- session에 저장된 포인트 정보가 있는경우 --%>
									<c:choose>
										<c:when test="${not empty userPoint}">
											<fmt:formatNumber value="${userPoint.poBalance}" pattern="###,###,###" /> P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:when>
									<%-- session에 저장된 포인트 정보가 없을 경우 0 --%>
										<c:otherwise><fmt:formatNumber value="${loginUser.point}" pattern="###,###,###" /> P &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:otherwise>
									</c:choose> 
										<!--  포인트 -->
						<div class="charge_point">
							<button type="button" id ="pointBtn" data-toggle="modal" data-target="#charge_point" data-backdrop="static" data-keyboard="false">포인트 충전</button>
							<%@ include file="/WEB-INF/views/user/payment/chargePoint.jsp"%>
						</div>
						<!--  포인트 -->
							<br><br>
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>포인트 잔액</th>
											<th>포인트 이용 내역</th>
											<th>충전 / 사용 포인트</th>
											<th>충전 / 사용 날짜</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.pointList) > 0 }">
											<c:forEach items="${mypage.pointList}" var="pointList">
												<tr>
													<td><fmt:formatNumber value="${pointList.totalPoint}" pattern="###,###,###" /> P</td>
													<c:choose>
														<c:when test ="${pointList.paInfo eq '포인트 입금' or pointList.paInfo eq '포인트 충전'}">
															<td><div class="po_In"><b>${pointList.paInfo}</b></div></td>
															<td><i class="fas fa-caret-up"></i> &nbsp; 
																<fmt:formatNumber value="${pointList.point_io}" pattern="###,###,###" /> P</td>
														</c:when>
														<c:otherwise>
															<td><div class="po_Out"><b>${pointList.paInfo}</b></div></td>
															<td><i class="fas fa-caret-down"></i> &nbsp;
															<fmt:formatNumber value="${pointList.point_io}" pattern="###,###,###" /> P</td>
														</c:otherwise>
													</c:choose>
													<td>${pointList.paDate}</td>
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
								<!-- 페이징 -->
								<div class = "pointpage">
									<ul class="pagination justify-content-center">
      									<li class="page-item">
													<a class="page-link" href="mypage${PointPageMaker.makeQuery(PointPageMaker.startPage - 1)}&mpPoint=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${PointPageMaker.startPage}" end="${PointPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="pointpage_${idx}" class="page-link" href="mypage${PointPageMaker.makeQuery(idx)}&mpPoint=yes">${idx}</a>
												</li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link"href="mypage${PointPageMaker.makeQuery(PointPageMaker.endPage + 1)}&mpPoint=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
								</div>
							</div><!-- Point List -->
						</div>
						<br>
						<!-- -------- 스크랩 목록 ------------- -->
						<div class="myinfo-wrap">
							<h3 id="mpScBtn">스크랩 목록</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="myscrapbtn">확인</button>
							</div>
							<p>'EE'에서 스크랩하신 게시글을 확인 할 수 있습니다.</p>
							<br>
							<br>
							<div class="scrap_list">
							 <div class="col">
			<nav>
				  <div class="nav nav-tabs" id="nav-tab" role="tablist">
				    <a class="nav-item nav-link active" id="nav-board-tab" data-toggle="tab" href="#scrap_board" role="tab" aria-controls="nav-board" aria-selected="true">게시판</a>
				    <a class="nav-item nav-link" id="nav-class-tab" data-toggle="tab" href="#scrap_class" role="tab" aria-controls="nav-class" aria-selected="false">클래스</a>
				    <a class="nav-item nav-link" id="nav-eating-tab" data-toggle="tab" href="#scrap_eating" role="tab" aria-controls="nav-eating" aria-selected="false">맛집</a>
				  </div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
			  <div class="tab-pane fade show active" id="scrap_board" role="tabpanel" aria-labelledby="nav-board-tab">
		<!--  게시판 스크랩 -->
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th> <input type="checkbox" class="allCheck"></th>
											<th>게시물 번호</th>
											<th>스크랩 게시물</th>
											<th>스크랩 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.scrapList) > 0 }">
											<c:forEach items="${mypage.scrapList}" var="scrapList">
												<tr class="scrapList_tr">
													<!--  스크랩 목록 선택 -->
													<td><input type="checkbox" name="pickCheck" class="pickCheck" value="${scrapList.sId}" /></td>
													<td>${scrapList.board_id}</td>
													<td class="Title"><a style="text-decoration: none"
														href="/eepp/board/contentView?bId=${scrapList.board_id}&searchType=&keyword=&sortType=&bCategory=">${scrapList.bTitle}</a></td>
													<td><fmt:formatDate value="${scrapList.sDate}" pattern="yyyy/MM/dd HH:mm"/></td>
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
								<div class="scrapBoardPage">
										   <ul class="pagination justify-content-center">
										      <li class="page-item">
													<a class="page-link"href="mypage${ScrapboardPageMaker.makeQuery(ScrapboardPageMaker.startPage - 1)}&cCategory=${cCategory}&scrap=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${ScrapboardPageMaker.startPage}" end="${ScrapboardPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="scrapBoardPage_${idx}" class="page-link" href="mypage${ScrapboardPageMaker.makeQuery(idx)}&cCategory=${cCategory}&scrap=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="mypage${ScrapboardPageMaker.makeQuery(ScrapboardPageMaker.endPage + 1)}&cCategory=${cCategory}&scrap=yes">
														<i class="fas fa-angle-right"></i>
													</a>
											</li>
										</ul>
									<br>
								</div><!-- paging -->
  						</div><!-- class="tab-pane fade show active" -->
  						
		<!--  class 스크랩 -->
		  	<div class="tab-pane fade" id="scrap_class" role="tabpanel" aria-labelledby="nav-class-tab">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th> <input type="checkbox" class="allCheck1"></th>
											<th>class 번호</th>
											<th>스크랩 게시물</th>
											<th>스크랩 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.ClassscrapList) > 0 }">
											<c:forEach items="${mypage.ClassscrapList}" var="ClassscrapList">
												<tr class="scrapCList_tr">
												<td><input type="checkbox" name="pickCheck1" class="pickCheck1" value="${ClassscrapList.sId}" /></td>
													<td>${ClassscrapList.class_id}</td>
													<td class="Title"><a style="text-decoration: none"
														href="/eepp/class/classView?cId=${ClassscrapList.class_id}&cCategory=${cCategory}">${ClassscrapList.cTitle}</a></td>
													<td><fmt:formatDate value="${ClassscrapList.sDate}" pattern="yyyy/MM/dd HH:mm"/></td>
													
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
								<div class="delbtn"> <button type="button" id="selectDeleteBtn2" class="btn btn-submit">삭제</button> </div>
									<div class="scrapClassPage">
										   <ul class="pagination justify-content-center">
										      <li class="page-item">
													<a class="page-link"href="mypage${ScrapClassPageMaker.makeQuery(ScrapClassPageMaker.startPage - 1)}&cCategory=${cCategory}&scrap=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${ScrapClassPageMaker.startPage}" end="${ScrapClassPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="scrapClassPage_${idx}" class="page-link" href="mypage${ScrapClassPageMaker.makeQuery(idx)}&cCategory=${cCategory}&scrap=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="mypage${ScrapClassPageMaker.makeQuery(ScrapClassPageMaker.endPage + 1)}&cCategory=${cCategory}&scrap=yes">
														<i class="fas fa-angle-right"></i>
													</a>
											</li>
										</ul>
									<br>
								</div><!-- paging -->
  						</div><!-- class="tab-pane fade show active" -->
  						
		<!--  eating 스크랩 -->
		  	<div class="tab-pane fade" id="scrap_eating" role="tabpanel" aria-labelledby="nav-eating-tab">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th> <input type="checkbox" class="allCheck2"></th>
											<th>eating 번호</th>
											<th>스크랩 게시물</th>
											<th>스크랩 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.scrapList) > 0 }">
											<c:forEach items="${mypage.scrapList}" var="scrapList">
												<tr class="scrapEList_tr">
													<td><input type="checkbox" name="pickCheck2" class="pickCheck2" value="${scrapList.sId}" /></td>
													<td>${scrapList.board_id}</td>
													<td class="Title"><a style="text-decoration: none"
														href="/eepp/board/contentView?bId=${scrapList.board_id}&searchType=&keyword=&sortType=&bCategory=">${scrapList.bTitle}</a></td>
													<td><fmt:formatDate value="${scrapList.sDate}" pattern="yyyy/MM/dd HH:mm"/></td>
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
								
									<div class="scrapBoardPage">
										   <ul class="pagination justify-content-center">
										      <li class="page-item">
													<a class="page-link"href="mypage${ScrapboardPageMaker.makeQuery(ScrapboardPageMaker.startPage - 1)}&cCategory=${cCategory}&scrap=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${ScrapboardPageMaker.startPage}" end="${ScrapboardPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="scrapBoardPage_${idx}" class="page-link" href="mypage${ScrapboardPageMaker.makeQuery(idx)}&cCategory=${cCategory}&scrap=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="mypage${ScrapboardPageMaker.makeQuery(ScrapboardPageMaker.endPage + 1)}&cCategory=${cCategory}&scrap=yes">
														<i class="fas fa-angle-right"></i>
													</a>
											</li>
										</ul>
									<br>
								</div><!-- paging -->
								
  						</div><!-- class="tab-pane fade show active" -->
			</div><!-- class="tab-content" id="nav-tabContent" -->
						</div><!-- col -->
  					</div><!-- scrap_list -->
							
						</div>
						<!-- -------- 클래스 목록 ------------- -->
						<div class="myclass-wrap">
							<h3 id="mpClBtn">클래스 목록</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="myclassbtn">확인</button>
							</div>
							<p>'EE'에서 구매 / 개설 하신 클래스를 확인 할 수 있습니다.</p>
							<br>
							<br>
							<div class="myclass_list">
				<nav>
					  <div class="nav nav-tabs" id="nav-tab" role="tablist">
					    <a class="nav-item nav-link active" id="nav-class-join-tab" data-toggle="tab" href="#class_join" role="tab" aria-controls="nav-board" aria-selected="true">가입한 클래스</a>
					    <a class="nav-item nav-link" id="nav-class-open-tab" data-toggle="tab" href="#class_open" role="tab" aria-controls="nav-class" aria-selected="false">개설한 클래스</a>
					  </div>
				</nav>
				<div class="tab-content" id="nav-tabContent">
				  <div class="tab-pane fade show active" id="class_join" role="tabpanel" aria-labelledby="nav-class-join-tab">
						<!--  게시판 스크랩 -->
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>번호</th>
											<th>클래스 카테고리</th>
											<th>클래스 제목</th>
											<th>클래스 가격</th>
											<th>클래스 구매일</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.joinClass) > 0 }">
											<c:forEach items="${mypage.joinClass}" var="joinClass">
												<tr class="classJList_tr">
													<td>${joinClass.class_id}</td>
													<td>
													<c:choose>
															<c:when test="${joinClass.cCategory eq 'it_dev'}">
																IT / 개발
															</c:when>
															
															<c:when test="${joinClass.cCategory eq 'workSkill'}">
																업무스킬
															</c:when>
															
															<c:when test="${joinClass.cCategory eq 'financialTechnology'}">
																재 테 크
															</c:when>
															
															<c:when test="${joinClass.cCategory eq 'daily'}">
																일 상
															</c:when>
															
															<c:when test="${joinClass.cCategory eq 'etc'}">
																기 타
															</c:when>
														</c:choose>
													</td>
													<td class="Title"><a style="text-decoration: none"
														href="/eepp/class/classView?cId=${joinClass.class_id}&cCategory=${cCategory}">${joinClass.cTitle}</a></td>
													<td class="cPrice"> <fmt:formatNumber value="${joinClass.cPrice}" pattern="###,###,###" /> P</td>
													<td><fmt:formatDate value="${joinClass.cjJoinDate}" pattern="yyyy/MM/dd HH:mm"/></td>
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
								<!-- 페이징 -->
								<div class = "clJoinPage">
									<ul class="pagination justify-content-center">
      									<li class="page-item">
													<a class="page-link" href="mypage${JoinClassPageMaker.makeQuery(JoinClassPageMaker.startPage - 1)}&mpclass=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${JoinClassPageMaker.startPage}" end="${JoinClassPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="clJoinPage_${idx}" class="page-link" href="mypage${JoinClassPageMaker.makeQuery(idx)}&mpclass=yes">${idx}</a>
												</li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link"href="mypage${JoinClassPageMaker.makeQuery(JoinClassPageMaker.endPage + 1)}&mpclass=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
								</div>
  						</div><!-- class="tab-pane fade show active" -->
			<!--  class 스크랩 -->
			  	<div class="tab-pane fade" id="class_open" role="tabpanel" aria-labelledby="nav-class-open-tab">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>번호</th>
											<th>클래스 제목</th>
											<th>참여인원/참여가능인원</th>
											<th>모집 시작일</th>
											<th>모집 기간</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.openClass) > 0 }">
											<c:forEach items="${mypage.openClass}" var="openClass">
												<input type="hidden" id="classId" value="${openClass.cId}" />
												<tr class="classOList_tr">
													<td>${openClass.cId}</td>
													<td class="Title"><a style="text-decoration: none"
														href="/eepp/class/classView?cId=${openClass.cId}&cCategory=${cCategory}">${openClass.cTitle}</a></td>
													<td><a style="cursor:pointer; color:#000;" onclick="classjoin_list('${openClass.cId}');"> <b>${openClass.totalcount}</b></a> / ${openClass.cTotalPeopleCount}</td>						
													<td><fmt:formatDate value="${openClass.cOpenDate}" pattern="yyyy년MM월dd일"/></td>
													<td>${openClass.cTerm}일</td>
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
								
									<div class="clOpenPage">
									   <ul class="pagination justify-content-center">
									      <li class="page-item">
													<a class="page-link" href="mypage${OpenClassPageMaker.makeQuery(OpenClassPageMaker.startPage - 1)}&cCategory=${cCategory}&mpclass=yes">
														<i class="fas fa-angle-left"></i>
													</a>
										</li>
											<c:forEach begin="${OpenClassPageMaker.startPage}" end="${OpenClassPageMaker.endPage}" var="idx">
												<li class="page-item">
													<a id="clOpenPage_${idx}" class="page-link" href="mypage${OpenClassPageMaker.makeQuery(idx)}&cCategory=${cCategory}&mpclass=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link" href="mypage${OpenClassPageMaker.makeQuery(OpenClassPageMaker.endPage + 1)}&cCategory=${cCategory}&mpclass=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
								</div><!-- paging -->
  						</div><!-- class="tab-pane fade show active" -->
  						</div>
  						</div>
  						<!-- content_list -->
						<div class="myreview-wrap">
							<h3 id="mpRVBtn1">나의 리뷰</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="mpRVBtn">확인</button>
							</div>
							<p>'EE'에서 작성하신 음식점 후기를 확인 할 수 있습니다.</p>
							<br>
							<br>
							<div class="review_list">
						<!--  리뷰 -->
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>리뷰 번호</th>
											<th>음식점</th>
											<th>후기</th>
											<th>작성일</th>
											<th>평점</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.reviewList) > 0 }">
											<c:forEach items="${mypage.reviewList}" var="reviewList">
												<tr>
													<td>${reviewList.rvId}</td>
													<td>${reviewList.ename}</td>
													<td>${reviewList.rvComment}</td>
													<td>${reviewList.rvWrittenDate}</td>
													<td>${reviewList.rvScore}</td>
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
								

								<!-- 페이징 -->
								<div class = "rv">
									<ul class="pagination justify-content-center">
      									<li class="page-item">
													<a class="page-link" href="mypage${MyReviewPageMaker.makeQuery(MyReviewPageMaker.startPage - 1)}&rv=yes">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											<c:forEach begin="${MyReviewPageMaker.startPage}" end="${MyReviewPageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id="rv_${idx}" class="page-link" href="mypage${MyReviewPageMaker.makeQuery(idx)}&rv=yes">${idx}</a>
												</li>
											</c:forEach>
											<li class="page-item">
													<a class="page-link"href="mypage${MyReviewPageMaker.makeQuery(MyReviewPageMaker.endPage + 1)}&rv=yes">
														<i class="fas fa-angle-right"></i>
													</a>
												</li>
										</ul>
								</div>
							</div><!-- review_List -->
						</div>
							
						
					</div>
					<!-- col-sm-8 -->
				</div>
				<!-- row -->
			</div>
			</div><!-- container -->
	<br>
		</c:when>
		<c:otherwise>
			<!-- 로그인 전 -->
			<h3>please login</h3>
			<button type="button" onclick="location.href='login/login.do'">로그인</button>

		</c:otherwise>
	</c:choose>
	<script src="${pageContext.request.contextPath}/js/user/mypage/mypage.js"></script>
	<script type="text/javascript">
	function openMsg(){
		 var tw = window.open("http://localhost:8282/eepp/message?messageType=myReceiveMsg","message","left="+(screen.availWidth-700)/2
				 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
		}
	</script>
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>