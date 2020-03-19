<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 포인트</title>
<!-- 아임포트 결제 API 라이브러리 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- // 아임포트 결제 API 라이브러리 -->
<!-- 아임포트 결제 API -->
</head>
<body>
	<script>
//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

	function payBtn_click() {
	var IMP = window.IMP; // 생략가능
	IMP.init('imp85104859'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	/* 충전 포인트가 30000포인트 이하일시 결제금액 10퍼센트 추가시킴 */
	var selValue = $('input:radio[name="chPoint"]:checked').val();
	var result = Number(selValue)
	if(result <= 30000){
		result += (result * (10 / 100))
		selValue = result.toString()
	}
	/* 충전되는 포인트 */
	var realPoint = $('input:radio[name="chPoint"]:checked').val();
	
	//포인트 충전금액
		IMP.request_pay({
			pg : 'inicis', 
		 	pay_method : 'card', // 충전 유형
		 	merchant_uid : 'merchant_' + new Date().getTime(), // 고유 주문 번호
			name : 'Community EE 포인트 충전', // 주문 명
		 	amount : selValue, // 충전할 금액
		 	buyer_email : $(".userEmail").val(), // 구매자의 이메일 받아와야함
		 	buyer_name : $(".userNickname").val(), // 구매자의 이름 받아와야함
		 	m_redirect_url : getContextPath() // 모바일 결제 후 이동될 주소
		 }, function(rsp) { // callback(결제가 완료 후 실행되는 함수)
		 		if (rsp.success) { // 결제 성공 시  로직
		 			var msg = realPoint + "포인트가 충전되었습니다.";
		 			/* msg += '고유ID : ' + rsp.imp_uid;
		 			msg += '상점 거래ID : ' + rsp.merchant_uid;
		 			msg += '결제 금액 : ' + rsp.paid_amount;
		 			msg += '카드 승인번호 : ' + rsp.apply_num; */
		 			
					// 결제한 금액 포인트로 전환
					$.ajax({
						url : getContextPath() + "/changeToPoint",
						type : "post",
						data : {
							"user_id": $(".userID").val(),
							"point" : realPoint
						},
						success : function(result) {
							$('#charge_point').modal('hide');
						},
						error : function(xhr, status, error) {
						alert("포인트 충전에 실패했습니다.")
						}
					})
			 } else { // 결제 실패 시  로직
				 var msg = '결제에 실패하였습니다.';
				 console.log('에러내용 : ' + rsp.error_msg)
		 	}
		 	alert(msg);
		 	resetForm();
		 });
	}
	function resetForm() {
		$('#charge_point').on('hidden.bs.modal', function (e) {
			$(this).find('form')[0].reset()
		});
		location.href=getContextPath()+"/myPage";
	}
</script>

</head>
<body>


	<input type="hidden" class="userEmail" value="${loginUser.uEmail}">
	<input type="hidden" name="userID" class="userID" value="${loginUser.user_id}">
	<input type="hidden" class="userNickname" value="${loginUser.uNickname}">

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
									<span>충전 포인트</span> <span class="tit_cost">결제금액(Vat포함)</span>
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
									<span>1,0000포인트</span>
									<span class="cost">1,1000원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="30000">
									<span>3,0000포인트</span>
									<span class="cost">3,3000원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="55000">
									<span>55,000포인트(5000p 보너스)</span>
									<span class="cost">55,000원</span>
								</label>
								<label>
									<input type="radio" name="chPoint" value="77000">
									<span>77,000포인트(7000p 보너스)</span>
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
					<button type="button" class="btn chargeBtn" onclick="payBtn_click();">충전하기</button>
				</div>
				<!-- Footer -->

			</div>
			<!-- modal-content -->
		</div>
		<!-- modal-dialog -->
	</div>
	<!-- modal -->
</body>
</html>