<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Class 수정 페이지</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/class/classModify.css">
	</head>

	<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
		
		<section class="classModifyWrap">
			<div class="container classModify">
				<div class="classModifyTitle">
					<img alt="EEclassOpen Img" src="${pageContext.request.contextPath}/img/class/eeClassModify.jpg">
				</div>
				<br>
				
				<div class="classModifyForm">
					<form name="mform" action="modifyClass" enctype="multipart/form-data" method="post" onsubmit="return checkForm();">
						<input type="hidden" name="cId" value="${modifyClass.cId}">
						<input type="hidden" name="page" value="${cscri.page}">
						<input type="hidden" name="perPageNum" value="${cscri.perPageNum}">
						<input type="hidden" name="searchType" value="${cscri.searchType}">
						<input type="hidden" name="keyword" value="${cscri.keyword}">
						
						<div class="clModify form-group row">
							<div class="clModifyLeft col-6">
								<div class="input-group clOpenner">
									<div class="input-group-prepend">
										<button class="btn btn-default" type="button">개 설 자</button>
									</div>
									<input class="form-control" type="text" value="${modifyClass.uNickname}" disabled="disabled">
								</div>
								<br>
								
								<div class="input-group clTitle">
									<div class="input-group-prepend">
										<button class="btn btn-default" type="button">강 좌 명</button>
									</div>
									<input class="form-control" name="cTitle" type="text" maxlength="30" value="${modifyClass.cTitle}" placeholder="30자 이내로 입력해주세요">
								</div>
								<br>
								
								<div class="input-group clSummary">
									<div class="input-group-prepend">
										<button class="btn btn-default" type="button">한줄소개</button>
									</div>
									<input class="form-control" type="text" name="cSummary" maxlength="30" placeholder="30자 이내로 작성해주세요." value="${modifyClass.cSummary}"/>
								</div>
								<br>
								
								<div class="input-group clTotalPeople">
									<div class="input-group-prepend">
										<button class="btn btn-default" type="button">모집인원</button>
									</div>
									<input class="form-control" type="number" name="cTotalPeopleCount" min="1" max="100" step="1" placeholder="최소 1명, 최대 100명까지 설정 가능합니다." value="${modifyClass.cTotalPeopleCount}"/>
								</div>
								<br>
								
								<div class="input-group clPoint">
									<div class="input-group-prepend">
										<button class="btn btn-default" type="button">포 인 트</button>
									</div>
									<input class="form-control" type="number" name="cPrice" placeholder="100Point = 100&#92;" step="100" value="${modifyClass.cPrice}"/>
								</div>
								<br>

								<div class="input-group clTerm">
									<div class="classTerm">
										<div class="input-group-prepend">
											<button class="btn btn-default" type="button">모집기간</button>
											<b id="clOpenTerm"></b>일(개설일 : <fmt:formatDate value="${modifyClass.cOpenDate}" pattern="yy.MM.dd HH:MM"/> 기준 <b>최대 30일</b>까지 가능)
										</div>
										<input id="myRange" class="slider" type="range" name="cTerm" min="1" max="30" step="1" value="${modifyClass.cTerm}">
									</div>
								</div>
								<br>
								
								<div class="input-group clModifyCate">
									<div class="input-group-prepend">
										<div class="clModifyCateTitle">
											<button class="btn btn-default" type="button">카테고리</button>
										</div>
	
										<div class="clModifyCateMenu btn-group btn-group-toggle" data-toggle="buttons">
											<label class="btn btn-light <c:out value="${modifyClass.cCategory eq 'it_dev' ? 'active' : ''}"/>">
												<input type="radio" name="cCategory" value="it_dev" autocomplete="off" <c:out value="${modifyClass.cCategory eq 'it_dev' ? 'checked' : ''}"/>/>
												<img alt="itdev_icon" src="${pageContext.request.contextPath}/img/class/itDev_Icon.png"><br>IT / 개발
											</label>
											
											<label class="btn btn-light <c:out value="${modifyClass.cCategory eq 'workSkill' ? 'active' : ''}"/>">
												<input type="radio" name="cCategory" value="workSkill" autocomplete="off" <c:out value="${modifyClass.cCategory eq 'workSkill' ? 'checked' : ''}"/>/>
												<img alt="workSkill_icon" src="${pageContext.request.contextPath}/img/class/workSkill_Icon.png"><br>업 무 스 킬
											</label> 
												
											<label class="btn btn-light <c:out value="${modifyClass.cCategory eq 'financialTechnology' ? 'active' : ''}"/>">
												<input type="radio" name="cCategory" value="financialTechnology" autocomplete="off" <c:out value="${modifyClass.cCategory eq 'financialTechnology' ? 'checked' : ''}"/>/>
												<img alt="finance_icon" src="${pageContext.request.contextPath}/img/class/finance_Icon.png"><br>재 테 크
											</label>
											
											<label class="btn btn-light <c:out value="${modifyClass.cCategory eq 'daily' ? 'active' : ''}"/>"> 
												<input type="radio" name="cCategory" value="daily" autocomplete="off" <c:out value="${modifyClass.cCategory eq 'daily' ? 'checked' : ''}"/>/>
												<img alt="daily_icon" src="${pageContext.request.contextPath}/img/class/daily_Icon.png"><br>일 상
											</label>
											
											<label class="btn btn-light <c:out value="${modifyClass.cCategory eq 'etc' ? 'active' : ''}"/>">
												<input type="radio" name="cCategory" value="etc" autocomplete="off" <c:out value="${modifyClass.cCategory eq 'etc' ? 'checked' : ''}"/>/>
												<img alt="etc_icon" src="${pageContext.request.contextPath}/img/class/etc_Icon.png"><br>기 타
											</label>
										</div>
									</div>
								</div>
								<br>
								
								<div class="input-group cModifylDifficulty">
									<div class="input-group-prepend">
										<div class="clModifyDiffTitle">
											<button class="btn btn-default" type="button">난 이 도</button>
										</div>
	
										<div class="clModifyDiffMenu btn-group btn-group-toggle" data-toggle="buttons" >
											<label class="clModifyDiffBtn btn btn-light <c:out value="${modifyClass.cDifficulty eq 'easy' ? 'active' : ''}"/>">
												<input type="radio" name="cDifficulty" value="easy" <c:out value="${modifyClass.cDifficulty eq 'easy' ? 'checked' : ''}"/>>쉬 움
											</label>
											
											<label class="clModifyDiffBtn btn btn-light <c:out value="${modifyClass.cDifficulty eq 'normal' ? 'active' : ''}"/>">
												<input type="radio" name="cDifficulty" value="normal" <c:out value="${modifyClass.cDifficulty eq 'normal' ? 'checked' : ''}"/>>중 간
											</label>
											
											<label class="clModifyDiffBtn btn btn-light <c:out value="${modifyClass.cDifficulty eq 'hard' ? 'active' : ''}"/>">
												<input type="radio" name="cDifficulty" value="hard" <c:out value="${modifyClass.cDifficulty eq 'hard' ? 'checked' : ''}"/>>어 려 움
											</label>
										</div>
									</div>
								</div>
							</div>
							
							<div class="clOpenRight col-6">
								<div class="input-group clThumnail">
									<div class="input-group-prepend">
										<div class="box-file-input">
											<label>
												<input type="file" name="file" id="classImg" onchange="LoadImg(this);" class="file-input" accept="image/*">
											</label>
											<span class="filename">클래스 강좌를 대표할 사진을 선택해주세요.</span>
										</div>
										<img id="loadImg" src="${modifyClass.cThumnail}"/>
									</div>
								</div>
								<br>
								
								<div class="clAddress">
									<div class="form-group classPlace">
										<button class="btn btn-default" type="button">교육장소</button>
									</div>
									
									<div class="form-group ad1">                   
										<input class="form-control" placeholder="우편번호" name="cAddress1" id="addr1" type="text" readonly="readonly" value="${modifyClass.cAddress1}"/>
										<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fas fa-search-location"></i> 주소찾기</button>                               
									</div>
									
									<div class="form-group ad2">
									    <input class="form-control" placeholder="도로명 주소" name="cAddress2" id="addr2" type="text" readonly="readonly" value="${modifyClass.cAddress2}"/>
									</div>
									
									<div class="form-group ad3">
									    <input class="form-control" placeholder="상세주소" name="cAddress3" id="addr3" type="text" value="${modifyClass.cAddress3}"/>
									</div>
								</div>
							</div>
							<hr>
						</div>
						
						<div class="clModify form-group row">
							<div class="col clContent">
								<div class="input-group-prepend">
									<div class="classContentArea">
										<button class="btn btn-default" type="button">강 좌 소 개</button>
									</div>
									<textarea id="summernote" name="cContent">${modifyClass.cContent}</textarea>
								</div>
							</div>
						</div>
						<hr>
			
						<div class="clModify form-group row">
							<div class="col classBtn" align="right">
								<input class="btn btn-default btn-lg" type="submit" value="강좌수정">
								<button class="btn btn-default btn-lg" type="button" onclick="location.href='classView?cId=${modifyClass.cId}&page=${cscri.page}&perPageNum=${cscri.perPageNum}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'">수정취소</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</section>
		
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->

		<script src="${pageContext.request.contextPath}/js/class/classModify.js"></script>
		<script src="${pageContext.request.contextPath}/js/common.js"></script>
	</body>
</html>