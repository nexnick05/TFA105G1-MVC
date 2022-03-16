<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<%
// String cameFromURL = request.getHeader("referer");
// String loginURL = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();
// if(!loginURL.equals(cameFromURL)){
// 	session.setAttribute("cameFromURL", cameFromURL);
// }
%>

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
<title>更改密碼</title>

</head>

<body>
	<!--Page Wrapper starts-->
	<div class="page-wrapper">
		<!--Header starts-->
		<%@include file="file/FS_Header.file"%>
		<!--Header ends-->

		<!--User Login section starts-->
		<div class="user-login-section section-padding bg-fixed"
			style="background-image: url(<%=request.getContextPath()%>/download/images/FS-login.jpg)">
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
									data-toggle="tab" href="#login" role="tab" aria-selected="true">更改密碼</a>
								</li>
							</ul>

							<div class="ui-dash tab-content">
								<div class="tab-pane fade show active" id="login"
									role="tabpanel">

									<form id="login-form"
										action="<%=request.getContextPath()%>/MVC/MemberInfo/checkPWD"
										method="post">
										<div class="form-group">
											<span class="error errorMsgsOnly">${errorMsgs.result}
												${verificationFailed}</span>												
										</div>
										<div class="form-group">																						
											<span>${rtEmail}</span>				
										</div>										
										<div class="form-group">
											<input type="password" name="newPWD" id="newPWD" tabindex="1"
												class="form-control" placeholder="請輸入新密碼" required autofocus><span
												class="error errorMsgsOnly">${errorMsgs.password}</span>
										</div>
										<div class="form-group">
											<input type="password" name="confirm_password"
												id="confirm-password" tabindex="2" class="form-control"
												placeholder="確認新密碼" required><span
												class="error errorMsgsOnly">${errorMsgs.confirmPWD}</span>
										</div>
										<div class="row mar-top-20">
											<div class="col-md-6 col-12 text-left"></div>
											<div class="col-md-6 col-12 text-right"></div>
										</div>
										<div class="res-box text-center mar-top-30">
											<input type="hidden" name="id" value="${no}">
											<button type="submit" class="btn v3" name="action"
												value="checkPWD">
												<i class="ion-log-in"></i>確認送出
											</button>

										</div>
									</form>
									<div class="col-md-6 col-12 text-left">
										<div class="res-box sm-left">
											<!-- <a -->
											<%-- href="<%=request.getContextPath()%>/download/FS-login.jsp" --%>
											<!-- tabindex="5" class=""></a> -->
										</div>
									</div>
									<div class="social-profile-login text-center mar-top-30">

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
	<!-- modal-start -->
	<div class="modal fade" id="forgot-password">
		<div class="modal-dialog modal-dialog-centered" role="image">
			<div class="picBox">
				<h2>忘記密碼 :</h2>

				<div id="add-form">
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/MVC/MemberInfo/PwdForget"
						name="form1">
						<table>
							<tr>
								<td><input type="text" name="FGemail" id="modalUsername"
									tabindex="1" class="form-control" placeholder="請輸入email"
									required autofocus></td>
							</tr>
						</table>
						<br> <input type="hidden" name="FGaction" value="forgotPWD">
						<button type="submit" class="btn v3" name="emailaction"
							value="login">
							<i class="ion-ios-email"></i>發送驗證碼
						</button>
					</FORM>
				</div>
			</div>
		</div>
	</div>
	<!-- modal-ends -->

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

	<script>
		$
		{
			errorCheck.checkEmail
		}
	<%session.removeAttribute("errorCheck");%>
		
	</script>

</body>

</html>
