<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<html lang="en">
<head>
<!-- Metas -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="NickWu" content="LionCoders" />
<!-- Links -->
<!-- <link rel="icon" type="image/png" href="#" /> -->
<!-- google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800"
	rel="stylesheet">
<!-- Plugins CSS -->
<link href="<%=request.getContextPath()%>/download/css/plugin.css"
	rel="stylesheet" />
<!-- Perfect scrollbar CSS-->
<link
	href="<%=request.getContextPath()%>/download/css/perfect-scrollbar.css"
	rel="stylesheet">
<!-- style CSS -->
<link href="<%=request.getContextPath()%>/download/css/style.css"
	rel="stylesheet" />
<!-- Dashboard CSS -->
<link href="<%=request.getContextPath()%>/download/css/dashboard.css"
	rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/download/css/switcher/skin-aqua.css"
	media="screen" id="style-colors" />
<!-- Document Title -->
<title>模擬首頁</title>

</head>

<body>
	<!--Page Wrapper starts-->
	<div class="page-wrapper">
		<!--Header starts-->
		<%@include file="file/FS_Header.file"%>
		<!--Header ends-->

		<!--User Login section starts-->
		<div class="user-login-section section-padding bg-fixed"
			style="background-image: url(images/header/hero-5.jpg)">
			<div class="container">
				<div class="row">
					<div class="col-md-10 offset-md-1  text-center">
						<!-- login-wrapper-start -->
						<div class="login-wrapper"
							class="modal-dialog modal-dialog-centered">
							<ul
								class="ui-list nav nav-tabs justify-content-center mar-bot-30"
								role="tablist">
								<li class="nav-item"><a class="nav-link active"
									data-toggle="tab" href="#register" role="tab"
									aria-selected="false">註冊</a></li>
							</ul>
							<div>
								<%-- 錯誤表列 --%>
								<c:if test="${not empty errorMsgs}">
									<font style="color: red">請修正以下錯誤:</font>
									<ul>
										<c:forEach var="message" items="${errorMsgs}">
											<li style="color: red">${message}</li>
										</c:forEach>
									</ul>
								</c:if>
							</div>
							<div class="ui-dash tab-content">
								<div class="tab-pane fade show active" id="register"
									role="tabpanel">
									<form id="register-form"
										action="<%=request.getContextPath()%>/member/member.register"
										method="post">
										<div class="form-group">
											<input type="email" name="email" id="email" tabindex="1"
												class="form-control" placeholder="Email" value="" required>
										</div>
										<div class="form-group">
											<input type="password" name="password" id="password"
												tabindex="2" class="form-control" placeholder="Password"
												required>
										</div>
										<div class="form-group">
											<input type="password" name="confirm-password"
												id="confirm-password" tabindex="2" class="form-control"
												placeholder="Confirm Password" required>
										</div>
										<div class="res-box text-left">
											<input type="checkbox" tabindex="3" class="" name="agreement"
												id="agreement" value="agreement" required> <label
												for="agreement">我已詳閱並同意 <a
												href="#TermsAndConditions">使用者條款</a> &amp; <a
												href="#Privacy">隱私權保護政策</a></label>
										</div>
										<div class="res-box text-center mar-top-30">
											<button type="submit" class="btn v3" name="action"
												value="register">
												<i class="ion-android-checkmark-circle"></i>註冊
											</button>
										</div>
									</form>
									<div class="col-md-8 col-12 text-left">
										<div class="res-box sm-left">
											已經有帳號了？<a
												href="<%=request.getContextPath()%>/download/FS-login.jsp"
												tabindex="5" class="register"><i class="ion-log-in"></i>
												登入</a>
										</div>
									</div>
									<div class="social-profile-login text-center mar-top-30">
										<!-- <h5>使用社交平台帳戶登入</h5>
                                        <ul class="social-btn">
                                            <li class="bg-fb"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                            <li class="bg-tt"><a href="#"><i class="ion-social-twitter"></i></a></li>
                                            <li class="bg-ig"><a href="#"><i class="ion-social-instagram"></i></a></li>
                                        </ul> -->
									</div>
								</div>
							</div>
						</div>
						<!-- login-wrapper-end -->
					</div>
				</div>
			</div>
		</div>
		<!--User login section ends-->
	</div>
	<!--Page Wrapper ends-->








	<!--Dashboard footer starts-->
	<%@include file="file/FS_footer.file"%>
	<!--Dashboard footer ends-->



	<!-- Plugin JS-->
	<script src="<%=request.getContextPath()%>/download/js/plugin.js"></script>
	<!--Perfect Scrollbar JS-->
	<script
		src="<%=request.getContextPath()%>/download/js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="<%=request.getContextPath()%>/download/js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="<%=request.getContextPath()%>/download/js/dashboard.js"></script>


</body>

</html>
