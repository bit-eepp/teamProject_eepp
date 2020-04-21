<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>마이페이지 - 회원정보</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<style>

</style>
</head>
<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
	 
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
								<td class="text_bold" style="color:#e74386"><span class="required">• </span><a href="/eepp/mypage">회원정보</a></td>
							</tr>
							<tr class="bordered">
								<td><a href="${pageContext.request.contextPath}/mypage">${loginUser.uNickname}</a></td>
							</tr>
							
							<tr>
								<td class="text_bold"><span class="required">• </span><a href="${pageContext.request.contextPath}/myPoint">내 포인트</a></td>
							</tr>
							<tr class="bordered">
							<td><a href="${pageContext.request.contextPath}/myPoint"><fmt:formatNumber value="${loginUser.point}" pattern="###,###,###" /> P</a></td>
							</tr>
							
							<tr>
							<td class="text_bold"><span class="required">• </span><a href="${pageContext.request.contextPath}/myContent">내 컨텐츠</a></td>
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

					<div class="col-sm-9">

						<!-- <br><br><br><br> -->
						<div class="myinfo-wrap">
							<br>
							<h3 id="mpInBtn">회원 정보</h3>
							<hr>
							<p>닉네임, 비밀번호 변경 등 회원 정보 수정이 가능합니다.</p>
							<div class="table-wrapping">
							<table class="info">
								<tr>
									<th class="input-title"><span class="required">•</span>프로필</th>
									<td style ="padding:0;">
							<br>
							<img src="${loginUser.uprofile}" class="img-circle" alt="profile_img">
							<form role="form" action="profileUpdate" method="post" autocomplete="off" enctype="multipart/form-data">
								<div class="choosePick">
									<input type="text" readonly="readonly" id="file_route">
										 <label>이미지 선택
										 	<input type="file" id="showImg" name ="file" onchange="javascript:document.getElementById('file_route').value=this.value">
										 </label>
								</div> 
								<br>
								<button type="submit" id="register_Btn" class="btn btn-submit">프로필 업데이트</button>
								<button type="submit" id="changeImg" class="btn btn-submit">기본이미지로</button>
							</form><br><br>
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
							<br><br><br>
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