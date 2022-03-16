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

<style type="text/css">
.bottom {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	padding: 15px 30px;
}

.btn {
	padding: 0.5rem 2rem;
	border: none;
	border-radius: 7px;
	background-color: #0cbcb7;;
	color: rgb(255, 255, 255);
	outline: transparent;
	cursor: pointer;
	font-size: 1rem;
}

table {
	width: 100%;
}

.invoice-panel tr td {
	padding: 20px 0 20px 20px;
}

input, .input-group {
	width: 80%;
}

input {
	font-size: 15px;
	height: calc(2.25rem + 2px);
	padding: 23px 20px;
	border: 1px solid #ced4da;
	outline: none;
}

select {
	border: 1px solid #ced4da !important;
}
</style>
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
											<li class="active"><a
												href="<%=request.getContextPath()%>/MVC/adminManagement/Index">後台首頁</a></li>
											<li class="active"><a
												href="<%=request.getContextPath()%>/MVC/MemberDispacher/MemberManage">會員管理</a></li>
											<li class="active"><a
												href="<%=request.getContextPath()%>/MVC/MemberDispacher/AddMember">新增會員</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
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
										<i class="ion-gear"></i>新增會員資料<br>
									</h5>
								</div>
								<div class="col-md-12">
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/member/member.do"
										name="form1">
										<span class="error errorMsgsOnly">${errorMsgs.exception}</span>
										<table>
											<tr>
												<td>Email :</td>
												<td><input type="email" name="email"
													required="required" value="${memberVO.email}"
													placeholder="Email" autofocus /><br> <span
													class="error errorMsgsOnly">${errorMsgs.email}</span></td>
												<td>密碼 :</td>
												<td><input type="password" name="password"
													required="required" placeholder="請輸入密碼" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.password}</span></td>
											</tr>


											<tr>
												<td>會員姓 :</td>
												<td><input type="TEXT" name="lastname"
													value="${memberVO.lastname}" placeholder="姓氏" /><br>
													<span class="error errorMsgsOnly">${errorMsgs.lastname}</span></td>
												<td>會員名 :</td>
												<td><input type="TEXT" name="firstname"
													value="${memberVO.firstname}" placeholder="名子" /><br>
													<span class="error errorMsgsOnly">${errorMsgs.firstname}</span></td>
											</tr>

											<tr>
												<td>國家 :</td>
												<td><%@include file="file/select-country.file"%></td>
												<td>身分證字號 :</td>
												<td><input type="text" name="idno"
													value="${memberVO.idno}" placeholder="身分證字號" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.idno}</span></td>
											</tr>

											<tr>
												<td>性別 :</td>
												<td><select name="gender" >
														<option value="">請選擇</option>
														<option value="男"
															${memberVO.gender == "男" ? 'selected="selected"' : ''}>男</option>
														<option value="女"
															${memberVO.gender == "女" ? 'selected="selected"' : ''}>女</option>
												</select></td>
												<td>手機 :</td>
												<td><input type="text" name="phone"
													value="${memberVO.phone}" placeholder="手機" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.phone}</span></td>
											</tr>


											<tr>
												<td>綽號 :</td>
												<td><input type="text" name="nickname"
													value="${memberVO.nickname}" placeholder="綽號" /></td>
												<td>自我介紹 :</td>
												<td><input type="text" name="selfintro"
													value="${memberVO.selfintro}" placeholder="自我介紹" /></td>
											</tr>
											<tr>
												<td>生日 :</td>
												<td><div id="datepicker-from" class="input-group date"
														class="w-37" data-date-format="yyyy-mm-dd">
														<input name="dateofbirth" class="form-control" type="text"
															placeholder="請選擇生日" autocomplete="off"
															value="${memberVO.dateofbirth}"> <span
															class="input-group-addon"><i
															class="icofont-ui-calendar"></i><br> <span
															class="error errorMsgsOnly">${errorMsgs.dateofbirth}</span></span>
													</div></td>
											</tr>
										</table>
										<div class="button">
											<br> <input type="hidden" name="action" value="insert">
											<button type="submit" class="btn v3">送出新增</button>
										</div>

										<br>
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