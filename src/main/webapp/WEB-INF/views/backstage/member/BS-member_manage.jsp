<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>


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
<title>會員管理</title>

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
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<span class="errorMsgsOnly">請修正以下錯誤:</span>
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
										<i class="ion-person"></i>會員資料 <a class="btn v2"
											href="<%=request.getContextPath()%>/MVC/MemberDispacher/AddMember"><i class="ion-log-in"></i>新增</a>										
									</h5>
								</div>
								<div class="invoice-body">
									<div class="table-responsive">
										<table class="invoice-table">
											<thead>
												<tr class="invoice-headings" style="text-align: center">
													<th>No.</th>
													<th>Email</th>
													<th>頭像</th>
													<th>姓</th>
													<th>名</th>
													<th>性別</th>
													<th>生日</th>
													<th>身分證字號</th>
												</tr>
											</thead>
											<c:forEach var="memberVO" items="${memberList}">
												<tbody>
													<tr style="text-align: center; padding: 10 0">
														<td>${memberVO.memberid}</td>
														<td>${memberVO.email}</td>
														<td><a href="<%=request.getContextPath()%>/MVC/MemberDispacher/MemberUpdatePic?memberid=${memberVO.memberid}">
														<img alt="${memberVO.memberid}" src="<%=request.getContextPath()%>/member/member.pic?memberid=${memberVO.memberid}" width="60px"></a></td>
														<td>${memberVO.lastname}</td>
														<td>${memberVO.firstname}</td>
														<td>${memberVO.gender}</td>
														<td>${memberVO.dateofbirth}</td>
														<td>${memberVO.idno}</td>
														<td>
															<FORM METHOD="post"
																ACTION="<%=request.getContextPath()%>/member/member.do">
																<input type="submit" class="btn v2" value="編輯">
																<input type="hidden" name="memberid"
																	value="${memberVO.memberid}"> <input
																	type="hidden" name="action" value="getOne_For_Update">
															</FORM>
														</td>
														<td>
															<FORM METHOD="post"
																ACTION="<%=request.getContextPath()%>/member/member.do">
																<input type="submit" class="btn v2" value="刪除">
																<input type="hidden" name="memberid"
																	value="${memberVO.memberid}"> <input
																	type="hidden" name="action" value="delete">
															</FORM>
														</td>
													</tr>
												</tbody>
											</c:forEach>
										</table>

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
</body>

</html>
