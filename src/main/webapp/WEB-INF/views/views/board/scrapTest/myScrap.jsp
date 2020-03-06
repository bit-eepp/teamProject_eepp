<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>내 스크랩</title>
	</head>
	
	<body>
		<h3>myScrapPage 입니다.</h3>
		<button type="button" onclick="location.href='/eepp/board/boardList'">직무 Community</button>
		<button type="button" onclick="location.href='/eepp/class/classList'">Class강좌</button>
		
		<h4>직무 Community 스크랩</h4>
		<table border="1">
			<tr>
				<td>스크랩번호</td>
				<td>스크랩 게시물</td>
				<td>스크랩 일시</td>
			</tr>
			<c:forEach items="${myScrapListB}" var="scrapB">
				<tr>
					<td>${scrapB.sId}</td>
					<td><a style="text-decoration: none" href="/eepp/board/contentView?bId=${scrapB.board_id}&searchType=&keyword=&sortType=&bCategory=">${scrapB.bTitle}</a></td>
					<td>${scrapB.sDate}</td>
				</tr>
			</c:forEach>
		</table>
		<hr>
		<br>
		
		<h4>Class강좌 스크랩</h4>
		<table border="1">
			<tr>
				<td>스크랩번호</td>
				<td>스크랩 Class강좌</td>
				<td>스크랩 일시</td>
			</tr>
			<c:forEach items="${myScrapListC}" var="scrapC">
				<tr>
					<td>${scrapC.sId}</td>
					<td><a style="text-decoration: none" href="/eepp/class/classView?cId=${scrapC.class_id}&searchType=&keyword=&cCategory=">${scrapC.cTitle}</a></td>
					<td>${scrapC.sDate}</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>