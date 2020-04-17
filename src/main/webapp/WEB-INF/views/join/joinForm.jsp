<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EE 회원가입</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login_join/loginAndJoin.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<div class="joinForm-wrapper container col-md-8">
	<section class="sc-welcome">
		<p class="welcomeEE">WELCOME TO EE!</p>
		<p class="subTitle">Community EE에 오신것을 환영합니다.<br>
			회원가입하신 후 EE의 다양한 서비스를 이용해보세요.</p>
	</section>
	
	<section class="sc-agreement">
		<div class="agreement-wrap">
		
			<h1 class="sc-title">약관동의</h1>
			
			<div id="ermsOfuse" class="agree_content">
				<p>
					1조 (목적 등)<br> <br> 1. 이 서비스 약관은 회원이 ㈜TT(이하 ""회사"")에서 제공하는
					인터넷 사이트 Community EE(www.EETT.com) 서비스(이하 ""서비스"")를 이용함에 있어 회사와 회원
					간의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.<br> 2. 회원이 되고자 하는 이용자가 회사가
					정한 소정의 절차를 거쳐서 ""동의"" 버튼을 누르면 본 약관에 동의하는 것으로 간주합니다. 본 약관에 정하는 이외의
					회사와 회원의 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.<br>
					<br> 제2조 (회원의 정의)<br> <br> 회원이란 회사가 제공하는 서비스에 접속하여 본
					약관에 따라 회원으로 가입하여 서비스를 제공받는 자를 말합니다.<br> <br> 제3조 (서비스 이용
					계약)<br> <br> 1. 회원 가입을 희망하는 이용자는 회사가 정한 가입 양식에 따라 회원정보를
					기입하고 ""동의"" 버튼을 누르는 방법으로 회원 가입을 신청합니다.<br> 2. 회사는 제1항과 같이 회원으로
					가입을 신청한 자가 다음 각 호에 해당하지 않는 한 신청한 자를 회원으로 등록합니다.<br> - 등록 내용에
					허위, 기재누락, 오기가 있는 경우<br> - 제6조 제2항에 해당하는 회원 자격 제한 및 정지, 상실을 한
					경험이 있었던 경우<br> - 기타 회원으로 등록하는 것이 회사의 서비스 운영 및 기술상 현저히 지장이 있다고
					판단되는 경우<br> <br> 3. 회원가입계약의 성립시기는 회사의 승낙이 가입신청자에게 도달한
					시점으로 합니다.<br> <br> 4. 회원은 제1항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시
					변경사항을 정정하여 기재하여야 합니다.<br> <br> 제4조 (서비스의 제공 및 변경)<br>
					<br> 1. 회사는 회원에게 아래와 같은 서비스를 제공합니다.<br> - Community
					EE(http://www.EETT.com) 서비스<br> - 회사가 자체 개발하거나 다른 회사와의 협력계약 등을
					통해 회원들에게 제공할 일체의 서비스<br> <br> 2. ""서비스제공자""는 그 변경될 서비스의
					내용 및 제공일자를 제7조 제2항에서 정한 방법으로 이용자에게 통지하고, 제1항에 정한 서비스를 변경하여 제공할 수
					있습니다.<br> <br> 제5조 (서비스의 중단)<br> 1. 회사는 컴퓨터 등
					정보통신설비의 보수점검/교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수
					있고, 새로운 서비스로의 교체 기타 ""서비스제공자""가 적절하다고 판단하는 사유에 기하여 현재 제공되는 서비스를 완전히
					중단할 수 있습니다.<br> 2. 제1항에 의한 서비스 중단의 경우에는 ""서비스제공자""는 제7조 제2항에서
					정한 방법으로 ""회원""에게 통지합니다. 다만, 회사가 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의
					고의. 중과실이 없는 시스템 장애 또는 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.<br>
					<br> 제6조 (회원 탈퇴 및 자격 상실 등)<br> <br> 1. 회원은 회사에 언제든지
					자신의 회원등록 정보를 말소해 줄 것(회원 탈퇴)을 요청할 수 있으며 회사는 위 요청을 받은 즉시 해당 회원의 정보
					말소를 위한 절차를 시행합니다.<br> 2. 회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원의 자격을
					적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다.<br> - 허위 내용을 등록한 경우<br> -
					다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우<br> - 서비스를
					이용하여 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우<br> <br> 3. 회사가
					회원의 회원자격을 상실시키기로 결정한 경우에는 회원등록 정보를 말소합니다.<br> <br> 4.
					이용자가 서비스 이용 도중 12개월 이상 로그인 기록이 없는 경우, 회사는 해당 회원의 자격을 상실시킬 수 있습니다.<br>
					<br> 제7조 (회원에 대한 통지)<br> <br> 1. 회사가 특정 회원에게 서비스에 관한
					통지를 하는 경우 회원정보에 등록된 메일주소를 사용할 수 있습니다.<br> <br> 2. 회사가
					불특정다수 회원에 대한 통지를 하는 경우 7일 이상 공지사항 게시판 혹은 관련 서비스 게시판에 게시함으로써 개별 통지에
					갈음할 수 있습니다.<br> <br> 이 약관은 2020 3월 1일부터 적용하고 이전의 모든 약관의
					내용에 우선하여 적용됩니다.
				</p>
			</div>
			<p class="agreeCheck">이용약관 동의(필수)</p>
			<input id="isAgree_01" type="checkbox" name="agreement_1"/>
			
			<div id="personalInfo" class="agree_content">
				<p>
					㈜Community EE 회원가입 및 서비스 제공을 위한 개인정보 수집 및 이용에 관한 동의를 받고 있습니다.<br>
					<br> 1. 개인정보 수집, 이용 목적<br> <br> Community EE는 회원관리,
					서비스 제공 등 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는
					이용되지 않으며, 이용 목적이 변경되는 경우에는 정보통신망법 제22조(개인정보의 수집ㆍ이용 동의 등)에 따라 별도의
					동의를 받는 등 필요한 조치를 이행할 것입니다.<br> <br> - 회원 가입 의사의 확인, 연령
					확인, 이용자본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를위하여 개인정보를 이용합니다.<br>
					- Community EE 서비스 제공, 관심에 기반한 이용자간 관계의 형성, 기존 서비스 개선 등을 위하여 개인정보를
					이용합니다.<br> - 민원인의 신원확인, 민원사항 확인, 사실조사를 위한 연락, 통지, 처리 결과 통보 등의
					목적으로 개인정보를 처리합니다. 또한 범죄의 예방 및 수사를 위한 요청 시 개인정보를 처리합니다. 자살시도의 개연성이
					충분한 게시물에 대해 경찰청의 요청이 있는 경우, 자살구호 및 예방의 목적으로 게시물 작성자의 인적사항, 연락처 등의
					개인정보를 처리합니다.<br> - 법령 및 Community EE 이용약관을 위반하는 회원에 대한 이용 제한
					조치, 부정 이용행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및
					부정거래방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록보존, 민원처리 등 이용자 보호 및 서비스 운영을
					위하여 개인정보를 이용합니다.<br> - 이벤트 정보 및 참여기회 제공 등을 위하여 개인정보를 이용합니다.<br>
					<br> 2. 수집하는 개인정보의 항목<br> <br> 회원제 서비스를 이용하기 위해
					회원가입을 할 경우, Community EE는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다. 회원가입 시점에
					Community EE가 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br> <br> - 개인
					회원<br> [필수항목]: 이메일, 비밀번호, 닉네임, 핸드폰 번호<br> [선택항목]: 기본정보
					프로필 사진<br> <br> 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로
					생성되어 수집될 수 있습니다.<br> - IP 주소, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록<br>
					<br> 3. 개인정보 이용기간 및 파기<br> <br> ① 이용자의 개인정보는 원칙적으로
					개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다.<br> 다만, 관련 법령에 의하여 보존할 필요가
					있는 경우 아래와 같이 관련 법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.<br> <br>
					[전자상거래 등에서의 소비자보호에 관한 법률]<br> - 계약 또는 청약철회 등에 관한 기록 : 5년 보관<br>
					- 대금결제 및 재화 등의 공급에 관한 기록 : 5년 보관<br> - 소비자의 불만 또는 분쟁처리에 관한 기록
					: 3년 보관<br> <br> [통신비밀보호법]<br> - 로그인 기록 : 3개월<br>
					<br> ② 회원 탈퇴를 요청하거나 개인정보의 수집 및 이용에 대한 동의를 철회하는 경우, 개인정보를 지체 없이
					파기합니다.<br> <br> 정보통신망법 제29조(개인정보의 파기)에 따라 1년 동안 서비스를 이용하지
					않은 이용자의 개인정보를 별도로 분리 보관하여 관리하고 있습니다.<br> <br> ③ 회사는 개인정보의
					수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다.
				</p>
			</div>
			<p class="agreeCheck">개인정보수집 및 이용에대한 안내(필수)</p>
			<input id="isAgree_02" type="checkbox" name="agreement_2"/>
			
		</div>
	</section>

	<section class="sc-registerForm">
		<div class="registerForm-wrap">
			<h1 class="sc-title">회원가입</h1>
			
			<div class="container">
			<c:choose>
			
			<c:when test="${not empty user.uEmail}">
			<form method="POST" id="joinSnsForm" name="JoinSnsForm" action="joinWithSns.me" class="py-3" enctype="multipart/form-data">
				<input type="hidden" name="uEmail" value="${user.uEmail}">
				<input type="hidden" name="snsType" value="${user.snsType}">
				
				<div class="form-group">
					<table class="joinTable">
					<tbody>
					<tr class="idInputBox">
						<th class="input-title"><span class="required">&#8226;</span>아이디</th>
						<td class="snsEmail">${user.uEmail}</td>
					</tr>
					
					<tr class="nickInputBox">
						<th class="input-title"><span class="required">&#8226;</span>닉네임</th>
						<td>
						<input name="uNickname" id="joinNickname" maxlength="8" class="lg-inputBox" oninput="nickCheck();">
						<span class="checkInfo" id="checkNickInfo"></span>
						</td>
					</tr>
					
					<tr class="phoneInputBox">
					<th class="input-title"><span class="required">&#8226;</span>핸드폰 번호</th>
					<td>
					<select name="uPhone_1" class="custom-select" id="uPhone">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
						<option value="080">080</option>
					</select> 
					- <input type="text" class="uPhone_2" name="uPhone_2" maxlength="4" size="6" oninput="phoneCheck()" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
					- <input type="text" class="uPhone_3"  name="uPhone_3" maxlength="4" size="6" oninput="phoneCheck()" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
					<span class="checkInfo" id="checkPhoneInfo"></span>
					<button type="button" class="sendSmsBtn joinBtn" id="phoneNumCheck" value="N">인증번호 전송</button>
					</td>
					</tr>
					
					<tr id="afterSendSMSAuth">
					<th class="input-title"></th>
					<td class="checkEmailAuth">
					<div>
						<input type="text" name="smsAuth" id="smsAuth">
						<input type="hidden" name="random" id="random">
						<button type="button" class="smsCheckBtn joinBtn" id="smsAuthBtn" value="N">확인</button>
					</div>
					</td>
					</tr>
					
					<tr class="profileInputBox">
					<th class="input-title"><span class="required">&#8226;</span>프로필 설정</th>
					<td>
					<div class= "profile">
						<img src="${pageContext.request.contextPath}/img/headerLogin.png" class="basic_img"/>
								<div class="choosePick">
								 <input type="text" readonly="readonly" id="file_route">
								 <label>이미지 선택
								 <input type="file" id="showImg" name="file" onchange="javascript:document.getElementById('file_route').value=this.value">
								 </label>
						<p class="info_profile">이미지 설정이 없을 시 기본 프로필 사진으로 설정 됩니다.<br>프로필은 마이페이지에서도 변경이 가능합니다.</p>
						</div>
					</div>
					<!-- profile -->
					</td>
					</tr>
					</tbody>
					</table>
				</div>

					<button type="submit" class="btn btn-submit" id="submit">회원가입</button>

			</form>
			</c:when>

			<c:otherwise>
			<form method="POST" id="joinNormalForm" name="joinNormalForm" action="join.me" class="py-3" enctype="multipart/form-data">
			
				<div class="form-group">
					<table class="joinTable">
					<tbody>
					<tr class="idInputBox">
						<th class="input-title"><span class="required">•</span>아이디</th>
						<td>
						<input type="text" name="email_01" id="email_01" class="email_input_01 emailInput" onchange="checkEmail()">&nbsp;@&nbsp;
						<input type="text" name="email_02" id="email_02" class="email_input_02 emailInput">
						<select class="custom-select" name="selectEmail" id="emailSelection" onchange="checkEmail()">
							<option value="" selected>직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="dreamwiz.com">dreamwiz.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						
						<span class="checkInfo" id="checkEmailInfo"></span>
						</td>
					</tr>
					
					<tr class="pwInputBox">
					<th class="input-title"><span class="required">&#8226;</span>비밀번호</th>
					<td><input type="password" name="uPassword" id="uPassword" class="lg-inputBox pwInputBox"></td>
					</tr>
					
					<tr class="pwInputBox">
					<th class="input-title"><span class="required">&#8226;</span>비밀번호 재입력</th>
					<td>
						<input type="password" name="uPasswordCheck" id="uPasswordCheck" class="lg-inputBox pwInputBox" oninput="passWordCheck()">
						<span class="checkInfo" id="checkPwInfo"></span>
					</td>
					</tr>
					
					<tr class="nickInputBox">
					<th class="input-title"><span class="required">&#8226;</span>닉네임</th>
					<td>
					<input name="uNickname" id="joinNickname" maxlength="8" class="lg-inputBox" oninput="nickCheck();">
					<span class="checkInfo" id="checkNickInfo"></span>
					</td>
					</tr>
					
					<tr class="phoneInputBox">
					<th class="input-title"><span class="required">&#8226;</span>핸드폰 번호</th>
					<td>
					<select name="uPhone_1" class="custom-select" id="uPhone">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
						<option value="080">080</option>
					</select> 
					- <input type="text" class="uPhone_2" name="uPhone_2" maxlength="4" size="6" oninput="phoneCheck()" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
					- <input type="text" class="uPhone_3"  name="uPhone_3" maxlength="4" size="6" oninput="phoneCheck()" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
					<span class="checkInfo" id="checkPhoneInfo"></span>
					<button type="button" class="sendSmsBtn joinBtn" id="phoneNumCheck" value="N">인증번호 전송</button>
					</td>
					</tr>
					
					<tr id="afterSendSMSAuth">
					<th class="input-title"></th>
					<td class="checkEmailAuth">
					<div>
						<input type="text" name="smsAuth" id="smsAuth">
						<input type="hidden" name="random" id="random">
						<button type="button" class="smsCheckBtn joinBtn" id="smsAuthBtn" value="N">확인</button>
					</div>
					</td>
					</tr>
					
					<tr class="profileInputBox">
					<th class="input-title"><span class="required">&#8226;</span>프로필 설정</th>
					<td>
					<div class= "profile">
						<img src="${pageContext.request.contextPath}/img/headerLogin.png" class="basic_img"/>
								<div class="choosePick">
								 <input type="text" readonly="readonly" id="file_route">
								 <label>이미지 선택
								 <input type="file" id="showImg" name="file" onchange="javascript:document.getElementById('file_route').value=this.value">
								 </label>
						<p class="info_profile">이미지 설정이 없을 시 기본 프로필 사진으로 설정 됩니다.<br>프로필은 마이페이지에서도 변경이 가능합니다.</p>
						</div>
					</div>
					<!-- profile -->
					</td>
					</tr>
				</tbody>
				</table>
			</div>
			
			<button type="submit" class="btn btn-submit" id="submit">회원가입</button>
		</form>
		</c:otherwise>
	</c:choose>
	</div>
	</div>
	
</section>
</div>

<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->

<script src="${pageContext.request.contextPath}/js/join.js"></script>
</body>
</html>