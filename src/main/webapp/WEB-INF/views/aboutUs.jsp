<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>About Us</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/aboutUs.css">

		<script>		
			$(document).ready(function() {
				var isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);
				
				if (!isChrome){
					$('#audio').remove();
				 } else {
					$('#playAudio').remove();
				}
			});
			
			function move(){
				var offset = $("#cu").offset();
				$('html, body').animate({scrollTop : offset.top}, 600);
			}
		</script>
	</head>

	<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
		
		<!-- 배경음악테스트 시작 -->
		<iframe src="${pageContext.request.contextPath}/img/aboutUs/trackNo2.mp3" allow="autoplay" id="audio" style="display:none"></iframe>
		<audio autoplay loop id="playAudio">
			<source src="${pageContext.request.contextPath}/img/aboutUs/trackNo2.mp3">
		</audio>
		<!-- 배경음악테스트 끝 -->

		<section id="asWrap">			
			<!-- about Us 메뉴1 시작 -->	
			<div class="bg-light menu1">
				<div class="container py-5">
					<div class="row h-100 align-items-center py-5">
						<div class="col-lg-6">				
							<h3 class="display-4"><b>About Us</b></h3>
							
							<p class="lead text-muted mb-0">
								COMMUNITY <b>EE</b><br>
								<b>E</b>MPLOYEES, <b>E</b>SCAPE FROM WORK
							</p>
							
							<br><br><br>
							
							<div class="cuBtn" align="left">
								<button class="btn btn-primary" onclick="move();">Contact Us</button>
							</div>
							
						</div>
						
						<div class="col-lg-6 d-none d-lg-block">
							<img src="${pageContext.request.contextPath}/img/aboutUs/as_main.png" alt="" class="img-fluid">
						</div>
					</div>
				</div>
			</div>
			<!-- about Us 메뉴1 끝 -->
		
			<!-- about Us 메뉴2 시작 -->
			<div class="bg-white py-5 menu2">
				<div class="container py-5">
					<div class="row mb-4">
						<div class="col-lg-5">
							<h3 class="display-4 font-weight-light"><b>Our Service</b></h3>
						</div>
					</div>
					
					<div class="row align-items-center mb-5 service">
						<div class="col-lg-6 order-2 order-lg-1">
							<i class="fas fa-users fa-2x mb-3"></i>	
							<h2 class="font-weight-light"><b>직무별 커뮤니티 게시판</b></h2>
							
							<p class="font-italic text-muted mb-4">
								IT/개발, 서비스, 금융, 공무원, 디자인, 기타 직군별 직장인들이 <br>
								직무별 커뮤니티 게시판에서 모여 서로 소통 할 수 있습니다.
							</p>
								
							<a href="${pageContext.request.contextPath}/board/boardList" class="btn btn-light px-5 rounded-pill shadow-sm"><b>상 세 보 기</b></a>
						</div>
						
						<div class="col-lg-5 px-5 mx-auto order-1 order-lg-2">
							<img src="${pageContext.request.contextPath}/img/aboutUs/as_service1.jpg" alt="" class="img-fluid mb-4 mb-lg-0">
						</div>
					</div>
					
					<div class="row align-items-center service">
						<div class="col-lg-5 px-5 mx-auto">
							<img src="${pageContext.request.contextPath}/img/aboutUs/as_service2.jpg" alt="" class="img-fluid mb-4 mb-lg-0">
						</div>
						
						<div class="col-lg-6">
							<i class="fas fa-utensils fa-2x mb-3"></i>
							<h2 class="font-weight-light"><b>맛집정보 - 오늘 뭐먹지?</b></h2>
							
							<p class="font-italic text-muted mb-4">
								항상 메뉴를 고민하는 직장인들을 위해 다양한 맛집정보를 제공합니다.
							</p>
								
							<a href="${pageContext.request.contextPath}/eating/eatingList" class="btn btn-light px-5 rounded-pill shadow-sm"><b>상 세 보 기</b></a>
						</div>
					</div>
					
					<div class="row align-items-center mb-5 service">
						<div class="col-lg-6 order-2 order-lg-1">
							<i class="fab fa-leanpub fa-2x mb-3"></i>
							
							<h2 class="font-weight-light"><b>클래스 강좌 플랫폼 - EE Class</b></h2>
							
							<p class="font-italic text-muted mb-4">
								직장인들의 자기개발을 위한 배움의 장을 제공합니다.
							</p>
							
							<a href="${pageContext.request.contextPath}/class/classList" class="btn btn-light px-5 rounded-pill shadow-sm"><b>상 세 보 기</b></a>
						</div>
						
						<div class="col-lg-5 px-5 mx-auto order-1 order-lg-2">
							<img src="${pageContext.request.contextPath}/img/aboutUs/as_service3.jpg" alt="" class="img-fluid mb-4 mb-lg-0">
						</div>
					</div>
					
					<div class="row align-items-center service">
						<div class="col-lg-5 px-5 mx-auto">
							<img src="${pageContext.request.contextPath}/img/aboutUs/as_service4.jpg" alt="" class="img-fluid mb-4 mb-lg-0">
						</div>
						
						<div class="col-lg-6">
							<i class="far fa-comment-dots fa-2x mb-3"></i>
							<h2 class="font-weight-light"><b>퇴근 후 모임 - EE Chat</b></h2>
							
							<p class="font-italic text-muted mb-4">
								직장인들의 퇴근 후 모임을 만들수 있는 채팅서비스를 제공합니다
							</p>
								
							<button class="btn btn-light px-5 rounded-pill shadow-sm">Thunder&nbsp;<i class="fas fa-bolt"></i></button>
						</div>
					</div>
				</div>
			</div>
			<!-- about Us 메뉴2 끝 -->
			
			
			<!-- about Us 메뉴3 시작 -->
			<div class="bg-light py-5 menu3">
				<div class="container py-5">
					<div class="row mb-4">
						<div class="col-lg-5">
							<h3 class="display-4 font-weight-light"><b>Our Team</b></h3>
						</div>
					</div>
	
					<div class="row text-center">
						<!-- Team item-->
						<div class="col-xl-3 col-sm-6 mb-5 people">
							<div class="bg-white rounded shadow-sm py-5 px-4">
								<img src="${pageContext.request.contextPath}/img/lee.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm"><br><br>
								<h5 class="mb-0">LEE HYEIN</h5>
								<span class="small text-uppercase text-muted">DEVELOPER</span><br><br>
								
								<h6 style="color: #59bfbf;"><b>"일어나, 코딩해야지.."</b></h6>
								
								<ul class="social mb-0 list-inline mt-3">
									
									<li class="list-inline-item"><a href="https://github.com/java-hyein" target="_blank" class="social-link"><i class="fab fa-github fa-2x"></i></a></li>
									
								</ul>
								
							</div>
						</div>
						<!-- End-->
	
						<!-- Team item-->
						<div class="col-xl-3 col-sm-6 mb-5">
							<div class="bg-white rounded shadow-sm py-5 px-4">
								<img src="${pageContext.request.contextPath}/img/do.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm"><br><br>
								<h5 class="mb-0">DO HEEJUNG</h5>
								<span class="small text-uppercase text-muted">DEVELOPER</span><br><br>
								
								<h6 style="color: #59bfbf;"><b>"GIT PUSH AND RUN"</b></h6>
								<ul class="social mb-0 list-inline mt-3">
									
									<li class="list-inline-item"><a href="https://github.com/doeez" target="_blank" class="social-link"><i class="fab fa-github fa-2x"></i></a></li>
									
								</ul>
							</div>
						</div>
						<!-- End-->
	
						<!-- Team item-->
						<div class="col-xl-3 col-sm-6 mb-5">
							<div class="bg-white rounded shadow-sm py-5 px-4">
								<img src="${pageContext.request.contextPath}/img/park.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm"><br><br>
								<h5 class="mb-0">PARK CHANGYEONG</h5>
								<span class="small text-uppercase text-muted">DEVELOPER</span><br><br>
								<h6 style="color: #59bfbf;"><b>"스택오버플로우는 내 친구"</b></h6>
								
								<ul class="social mb-0 list-inline mt-3">
									<li class="list-inline-item"><a href="https://github.com/rtnbrnch" target="_blank" class="social-link"><i class="fab fa-github fa-2x"></i></a></li>
								</ul>
							</div>
						</div>
						<!-- End-->
	
						<!-- Team item-->
						<div class="col-xl-3 col-sm-6 mb-5">
							<div class="bg-white rounded shadow-sm py-5 px-4">
								<img src="${pageContext.request.contextPath}/img/kim.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm"><br><br>
								<h5 class="mb-0">KIM MINYOUNG</h5>
								<span class="small text-uppercase text-muted">DEVELOPER</span><br><br>
								
								<h6 style="color: #59bfbf;"><b>"3년뒤, 카카오에서 만나요!"</b></h6>
								
								<ul class="social mb-0 list-inline mt-3">
									
									<li class="list-inline-item"><a href="https://github.com/mykim8710" target="_blank" class="social-link"><i class="fab fa-github fa-2x"></i></a></li>
									
								</ul>
							</div>
						</div>
						<!-- End-->
	
					</div>
				</div>
			</div>
			<!-- about Us 메뉴3 끝 -->
			
			<!-- about Us 메뉴4 시작 -->	
			<div class="bg-white py-5 menu4" id="cu">
				<div class="container py-5">
					<div class="row mb-4">
						<div class="col-lg-5">
							<h3 class="display-4 font-weight-light"><b>Contact US</b></h3>
						</div>
						<br>
					</div>
						
					<div class="row caMain">
						<div class="col-md-8">
							<form class="gform" name="formQna" action="https://script.google.com/macros/s/AKfycbxe7wfW0c7kH6TvOWXu6CGUgPh2kZkUo9wzFMRIW_o0I2C_Mp3D/exec" method="post">
								<input class="form-control" type="text" name="nickname" placeholder="이름" value="${loginUser.uNickname}"/><br>
								<input class="form-control" type="text" name="phone" placeholder="연락처" value="${loginUser.uPhone}"/><br>
								<input class="form-control" type="text" name="email" placeholder="e-mail"/><br>
								<textarea class="form-control" name="message" placeholder="문의사항을 입력해주세요."></textarea><br>
								<input id="qnaBtn" class="btn btn-primary" type="submit" value="보 내 기" /><br><br>
							</form>
						</div>
						
						<div class="col-md-4">
							<div align="center">
								<h4><b>Contact Info</b></h4><br><br>
							</div>
							
							<div class="cainfo">
								<i class="fas fa-building"></i>&nbsp;&nbsp;&nbsp;&nbsp;<b>Team BBANG-BBANG</b><br><br>
								<i class="fas fa-home"></i>&nbsp;&nbsp;&nbsp;&nbsp;<b>MapoGu BackBum-ro 23 Seoul</b><br><br>
								<i class="fas fa-envelope"></i>&nbsp;&nbsp;&nbsp;&nbsp;<b>bit.eepp@gmail.com</b><br><br>
								<i class="fas fa-phone"></i>&nbsp;&nbsp;&nbsp;&nbsp;<b>+082 02 707 0491</b><br><br>
								<i class="fas fa-print"></i>&nbsp;&nbsp;&nbsp;&nbsp;<b>+082 02 707 0495</b><br><br>
							</div>
						</div>
					</div>

				</div>
			</div>
		</section>

	
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
	
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->
		
		<script data-cfasync="false" type="text/javascript" src="https://cdn.rawgit.com/dwyl/html-form-send-email-via-google-script-without-server/master/form-submission-handler.js"></script>
		<script src="${pageContext.request.contextPath}/js/common.js"></script>
	</body>
</html>