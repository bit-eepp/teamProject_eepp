<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>직장인을 위한 코로나19 예방 캠페인</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		
		<script type="text/javascript">
			function setCookie(name, value, expiredays) {
		        var date = new Date();
		        date.setDate(date.getDate() + expiredays);
		        document.cookie = escape(name) + "=" + escape(value) + "; expires=" + date.toUTCString();
		    }
	
		    function closePopup() {
		        if (document.getElementById("check").value) {
		            setCookie("popupYN", "N", 1);
		            self.close();
		        }
		    }
		</script>
	</head>

	<body>
		<div style="width: 100%; height: auto;">
			<a title="코로나19 정보사이트로" href="http://ncov.mohw.go.kr/" target="_blank"><img style="width: 100%; height: auto;" alt="EE캠페인1" src="${pageContext.request.contextPath}/img/popUp1.jpg"></a>
		</div>
		
		<div style="width: 100%; height: auto;">
			<a title="코로나맵" href="https://www.coronamap.co.kr/" target="_blank"><img style="width: 100%; height: auto;" alt="EE캠페인1" src="${pageContext.request.contextPath}/img/popUp2.jpg"></a>
		</div>
		
		<div style="width: 100%; height: auto;" align="right">
			<p><input type="checkbox" id="check" onclick="closePopup();">&nbsp;<b>오늘 하루 그만보기</b></p>
		</div>
	</body>
</html>