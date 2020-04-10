<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>내 클래스</title>
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
							<td class="text_bold" style="cursor:pointer" onclick="openMsg();"><span class="required">• </span>내 쪽지</td>
							</tr>
							
							<tr class="bordered">
							<td class="liwrap" value="open_message" style="cursor:pointer" onclick="openMsg();">받은
								쪽지 ${mypage.messageRes}&nbsp;&nbsp;&nbsp;&nbsp;보낸 쪽지 ${mypage.messageSen}</td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="/eepp/myClass?tabType=myClassJoin">내 클래스</a></td>
							</tr>
							
							<tr class="bordered">
							<td><a href="/eepp/myClass?tabType=myClassJoin">개설 ${mypage.openClassCount}&nbsp;&nbsp;&nbsp;&nbsp;가입 ${mypage.joinClassCount}</a></td>
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
							<td class="text_bold"><span class="required">• </span><a href="myScrap?tabType=myScrapBoard">스크랩</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="scrap_count"><a href="myScrap?tabType=myScrapBoard">게시글 ${mypage.scrapCount} &nbsp;&nbsp;클래스 ${mypage.scrapClassCount}&nbsp;&nbsp;&nbsp;맛집 ${mypage.scrapEatingCount}</a></div></td>
							</tr>
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="/eepp/myReview">리뷰</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="review_count"><a href="/eepp/myReview">${mypage.reviewListCount}건</a></div></td>
							</tr>
							<tr>
							<td class="drop"><a href="withdrawal" id=drop onclick="drop();">회원탈퇴</a></td>
							</tr>
							
						</table>

					</div><!-- col-sm-4 -->
					<div class="col-sm-9">
					<div class="myclass-wrap">
		<h3 id="mpClBtn">클래스 목록</h3>
		<hr>
		<p>'EE class'에서 구매 / 개설 하신 클래스를 확인 할 수 있습니다.</p>
		<br><br>
			<!-- 리스트 테이블 -->		
			<div class="classForm">
					<ul class="nav nav-tabs">
						  <li class="nav-item">
						    <a class="nav-link linkToCJ" href="myClass?tabType=myClassJoin">가입한 클래스</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link linkToOP" href="myClass?tabType=myClassOpen">개설한 클래스</a>
						  </li>
						</ul>
						
						<div class="tab-content">
						<div class="tab-pane fade show active">
			<div id="showMyClass" class="notelist">
						<form>
							<input type="hidden" class="tabType" value="${tabType}">
								<c:choose>
									<c:when test="${tabType eq 'myClassJoin'}">
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
													<td class="Title"><a style="text-decoration: none" target="blank"
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
										</c:when>				
									</c:choose>
							</form>
							
						<form>
							<input type="hidden" class="tabType" value="${tabType}">
								<c:choose>
									<c:when test="${tabType eq 'myClassOpen'}">
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
																<td class="Title"><a style="text-decoration: none" target="blank"
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
										</c:when>				
									</c:choose>
							</form>
				</div><!-- #showMyMessage -->
						</div><!-- tab-pane fade show active -->
						</div><!-- tab-content -->
</div><!-- messageForm -->
<br><br>
			<div class="boardpaging">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<a class="page-link" href="myClass${myPagePageMaker.makeQuery(myPagePageMaker.startPage - 1)}&tabType=${tabType}">
							<i class="fas fa-angle-left"></i>
						</a>
					</li>
				<c:forEach begin="${myPagePageMaker.startPage}" end="${myPagePageMaker.endPage}" var="idx">
					<li class="page-item">
						<a id ="boardpaging_${idx}" class="page-link" href="myClass${myPagePageMaker.makeQuery(idx)}&tabType=${tabType}">${idx}</a></li>
				</c:forEach>
					<li class="page-item">
						<a class="page-link" href="myClass${myPagePageMaker.makeQuery(myPagePageMaker.endPage + 1)}&tabType=${tabType}">
							<i class="fas fa-angle-right"></i>
						</a>
					</li>
				</ul>
			</div><!-- paging -->
				</div><!-- col-sm-9 -->
			</div><!-- row -->
			</div><!-- container -->
			</div>
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