<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<%
Integer id = Integer.valueOf(request.getParameter("memberid"));
%>

<html lang="en">
<head>
<!-- Metas -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="NickWu" content="LionCoders" />
<!-- Links -->
<link rel="icon" type="image/png" href="#" />
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
<style>
.picBox {
	display: block;
	margin: auto;
}

.bottom {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	padding: 15px 30px;
	flex-direction: column-reverse;
}
</style>
<!-- Document Title -->
<title>更新頭像</title>

</head>

<body>

	<div class="page-wrapper">
		<!--Sidebar Menu Starts-->
		<%@include file="/download/file/BS_Sidebar Menu.file"%>
		<!--Sidebar Menu ends-->

		<!--Dashboard content Wrapper starts-->
		<div class="dash-content-wrap">

			<!-- Top header starts-->
			<%@include file="/download/file/BS_Top header.file"%>
			<!-- Top header ends-->

			<!--Dashboard breadcrumb starts-->
			<div class="dash-breadcrumb">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="dash-breadcrumb-content">
								<div class="dash-breadcrumb-left">
									<div class="breadcrumb-menu text-right sm-left">
										<ul>
											<li class="active"><a
												href="<%=request.getContextPath()%>/MVC/adminManagement/Index">後台首頁</a></li>
											<li class="active"><a
												href="<%=request.getContextPath()%>/MVC/MemberDispacher/MemberManage">會員管理</a></li>
											<li>更新頭像</li>
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
										<i class="ion-gear"></i>更新頭像
									</h5>
								</div>
								<div class="row">
									<div class="col-md-4">
										<div class="edit-profile-photo">



											<div id="changePic">

												<img class="picBox"
													src="<%=request.getContextPath()%>/member/member.pic?memberid=<%=id%>">
											</div>

											<div class="change-photo-btn">
												<div class="contact-form__upload-btn xs-left">

													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/member/member.upload"
														enctype="multipart/form-data">
														<div class="bottom">
															<label for="p_file" class="btn v2">請選擇檔案 <input
																type="file" id="p_file" name="photo-upload"
																style="display: none;" accept="image/jpeg, image/png" />
																<input type="hidden" name="memberid" value="<%=id%>">
															</label>
														</div>

														<div class="bottom">
															<input type="submit" name="action" class="btn v3"
																value="上傳">
														</div>

													</FORM>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!--Dashboard content ends-->

			<!--Dashboard footer starts-->
			<%@include file="/download/file/BS_footer.file"%>
			<!--Dashboard footer ends-->
		</div>
		<!--Dashboard content Wrapper ends-->
	</div>
	<!-- Plugin JS-->
	<script src="<%=request.getContextPath()%>/download/js/plugin.js"></script>
	<!--Perfect Scrollbar JS-->
	<script
		src="<%=request.getContextPath()%>/download/js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="<%=request.getContextPath()%>/download/js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="<%=request.getContextPath()%>/download/js/dashboard.js"></script>
	<!-- changePic id="p_file"-->
	<script src="<%=request.getContextPath()%>/download/js/changePic.js"></script>
</body>

</html>
