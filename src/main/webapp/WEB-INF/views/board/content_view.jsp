<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<td>bId</td>
				<td>user_id</td>
				<td>bTitle</td>
				<td>bContent</td>
				<td>bSubject</td>
				<td>bCategory</td>
				<td>bWrittenDate</td>
				<td>bModifyDate</td>
				<td>bHit</td>
				<td>bLike</td>
				<td>bUnlike</td>
				<td>bBlind</td>
			</tr>
			
			<c:forEach items="${boardList}" var="vo">
			<tr>
				<td>${vo.bId}</td>
				<td>${vo.user_id}</td>
				<td>${vo.bTitle}</td>
				<td>${vo.bContent}</td>
				<td>${vo.bSubject}</td>
				<td>${vo.bCategory}</td>
				<td>${vo.bWrittenDate}</td>
				<td>${vo.bModifyDate}</td>
				<td>${vo.bHit}</td>
				<td>${vo.bLike}</td>
				<td>${vo.bUnlike}</td>
				<td>${vo.bBlind}</td>
			</tr>
			</c:forEach>

		</table>
	</body>
</html>