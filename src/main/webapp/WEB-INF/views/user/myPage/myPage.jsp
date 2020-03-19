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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>

	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
	<input type="hidden" id="mypageMakerTotalCount" value="${myPagePageMaker.totalCount}">
	<input type="hidden" id="mypageMakerCriPage" value="${myPagePageMaker.cri.page}">
	<input type="hidden" id="mypageMakeQuery" value="${myPagePageMaker.makeQuery(1)}">

	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<h1>'${loginUser.uNickname}' 님의 마이페이지~!~!~!~!~!~!~!~!~!</h1>
			<br>
			<button type="button" onclick="location.href='logout.do'">로그아웃</button>
			<div class="container text-center">
				<h1 style="text-align: center; width: 15%; margin: 0 auto">
					<img style="max-width: 100%"
						src="${pageContext.request.contextPath}/img/EE_logo.png" />
				</h1>
				<p style="text-align: center; font-weight: bold; margin: 0;">Community EE</p>
				<p style="text-align: center; font-weight: bold;">마 이 페 이 지</p>
			</div>
			<hr>
			<div class="container">
				<br>
				<div class="row">
					<div class="col-sm-3">
						<div class="text-center">
							<img src="${loginUser.uprofile}" class="img" alt="profile_img"
								width="250" height="250">

							<form role="form" action = "profileUpdate"method="post" autocomplete="off" enctype="multipart/form-data">
								<div class="inputArea"><br>
									<input type="file" id="showImg" name="file" />
								</div>
								<br>
								<button type="submit" id="register_Btn" class="btn btn-info">프로필 업데이트</button>
							</form>
						</div>
					</div>
					<div class="col-sm-9">
						<table class="table" border="2">
							<thead class="thead-color">
								<tr>
									<th>내 포인트</th>
									<th>내 쪽지</th>
									<th>내 클래스</th>
									<th>내 컨텐츠</th>
									<th>스크랩</th>
								</tr>
							</thead>
								<tr class="trColor">
									<td>
									<c:choose>
									<%-- session에 저장된 포인트 정보가 있는경우 --%>
									<c:when test="${not empty userPoint}">
										${userPoint.poBalance}
									</c:when>
									<%-- session에 저장된 포인트 정보가 없을 경우 0 --%>
									<c:otherwise> 0 </c:otherwise>
									</c:choose>
									</td>
									<td>보낸 쪽지 : <br>
										받은 쪽지 : 
									</td>
									<td>개설한 클래스 : <br> 참여한 클래스 :
									</td>
									<td>
										게시글 : ' ${listCount} ' 개<br>
										댓글 : ' ${replyCount} '개
									</td>
									<td>' ${scrapCount} '개</td>
								</tr>
						</table>
						
						<!--  포인트 -->
						<div class="charge_point">
							<button type="button" data-toggle="modal" data-target="#charge_point" data-backdrop="static" data-keyboard="false">포인트 충전</button>
							<%@ include file="/WEB-INF/views/user/payment/chargePoint.jsp"%>
						</div>
						<!--  포인트 -->
						
						<br>
							<h1 class="sc-title">회원 정보 수정</h1>


							<div class="container col-md-10">
								<table class= "info">
										<tr>
											<th class="input-title"><span class="required">•</span>이메일</th>
											<td>${loginUser.uEmail}</td>
										</tr>

										<tr>
											<th class="input-title"><span class="required">&#8226;</span>닉네임
												변경</th>
											<td>
											<form action = "updateNickName">
												<input name="uNickname" id="uNickname" maxlength="8" value="${loginUser.uNickname}">
												<button type="button" class="btn btn-info"id="mypagenickNameCheck" onclick="nickCheck();" value="N">중복확인</button>
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
													<button class="btn btn-info">비밀번호 변경</button>
												</form> 
											</td>
											<td class = "drop"><a href="withdrawal" onclick="drop();">회원탈퇴</a></td>
										</tr>
								</table>
							</div>
						<br>
						<h1 class="sc-title">'${loginUser.uNickname}' 님의 게시글 목록</h1>
						<br>
						<table border="1">
							<tr>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>글 번호</th>
								<th>카테고리</th>
								<th>말머리</th>
								<th>글 제목</th>
								<th>작성자 / 작성일</th>
								<th>조회수</th>
								<th>추천/비추천</th>
							</tr>
							<c:choose>
								<c:when test="${fn:length(myBoardList) > 0 }">
									<c:forEach items="${myBoardList}" var="vo">
										<tr>
											<td>
												<c:choose>
													<c:when test="${vo.dCount > 10}">
														<b style="color: red">[BLIND]</b>
													</c:when>
													<c:otherwise>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:otherwise>
												</c:choose>
											</td>
											<td>${vo.bId}</td>
											<td>${vo.bCategory}</td>
											<td>${vo.bSubject}</td>
											<td>
											<c:choose>
													<c:when test="${vo.dCount > 10}">${vo.bTitle}</c:when>
										<c:otherwise>
											<a style="text-decoration: none" href="/eepp/board/contentView?${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${vo.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">
											${vo.bTitle}  [${vo.rpCount}]</a>
										</c:otherwise>
											</c:choose></td>
											
											<td><b>${vo.uNickname}</b><br> ${vo.bWrittenDate}</td>
											<td>${vo.bHit}</td>
											<td>${vo.bLike}// ${vo.bUnlike}</td>
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
						<!-- 검색 부분  -->
						<div class="search">
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
							</select>
							<input type="text" name="keyword" id="keywordInput" value="${mscri.keyword}" />
							<button id="searchBtn" type="button">검색</button>
						</div>
						<!-- 검색 부분 끝  -->
						<div><!-- 페이징 시작 -->
							<c:if test="${myPagePageMaker.prev}">
								<a style="text-decoration: none" href="mypage${myPagePageMaker.makeSearch(myPagePageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}">
									« </a>
							</c:if>

							[
							<c:forEach begin="${myPagePageMaker.startPage}" end="${myPagePageMaker.endPage}" var="idx">
								<a style="text-decoration: none" href="mypage${myPagePageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}">${idx}</a>
							</c:forEach>
							]

							<c:if test="${myPagePageMaker.next && myPagePageMaker.endPage > 0}">
								<a style="text-decoration: none" href="mypage${myPagePageMaker.makeSearch(myPagePageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}">
									» </a>&nbsp;&nbsp;
							</c:if>
						</div> <!-- 페이징 끝 -->
						<br>
			<!-- ------scrap list ------------- -->
			<h1 class="sc-title">'${loginUser.uNickname}' 님의 스크랩 목록</h1>
						<table border ="1">
							<tr>
								<th>스크랩번호</th>
								<th>스크랩 게시물</th>
								<th>스크랩 일시</th>
							</tr>
							<c:forEach items="${scrapList}" var="scrapList">
							<tr>
								<td>${scrapList.sId}</td>
								<td><a style="text-decoration: none" href="/eepp/board/contentView?bId=${scrapList.board_id}&searchType=&keyword=&sortType=&bCategory=">${scrapList.bTitle}</a></td>
								<td>${scrapList.sDate}</td>
							</tr>
						</c:forEach>
					</table>

					</div><!-- div class="col-sm-9" -->
				</div><!-- div class="row" -->
			</div><!-- div class="container" -->
			<hr>
		</c:when>
		<c:otherwise>
			<!-- 로그인 전 -->
			<h3>please login</h3>
			<button type="button" onclick="location.href='login/login.do'">로그인</button>

		</c:otherwise>
	</c:choose>
	<script src="${pageContext.request.contextPath}/js/user/mypage/mypage.js"></script>
</body>
</html>