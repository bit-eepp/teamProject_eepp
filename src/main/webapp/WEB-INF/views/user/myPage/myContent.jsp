<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>마이페이지 - 내 컨텐츠</title>
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
								<td><a href="${pageContext.request.contextPath}/mypage">${loginUser.uNickname}</a></td>
							</tr>
							
							<tr>
								<td class="text_bold"><span class="required">• </span><a href="/eepp/myPoint">내 포인트</a></td>
							</tr>
							<tr class="bordered">
							<td><a href="${pageContext.request.contextPath}/myPoint"><fmt:formatNumber value="${loginUser.point}" pattern="###,###,###" /> P</a></td>
							</tr>
							
							<tr>
							<td class="text_bold" style="color:#e74386"><span class="required">• </span><a href="${pageContext.request.contextPath}/myContent">내 컨텐츠</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="content_count">
							<a href="${pageContext.request.contextPath}/myContent">게시물 ${mypage.listCount}</a></div></td>
							<!-- <a style="cursor:pointer" onclick="location.href='mypage?board=board'"> -->
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="${pageContext.request.contextPath}/myClass?tabType=myClassJoin">내 클래스</a></td>
							</tr>
							
							<tr class="bordered">
							<td><a href="${pageContext.request.contextPath}/myClass?tabType=myClassJoin">가입 ${mypage.joinClassCount}&nbsp;&nbsp;&nbsp;&nbsp;개설 ${mypage.openClassCount}</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="${pageContext.request.contextPath}/myReview">내 리뷰</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="review_count"><a href="${pageContext.request.contextPath}/myReview">${mypage.reviewListCount}건</a></div></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="${pageContext.request.contextPath}/myScrap?tabType=myScrapBoard">내 스크랩</a></td>
							</tr>
							
							<tr class="bordered">
							<td><div class="scrap_count"><a href="${pageContext.request.contextPath}/myScrap?tabType=myScrapBoard">게시글 ${mypage.scrapCount} &nbsp;&nbsp;클래스 ${mypage.scrapClassCount}&nbsp;&nbsp;&nbsp;맛집 ${mypage.scrapEatingCount}</a></div></td>
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
					<div class="col-sm-9"><br>
						<div class="myinfo-wrap">
							<h3 id="mpBoBtn">내 컨텐츠</h3>
							<hr>
							<p>'직무별 커뮤니티 게시판'에서 작성하신 게시글을 확인 할 수 있습니다.</p>
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
									
									<div class="input-group md-form form-sm form-2 pl-0 newGroup">
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
													<td class="Title"><c:choose>
															<c:when test="${vo.dCount > 10}">${vo.bTitle}</c:when>
															<c:otherwise>
																<a style="text-decoration: none" target="blank"
																	href="/eepp/board/contentView?${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${vo.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${vo.bCategory}">
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
								</table>
								<br>
									<!-- 페이징 시작 -->
								<div class="boardpaging">
										<ul class="pagination justify-content-center">
											<li class="page-item">
												<a class="page-link" href="myContent${myPagePageMaker.makeSearch(myPagePageMaker.startPage - 1)}">
													<i class="fas fa-angle-left"></i>
												</a>
											</li>
											<c:forEach begin="${myPagePageMaker.startPage}" end="${myPagePageMaker.endPage}" var="idx">
												<li class="page-item">
												<a id ="boardpaging_${idx}" class="page-link" href="myContent${myPagePageMaker.makeSearch(idx)}">${idx}</a></li>
											</c:forEach>
											<li class="page-item">
												<a class="page-link" href="myContent${myPagePageMaker.makeSearch(myPagePageMaker.endPage + 1)}">
														<i class="fas fa-angle-right"></i>
												</a>
											</li>
										</ul>
								</div><!-- paging -->
							</div><!-- content_list -->
						</div><!-- myinfo-wrap -->
						</div><!-- col-sm-9 -->
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
	<script src="${pageContext.request.contextPath}/js/user/mypage/mypage.js"></script>
	<script type="text/javascript">
		function getContextPath() {
			var hostIndex = location.href.indexOf(location.host) + location.host.length;
			return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
		};
		
		function openMsg(){
			var tw = window.open(getContextPath() +"/message?messageType=myReceiveMsg","message","left="+(screen.availWidth-700)/2
				 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
		}
	</script>
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>