<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="now" class="java.util.Date"/>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		<title>오프라인 클래스 강좌 플랫폼</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/class/classMain.css">
	</head>

	<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
		
		<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
		<input type="hidden" id="classPageMaker" value="${classPageMaker.makeQuery(1)}" />
		<input type="hidden" id="cCategory" value="${cCategory}" />
		<input type="hidden" id="classTotalCount" value="${classPageMaker.totalCount}" />
		<input type="hidden" id="classCriPage" value="${classPageMaker.cri.page}" />
		<input type="hidden" id="classSearchType" value="${cscri.searchType}" />
		
		<section class="eeClassList">
			<div class="container classList">
				<div class="classListImg">
					<img alt="classMainImg" src="${pageContext.request.contextPath}/img/class/eeClassMain.jpg">
				</div>
				<br>
			
				<!-- 클래스 검색 부분  -->
				<div class="classSearch">
					<div class="input-group mb-4">
						<select name="searchType">
							<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
							<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>개설자</option>
							<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>강좌명</option>
							<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>강좌내용</option>
							<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>강좌명 + 강좌내용</option>
						</select>
					
						<input type="search" name="keyword" id="keywordInput" value="${cscri.keyword}" placeholder="배우고 싶은 지식을 입력해주세요." aria-describedby="button-addon3" class="form-control bg-none border-0">
						
						<div class="input-group-append border-0">
							<button id="classSearchBtn" type="button" class="btn btn-link text-success"><i class="fas fa-search"></i></button>
						</div>
					</div>
	          		
	          		<!-- 클래스개설 -->
					<div class="classMakeBtn" align="right">
						<c:choose>
							<c:when test="${loginUser.uNickname == null}">	
							</c:when>
							<c:otherwise>
								<button type="button" id="openNewClass" class="btn btn-warning btn-lg" onclick="location.href='classOpenView${classPageMaker.makeQuery(classPageMaker.cri.page)}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'"><strong>클래스 개설</strong></button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<br><br><br><br>
				
				<!--Class 강좌 카테고리 -->
				<div class="classCategory btn-group-lg" align="center">
					<button id="cateAll" class="btn btn-primary" onclick="location.href='classList'"><img alt="allicon" src="${pageContext.request.contextPath}/img/class/all_Icon.png"><br>전 체</button>&nbsp;&nbsp;
					<button id="cateItDev" class="btn btn-primary" onclick="location.href='classList?&cCategory=it_dev'"><img alt="itdev_icon" src="${pageContext.request.contextPath}/img/class/itDev_Icon.png"><br>IT / 개발</button>&nbsp;&nbsp;
					<button id="cateWorkSkill" class="btn btn-primary" onclick="location.href='classList?&cCategory=workSkill'"><img alt="workSkill_icon" src="${pageContext.request.contextPath}/img/class/workSkill_Icon.png"><br>업 무 스 킬</button>&nbsp;&nbsp;
					<button id="cateFinance" class="btn btn-primary" onclick="location.href='classList?&cCategory=financialTechnology'"><img alt="finance_icon" src="${pageContext.request.contextPath}/img/class/finance_Icon.png"><br>재 테 크</button>&nbsp;&nbsp;
					<button id="cateDaily" class="btn btn-primary" onclick="location.href='classList?&cCategory=daily'"><img alt="daily_icon" src="${pageContext.request.contextPath}/img/class/daily_Icon.png"><br>일 상</button>&nbsp;&nbsp;
					<button id="cateEtc" class="btn btn-primary" onclick="location.href='classList?&cCategory=etc'"><img alt="etc_icon" src="${pageContext.request.contextPath}/img/class/etc_Icon.png"><br>기 타</button>
				</div>
				
				<!-- 클래스 리스트 -->
				<div class="row classList">
					<c:choose>
						<c:when test="${fn:length(classList) > 0 }">
							<c:forEach items="${classList}" var="cl">
							<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
							<fmt:parseNumber value="${cl.cEndDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
								<c:choose>
									<c:when test="${endDate - nowDate < 0}">
										<div class="col-sm-4 mt-4 classList" id="isEndedClass">
									</c:when>
									<c:otherwise>
										<div class="col-sm-4 mt-4 classList" id="isActiveClass">
									</c:otherwise>
								</c:choose>
									<div class="card classList classWrapper">
										<!-- Card image -->
										<div class="classListImg">
		 									<img class="card-img-top classList" src="${cl.cThumnail}">
										</div>

										<div class="card-body classList">
											<div class="card-title clTitle">
												<strong>${cl.cTitle}</strong>
											</div>
											
											<div class="card-text clSummary" >
												${cl.cSummary}
											</div>
											
											<div class="card-text clOpenner">
												<c:choose>
													<c:when test="${cl.uNickname eq loginUser.uNickname or cl.uNickname eq '운영자' or cl.uNickname eq 'admin2' or loginUser.uNickname == null}">
														<a class="userBtn"><i class="fas fa-portrait"></i> ${cl.uNickname}</a>
													</c:when>
									
													<c:otherwise>
														<div class="dropdown">
															<a class="userBtn" id="user_btn_${cl.user_id}${cl.cId}" data-toggle="dropdown"><i class="fas fa-portrait"></i> ${cl.uNickname}</a>
									           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_${cl.uNickname}${cl.cId}">
									                			<li><a onclick="memberInfo('${cl.uNickname}',${cl.user_id});">회원정보</a></li>
									                			<li><a onclick="sendMessage('${cl.uNickname}',${cl.user_id});">쪽지 보내기</a></li>
									                			<li><a data-toggle="modal" data-target="#report_user_${cl.user_id}${cl.cId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
									                		</ul>
														</div>
														
														<!-- 유저 신고 modal -->	
						                				<div class="modal fade reportModalBox" id="report_user_${cl.user_id}${cl.cId}" role="dialog">
						                					<div class="modal-dialog">
						                						<div class="modal-content">
						                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${cl.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
									            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${cl.user_id}${cl.cId}" role="formDeclaration_user_${cl.user_id}${cl.cId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${cl.user_id}">
												            				<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${cl.cId}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${cl.cId}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${cl.cId}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${cl.cId}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${cl.cId}" name="dReason" disabled></textarea>
													            			</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
						            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${cl.user_id}${cl.cId},'${cl.uNickname}');">신고</button>
												            		</div>
												            		<!-- Footer -->
									            		
											        			</div>
											        			<!-- modal-content -->
							    							</div>
							    							<!-- modal-dialog -->
														</div>
													<!-- modal -->
													</c:otherwise>
												</c:choose>
											</div>
											
											<div class="card-text clDate">
												<i class="far fa-calendar-alt"></i> <fmt:formatDate value="${cl.cOpenDate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${cl.cEndDate}" pattern="yyyy.MM.dd" />
												<c:choose>
													<c:when test="${endDate - nowDate < 0}">
														<strong class="isEndedClass">(수강신청기간 종료)</strong>
													</c:when>
													<c:when test="${endDate - nowDate == 0}">
														<strong>(금일 마감 예정)</strong>
													</c:when>
													<c:otherwise>
														<strong>(${endDate - nowDate}일)</strong>
													</c:otherwise>
												</c:choose>
											</div>
					
											<div class="card-text clPoint" align="right">
												<i class="fab fa-product-hunt"></i>&nbsp;<fmt:formatNumber value="${cl.cPrice}" pattern="#,###" />
											</div>
											<hr>
											
											<div class="card-text clBtn">
												<button class="btn btn-block" type="button" onclick="location.href='classView${classPageMaker.makeQuery(classPageMaker.cri.page)}&cId=${cl.cId}&searchType=${cscri.searchType}&keyword=${cscri.keyword}&cCategory=${cCategory}'"><strong>상 세 정 보</strong></button>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
					
						<c:when test="${fn:length(classList) == 0}">
							<div class="col clNoSearch">
								<h4>조회된 결과가 없습니다.</h4>
							</div>
						</c:when>
					</c:choose>
				</div>
				<hr>	
				
				<!-- 페이징 -->
				<div class="clPage">
					<ul class="pagination justify-content-center">
						<li class="page-item">
							<a class="page-link" href="classList${classPageMaker.makeSearch(classPageMaker.startPage - 1)}&cCategory=${cCategory}"><i class="fas fa-angle-left"></i></a>
						</li>

						<c:forEach begin="${classPageMaker.startPage}" end="${classPageMaker.endPage}" var="idx">
							<li class="page-item">
								<a id="clPage_${idx}" class="page-link" href="classList${classPageMaker.makeSearch(idx)}&cCategory=${cCategory}">${idx}</a>
							</li>
						</c:forEach>
						
						<li class="page-item">
							<a class="page-link" href="classList${classPageMaker.makeSearch(classPageMaker.endPage + 1)}&cCategory=${cCategory}"><i class="fas fa-angle-right"></i></a>
						</li>
					</ul>
				</div>
			</div>
		</section>
		
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->
		
		<script src="${pageContext.request.contextPath}/js/class/classMain.js"></script>
		<script src="${pageContext.request.contextPath}/js/common.js"></script>
	</body>
</html>