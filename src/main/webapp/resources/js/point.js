//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

function pointBtn() {
	
	var IMP = window.IMP; // 생략가능
	IMP.init('imp85104859'); // "가맹점 식별코드"

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
		buyer_email : $(".userEmail").val(), // 구매자의 이메일
		buyer_name : $(".userNickname").val(), // 구매자의 이름
		m_redirect_url : getContextPath() // 모바일 결제 후 이동될 주소
	}, function(rsp) { // callback
		
		if (rsp.success) { // 결제 성공 시
			var msg = realPoint + "포인트가 충전되었습니다.";
		 			
			// 결제한 금액 포인트로 전환
			$.ajax({
				url : getContextPath() + "/changeToPoint",
				type : "post",
				data : {
					"user_id": $(".userID").val(),
					"uEmail": $(".userEmail").val(),
					"point" : realPoint
				},
				success : function(result) {
					$('#charge_point').modal('hide');
					$('.modal-backdrop').remove();
				},
				error : function(xhr, status, error) {
					alert("포인트 충전에 실패했습니다.")
				}
			})
		} else { // 결제 실패 시
			var msg = '결제에 실패하였습니다.';
			console.log('에러내용 : ' + rsp.error_msg)
		}
		
		 	alert(msg);
		 	resetForm();
		 	location.href= getContextPath()+"/mypage?showInfo=showInfo"
	});
}

function resetForm() {
	$('#charge_point').on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}
