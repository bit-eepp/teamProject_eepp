<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Eating Thema List</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>

<script type="text/javascript">
	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host)
				+ location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
	};
</script>

</head>


<body>
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
	<input type="hidden" id="eatingPageMaker" value="${eatingPageMaker.makeQuery(1)}" />
	<input type="hidden" id="eCategory" value="${eCategory}" />
	<input type="hidden" id="eThema" value="${eThema}" />
	<input type="hidden" id="eatingTotalCount" value="${eatingPageMaker.totalCount}" />
	<input type="hidden" id="eatingCriPage" value="${eatingPageMaker.cri.page}" />
	<input type="hidden" id="eatingSearchType" value="${escri.searchType}" />
	<input type="hidden" id="eatingCriPage" value="${eatingPageMaker.cri.page}" />


	<br>
	<h1 type="text" class="eatingTitle" onclick="location.href='eatingList'">메인으로 가시오</h1>

	<br>
	<h1 type="text" class="themaTitle">${eThema} 보기</h1>
	<br>


	<hr>
	<!-- 해당 테마 리스트 -->
	<div class="themaList">
		<c:choose>
			<c:when test="${fn:length(themaList) > 0}">
				<c:forEach items="${themaList}" var="tl">
					<span>
						<table width="300" align="center"
							style="width: 33%; float: left; padding: 10px; font-size: 1.0rem; text-align: center;"
							cellspacing="2" cellpadding="1" border="1">
							<tr>
								<td colspan="2"><img style="width: 33%;" src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${tl.eId}.jpg">
								</td>
							</tr>
							<tr>
								<td>상호명</td>
								<td>${tl.eTitle}</td>
							</tr>
							<tr>
								<td>평점</td>
								<td>${tl.rvAVG}</td>
							</tr>
							<tr>
								<td>주소</td>
								<td>${tl.eAddress_new}</td>
							</tr>
							<tr>
								<td colspan="2"><button type="button" onclick="location.href='eatingView${eatingPageMaker.makeQuery(eatingPageMaker.cri.page)}&eId=${tl.eId}&searchType=${escri.searchType}&keyword=${escri.keyword}&eCategory=${eCategory}&eThema=${eThema}'">더
										보기!</button></td>
							</tr>
						</table>
					</span>
				</c:forEach>
			</c:when>

			<c:otherwise>
				<tr>
					<td colspan="9">조회된 결과가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</div>

	<p />
	<!-- 페이징 -->
	<div class="storePaging" align="center"
		style="float: left; padding: 20px; font-size: 2.0rem;">
		<div>
			<c:if test="${eatingPageMaker.prev}">
				<a style="text-decoration: none"
					href="eatingList${eatingPageMaker.makeSearch(eatingPageMaker.startPage - 1)}&eThema=${eThema}">
					« </a>
			</c:if>

			[
			<c:forEach begin="${eatingPageMaker.startPage}"
				end="${eatingPageMaker.endPage}" var="idx">
				<a style="text-decoration: none"
					href="eatingList${eatingPageMaker.makeSearch(idx)}&eThema=${eThema}">${idx}</a>
			</c:forEach>
			]

			<c:if test="${eatingPageMaker.next && eatingPageMaker.endPage > 0}">
				<a style="text-decoration: none"
					href="eatingList${eatingPageMaker.makeSearch(eatingPageMaker.endPage + 1)}&eThema=${eThema}">
					» </a>&nbsp;&nbsp;
			</c:if>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/js/eating/eatingMain.js"></script>
</body>
</html>