<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<title>Class Main</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			// 게시물 검색
			$('#classSearchBtn').click(function() {
				if($('select[name=searchType]').val() == 'n') {
					alert('검색조건을 지정해주세요');
					return;
				} else {
					self.location = "classList" + '${classPageMaker.makeQuery(1)}' + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) +"&cCategory=${cCategory}";
				}
			});
			
			// 게시글 n개씩 보기
			$('#cntPerPage').change(function() {
				var totalCount = ${classPageMaker.totalCount};
				var perPageNum = this.value;
				var page = ${classPageMaker.cri.page};
				
				if(perPageNum * page > totalCount) {
					alert('정렬이 불가합니다.');
					return;
				} else {
					location.href="classList?page=${classPageMaker.cri.page}&perPageNum=" +perPageNum +"&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}";
				}
			});
			
			var title = '${cCategory}';
			classTitle(title);
		});
		
		// 게시판 타이틀 
		function classTitle(title) {
			if(title == '') {
				$('.classTitle').append('<h2>전체 CLASS 강좌</h2>');
			} else if(title == 'it_dev') {
				$('.classTitle').append('<h2>IT/개발 관련 CLASS 강좌</h2>');
			} else if(title == 'workSkill') {
				$('.classTitle').append('<h2>업무스킬 관련 CLASS 강좌</h2>');
			} else if(title == 'daily') {
				$('.classTitle').append('<h2>일상관련 CLASS 강좌</h2>');
			} else if(title == 'financialTechnology') {
				$('.classTitle').append('<h2>재테크 관련 CLASS 강좌</h2>');
			} else if(title == 'etc') {
				$('.classTitle').append('<h2>기타 CLASS 강좌</h2>');
			} 
		}
	</script>	
				
		<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() {
				$("ul.sub").hide();
				$("ul.menu li").hover(function() {
					$("ul:not(:animated)", this).slideDown("fast");
				}, function() {
					$("ul", this).slideUp("fast");
				});
			});
		</script>

		<style type="text/css">
			/* ~ 리스트 모양 숨김~ */
			* {
				margin: 0;
				padding: 0;
				list-style-type: none;
			}
			
			/* ~ 최상단 기본 메뉴 바 ~ */
			#container {
				margin: 100px auto;
				width: 537px;
			}
			
			ul.menu li {
				float: left;
				width: 179px;
				height: 48px;
				background-color: #555;
				position: relative;
			}
			
			ul.menu li a {
				display: block;
				align: center;
				width: 100%;
				height: 100%;
				line-height: 48px;
				text-indent: 30px;
				font-weight: bold;
				color: #eee;
				text-decoration: none;
			}
			
			ul.menu li a:hover {
				background-color: #333;
			}
			
			ul.menu li ul.sub {
				position: absolute;
			}
			
			ul.menu {
				zoom: 1;
			}
			
			ul.menu:after {
				height: 0;
				visibility: hidden;
				content: ".";
				display: block;
				clear: both;
			}
			
			ul.menu li a {
				display: block;
				align: center;
				width: 100%;
				height: 100%;
				line-height: 48px;
				text-indent: 30px;
				font-weight: bold;
				color: #eee;
				text-decoration: none;
			}
			
			ul.menu li a:hover {
				background-color: #333;
			}
		</style>
	
		상단 버튼 메뉴
		<style type="text/css">
			.btnmenu {
				margin: 80px auto;
				border: 1;
				font-size: 15px;
				position: relative;
				top: 0;
				margin-top: 75px;
				margin-left: -6px;
				width: 25%;
				height: 48px;
				text-align: center;
				box-sizing: border-box;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				-webkit-user-select: none;
				cursor: default;
			}
		</style> -->
	</head>


	<body>
		<!-- 최상단 기본 메뉴 바<br>
		<div id="container">
			<ul class="menu">
				<li><a href="#" align="center">JOB</a>
					<ul class="sub">
						<li><a onclick="location.href='#'">IT</a></li>
						<li><a onclick="location.href='#'">SERVICE</a></li>
						<li><a onclick="location.href='#'">DESIGN</a></li>
						<li><a onclick="location.href='#'">OFFICIAL</a></li>
						<li><a onclick="location.href='#'">ETC</a></li>
					</ul>
				<li><a href="#">ENTERTAINMENT</a>
					<ul class="sub">
						<li><a onclick="location.href='#'">WHAT TO EAT?</a></li>
						<li><a onclick="location.href='#'">MINI GAME</a></li>
						<li><a onclick="location.href='#'">Today's Lucky</a></li>
					</ul>
				<li><a href="#" align="center">CLASS</a>
					<ul class="sub">
						<li><a onclick="location.href='#'">IT</a></li>
						<li><a onclick="location.href='#'">업무스킬</a></li>
						<li><a onclick="location.href='#'">재태크</a></li>
						<li><a onclick="location.href='#'">디자인</a></li>
					</ul></li>
			</ul>
		</div>
		<br>
		<br> -->

		<h1 class="classTitle"></h1>
		<button type="button" onclick="location.href='/eepp/board/boardList'">직무 Community</button>
		<button type="button" onclick="location.href='classOpenView${classPageMaker.makeQuery(classPageMaker.cri.page)}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'">강좌개설</button>
		<button type="button" onclick="location.href='/eepp/scrap/myScrapList'">스크랩 확인</button>
		<hr>
		<br>
		
		<!--Class강좌 카테고리 -->
		<div>
			<button onclick="location.href='classList'">All</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=it_dev'">IT/개발</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=workSkill'">업무스킬</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=financialTechnology'">재테크</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=daily'">일상</button>&nbsp;&nbsp;&nbsp;
			<button onclick="location.href='classList?&cCategory=etc'">기타</button>
		</div>
		<hr>
		<br>
		
		<!-- class강좌 n개씩 보기 -->
		<div>
			<select id="cntPerPage" name="perPageNum">
				<option value="3"  <c:out value="${classPageMaker.cri.perPageNum eq '3' ? 'selected' : ''}"/>>3개씩 보기</option>
				<option value="6" <c:out value="${classPageMaker.cri.perPageNum eq '6' ? 'selected' : ''}"/>>6개씩 보기</option>
				<option value="9" <c:out value="${classPageMaker.cri.perPageNum eq '9' ? 'selected' : ''}"/>>9개씩 보기</option>
				<option value="12" <c:out value="${classPageMaker.cri.perPageNum eq '12' ? 'selected' : ''}"/>>12개씩 보기</option>
				<option value="15" <c:out value="${classPageMaker.cri.perPageNum eq '15' ? 'selected' : ''}"/>>15개씩보기</option>
				<option value="18" <c:out value="${classPageMaker.cri.perPageNum eq '18' ? 'selected' : ''}"/>>18개씩 보기</option>
			</select>&nbsp;&nbsp;&nbsp;
		</div>
		<hr>
		<br>
		
		<!-- 검색 부분  -->
		<div class="search">
			<select name="searchType">
				<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
				<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>개설자</option>
				<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>강좌명</option>
				<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>강좌내용</option>
				<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>강좌명 + 강좌내용</option>
			</select> 
			
			<input type="text" name="keyword" id="keywordInput" value="${cscri.keyword}" />
			<button id="classSearchBtn" type="button">검색</button>
		</div>
		<!-- 검색 부분 끝  -->
		<hr>
		
		<!-- 페이징 -->
		<div>
			<c:if test="${classPageMaker.prev}">
				<a style="text-decoration: none" href="classList${classPageMaker.makeSearch(classPageMaker.startPage - 1)}&cCategory=${cCategory}"> « </a>
			</c:if>
			
			[<c:forEach begin="${classPageMaker.startPage}" end="${classPageMaker.endPage}" var="idx">
				<a style="text-decoration: none" href="classList${classPageMaker.makeSearch(idx)}&cCategory=${cCategory}">${idx}</a>
			</c:forEach>]
	
			<c:if test="${classPageMaker.next && classPageMaker.endPage > 0}">
				<a style="text-decoration: none" href="classList${classPageMaker.makeSearch(classPageMaker.endPage + 1)}&cCategory=${cCategory}"> » </a>&nbsp;&nbsp;
			</c:if>
		</div>
		
		<!-- 클래스 리스트 -->
		<div>
			<c:choose>
				<c:when test="${fn:length(classList) > 0 }">
					<c:forEach items="${classList}" var="cl">
						<span>
							<table width="300", align="center", style="float: left; width: 33%; padding: 10px; font-size: 10pt;" cellspacing="2" cellpadding="1" border="1">
								<tr>
									<td colspan="2"><img
										src="data:image/jpeg;base64,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">
									</td>
								</tr>
								<tr>
									<td>강좌번호</td>
									<td>${cl.cId}</td>
								</tr>
								<tr>
									<td>강좌명</td>
									<td>${cl.cTitle}</td>
								</tr>
								<tr>
									<td>한줄요약</td>
									<td>${cl.cSummary}</td>
								</tr>
								<tr>
									<td>개설자</td>
									<td>${cl.uNickname}</td>
								</tr>
								<tr>
									<td>분 류</td>
									<td>${cl.cCategory}</td>
								</tr>
								<tr>
									<td>개설일</td>
									<td><fmt:formatDate value="${cl.cOpenDate}" pattern="yyyy-MM-dd" /></td>
								</tr>
								<tr>
									<td>개설만료일</td>
									<td><fmt:formatDate value="${cl.cEndDate}" pattern="yyyy-MM-dd" /></td>
								</tr>
								<tr>
									<td>개설기간</td>
									<td>${cl.cTerm}일</td>
								</tr>
								<tr>
									<td>포인트 가격</td>
									<td>${cl.cPrice}</td>
								</tr>
								<tr>
									<td>모집인원</td>
									<td>${cl.cTotalPeopleCount}</td>
								</tr>
								<tr>
									<td>현재참여인원</td>
									<td>${cl.cCurrentPeopleCount}</td>
								</tr>
								<tr>
									<td>난이도</td>
									<td>${cl.cDifficulty}</td>
								</tr>
								<tr>
									<td>준비물</td>
									<td>${cl.cMaterials}</td>
								</tr>
								<tr>
									<td colspan="2"><button type="button" onclick="location.href='classView${classPageMaker.makeQuery(classPageMaker.cri.page)}&cId=${cl.cId}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'">상세정보</button></td>
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
		<hr>
	</body>
</html>