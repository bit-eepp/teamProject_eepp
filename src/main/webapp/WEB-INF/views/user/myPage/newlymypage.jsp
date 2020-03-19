<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/mypage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<%@ include file="/WEB-INF/views/header.jsp"%>
</head>
<body>

	<input type="hidden" id="userNickname" name="loginUser"
		value="${loginUser.uNickname}">

	<input type="hidden" id="mypageMakerTotalCount"
		value="${myPagePageMaker.totalCount}">
	<input type="hidden" id="mypageMakerCriPage"
		value="${myPagePageMaker.cri.page}">
	<input type="hidden" id="mypageMakeQuery"
		value="${myPagePageMaker.makeQuery(1)}">

	<input type="hidden" id="ScrapMakerTotalCount"
		value="${ScrapPageMaker.totalCount}">
	<input type="hidden" id="ScrapMakerCriPage"
		value="${ScrapPageMaker.cri.page}">
	<input type="hidden" id="ScrapMakeQuery"
		value="${ScrapPageMaker.makeQuery(1)}">
		
	 <input type="hidden" id="board" value="${board}">
	 <input type="hidden" id="scrap" value="${scrap}">
	 <input type="hidden" id="point" value="${point}">
	 <input type="hidden" id="myInfo" value="${myInfo}">
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<br>
			<div class="container">
				<br>
				<br>
				<div class="row">
					<div class="col-sm-4">
						<div class="text-center">
							<br>

							<img src="${loginUser.uprofile}" class="img-circle"
								alt="profile_img">

							<form role="form" action="profileUpdate" method="post"
								autocomplete="off" enctype="multipart/form-data">
								<br>
								<div class="inputArea">
									<!-- <i class="fa fa-gear">업로드 -->
									<input type="file" id="showImg" name="file" />
									<!-- </i> -->
								</div>
								<br>
								<button type="submit" id="register_Btn" class="btn btn-info">프로필
									업데이트</button>
								<br>
								<button type="submit" id="changeImg" class="btn btn-info">기본이미지로</button>

							</form>
						</div>
						<br>
						<br>
						<hr>
						<table class="text-wrap">
						<tr>
							<td class="text_bold"><span class="required">• </span>내 포인트</td>
						</tr>
						<tr class="bordered">
							<td>
							${loginUser.point} P
									</td>
							
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 쪽지</td>
							</tr>
							
							<tr class="bordered">
							<td class="liwrap" value="open_message" onclick="openMsg();">받은
								쪽지 ${messageRes} <br> 보낸 쪽지 ${messageSen}</td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 클래스</td>
							</tr>
							
							<tr class="bordered">
							<td>개설 0 <br> 참여 0</td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>내 컨텐츠</td>
							</tr>
							
							<tr class="bordered">
							<td><div class="content_count">게시물
									${listCount} <br>  댓글 ${replyCount}</div></td>
							
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span>스크랩</td>
							</tr>
							
							<tr class="bordered">
							<td><div class="scrap_count">${scrapCount}건</div></td>
							</tr>
							
						</table>

					</div>
					<!-- col-sm-4 -->

					<div class="col-sm-8">

						<!-- <br><br><br><br> -->
						<div class="myinfo-wrap">
							<br>
							<h3>회원 정보 수정</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="myinfobtn">수정</button>
							</div>
							<p>닉네임, 비밀번호 변경 등 회원 정보 수정이 가능합니다.</p>
							<br>
							<br>
							<table class="info">
								<tr>
									<th class="input-title"><span class="required">•</span>이메일</th>
									<td>${loginUser.uEmail}</td>
								</tr>
								<tr>
									<th class="input-title"><span class="required">•</span>포인트</th>
									<td><%-- session에 저장된 포인트 정보가 있는경우 --%>
									<c:choose>
										<c:when test="${not empty userPoint}">
											${userPoint.poBalance}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:when>
							<%-- session에 저장된 포인트 정보가 없을 경우 0 --%>
										<c:otherwise> ${loginUser.point}P &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:otherwise>
									</c:choose> 
										<!--  포인트 -->
						<div class="charge_point">
							<button type="button" id ="pointBtn" data-toggle="modal" data-target="#charge_point" data-backdrop="static" data-keyboard="false">포인트 충전</button>
							<%@ include file="/WEB-INF/views/user/payment/chargePoint.jsp"%>
						</div>
						<!--  포인트 -->
									</td>
								</tr>

								<tr>
									<th class="input-title"><span class="required">&#8226;</span>닉네임
										변경</th>
									<td>
										<form action="updateNickName">
											<input name="uNickname" id="uNickname" maxlength="8"
												placeholder="${loginUser.uNickname}">
											<button type="button" class="btn btn-info"
												id="mypagenickNameCheck" onclick="nickCheck();" value="N">중복확인</button>
											<button type="submit" class="btn btn-submit" id="submit">변경</button>
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
									<td class="drop"><a href="withdrawal" id=drop
										onclick="drop();">회원탈퇴</a></td>
								</tr>
							</table>
						</div>
						<br>
						<div class="myinfo-wrap">
							<h3>게시글 목록</h3>
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
								<div class="search justify-content-center">
									<select name="searchType">
										<option value="n"
											<c:out value="${mscri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
										<option value="w"
											<c:out value="${mscri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
										<option value="t"
											<c:out value="${mscri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
										<option value="c"
											<c:out value="${mscri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
										<option value="tc"
											<c:out value="${mscri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
									</select> <input type="text" name="keyword" id="keywordInput"
										value="${mscri.keyword}" />
									<button id="searchBtn" class="btn" type="button">검색</button>
								</div>
								<!-- 검색 부분 끝  -->
								<br>
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
										<c:when test="${fn:length(myBoardList) > 0 }">
											<c:forEach items="${myBoardList}" var="vo">
												<tr>
													<td><c:choose>
															<c:when test="${vo.dCount > 10}">
																<b style="color: red">[BLIND]</b>
															</c:when>
															<c:otherwise>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:otherwise>
														</c:choose></td>
													<td>${vo.bId}</td>
													<td>${vo.bCategory}</td>
													<td>${vo.bSubject}</td>
													<td><c:choose>
															<c:when test="${vo.dCount > 10}">${vo.bTitle}</c:when>
															<c:otherwise>
																<a style="text-decoration: none"
																	href="/eepp/board/contentView?${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${vo.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">
																	${vo.bTitle} [${vo.rpCount}]</a>
															</c:otherwise>
														</c:choose></td>

													<td><b>${vo.uNickname}</b><br> ${vo.bWrittenDate}</td>
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
								<div>
									<!-- 페이징 시작 -->
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center">
											<li class="page-item"><c:if
													test="${myPagePageMaker.prev}">
													<a class="page-link"
														href="mypage${myPagePageMaker.makeSearch(myPagePageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">Previous</a>
												</c:if></li>
											<c:forEach begin="${myPagePageMaker.startPage}"
												end="${myPagePageMaker.endPage}" var="idx">
												<li class="page-item"><a class="page-link"
													href="mypage${myPagePageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item"><c:if
													test="${myPagePageMaker.next && myPagePageMaker.endPage > 0}">
													<a class="page-link"
														href="mypage${myPagePageMaker.makeSearch(myPagePageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}&board=yes">Next</a>
												</c:if></li>
										</ul>
									</nav>
									<br>
								</div>
																<!-- paging -->
							</div>
						</div>
						<!-- content_list -->
						<div class="myinfo-wrap">
							<h3>포인트 사용 / 충전내역</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="mypointbtn">확인</button>
							</div>
							<p>'EE'에서 충전하고 사용하신 포인트 내역을 확인 할 수 있습니다.</p>
							<h6>(포인트 히스토리 부분 미완성 이므로 일단 이렇게두겠습니다.)</h6>
							<br>
							<br>
							<div id="point_list">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">

											<th>충전 / 사용 포인트</th>
											<th>충전 / 사용 후 잔액</th>
											<th>충전 / 사용 날짜</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(myBoardList) > 0 }">
											<c:forEach items="${scrapList}" var="scrapList">
												<tr>
													<td>${scrapList.sId}</td>
													<td><a style="text-decoration: none"
														href="/eepp/board/contentView?bId=${scrapList.board_id}&searchType=&keyword=&sortType=&bCategory=">${scrapList.bTitle}</a></td>
													<td>${scrapList.sDate}</td>
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

								<!-- scrap_list -->
								<div>
									<!-- 페이징 시작 -->
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center">
											<li class="page-item"><c:if
													test="${ScrapPageMaker.prev}">
													<a class="page-link"
														href="mypage${ScrapPageMaker.makeSearch(ScrapPageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}&point=yes">Previous</a>
												</c:if></li>
											<c:forEach begin="${ScrapPageMaker.startPage}"
												end="${ScrapPageMaker.endPage}" var="idx">
												<li class="page-item"><a class="page-link"
													href="mypage${ScrapPageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}&point=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item"><c:if
													test="${ScrapPageMaker.next && ScrapPageMaker.endPage > 0}">
													<a class="page-link"
														href="mypage${ScrapPageMaker.makeSearch(ScrapPageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}&point=yes">Next</a>
												</c:if></li>
										</ul>
									</nav>
									<br>
								</div>
								<!-- paging -->
							</div>
						</div>
						<br>
						<!-- -------- 스크랩 목록 ------------- -->
						<div class="myinfo-wrap">
							<h3>스크랩 목록</h3>
							<hr>
							<div align="right">
								<button type="button" class="btn btn-info" id="myscrapbtn">확인</button>
							</div>
							<p>'EE'에서 스크랩하신 게시글을 확인 할 수 있습니다.</p>
							<br>
							<br>
							<div class="scrap_list">
								<table class="table table-bordered">
									<thead class="thead-color">
										<tr class="content_tr">
											<th>스크랩 번호</th>
											<th>스크랩 게시물</th>
											<th>스크랩 일시</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${fn:length(scrapList) > 0 }">
											<c:forEach items="${scrapList}" var="scrapList">
												<tr>
													<td>${scrapList.sId}</td>
													<td><a style="text-decoration: none"
														href="/eepp/board/contentView?bId=${scrapList.board_id}&searchType=&keyword=&sortType=&bCategory=">${scrapList.bTitle}</a></td>
													<td>${scrapList.sDate}</td>
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

								<!-- scrap_list -->
								<div>
									<!-- 페이징 시작 -->
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center">
											<li class="page-item"><c:if
													test="${ScrapPageMaker.prev}">
													<a class="page-link"
														href="mypage${ScrapPageMaker.makeSearch(ScrapPageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}&scrap=yes">Previous</a>
												</c:if></li>
											<c:forEach begin="${ScrapPageMaker.startPage}"
												end="${ScrapPageMaker.endPage}" var="idx">
												<li class="page-item"><a class="page-link"
													href="mypage${ScrapPageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}&scrap=yes">${idx}</a></li>
											</c:forEach>
											<li class="page-item"><c:if
													test="${ScrapPageMaker.next && ScrapPageMaker.endPage > 0}">
													<a class="page-link"
														href="mypage${ScrapPageMaker.makeSearch(ScrapPageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}&scrap=yes">Next</a>
												</c:if></li>
										</ul>
									</nav>
									<br>
								</div>
								<!-- paging -->
							</div>
						</div>
					</div>
					<!-- col-sm-8 -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
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
		function openMsg() {
			var tw = window
					.open(
							"http://localhost:8282/eepp/message?messageType=myReceiveMsg",
							"message", "left=" + (screen.availWidth - 700) / 2
									+ ",top=" + (screen.availHeight - 440) / 2
									+ ",width=700,height=440");
		}
		$(function(){  
			var currentPosition = parseInt($(".float").css("top")); 
			$(window).scroll(function() { 
				var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환
				$(".float").stop().animate({"top":position+currentPosition+"px"},500); 
			});
		});
	</script>
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>