<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<style>
#gdsImg {
	margin-left: 50px;
}

#register_Btn {
	width: 250px;
}
</style>
<title>MyPage</title>
</head>
<body>
<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<div>
				<h1>'${loginUser.uNickname}' 님의 마이페이지~!~!~!~!~!~!~!~!~!</h1>
				<br>
				<button type="button" onclick="location.href='logout.do'">로그아웃</button>
				<div class="container text-center">
					<h1 style="text-align: center; width: 15%; margin: 0 auto">
						<img style="max-width: 100%"
							src="${pageContext.request.contextPath}/img/EE_logo.png" />

					</h1>
					<p style="text-align: center; font-weight: bold; margin: 0;">Community
						EE</p>
					<p style="text-align: center; font-weight: bold;">마 이 페 이 지</p>
					<%=request.getRealPath("/") %>
				</div>
				<hr>
					<div class="container">
						<br>
				<div class="row">
				<div class="col-sm-3">
						<!-- 기본 이미지 -->
						<div class="text-center">
							<img src="${loginUser.uprofile}" class="img" alt="profile_img"
								width="250" height="250">

							<form role="form" method="post" autocomplete="off"
								enctype="multipart/form-data">
								<div class="inputArea">
									<br> <input type="file" id="gdsImg" name="file" />
									<script>
										$("#gdsImg")
												.change(
														function() {
															if (this.files && this.files[0]) {
																var reader = new FileReader;
																reader.onload = function(data) {
																	$(".img").attr("src",data.target.result);
																}
																reader.readAsDataURL(this.files[0]);
															}
														});
									</script>
								</div>
								<br>
								<button type="submit" id="register_Btn" class="btn btn-info">프로필 업데이트</button>
							</form>
						</div>
						</div>
						<hr>
				</div>
			</div>
	</div>
		</c:when>
		<c:otherwise>
			<!-- 로그인 전 -->
			<h3>please login</h3>
			<button type="button" onclick="location.href='login/login.do'">로그인</button>

		</c:otherwise>
	</c:choose>
</body>
</html>