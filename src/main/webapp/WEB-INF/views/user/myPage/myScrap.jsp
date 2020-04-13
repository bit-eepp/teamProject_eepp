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
		
	<input type="hidden" id="mypageMakerCriPage" value="${myPagePageMaker.cri.page_my}">
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<br>
			<div class="container" id="MPwrap">
				<br>
				<br>
				<div class="row">
					<div class="col-sm-3">
						<table class="text-wrap">
							<tr>
								<td class="text_bold"><span class="required">• </span><a href="/eepp/mypage">회원정보</a></td>
							</tr>
							<tr class="bordered">
								<td><a href="/eepp/mypage">${loginUser.uNickname}</a></td>
							</tr>
							
							<tr>
								<td class="text_bold"><span class="required">• </span><a href="/eepp/myPoint">내 포인트</a></td>
							</tr>
							<tr class="bordered">
							<td><a href="/eepp/myPoint"><fmt:formatNumber value="${loginUser.point}" pattern="###,###,###" /> P</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="/eepp/myContent">내 컨텐츠</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="content_count">
							<a href="/eepp/myContent">게시물 ${mypage.listCount}</a></div></td>
							<!-- <a style="cursor:pointer" onclick="location.href='mypage?board=board'"> -->
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="/eepp/myClass?tabType=myClassJoin">내 클래스</a></td>
							</tr>
							
							<tr class="bordered">
							<td><a href="/eepp/myClass?tabType=myClassJoin">개설 ${mypage.openClassCount}&nbsp;&nbsp;&nbsp;&nbsp;가입 ${mypage.joinClassCount}</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="/eepp/myReview">내 리뷰</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="review_count"><a href="/eepp/myReview">${mypage.reviewListCount}건</a></div></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="myScrap?tabType=myScrapBoard">스크랩</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="scrap_count"><a href="myScrap?tabType=myScrapBoard">게시글 ${mypage.scrapCount} &nbsp;&nbsp;클래스 ${mypage.scrapClassCount}&nbsp;&nbsp;&nbsp;맛집 ${mypage.scrapEatingCount}</a></div></td>
							</tr>
							
							<tr>
							<td class="text_bold" style="cursor:pointer" onclick="openMsg();"><span class="required">• </span>내 쪽지</td>
							</tr>
							
							<tr class="bordered">
							<td class="liwrap" value="open_message" style="cursor:pointer" onclick="openMsg();" >받은
								쪽지 ${mypage.messageRes}&nbsp;&nbsp;&nbsp;&nbsp;보낸 쪽지 ${mypage.messageSen}</td>
							</tr>
							
							<tr>
							<td class="drop"><a href="withdrawal" id=drop onclick="drop();">회원탈퇴</a></td>
							</tr>
							
						</table>


					</div><!-- col-sm-4 -->

					<div class="col-sm-9">
					<h3 id="mpScBtn">스크랩</h3>
							<hr>
							<p>'EE'에서 스크랩하신 게시글을 확인 할 수 있습니다.</p>
							<br><br>		
			<div class="classForm">
					<ul class="nav nav-tabs">
						  <li class="nav-item">
						    <a class="nav-link linkToBo" href="myScrap?tabType=myScrapBoard">게시글 스크랩</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link linkToCL" href="myScrap?tabType=myScrapClass">클래스 스크랩</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link linkToEA" href="myScrap?tabType=myScrapEating">맛집 스크랩</a>
						  </li>
						</ul>
						
						<div class="tab-content">
						<div class="tab-pane fade show active">
						
			<div id="showMyClass" class="notelist">
						<form>
							<input type="hidden" class="tabType" value="${tabType}">
								<c:choose>
									<c:when test="${tabType eq 'myScrapBoard'}">
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
													<td class="Title"><a style="text-decoration: none" target="blank"
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
									<div class="delbtn"> <button type="button" id="selectDeleteBtn_Sboard" class="btn btn-submit">삭제</button> </div>
							</c:when>				
						</c:choose>
							</form>
						<form>
							<input type="hidden" class="tabType" value="${tabType}">
									
								<c:choose>
									<c:when test="${tabType eq 'myScrapClass'}">
										<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th> <input type="checkbox" class="allCheck1"></th>
											<th>번호</th>
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
													<td class="Title"><a style="text-decoration: none" target="blank"
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
								<div class="delbtn"> <button type="button" id="selectDeleteBtn_SClass" class="btn btn-submit">삭제</button> </div>
									</c:when>				
									</c:choose>
							</form>
							<form>
							<input type="hidden" class="tabType" value="${tabType}">
									
								<c:choose>
									<c:when test="${tabType eq 'myScrapEating'}">
										<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th> <input type="checkbox" class="allCheck2"></th>
											<th>카테고리</th>
											<th>스크랩 게시물</th>
											<th>스크랩 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(mypage.EatingScrapList) > 0 }">
											<c:forEach items="${mypage.EatingScrapList}" var="EatingScrapList">
												<tr class="scrapCList_tr">
												<td><input type="checkbox" name="pickCheck2" class="pickCheck2" value="${EatingScrapList.sId}" /></td>
													<td>
													<c:choose>
															<c:when test="${EatingScrapList.ecategory eq 'korean_food'}">한 식</c:when>
															<c:when test="${EatingScrapList.ecategory eq 'western_food'}">양 식</c:when>
															<c:when test="${EatingScrapList.ecategory eq 'chinese_food'}">중 식</c:when>
															<c:when test="${EatingScrapList.ecategory eq 'asain_food'}">아시안</c:when>
															<c:when test="${EatingScrapList.ecategory eq 'fusion_food'}">퓨 전</c:when>
															<c:when test="${EatingScrapList.ecategory eq 'japanese_food'}">일 식</c:when>
															<c:when test="${EatingScrapList.ecategory eq 'etc_food'}">기 타</c:when>
														</c:choose>
													
													</td>
													<td class="Title"><a style="text-decoration: none" target="blank"
														href="/eepp/eating/eatingView?eId=${EatingScrapList.eating_id}">${EatingScrapList.eTitle}</a></td>
													<td><fmt:formatDate value="${EatingScrapList.sDate}" pattern="yyyy/MM/dd HH:mm"/></td>
													
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
								<div class="delbtn"> <button type="button" id="selectDeleteBtn_SEating" class="btn btn-submit">삭제</button> </div>
									</c:when>				
									</c:choose>
							</form>
					
				</div><!-- #showMyMessage -->
						</div><!-- tab-pane fade show active -->
						</div><!-- tab-content -->
</div><!-- messageForm -->
<br><br>
<!-- 페이징 시작 -->
								<div class="boardpaging">
										<ul class="pagination justify-content-center">
											<li class="page-item">
												<a class="page-link" href="myScrap${myPagePageMaker.makeQuery(myPagePageMaker.startPage - 1)}&tabType=${tabType}">
													<i class="fas fa-angle-left"></i>
												</a>
											</li>
											<c:forEach begin="${myPagePageMaker.startPage}" end="${myPagePageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id ="boardpaging_${idx}" class="page-link" href="myScrap${myPagePageMaker.makeQuery(idx)}&tabType=${tabType}">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
												<a class="page-link" href="myScrap${myPagePageMaker.makeQuery(myPagePageMaker.endPage + 1)}&tabType=${tabType}">
														<i class="fas fa-angle-right"></i>
												</a>
											</li>
										</ul>
								</div><!-- paging -->
					<!-- col-sm-8 -->
				</div>
				</div>
				<!-- row -->
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