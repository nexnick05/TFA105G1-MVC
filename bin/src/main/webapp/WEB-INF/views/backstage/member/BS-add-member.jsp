<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<%
MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //MemberServlet.java(Controller), 存入req的memberVO物件 (包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)
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
<title>新增會員</title>

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
											<li class="active"><a href="#">Home</a></li>
											<li class="active"><a
												href="<%=request.getContextPath()%>/download/BS-member_manage.jsp">會員管理</a></li>
											<li>新增會員</li>
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
										<i class="ion-gear"></i>新增會員資料
									</h5>
								</div>
								<div class="col-md-12">
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/member/member.do"
										name="form1">
										<table>
											<tr>
												<td>Email :</td>
												<td><input type="email" name="email" size="30" required
													value="${memberVO.email}" placeholder="Email" autofocus /></td>
											</tr>
											<tr>
												<td>密碼 :</td>
												<td><input type="password" name="password" size="30"
													required placeholder="請輸入密碼" /></td>
											</tr>
											<!--<tr>
											<td>確認密碼 : </td>
											<td><input type="password" name="Confirm Password" size="30"
												 placeholder="確認密碼"/></td>
										</tr>	-->
											<tr>
												<td>會員姓 :</td>
												<td><input type="TEXT" name="lastname" size="30"
													value="${memberVO.lastname}" placeholder="姓氏" /></td>
											</tr>
											<tr>
												<td>會員名 :</td>
												<td><input type="TEXT" name="firstname" size="30"
													value="${memberVO.firstname}" placeholder="名子" /></td>
											</tr>
											<tr>
												<td>身分證字號 :</td>
												<td><input type="text" name="idno" size="30"
													value="${memberVO.idno}" placeholder="身分證字號" /></td>
											</tr>
											<tr>
												<td>性別 :</td>
												<td><select class="w-37" name="gender">
														<option value="">請選擇</option>
														<option value="男"
															${memberVO.gender == "男" ? 'selected="selected"' : ''}>男</option>
														<option value="女"
															${memberVO.gender == "女" ? 'selected="selected"' : ''}>女</option>
												</select></td>
											</tr>
											<tr>
												<td>生日 :</td>
												<td><div id="datepicker-from" class="input-group date"
														class="w-37" data-date-format="yyyy-mm-dd">
														<input name="dateofbirth" class="form-control" type="text"
															placeholder="請選擇生日" autocomplete="off"
															value="${memberVO.dateofbirth}"> <span
															class="input-group-addon"><i
															class="icofont-ui-calendar"></i></span>
													</div></td>
											</tr>
											<tr>
												<td>國家 :</td>
												<td><%@include file="file/select-country.file"%></td>
											</tr>
											<tr>
												<td>手機 :</td>
												<td><input type="text" name="phone" size="30"
													value="${memberVO.phone}" placeholder="手機" /></td>
											</tr>
											<tr>
												<td>綽號 :</td>
												<td><input type="text" name="nickname" size="30"
													value="${memberVO.nickname}" placeholder="綽號" /></td>
											</tr>
											<tr>
												<td>自我介紹 :</td>
												<td><input type="text" name="selfintro" size="45"
													value="${memberVO.selfintro}" placeholder="自我介紹" /></td>
											</tr>
										</table>
										<br> <input type="hidden" name="action" value="insert">
										<input type="submit" value="送出新增">
									</FORM>
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