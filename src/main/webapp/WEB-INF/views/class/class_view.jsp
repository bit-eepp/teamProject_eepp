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
						<div class="clContentTitle">
							<p id="classTitle">${clView.cTitle}</p>
						</div>
						
						<div class="clContentSummary">
							<p>${clView.cSummary}</p>
						</div>

						<div class="clContentThumnail">
							<img alt="ClassImg" src="${clView.cThumnail}">
						</div>
						<br>
						
						<div class="hr-sect" >
							<p>강좌소개</p>
						</div>
						
						<div class="clContentView">
							${clView.cContent}
						</div>
					</div>
					
					<div class="col-4 clContentRight">
						<div class="clContentDetailHaed">
							<p class="classInfoTitle">세 부 정 보</p>
						</div>
						
						<div class="clContentDetailBody">			
							<ul class="detailBody-ul">
								<li class="openUser detailBody-li">
									<c:choose>
										<c:when test="${clView.uNickname eq loginUser.uNickname or clView.uNickname eq '운영자' or clView.uNickname eq 'admin2' or loginUser.uNickname == null}">
											<div class="clOpennerNick">
												<p class="clInfoTitle">
													<i title="개설자" class="fas fa-user-circle"></i>개설자
												</p>
												<p class="clInfoTxt"><a class="userBtn clUserE">${clView.uNickname}</a></p>
											</div>
										</c:when>
											
										<c:otherwise>	
											<div class="dropdown clOpennerNick">
												<p class="clInfoTitle">
													<i title="개설자" class="fas fa-user-circle"></i>개설자
												</p>
													<a href="#" class="userBtn clUser clInfoTxt" id="user_btn_${clView.user_id}${clView.cId}" data-toggle="dropdown">${clView.uNickname}</a>
						           				<ul class="dropdown-menu" role="menu" aria-labelledby="user_btn_${clView.user_id}${clView.cId}">
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
											            			<textarea class="form-control" id="etc_${clView.cId}" name="dReason" disabled></textarea>
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
								
								<li class="price detailBody-li">
									<p class="clInfoTitle">
										<i title="포인트 가격" class="fab fa-product-hunt" style="color: #FFC107;"></i>포인트
									</p>
									<p class="clInfoTxt">
										<fmt:formatNumber value="${clView.cPrice}" pattern="#,###" />
									</p>
								</li>
								
								<li class="cate detailBody-li">
									<p class="clInfoTitle">
										<i title="강좌 카테고리" class="fas fa-th-list"></i>카테고리
									</p>
									<p class="clInfoTxt">
									<c:choose>
										<c:when test="${clView.cCategory eq 'it_dev'}">
											IT/개발
										</c:when>
										
										<c:when test="${clView.cCategory eq 'workSkill'}">
											업무스킬
										</c:when>
										
										<c:when test="${clView.cCategory eq 'financialTechnology'}">
											재테크
										</c:when>
										
										<c:when test="${clView.cCategory eq 'daily'}">
											일상
										</c:when>
										
										<c:when test="${clView.cCategory eq 'etc'}">
											기타
										</c:when>
									</c:choose>
									</p>
								</li>
								
								<li class="period detailBody-li">
									<p class="clInfoTitle">
										<i title="신청기간" class="fas fa-calendar-alt"></i>신청기간
									</p>
									<p class="clInfoTxt">
										<fmt:formatDate value="${clView.cOpenDate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${clView.cEndDate}" pattern="yyyy.MM.dd"/>
									</p>
								</li>

								<li class="remain detailBody-li">
									<p class="clInfoTitle">
										<i title="남은기간" class="far fa-clock"></i>남은기간
									</p>
									<p id="classEndCountDown" class="clInfoTxt"></p>
								</li>
					
								<li class="count detailBody-li">
									<p class="clInfoTitle">
										<i title="신청인원" class="fas fa-users"></i>신청인원
									</p>
									<p class="classCurrentPeople clInfoTxt"></p>
								</li>
								
								<li class="diff detailBody-li">
									<p class="clInfoTitle">
										<i title="난이도" class="fas fa-layer-group"></i>난이도
									</p>
									<div class="clDiffGroup clInfoTxt">
										<p class="clDiff <c:if test="${clView.cDifficulty eq 'easy'}">clDiffSelect</c:if>">쉬 움</p>
										<p class="clDiff <c:if test="${clView.cDifficulty eq 'normal'}">clDiffSelect</c:if>">보 통</p>
										<p class="clDiff <c:if test="${clView.cDifficulty eq 'hard'}">clDiffSelect</c:if>">어려움</p>
									</div>
								</li>
								
								<li class="clPlaceMap detailBody-li">
									<p class="clInfoTitle">
										<i title="교육장소" class="fas fa-map-marked-alt"></i>교육장소
									</p>
									<p class="clInfoMap">
										${clView.cAddress2}<br>
										${clView.cAddress3}(${clView.cAddress1})
									</p>
									<div id="map" style="width:100%; height:200px;"></div>
								</li>
								
								<c:choose>
									<c:when test="${loginUser.uNickname == null or loginUser.uNickname == clView.uNickname}">
										
									</c:when>

									<c:otherwise>
										<li class="applyMenu detailBody-li">
											<div class="classJoinForm">
												<button class="btn applyBtn" data-toggle="modal" data-target="#modalForm" data-backdrop="static" data-keyboard="false">강좌참여</button>
												<div class="modal fade" id="modalForm" role="dialog">
													<div class="modal-dialog">
														<div class="modal-content text-center">
												            <!-- Modal Header -->
												            <div class="modal-header">
												            	<p class="modal-title" id="myModalLabel">나의 가치를 올려주는 EE CLASS</p>
												            </div>
									            
												            <!-- Modal Body -->
												            <div class="modal-body">									            												            	
												            	<p class="classImg">
												           			<img alt="class IMG" src="${clView.cThumnail}">
												            	</p>

												            	<table>
												            		<tbody>
													            		<tr class="table-Default">
													            			<td class="tb-title">강 좌 명</td>
													            			<td>${clView.cTitle}</td>
													            		</tr>
													            		
													            		<tr class="table-Default">
													            			<td class="tb-title">개 설 자</td>
													            			<td>${clView.uNickname}</td>
													            		</tr>
													            		
													            		<tr class="table-Default">
													            			<td class="tb-title">포 인 트</td>
													            			<td><i class="fab fa-product-hunt" style="color: #FFC107;"></i>&nbsp;<fmt:formatNumber value="${clView.cPrice}" pattern="#,###" /></td>
													            		</tr>
													            		
													            		<tr class="table-Default">
													            			<td class="tb-title">신 청 일</td>
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
																<p class="paymentInfo">
												            		<b style="color: #e7438b;"><fmt:formatNumber value="${clView.cPrice}" pattern="#,###"/></b> 포인트를 사용하여<br>
												            		<b style="color: #e7438b;">"${clView.cTitle}"</b><br>
												            		강좌를 결제합니다.
												            	</p>
												            	<p class="mypointInfo">사용가능 포인트 : <i class="fab fa-product-hunt" style="color: #FFC107;"></i>&nbsp;<fmt:formatNumber value="${loginUser.point}" pattern="#,###"/></p>
												            	
													            <div class="cjoinBtn" align="center">
																	<button title="개설자에게 문의하기" class="btn" type="button" onclick="sendMessage('${clView.uNickname}',${clView.user_id});"><i class="far fa-envelope"></i></button>
																	<button title="수강신청" class="btn" type="button" onclick="classJoinForm(${loginUser.point}, ${clView.cTotalPeopleCount}, ${loginUser.user_id})"><i class="fas fa-check fa-2x"></i></button>
																	<button title="취소" class="btn" type="button" data-dismiss="modal" onclick="resetForm()"><i class="fas fa-times"></i></button>
																</div>
															</div>
												        </div>
									    			</div>
												</div>				
											</div>
										</li>
									</c:otherwise>
								</c:choose>

								<li class="menuBtn detailBody-li">
									<c:choose>		
										<c:when test="${loginUser.uNickname == null}">
											<div class="btnWrap">
												<button title="강좌목록" class="btn classList" type="button"><i class="fas fa-list-ul fa-2x"></i></button>
												<!-- 게시글 공유 -->
												<p class="shareBtn">
													<a class="share" id="kakaoShareBtn">
														<img src="${pageContext.request.contextPath}/img/kakaolink_btn_medium.png"/>
													</a>
												</p>
											</div>
										</c:when>

										<c:when test="${loginUser.uNickname == clView.uNickname}"> 
											<div class="btnWrap">
												<button title="강좌수정" class="btn classModify" type="button"><i class="fas fa-edit fa-2x"></i></button>
												<button title="강좌삭제" class="btn classDelete" type="button"><i class="fas fa-eraser fa-2x"></i></button>
												<button title="강좌목록" class="btn classList" type="button"><i class="fas fa-list-ul fa-2x"></i></button>
												<!-- 게시글 공유 -->
												<p class="shareBtn">
													<a class="share" id="kakaoShareBtn">
														<img src="${pageContext.request.contextPath}/img/kakaolink_btn_medium.png"/>
													</a>
												</p>
											</div>
										</c:when>

										<c:otherwise>
											<div class="btnWrap">
												<button title="스크랩" class="btn" type="button" onclick="cScrap(${clView.cId})"><i class="fas fa-bookmark fa-2x"></i></button>
												<button title="강좌목록" class="btn classList" type="button"><i class="fas fa-list-ul fa-2x"></i></button>
												<!-- 게시글 공유 -->
												<p class="shareBtn">
													<a class="share" id="kakaoShareBtn">
														<img src="${pageContext.request.contextPath}/img/kakaolink_btn_medium.png"/>
													</a>
												</p>
											</div>
										</c:otherwise>
									</c:choose>
								
								</li>
							</ul>
						</div>	
					</div>
					<br>
					
					<div class="col clQuestion">
						<div class="input-group hr-sect" >
							<h4>강 좌 문 의 (<b class="qCount"></b>)</h4>
						</div>
						
						<!-- 개설자일경우 안보임-->
						<c:choose>
							<c:when test="${loginUser.uNickname == clView.uNickname}"></c:when>

							<c:otherwise>
								<div class="questionForm">
									<h5>
										<b>문 의 작 성<i class="fas fa-comment-alt"></i></b>
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
								        </tr>
								        
								        <tr>
								            <td>
								            	<p class="qUser">${loginUser.uNickname}</p>
								            	<button class="btn questionBtn" type="button" name="qBtn"><p>등록</p></button>
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
			<input type="hidden" id="classTotalPeopleCount" value="${clView.cTotalPeopleCount}">
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