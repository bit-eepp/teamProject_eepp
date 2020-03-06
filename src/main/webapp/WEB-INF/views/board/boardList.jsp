<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>직무별 Community</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script>
		var uNickname = $("#userNickname").val();
		
			$(document).ready(function(){
				// 게시물 검색
				$('#searchBtn').click(function() {
					if($('select[name=searchType]').val() == 'n') {
						alert('검색조건을 지정해주세요');
						return;
					} else {
						self.location = "boardList" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) +"&sortType=${sortType}" +"&bCategory=${bCategory}";
					}
				});
				
				// 게시글 n개씩 보기
				$('#cntPerPage').change(function() {
					var totalCount = ${pageMaker.totalCount};
					var perPageNum = this.value;
					var page = ${pageMaker.cri.page};
					
					if(perPageNum * page > totalCount) {
						alert('정렬이 불가합니다.');
						return;
					} else {
						location.href="boardList?page=${pageMaker.cri.page}&perPageNum=" +perPageNum +"&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}";
					}
				});
				
				var formObj = $('form[role="form"]');
				
				$('.writeBtn').on('click', function(){
				    formObj.attr('method','post');
				    formObj.attr('action','writeView');
				    formObj.submit();
			    });				
				
				var title = '${bCategory}';
				boardTitle(title);
				
				//로그인 하지않은 경우, 새글쓰기 버튼 삭제
				if(!$("#userNickname").val()){
					$('.writeBtn').remove();
				}
			});
			
			// 게시판 타이틀 
			function boardTitle(title) {
				if(title == '') {
					$('.boardTitle').append('<h2>직장인 커뮤니티</h2>');
				} else if(title == 'notice') {
					$('.boardTitle').append('<h2>공지사항</h2>');
				} else if(title == 'it_dev') {
					$('.boardTitle').append('<h2>IT/개발 직군 커뮤니티</h2>');
				} else if(title == 'service') {
					$('.boardTitle').append('<h2>서비스 직군 커뮤니티</h2>');
				} else if(title == 'finance') {
					$('.boardTitle').append('<h2>금융 직군 커뮤니티</h2>');
				} else if(title == 'design') {
					$('.boardTitle').append('<h2>디자인 직군 커뮤니티</h2>');
				} else if(title == 'official') {
					$('.boardTitle').append('<h2>공무원 직군 커뮤니티</h2>');
				} else if(title == 'etc') {
					$('.boardTitle').append('<h2>기타 직군 커뮤니티</h2>');
				} 
			}
		</script>
	</head>
	
	<body>
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
	
		<h1 class="boardTitle"></h1>
		<button type="button" onclick="location.href='/eepp/scrap/myScrapList'">스크랩 확인</button>
		<button type="button" onclick="location.href='/eepp/class/classList'">CLASS</button>
		<hr>
		
		<!-- 직무 게시판 카테고리 -->
		<div>
			<h3>직무 별 카테고리</h3>
			<a class="category" href="boardList">All</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=notice">공지사항</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=it_dev">IT & 개발</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=service">서비스</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=finance">금융</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=design">디자인</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=official">공무원</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=etc">etc</a>
		</div>
		<hr>
				
		<!-- 게시판 정렬방법 -->
		<div>
			<h3>게시글 정렬방법</h3>
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=bWrittenDate&bCategory=${bCategory}">최신순</a>&nbsp;&nbsp;&nbsp;
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=bHit&bCategory=${bCategory}">조회순</a>&nbsp;&nbsp;&nbsp;
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=bLike&bCategory=${bCategory}">추천순</a>&nbsp;&nbsp;&nbsp;
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=rpCount&bCategory=${bCategory}">댓글순</a>
		</div>
		<hr>
		
		<!-- 게시글 n개씩 보기 -->
		<div>
			<select id="cntPerPage" name="perPageNum">
				<option value="5"  <c:out value="${pageMaker.cri.perPageNum eq '5' ? 'selected' : ''}"/>>5줄 보기</option>
				<option value="10" <c:out value="${pageMaker.cri.perPageNum eq '10' ? 'selected' : ''}"/>>10줄 보기</option>
				<option value="15" <c:out value="${pageMaker.cri.perPageNum eq '15' ? 'selected' : ''}"/>>15줄 보기</option>
				<option value="20" <c:out value="${pageMaker.cri.perPageNum eq '20' ? 'selected' : ''}"/>>20줄 보기</option>
				<option value="30" <c:out value="${pageMaker.cri.perPageNum eq '30' ? 'selected' : ''}"/>>30줄 보기</option>
				<option value="40" <c:out value="${pageMaker.cri.perPageNum eq '40' ? 'selected' : ''}"/>>40줄 보기</option>
				<option value="50" <c:out value="${pageMaker.cri.perPageNum eq '50' ? 'selected' : ''}"/>>50줄 보기</option>
			</select>&nbsp;&nbsp;&nbsp;
			
			<!-- 새글작성 -->
			<button type="button" class="writeBtn">새 글 쓰기</button>
		
			<form name="form1" role="form" method="post">
				<input type="hidden" name="page" value="${scri.page}" />
				<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
				<input type="hidden" name="searchType" value="${scri.searchType}" />
				<input type="hidden" name="keyword" value="${scri.keyword}" />
				<input type="hidden" name="sortType" value="${sortType}" />
				<input type="hidden" name="bCategory" value="${bCategory}" />
			</form>
		</div>
		<hr>
		
		<!-- 게시물 리스트 -->
		<div>
			<table border="1">
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>글번호</td>
					<td>카테고리</td>	
					<td>말머리</td>
					<td>글제목</td>
					<td>작성자</td>
					<td>조회수</td>
					<td>추천 // 비추천</td>
				</tr>
				
				<!-- 공지사항 상위노출 2개 -->
				<c:forEach items="${notice}" var="notice">
					<tr>
						<td><img src="${pageContext.request.contextPath}/resources/img/boardIcon/notice3.png" width="50" height="50"></td>
						<td>${notice.bId}</td>
						<td>${notice.bCategory}</td>
						<td>${notice.bSubject}</td>
						<td>
							<a style="text-decoration: none" href="contentView${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${notice.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">${notice.bTitle}  [${notice.rpCount}]</a>
						</td>
						<td><b>${notice.uNickname}</b><br>
							${notice.bWrittenDate}
						</td>
						<td>${notice.bHit}</td>
						<td>${notice.bLike} // ${notice.bUnlike}</td>
					</tr>
				</c:forEach>
				
				<!-- 인기글 상위노출 3개 -->
				<c:forEach items="${hotArticle}" var="hot">
					<tr>
						<td><img src="${pageContext.request.contextPath}/resources/img/boardIcon/hot3.png" width="50" height="50"></td>
						<td>${hot.bId}</td>
						<td>${hot.bCategory}</td>
						<td>${hot.bSubject}</td>
						<td>
							<a style="text-decoration: none" href="contentView${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${hot.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">${hot.bTitle}  [${hot.rpCount}]</a>
						</td>
						<td><b>${hot.uNickname}</b><br>
							${hot.bWrittenDate}
						</td>
						<td>${hot.bHit}</td>
						<td>${hot.bLike} // ${hot.bUnlike}</td>
					</tr>
				</c:forEach>
				
				<tr>
					<td colspan="9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				
				<c:choose>
					<c:when test="${fn:length(boardList) > 0 }">
						<c:forEach items="${boardList}" var="vo">
							<tr>
								<td>
									<c:choose>
										<c:when test="${vo.dCount > 10}">
											<b style="color: red">[BLIND]</b>
										</c:when>
										<c:otherwise>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:otherwise>
									</c:choose>
								</td>
								<td>${vo.bId}</td>
								<td>${vo.bCategory}</td>
								<td>${vo.bSubject}</td>
								<td>
									<c:choose>
										<c:when test="${vo.dCount > 10}">
											${vo.bTitle}
										</c:when>
										<c:otherwise>
											<a style="text-decoration: none" href="contentView${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${vo.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">
											${vo.bTitle}  [${vo.rpCount}]</a>
										</c:otherwise>
									</c:choose>
								</td>
								<td><b>${vo.uNickname}</b><br>
									${vo.bWrittenDate}
								</td>
								<td>${vo.bHit}</td>
								<td>${vo.bLike}  //  ${vo.bUnlike}</td>
							</tr>
						</c:forEach>
					</c:when>
				
					<c:otherwise>
						<tr>
							<td colspan="9">조회된 결과가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		<hr>
		
		<!-- 검색 부분  -->
		<div class="search">
			<select name="searchType">
				<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
				<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
				<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
				<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
			</select> 
			
			<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" />
			<button id="searchBtn" type="button">검색</button>
		</div>
		<!-- 검색 부분 끝  -->
		<hr>
		
		<!-- 페이징 -->
		<div>
			<c:if test="${pageMaker.prev}">
				<a style="text-decoration: none" href="boardList${pageMaker.makeSearch(pageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}"> « </a>
			</c:if>
			
			[<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<a style="text-decoration: none" href="boardList${pageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}">${idx}</a>
			</c:forEach>]
	
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<a style="text-decoration: none" href="boardList${pageMaker.makeSearch(pageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}"> » </a>&nbsp;&nbsp;
			</c:if>
		</div>
	</body>
</html>