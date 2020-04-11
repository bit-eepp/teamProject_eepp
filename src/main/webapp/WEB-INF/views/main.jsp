<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Community EE</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
		
		<script type="text/javascript">
			function getCookie(name) { 
				var cookie = document.cookie; 
				
				if (document.cookie != "") { 
					var cookie_array = cookie.split("; "); 
					for ( var index in cookie_array) { 
						var cookie_name = cookie_array[index].split("=");
						
						if (cookie_name[0] == "popupYN") { 
							return cookie_name[1]; 
						} 
					} 
				} 
				
				return ; 
			} 
			
			function openPopup(url) { 
				var cookieCheck = getCookie("popupYN");
				
				if (cookieCheck != "N") 
					window.open(url, '', 'width=500,height=430,left=0,top=0') 
			}
		</script>
		
		
		
	</head>

	<body onload="javascript:openPopup('${pageContext.request.contextPath}/popUp')">
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
	
		<input type="hidden" id="user_id" value="${loginUser.user_id}" />
		<input type="hidden" id="uNickname" value="${loginUser.uNickname}" />
		
		<form name="form1" role="form" method="post">
			<input type="hidden" name="sortType" id="sortType" value="${sortType}" />
			<input type="hidden" name="bCategory" id="bCategory" value="${bCategory}" />
		</form>	
		
		<!-- Main Page Contents -->
		<section id="sc-mainPage">
			<div class="container mainPage">
				<!-- 사진 슬라이드 시작 -->
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>
					
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active img1">
							<!-- <p class="carouselTitle">WELCOME TO <br>COMMUNITY <b>EE</b></p> -->
							<img src="${pageContext.request.contextPath}/img/main/ee_mainImageEdit1.jpg" alt="mainImage1">
						</div>
					
						<div class="carousel-item img2">
							<!-- <p class="carouselTitle"><b>E</b>MPLOYEES<br><b>E</b>SCAPE FROM WORK</p> -->
							<img src="${pageContext.request.contextPath}/img/main/ee_mainImageEdit2.jpg" alt="mainImage2">
						</div>
						
						<div class="carousel-item img3">
							<!-- <p class="carouselTitle">HAVE A FUN TIME<br>IN THE COMMUNITY <b>EE</b></p> -->
							<img src="${pageContext.request.contextPath}/img/main/ee_mainImageEdit3.jpg" alt="mainImage3">
						</div>
					</div>
					
					<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
						<span class="icon-prev" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
						<span class="icon-next" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<br><br>
				<!-- 사진 슬라이드 끝 -->
		
				<!-- 직무게시판 베스트 리스트 시작 -->
				<div class="col mainBoardList">
					<h5><!-- <i class="fas fa-star" style="color: #ffc107;"></i> -->BOARD - JOB&nbsp;&nbsp;<b style="color: #ffc107">BEST</b></h5>
					<div align="right">
						<a class="writeBtn">새 글 쓰기</a>
					</div>
					
					<div class="row">
                    	<div class="col-md-12">
	                        <nav>
	                            <div class="nav nav-tabs" id="nav-tab" role="tablist">
	                                <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">전 체</a>
	                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact1" role="tab" aria-controls="nav-profile" aria-selected="false">IT&개발</a>
	                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact2" role="tab" aria-controls="nav-contact" aria-selected="false">서 비 스</a>
	                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact3" role="tab" aria-controls="nav-contact" aria-selected="true">금 융</a>
	                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact4" role="tab" aria-controls="nav-profile" aria-selected="false">디 자 인</a>
	                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact5" role="tab" aria-controls="nav-contact" aria-selected="false">공 무 원</a>
	                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact6" role="tab" aria-controls="nav-contact" aria-selected="false">기 타</a>
	                            </div>
	                        </nav>
                        
	                        <div class="tab-content" id="nav-tabContent">
	                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
	                                <div class="listTable">
										<table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>
											
											<c:forEach items="${boardHot}" var="bh">
												<tr class="listTable-list listWidth isHotList">
													<td class="isHotContent"><i class="fab fa-hotjar"></i></td>
													<td class="bId">${bh.bId}</td>
													<td class="bSubject">${bh.bSubject}</td>
													<td class="bCategory">${bh.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bh.bId}&searchType=&keyword=&sortType=&bCategory=${bh.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bh.bTitle) > 33}">
																${fn:substring(bh.bTitle, 0, 33)}... [${bh.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bh.bTitle} [${bh.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${bh.uNickname eq loginUser.uNickname or bh.uNickname eq '운영자' or bh.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${bh.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_hot_${bh.user_id}${btn.index}" data-toggle="dropdown">${bh.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_hot_${bh.user_id}${btn.index}">
											                			<li><a onclick="memberInfo('${bh.uNickname}',${bh.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${bh.uNickname}',${bh.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${bh.user_id}${btn.index}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${bh.user_id}${btn.index}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${bh.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${bh.user_id}${btn.index}" role="formDeclaration_user_${bh.user_id}${btn.index}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${bh.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${bh.user_id}${btn.index}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${bh.user_id}${btn.index}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${bh.user_id}${btn.index}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${bh.user_id}${btn.index}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${bh.user_id}${btn.index}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${bh.user_id}${btn.index},'${bh.uNickname}');">신고</button>
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
														<span>${bh.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bh.bHit}</td>
													<td class="bLike">${bh.bLike} / ${bh.bUnlike}</td>
												</tr>
											</c:forEach>
											
											<c:forEach items="${boardListALL}" var="bl">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le bl.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
													
													<td class="bId">${bl.bId}</td>
													<td class="bSubject">${bl.bSubject}</td>
													<td class="bCategory">${bl.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bl.bId}&searchType=&keyword=&sortType=&bCategory=${bl.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bl.bTitle) > 33}">
																${fn:substring(bl.bTitle, 0, 33)}... [${bl.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bl.bTitle} [${bl.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${bl.uNickname eq loginUser.uNickname or bl.uNickname eq '운영자' or bl.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${bl.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${bl.user_id}${btn.index}" data-toggle="dropdown">${bl.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${bl.user_id}${btn.index}">
											                			<li><a onclick="memberInfo('${bl.uNickname}',${bl.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${bl.uNickname}',${bl.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${bl.user_id}${btn.index}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${bl.user_id}${btn.index}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${bl.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${bl.user_id}${btn.index}" role="formDeclaration_user_${bl.user_id}${btn.index}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${bl.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${bl.user_id}${btn.index}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${bl.user_id}${btn.index}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${bl.user_id}${btn.index}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${bl.user_id}${btn.index}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${bl.user_id}${btn.index}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${bl.user_id}${btn.index},'${bl.uNickname}');">신고</button>
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
														<span>${bl.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bl.bHit}</td>
													<td class="bLike">${bl.bLike} / ${bl.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
                            
	                            <div class="tab-pane fade" id="nav-contact1" role="tabpanel" aria-labelledby="nav-profile-tab">
	                                <div class="listTable">
										<table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>

											<c:forEach items="${boardListIT}" var="blIT">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le blIT.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
													
													<td class="bId">${blIT.bId}</td>
													<td class="bSubject">${blIT.bSubject}</td>
													<td class="bCategory">${blIT.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${blIT.bId}&searchType=&keyword=&sortType=&bCategory=${blIT.bCategory}">
														<c:choose>
															<c:when test="${fn:length(blIT.bTitle) > 33}">
																${fn:substring(blIT.bTitle, 0, 33)}... [${blIT.rpCount}]
															</c:when>
										
															<c:otherwise>
																${blIT.bTitle} [${blIT.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${blIT.uNickname eq loginUser.uNickname or blIT.uNickname eq '운영자' or blIT.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${blIT.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${blIT.user_id}${blIT.bId}" data-toggle="dropdown">${blIT.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${bl.user_id}${blIT.bId}">
											                			<li><a onclick="memberInfo('${blIT.uNickname}',${blIT.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${blIT.uNickname}',${blIT.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${blIT.user_id}${blIT.bId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${blIT.user_id}${blIT.bId}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${blIT.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${blIT.user_id}${blIT.bId}" role="formDeclaration_user_${blIT.user_id}${blIT.bId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${blIT.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${blIT.user_id}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${blIT.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${blIT.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${blIT.user_id}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${blIT.user_id}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${blIT.user_id}${blIT.bId},'${blIT.uNickname}');">신고</button>
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
														<span>${blIT.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${blIT.bHit}</td>
													<td class="bLike">${blIT.bLike} / ${blIT.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
                            
	                            <div class="tab-pane fade" id="nav-contact2" role="tabpanel" aria-labelledby="nav-contact-tab">
	                                 <div class="listTable">
		                                <table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>
	
											<c:forEach items="${boardListService}" var="blService">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le blService.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
													</c:otherwise>
													</c:choose>
													
													<td class="bId">${blService.bId}</td>
													<td class="bSubject">${blService.bSubject}</td>
													<td class="bCategory">${blService.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${blService.bId}&searchType=&keyword=&sortType=&bCategory=${blService.bCategory}">
														<c:choose>
															<c:when test="${fn:length(blService.bTitle) > 33}">
																${fn:substring(blService.bTitle, 0, 33)}... [${blService.rpCount}]
															</c:when>
										
															<c:otherwise>
																${blService.bTitle} [${blService.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${blService.uNickname eq loginUser.uNickname or blService.uNickname eq '운영자' or blService.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${blService.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${blService.user_id}${blService.bId}" data-toggle="dropdown">${blService.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${blService.user_id}${blService.bId}">
											                			<li><a onclick="memberInfo('${blService.uNickname}',${blService.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${blService.uNickname}',${blService.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${blService.user_id}${blService.bId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${blService.user_id}${blService.bId}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${blService.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${blService.user_id}${blService.bId}" role="formDeclaration_user_${blService.user_id}${blService.bId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${blService.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${blService.user_id}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${blService.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${blService.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${blService.user_id}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${blService.user_id}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${blService.user_id}${blService.bId},'${blService.uNickname}');">신고</button>
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
														<span>${blService.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${blService.bHit}</td>
													<td class="bLike">${blService.bLike} / ${blService.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
	                            
	                            <div class="tab-pane fade" id="nav-contact3" role="tabpanel" aria-labelledby="nav-contact-tab">
	                           		<div class="listTable">
		                           		<table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>
	
											<c:forEach items="${boardListFinance}" var="blFinance">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le blFinance.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
													</c:otherwise>
													</c:choose>
													
													<td class="bId">${blFinance.bId}</td>
													<td class="bSubject">${blFinance.bSubject}</td>
													<td class="bCategory">${blFinance.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${blFinance.bId}&searchType=&keyword=&sortType=&bCategory=${blFinance.bCategory}">
														<c:choose>
															<c:when test="${fn:length(blFinance.bTitle) > 33}">
																${fn:substring(blFinance.bTitle, 0, 33)}... [${blFinance.rpCount}]
															</c:when>
										
															<c:otherwise>
																${blFinance.bTitle} [${blFinance.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${blFinance.uNickname eq loginUser.uNickname or blFinance.uNickname eq '운영자' or blFinance.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${blFinance.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${blFinance.user_id}${blFinance.bId}" data-toggle="dropdown">${blFinance.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${blFinance.user_id}${blFinance.bId}">
											                			<li><a onclick="memberInfo('${blFinance.uNickname}',${blFinance.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${blFinance.uNickname}',${blFinance.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${blFinance.user_id}${blFinance.bId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${blFinance.user_id}${blFinance.bId}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${blFinance.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${blFinance.user_id}${blFinance.bId}" role="formDeclaration_user_${blFinance.user_id}${blFinance.bId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${blFinance.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${blFinance.user_id}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${blFinance.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${blFinance.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${blFinance.user_id}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${blFinance.user_id}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${blFinance.user_id}${blFinance.bId},'${blFinance.uNickname}');">신고</button>
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
														<span>${blFinance.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${blFinance.bHit}</td>
													<td class="bLike">${blFinance.bLike} / ${blFinance.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
	                            
	                            <div class="tab-pane fade" id="nav-contact4" role="tabpanel" aria-labelledby="nav-contact-tab">
	                                <div class="listTable">
		                                <table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>	
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>
	
											<c:forEach items="${boardListDesign}" var="blDesign">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le blDesign.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
													
													<td class="bId">${blDesign.bId}</td>
													<td class="bSubject">${blDesign.bSubject}</td>
													<td class="bCategory">${blDesign.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${blDesign.bId}&searchType=&keyword=&sortType=&bCategory=${blDesign.bCategory}">
														<c:choose>
															<c:when test="${fn:length(blDesign.bTitle) > 33}">
																${fn:substring(blDesign.bTitle, 0, 33)}... [${blDesign.rpCount}]
															</c:when>
										
															<c:otherwise>
																${blDesign.bTitle} [${blDesign.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${blDesign.uNickname eq loginUser.uNickname or blDesign.uNickname eq '운영자' or blDesign.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${blDesign.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${blDesign.user_id}${blDesign.bId}" data-toggle="dropdown">${blDesign.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${blDesign.user_id}${blDesign.bId}">
											                			<li><a onclick="memberInfo('${blDesign.uNickname}',${blDesign.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${blDesign.uNickname}',${blDesign.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${blDesign.user_id}${blDesign.bId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${blDesign.user_id}${blDesign.bId}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${blDesign.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${blDesign.user_id}${blDesign.bId}" role="formDeclaration_user_${blDesign.user_id}${blDesign.bId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${blDesign.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${blDesign.user_id}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${blDesign.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${blDesign.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${blDesign.user_id}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${blDesign.user_id}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${blDesign.user_id}${blDesign.bId},'${blDesign.uNickname}');">신고</button>
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
														<span>${blDesign.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${blDesign.bHit}</td>
													<td class="bLike">${blDesign.bLike} / ${blDesign.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
	                            
	                            <div class="tab-pane fade" id="nav-contact5" role="tabpanel" aria-labelledby="nav-contact-tab">
	                                <div class="listTable">
		                                <table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>
	
											<c:forEach items="${boardListOfficial}" var="blOfficial">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le blOfficial.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
													
													<td class="bId">${blOfficial.bId}</td>
													<td class="bSubject">${blOfficial.bSubject}</td>
													<td class="bCategory">${blOfficial.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${blOfficial.bId}&searchType=&keyword=&sortType=&bCategory=${blOfficial.bCategory}">
														<c:choose>
															<c:when test="${fn:length(blOfficial.bTitle) > 33}">
																${fn:substring(blOfficial.bTitle, 0, 33)}... [${blOfficial.rpCount}]
															</c:when>
										
															<c:otherwise>
																${blOfficial.bTitle} [${blOfficial.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${blOfficial.uNickname eq loginUser.uNickname or blOfficial.uNickname eq '운영자' or blOfficial.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${blOfficial.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${blOfficial.user_id}${blOfficial.bId}" data-toggle="dropdown">${blOfficial.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${blOfficial.user_id}${blOfficial.bId}">
											                			<li><a onclick="memberInfo('${blOfficial.uNickname}',${blOfficial.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${blOfficial.uNickname}',${blOfficial.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${blOfficial.user_id}${blOfficial.bId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${blOfficial.user_id}${blOfficial.bId}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${blOfficial.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${blOfficial.user_id}${blOfficial.bId}" role="formDeclaration_user_${blOfficial.user_id}${blOfficial.bId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${blOfficial.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${blOfficial.user_id}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${blOfficial.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${blOfficial.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${blOfficial.user_id}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${blOfficial.user_id}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${blOfficial.user_id}${blOfficial.bId},'${blOfficial.uNickname}');">신고</button>
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
														<span>${blOfficial.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${blOfficial.bHit}</td>
													<td class="bLike">${blOfficial.bLike} / ${blOfficial.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
	                            
	                            <div class="tab-pane fade" id="nav-contact6" role="tabpanel" aria-labelledby="nav-contact-tab">
	                                <div class="listTable">
		                                <table>
											<tr class="listTable-title listWidth">
												<td></td>
												<td class="bId">글번호</td>	
												<td class="bSubject">말머리</td>
												<td class="bCategory">카테고리</td>
												<td class="bTitle">글제목</td>
												<td class="bWriter">작성자</td>
												<td class="bHit">조회수</td>
												<td class="bLike">추천 / 비추천</td>
											</tr>
											
											<c:forEach items="${boardNotice}" var="bn">
												<tr class="listTable-list listWidth isNoticeList">
													<td class="isNoticeContent"><i class="fas fa-flag"></i></td>
													<td class="bId">${bn.bId}</td>
													<td class="bSubject">${bn.bSubject}</td>
													<td class="bCategory">${bn.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${bn.bId}&searchType=&keyword=&sortType=&bCategory=${bn.bCategory}">
														<c:choose>
															<c:when test="${fn:length(bn.bTitle) > 33}">
																${fn:substring(bn.bTitle, 0, 33)}... [${bn.rpCount}]
															</c:when>
										
															<c:otherwise>
																${bn.bTitle} [${bn.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<a class="userBtn">${bn.uNickname}</a>
														<span>${bn.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${bn.bHit}</td>
													<td class="bLike">${bn.bLike} / ${bn.bUnlike}</td>
												</tr>
											</c:forEach>
	
											<c:forEach items="${boardListEtc}" var="blEtc">
												<tr class="listTable-list listWidth">
													<c:choose>
														<c:when test="${newArticle le blEtc.isNew}">
															<td class="isNewContent">NEW</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
													
													<td class="bId">${blEtc.bId}</td>
													<td class="bSubject">${blEtc.bSubject}</td>
													<td class="bCategory">${blEtc.bCategory}</td>
													<td class="bTitle">
														<a style="text-decoration: none" href="${pageContext.request.contextPath}/board/contentView?bId=${blEtc.bId}&searchType=&keyword=&sortType=&bCategory=${blEtc.bCategory}">
														<c:choose>
															<c:when test="${fn:length(blEtc.bTitle) > 33}">
																${fn:substring(blEtc.bTitle, 0, 33)}... [${blEtc.rpCount}]
															</c:when>
										
															<c:otherwise>
																${blEtc.bTitle} [${blEtc.rpCount}]
															</c:otherwise>
														</c:choose>
														</a>
													</td>
													
													<td class="bWriter">
														<c:choose>
															<c:when test="${blEtc.uNickname eq loginUser.uNickname or blEtc.uNickname eq '운영자' or blEtc.uNickname eq 'admin2' or loginUser.uNickname == null}">
																<a class="userBtn">${blEtc.uNickname}</a>
															</c:when>
															
															<c:otherwise>
																<div class="dropdown">
																	<a href="#" class="userBtn" id="user_${blEtc.user_id}${blEtc.bId}" data-toggle="dropdown">${blEtc.uNickname}</a>
																	
											           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_${blEtc.user_id}${blEtc.bId}">
											                			<li><a onclick="memberInfo('${blEtc.uNickname}',${blEtc.user_id});">회원정보</a></li>
											                			<li><a onclick="sendMessage('${blEtc.uNickname}',${blEtc.user_id});">쪽지 보내기</a></li>
											                			<li><a data-toggle="modal" data-target="#report_user_${blEtc.user_id}${blEtc.bId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
											                		</ul>
																</div>
																<!-- 유저 신고 modal -->	
									                			<div class="modal fade reportModalBox" id="report_user_${blEtc.user_id}${blEtc.bId}" role="dialog">
									                				<div class="modal-dialog">
									                				<div class="modal-content">
									                						
									                				<!-- Modal Header -->
									                				<div class="modal-header">
									                					<button type="button" class="close" data-dismiss="modal">
									                					<span aria-hidden="true">&times;</span>
												                    	<span class="sr-only">Close</span>
												                		</button>
												               			<h4 class="modal-title">&#8988;${blEtc.uNickname}&#8991;님 신고</h4>
												            		</div>
												            		<!-- Header -->
												            				
												            		<!-- Modal Body -->
												            		<div class="modal-body">
												            			<form id="declaration_user_${blEtc.user_id}${blEtc.bId}" role="formDeclaration_user_${blEtc.user_id}${blEtc.bId}" name="dform">
													            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
													            			<input type="hidden" name="reported_id" value="${blEtc.user_id}">
													            			
													            			<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
													            			
													            			<div class="form-group">
														            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${blEtc.user_id}.disabled=true">  부적절한 홍보 게시글<br>
														            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${blEtc.user_id}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
														            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${blEtc.user_id}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
														            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${blEtc.user_id}.disabled=false">  기타<br>
														            			<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${blEtc.user_id}" name="dReason" disabled></textarea>
														            		</div>
												                		</form>
												                		<!-- declaration -->
												           		 	</div>
												           		 	<!-- modal-body -->
									            
												            		<!-- Modal Footer -->
												            		<div class="modal-footer">
												                		<button type="button" class="btn reportBtn" onclick="reportUser(${blEtc.user_id}${blEtc.bId},'${blEtc.uNickname}');">신고</button>
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
														<span>${blEtc.bWrittenDate}</span>
													</td>
													
													<td class="bHit">${blEtc.bHit}</td>
													<td class="bLike">${blEtc.bLike} / ${blEtc.bUnlike}</td>
												</tr>
											</c:forEach>
										</table>
									</div>
	                            </div>
           					</div>	<!-- tab-content -->
                 
                    	</div>	<!-- col-md-12 -->
                	</div>	<!-- row -->			
				</div>	<!-- col boardList -->
				<br><br>
				<!-- 직무게시판 베스트 리스트 끝 -->
				
				
				<!-- 오늘뭐먹지? 베스트 시작 -->
				<div class="col mainEatingList">
					<h5><!-- <i class="fas fa-star" style="color: #ffc107;"></i> --> EATING&nbsp;&nbsp;<b style="color: #ffc107">BEST</b></h5>
					<div class="row">
						<c:forEach items="${eatStoreList}" var="el">
							<div class="col-md-3">
								<div class="imgThumnail">
									<a href="${pageContext.request.contextPath}/eating/eatingView?eId=${el.eId}&eThema="><img class="img-thumbnail" alt="eatImg" src="${pageContext.request.contextPath}/img/eating/thumnail/eat_Thumnail${el.eId}.jpg" style="width: 100%; height: auto; margin-bottom: 10px;"></a>
									<div class="imgText">
										<p>
											<img alt="good" src="${pageContext.request.contextPath}/img/main/eat_good.png" style="max-width: 15%;">
										</p>
									</div>
								</div>
							
								<p class="eTitle">
									<a href="${pageContext.request.contextPath}/eating/eatingView?eId=${el.eId}&eThema=">${el.eTitle}&nbsp;&nbsp;<b style="color: #e7438b;">${el.rvAVG}</b></a>
								</p>
								
								<p class="eThema">
									<c:choose>
										<c:when test="${el.eThema == 'thema_1'}">
											<p style="color:#868e96; font-size: 85%;">신촌/홍대 - ${el.eKeyword_food}</p>
										</c:when>
										<c:when test="${el.eThema == 'thema_2'}">
											<p style="color:#868e96; font-size: 85%;">여의도 - ${el.eKeyword_food}</p>
										</c:when>
										<c:when test="${el.eThema == 'thema_3'}">
											<p style="color:#868e96; font-size: 85%;">용산/이태원 - ${el.eKeyword_food}</p>
										</c:when>
										<c:when test="${el.eThema == 'thema_4'}">
											<p style="color:#868e96; font-size: 85%;">강남/논현 - ${el.eKeyword_food}</p>
										</c:when>
										<c:when test="${el.eThema == 'thema_5'}">
											<p style="color:#868e96; font-size: 85%;">건대입구 - ${el.eKeyword_food}</p>
										</c:when>
										<c:when test="${el.eThema == 'thema_6'}">
											<p style="color:#868e96; font-size: 85%;">합정/망원 - ${el.eKeyword_food}</p>
										</c:when>
									</c:choose>
								</p>
							</div>
						</c:forEach>
					</div>
				</div>
				<br><br>
				<!-- 오늘뭐먹지? 베스트 끝 -->

				
				<!-- EE CLASS 베스트 시작 -->
				<div class="col mainClassList">
					<h5><!-- <i class="fas fa-star" style="color: #ffc107;"></i> --> EE CLASS&nbsp;&nbsp;<b style="color: #ffc107">BEST</b></h5>
					<div class="row">
                   		<c:forEach items="${classList}" var="cl">
							<div class="col-md-3">
								<div class="card cl">
									<!-- Card image -->
									<div class="classListImg">
	 									<a href="${pageContext.request.contextPath}/class/classView?cId=${cl.cId}&cCategory=${cl.cCategory}"><img class="card-img-top" src="${cl.cThumnail}"></a>
									</div>

									<div class="card-body classList">
										<p class="card-title clTitle">
											${cl.cTitle}
										</p>
										
										<p class="card-text clDate" align="right">
											<i class="far fa-calendar-alt"></i> 
											
											<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
											<fmt:parseNumber value="${cl.cEndDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
											<c:choose>
												<c:when test="${endDate - nowDate < 0}">
													<b>수강신청기간 종료</b>
												</c:when>
												<c:when test="${endDate - nowDate == 0}">
													<b>금일 마감 예정</b>
												</c:when>
												<c:otherwise>
													신청기한 : <b>${endDate - nowDate}일</b> 남음
												</c:otherwise>
											</c:choose>
										</p>
				
										<p class="card-text clPoint" align="right">
											<i class="fab fa-product-hunt" style="color:#ffc107"></i>&nbsp;<fmt:formatNumber value="${cl.cPrice}" pattern="#,###" />
										</p>
										
										<button class="btn btn-default" type="button" onclick="location.href='${pageContext.request.contextPath}/class/classView?cId=${cl.cId}&cCategory=${cl.cCategory}'">상 세 보 기</button>
									</div>
								</div>
							</div>
						</c:forEach>
                   	</div>
				</div>
				<!-- EE CLASS 베스트 끝 -->
			</div>
		</section>
		<!-- Main Page Contents -->
	
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
	
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->
		<script src="${pageContext.request.contextPath}/js/main.js"></script>
		<script src="${pageContext.request.contextPath}/js/common.js"></script>
	</body>
</html>