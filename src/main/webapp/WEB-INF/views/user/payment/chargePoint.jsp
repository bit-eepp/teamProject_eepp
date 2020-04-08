<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 충전</title>
<!-- 아임포트 결제 API 라이브러리 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 아임포트 결제 API -->
</head>

<body>
	<!-- 포인트 충전 modal -->
	<div class="modal fade" id="charge_point" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">포인트 충전</h4>
				</div>
				<!-- Header -->

				<!-- Modal Body -->
				<div class="modal-body">
					<form id="myPoint" role="form_myPoint" name="pform">
						<input type="hidden" name="user_id" value="${loginUser.user_id}">

						<div class="point_list">
								<div class="tit_wrap">
									<span>충전 포인트</span> <span class="tit_cost">결제금액(VAT포함)</span>
								</div>
								<div class="point_wrap">
								<label>
									<input type="radio" name="chPoint" value="1000" checked>
									<span>1,000포인트</span>
									<span class="cost">1,100원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="3000">
									<span>3,000포인트</span>
									<span class="cost">3,300원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="5000">
									<span>5,000포인트</span>
									<span class="cost">5,500원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="10000">
									<span>10,000포인트</span>
									<span class="cost">11,000원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="30000">
									<span>30,000포인트</span>
									<span class="cost">33,000원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="55000">
									<span>55,000포인트(5,000p 보너스)</span>
									<span class="cost">55,000원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="77000">
									<span>77,000포인트(7,000p 보너스)</span>
									<span class="cost">77,000원</span>
								</label>
									
								</div>
							</div>

					</form>
					<!-- declaration -->
				</div>
				<!-- modal-body -->

				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="button" class="btn chargeBtn" onclick="pointBtn();">충전하기</button>
				</div>
				<!-- Footer -->

			</div>
			<!-- modal-content -->
		</div>
		<!-- modal-dialog -->
	</div>
	<!-- modal -->
	
	<input type="hidden" class="userEmail" value="${loginUser.uEmail}">
	<input type="hidden" name="userID" class="userID" value="${loginUser.user_id}">
	<input type="hidden" class="userNickname" value="${loginUser.uNickname}">
	<script src="${pageContext.request.contextPath}/js/point.js"></script>
</body>
</html>