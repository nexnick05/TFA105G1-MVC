<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<%
Integer memberid = (Integer) session.getAttribute("memberid");
MemberService memberSvc = new MemberService();
MemberVO memberVO = memberSvc.getOneMember(memberid);
pageContext.setAttribute("memberVO", memberVO);
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
<!-- Document Title -->
<title>基本資料</title>

</head>

<body>
	<div class="page-wrapper">
		<!--Sidebar Menu Starts-->
		<%@include file="/WEB-INF/views/frontstage/file/FS_Sidebar Menu.file"%>
		<!--Sidebar Menu ends-->

		<!--Dashboard content Wrapper starts-->
		<div class="dash-content-wrap">

			<!-- Top header starts-->

			<%@include file="/WEB-INF/views/frontstage/file/FS_Header.file"%>

			<!-- Top header ends-->

			<!--main 上索引開始-->
			<div class="dash-breadcrumb">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="dash-breadcrumb-content">
								<div class="dash-breadcrumb-left">
									<div class="breadcrumb-menu text-right sm-left">
										<ul>
											<li class="active"><a href="#">Home</a></li>
											<li>My Profile</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--main 上索引結束-->
			<!--main content starts-->
			<div class="dash-content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-10 offset-md-1">
							<div class="recent-activity">
								<div class="act-title">
									<h5>
										<i class="ion-person"></i>基本資料
									</h5>
								</div>
								<div class="profile-wrap">
									<div class="row">
										<div class="col-md-8 offset-md-2 py-4">
											<div class="edit-profile-photo text-center">
												<a
													href="<%=request.getContextPath()%>/download/BS-update-image.jsp?memberid=${memberVO.memberid}"><img
													alt="${memberVO.memberid}"
													src="<%=request.getContextPath()%>/member/member.pic?memberid=${memberVO.memberid}"
													width="80px"></a>
											</div>
										</div>
										<div class="col-md-12">
											<div class="my-profile">
												<ul class="db-profile-info">
													<li>
														<h6>First Name :</h6> <span>${(memberVO == null) ? "名字" : memberVO.firstname}</span>
													</li>
													<li>
														<h6>Last Name :</h6> <span>${(memberVO == null) ? "姓氏" : memberVO.lastname}</span>
													</li>
													<li>
														<h6>Email Id :</h6> <span>${(memberVO == null) ? "電子信箱" : memberVO.email}</span>
													</li>
													<li>
														<h6>Phone :</h6> <span>${(memberVO == null) ? "連絡電話" : memberVO.phone}</span>
													</li>
													<li>
														<h6>Password :</h6> <span>${(memberVO == null) ? "密碼" : memberVO.password}</span>
													</li>
													<!-- 													<li> -->
													<!-- 														<h6>Address :</h6> <span> 864 W. Walnut Ave. Avon, -->
													<!-- 															IN 46123 St James Pl, Brooklyn</span> -->
													<!-- 													</li> -->
													<!-- <li>
                                                        <h6>Social Profile :</h6>
                                                        <ul class="social-profile">
                                                            <li class="bg-fb"><a href="https://www.facebook.com"><i class="ion-social-facebook"></i></a></li>
                                                            <li class="bg-tt"><a href="https://www.twitter.com"><i class="ion-social-twitter"></i></a></li>
                                                            <li class="bg-ig"><a href="https://www.instagram.com"><i class="ion-social-instagram"></i></a></li>
                                                        </ul>
                                                    </li> -->

												</ul>
												<a href="db-edit-profile.jsp" class="btn v5">Edit
													profile</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--main content ends-->

			<!--Dashboard footer starts-->
			<%@include file="/WEB-INF/views/frontstage/file/FS_footer.file"%>
			<!--Dashboard footer ends-->
		</div>
		<!--Dashboard content Wrapper ends-->
	</div>
	<!-- Plugin JS-->
	<script src="js/plugin.js"></script>
	<!--Perfect Scrollbar JS-->
	<script src="js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="js/dashboard.js"></script>
</body>

</html>
