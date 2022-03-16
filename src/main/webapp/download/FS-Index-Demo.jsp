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
		<!--Dashboard breadcrumb starts-->
		<div class="dash-breadcrumb">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
						<div class="dash-breadcrumb-content">
							<div class="dash-breadcrumb-left">
								<div class="breadcrumb-menu text-right sm-left">
									<ul>
										<li class="active"><a href="#">Home</a></li>
										<li class="active"><a
											href="<%=request.getContextPath()%>/download/BS-member_manage.jsp">會員管理</a></li>
										<li>編輯會員資料</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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
		<!--Dashboard breadcrumb ends-->
		<!--Dashboard content starts-->
		<div class="dash-content">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12 ">
						<div class="invoice-panel">
							<div class="act-title">
								<h5>
									<i class="ion-gear"></i>我是首頁 <a
										href="<%=session.getAttribute("memberid") == null ? request.getContextPath() + "/download/FS-login.jsp"
		: request.getContextPath() + "/member/member.login?action=logout"%>"><%=session.getAttribute("memberid") == null ? "登入/註冊" : "登出"%></a>

								</h5>
							</div>
							<div class="invoice-body">session.memberVO = ${memberVO.email}</div>

						</div>


					</div>
				</div>
			</div>
		</div>
		<!--Dashboard content ends-->
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
