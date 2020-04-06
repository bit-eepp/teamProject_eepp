<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>No.${clView.cId} CLASS강좌</title>
		
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/class/classView.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/class/classQuestionList.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	</head>
	
	<body>
		<!-- header -->
		<%@ include file="/WEB-INF/views/header.jsp"%>
		<!-- header -->
		
		<section class="classViewWrap">
			<div class="container clView">
				<div class="row clContent">
					<div class="col-8 clContentLeft">
						<div class="input-group clContentTitle">
							<p><b>${clView.cTitle}</b></p>
						</div>
						
						<div class="input-group clContentSummary">
							<p><b>${clView.cSummary}</b></p>
						</div>

						<div class="input-group clContentThumnail">
							<img alt="ClassImg" src="${clView.cThumnail}">
						</div>
						<br>
						
						<div class="input-group hr-sect" >
							<b>강 좌 소 개</b>
						</div>
						
						<div class="input-group clContentView">
							<textarea id="summernote">${clView.cContent}</textarea>
						</div>
					</div>
					
					<div class="col-4 clContentRight">
						<div class="input-group clContentDetailHaed">
							<button class="btn btn-default" type="button"><b>세 부 정 보</b></button>
						</div>
						
						<div class="input-group clContentDetailBody">			
							<ul class="list-group list-group-flush">
								<li class="list-group-item"></li>
								
								<li class="list-group-item openUser">
									<c:choose>
										<c:when test="${clView.uNickname eq loginUser.uNickname or clView.uNickname eq '운영자' or clView.uNickname eq 'admin2' or loginUser.uNickname == null}">
											<div class="clOpennerNick">
												<i title="개설자" class="fas fa-user-circle"></i>&nbsp;개 설 자 : <a class="userBtn clUserE"><b>${clView.uNickname}</b></a>
											</div>
										</c:when>
											
										<c:otherwise>	
											<div class="dropdown clOpennerNick">
												<i title="개설자" class="fas fa-user-circle"></i>&nbsp;개 설 자 : <a href="#" class="userBtn clUser" id="user_btn_${clView.user_id}${clView.cId}" data-toggle="dropdown"><b>${clView.uNickname}</b></a>	
						           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_${clView.uNickname}${clView.cId}">
						                			<li><a onclick="memberInfo('${clView.uNickname}',${clView.user_id});">회원정보</a></li>
						                			<li><a onclick="sendMessage('${clView.uNickname}',${clView.user_id});">쪽지 보내기</a></li>
						                			<li><a data-toggle="modal" data-target="#report_user_${clView.user_id}${clView.cId}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
						                		</ul>
											</div>			
											
											<!-- 유저 신고 modal -->	
				                			<div class="modal fade reportModalBox" id="report_user_${clView.user_id}${clView.cId}" role="dialog">
				                				<!-- modal-dialog -->
				                				<div class="modal-dialog">
				                					<!-- modal-content -->
					                				<div class="modal-content">
						                				<!-- Modal Header -->
						                				<div class="modal-header">
						                					<button type="button" class="close" data-dismiss="modal">
						                					<span aria-hidden="true">&times;</span>
									                    	<span class="sr-only">Close</span>
									                		</button>
									               			<h4 class="modal-title">&#8988;${clView.uNickname}&#8991;님 신고</h4>
									            		</div>
									            		<!-- Header -->
									            				
									            		<!-- Modal Body -->
									            		<div class="modal-body">
									            			<!-- declaration -->
									            			<form id="declaration_user_${clView.user_id}${clView.cId}" role="formDeclaration_user_${clView.user_id}${clView.cId}" name="dform">
										            			<input type="hidden" name="reporter_id" value="${loginUser.user_id}">
										            			<input type="hidden" name="reported_id" value="${clView.user_id}">
									            				<p class="reportBoxIcon"><img src="${pageContext.request.contextPath}/img/reportBoxIcon.png"></p>
										            			<div class="form-group">
											            			<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${clView.cId}.disabled=true">  부적절한 홍보 게시글<br>
											            			<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${clView.cId}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
											            			<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${clView.cId}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
											            			<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${clView.cId}.disabled=false">  기타<br>
											            			<textarea style="resize:none; height:80px; width:100%;" cols="30" rows="10" class="form-control" id="etc_${clView.cId}" name="dReason" disabled></textarea>
										            			</div>
									                		</form>
									                		<!-- declaration -->
									           		 	</div>
									           		 	<!-- modal-body -->
						            
									            		<!-- Modal Footer -->
									            		<div class="modal-footer">
									                		<button type="button" class="btn reportBtn" onclick="reportUser(${clView.user_id}${clView.cId},'${clView.uNickname}');">신고</button>
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
								</li>
								
								<li class="list-group-item price">
									<i title="포인트 가격" class="fab fa-product-hunt" style="color: #FFC107;"></i>&nbsp;포 인 트 : <fmt:formatNumber value="${clView.cPrice}" pattern="#,###" />
								</li>
								
								<li class="list-group-item cate">
									<i title="강좌 카테고리" class="fas fa-th-list"></i>&nbsp;카테고리 : 
									<c:choose>
										<c:when test="${clView.cCategory eq 'it_dev'}">
											IT / 개발
										</c:when>
										
										<c:when test="${clView.cCategory eq 'workSkill'}">
											업무스킬
										</c:when>
										
										<c:when test="${clView.cCategory eq 'financialTechnology'}">
											재 테 크
										</c:when>
										
										<c:when test="${clView.cCategory eq 'daily'}">
											일 상
										</c:when>
										
										<c:when test="${clView.cCategory eq 'etc'}">
											기 타
										</c:when>
									</c:choose>
								</li>
								
								<li class="list-group-item period">
									<i title="신청기간" class="fas fa-calendar-alt"></i>&nbsp;신청기간 : <fmt:formatDate value="${clView.cOpenDate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${clView.cEndDate}" pattern="yyyy.MM.dd"/>
								</li>

								<li class="list-group-item remain">
									<i title="남은기간" class="far fa-clock"></i>&nbsp;남은기간 : <b id="classEndCountDown" style="color: #e7438b"></b>
								</li>
					
								<li class="list-group-item count" >
									<i title="남은기간" class="fas fa-users"></i>&nbsp;신청인원 : <b class="classCurrentPeople" style="color: #e7438b"></b> / ${clView.cTotalPeopleCount}
								</li>
								
								<li class="list-group-item diff">
									<p>
										<i title="난이도" class="fas fa-layer-group"></i>&nbsp;난 이 도
									</p>
									<div class="clDiffGroup" align="center">
										<button type="button" class="clDiffBtnE <c:if test="${clView.cDifficulty eq 'easy'}">clDiffBtnSelect</c:if>">쉬 움</button>
										<button type="button" class="clDiffBtnN <c:if test="${clView.cDifficulty eq 'normal'}">clDiffBtnSelect</c:if>">보 통</button>
										<button type="button" class="clDiffBtnH <c:if test="${clView.cDifficulty eq 'hard'}">clDiffBtnSelect</c:if>">어려움</button>
									</div>
								</li>
								
								<li class="list-group-item clPlaceMap">
									<p>
										<i title="교육장소" class="fas fa-map-marked-alt"></i>&nbsp;교육장소
									</p>
									<p>
										${clView.cAddress2}<br>
										${clView.cAddress3}(${clView.cAddress1})
									</p>
									<div id="map"></div>
								</li>								
								<hr>
								
								<c:choose>
									<c:when test="${loginUser.uNickname == null or loginUser.uNickname == clView.uNickname}">
										
									</c:when>

									<c:otherwise>
										<li class="list-group-item applyMenu">
											<div class="classJoinForm">
												<button class="btn btn-lg applyBtn" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false">강 좌 참 여</button>
												<div class="modal fade" id="modalForm" role="dialog">
													<div class="modal-dialog modal-lg">
														<div class="modal-content text-center">
												            <!-- Modal Header -->
												            <div class="modal-header">
												            	<p class="modal-title" id="myModalLabel">나의 가치를 올려주는 EE CLASS</p>
												            </div>
									            
												            <!-- Modal Body -->
												            <div class="modal-body">									            												            	
												            	<p>
												           			<img alt="class IMG" src="${clView.cThumnail}">
												            	</p>

												            	<table class="table table-hover">
												            		<tbody>
													            		<tr class="table-Default">
													            			<td>강 좌 명</td>
													            			<td>${clView.cTitle}</td>
													            		</tr>
													            		
													            		<tr class="table-Default">
													            			<td>개 설 자</td>
													            			<td>${clView.uNickname}</td>
													            		</tr>
													            		
													            		<tr class="table-Default">
													            			<td>포 인 트</td>
													            			<td><i class="fab fa-product-hunt" style="color: #FFC107;"></i>&nbsp;<fmt:formatNumber value="${clView.cPrice}" pattern="#,###" /></td>
													            		</tr>
													            		
													            		<tr class="table-Default">
													            			<td>신 청 일</td>
													            			<td><fmt:formatDate value="${now}" pattern="yyyy.MM.dd HH:MM"/></td>
													            		</tr>
												            		</tbody>
												            	</table>

												                <form id="classJoin" role="classJoinRole" name="cjform">
												      				<input type="hidden" name="class_id" value="${clView.cId}">
												      				<input type="hidden" name="user_id" value="${loginUser.user_id}">		<!-- 신청자 user_id -->
												      				<input type="hidden" name="opennerUser_id" value="${clView.user_id}">	<!-- 개설자 user_id -->
												      				<input type="hidden" name="classPrice" value="${clView.cPrice}">
												      			</form>
												            </div>
									            
												            <!-- Modal Footer -->
												            <div class="modal-footer">
																<p>
												            		<b style="color: #e7438b;"><fmt:formatNumber value="${clView.cPrice}" pattern="#,###"/></b> 포인트를 사용하여<br>
												            		<b style="color: #e7438b;">"${clView.cTitle}"</b><br>
												            		강좌를 결제합니다.
												            	</p>
												            	
												            	<div>										            	
													            	<table style="width: 100%;">
													            		<tr>
													            			<td>사용가능 포인트</td>
													            			<td><i class="fab fa-product-hunt" style="color: #FFC107;"></i>&nbsp;<fmt:formatNumber value="${loginUser.point}" pattern="#,###"/></td>
													            		</tr>
													            	</table>
												            	</div>
												            	<br>
												            	
													            <div class="cjoinBtn" align="center">
																	<button title="개설자에게 문의하기" class="btn btn-default" type="button" onclick="sendMessage('${clView.uNickname}',${clView.user_id});" style="margin-right: 30px;"><i class="fas fa-question fa-2x"></i></button>
																	<button title="수강신청" class="btn btn-default" type="button" onclick="classJoinForm(${loginUser.point}, ${clView.cTotalPeopleCount}, ${loginUser.user_id})" style="margin-right: 30px;"><i class="fas fa-check fa-2x"></i></button>
																	<button title="취소" class="btn btn-default" type="button" data-dismiss="modal" onclick="resetForm()"><i class="fas fa-ban fa-2x"></i></button>
																</div>
															</div>
												        </div>
									    			</div>
												</div>				
											</div>
										</li>
									</c:otherwise>
								</c:choose>

								<li class="list-group-item menuBtn">
									<c:choose>		
										<c:when test="${loginUser.uNickname == null}">
											<div align="center">
												<button title="강좌목록" class="btn classList" type="button"><i class="fas fa-list-ul fa-2x"></i></button>
											</div>
										</c:when>

										<c:when test="${loginUser.uNickname == clView.uNickname}"> 
											<div align="center">
												<button title="강좌수정" class="btn classModify" type="button"><i class="fas fa-edit fa-2x"></i></button>
												<button title="강좌삭제" class="btn classDelete" type="button"><i class="fas fa-eraser fa-2x"></i></button>
												<button title="강좌목록" class="btn classList" type="button"><i class="fas fa-list-ul fa-2x"></i></button>
											</div>
										</c:when>

										<c:otherwise>
											<div align="center">
												<button title="스크랩" class="btn" type="button" onclick="cScrap(${clView.cId})"><i class="fas fa-bookmark fa-2x"></i></button>
												<button title="강좌목록" class="btn classList" type="button"><i class="fas fa-list-ul fa-2x"></i></button>
											</div>
										</c:otherwise>
									</c:choose>
								
								</li>
							</ul>
						</div>	
					</div>
					<br>
					
					<div class="col clQuestion">
						<br><br>
						<div class="input-group hr-sect" >
							<h4>강 좌 문 의 (<b class="qCount"></b>)</h4>
						</div>
						
						<!-- 개설자일경우 안보임-->
						<c:choose>
							<c:when test="${loginUser.uNickname == clView.uNickname}"></c:when>

							<c:otherwise>
								<div class="questionForm">
									<h5>
										<b><i class="fas fa-comment-alt"></i>&nbsp;문 의 작 성</b>
									</h5>
									
									<table>
										<tr>
								            <td align=center rowspan="2" style="width: 85%;">
								            	<form name="qForm">
													<input type="hidden" name="class_id" value="${clView.cId}" />
													<input type="hidden" name="user_id" value="${loginUser.user_id}">
													<textarea id="cqInputform" class="form-control" rows="4" name="rpContent" placeholder="강좌에 문의할 점이 있으면 작성해주세요." style="width: 100%; resize: none;"></textarea>
												</form>
								            </td>
								            
								            <td align=center>
								            	<b>${loginUser.uNickname}</b>
								            </td>
								        </tr>
								        
								        <tr>
								            <td align=center>
								            	<button class="btn btn-lg questionBtn" type="button" name="qBtn"><b>문 의</b></button>
								            </td>
								        </tr>
									</table>
								</div>
							</c:otherwise>
						</c:choose>	
						
						<div class="questionList"></div>
						<div class="clQuestionPage"></div>
					</div>				
				</div>	
			</div>

			<form name="form1" role="form" method="post">
				<input type='hidden' name='cId' value="${clView.cId}">
				<input type="hidden" name="page" id="cscriPage" value="${cscri.page}" />
				<input type="hidden" name="perPageNum" id="cscriPageNum" value="${cscri.perPageNum}" />
				<input type="hidden" name="searchType" id="cscriSearchType" value="${cscri.searchType}" />
				<input type="hidden" name="keyword" id="cscriKeyword" value="${cscri.keyword}" />
				<input type="hidden" name="cCategory" id="cCategory" value="${cCategory}" />
			</form>
			
			<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}" />
			<input type="hidden" id="userId" name="loginUserId" value="${loginUser.user_id}" />
			<input type="hidden" id="uProfile" name="loginUserId" value="${loginUser.uprofile}">
			<input type="hidden" id="classId" value="${clView.cId}" />
			<input type="hidden" id="classOpenner" value="${clView.uNickname}" />
			<input type="hidden" id="classPrice" value="${clView.cPrice}" />
			<input type="hidden" id="difficulty" value="${clView.cDifficulty}"/>
			<input type="hidden" id="ad1" value="${clView.cAddress1}"/>
			<input type="hidden" id="ad2" value="${clView.cAddress2}"/>
			<input type="hidden" id="ad3" value="${clView.cAddress3}"/>
			<input type="hidden" id="difficulty" value="${clView.cDifficulty}"/>
			<input type="hidden" id="classEndDate" value="<fmt:formatDate value="${clView.cEndDate}" pattern="yyyy-MM-dd HH:MM:ss"/>">
			
			<!-- 문의사항 -->
			<script src="${pageContext.request.contextPath}/js/class/question/question.js"></script>
			
			<div id="clCurrentPageNum"></div>
		</section>
		
		<!-- chat -->
		<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
		<!-- chat -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/footer.jsp"%>
		<!-- footer -->

		<script src="${pageContext.request.contextPath}/js/common.js"></script>
		<script src="${pageContext.request.contextPath}/js/class/classContent.js"></script>
	</body>
</html>