<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<!DOCTYPE html>
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
	padding: 14px 20px;
	border: 1px solid #ced4da;
	outline: none;
}

</style>




<!-- Document Title -->
<title>編輯資料</title>

</head>

<body>
	<div class="page-wrapper">
		<!--Sidebar Menu Starts-->
		<%@include file="file/FS_Sidebar Menu.file"%>
		<!--Sidebar Menu ends-->

		<!--Dashboard content Wrapper starts-->
		<div class="dash-content-wrap">

			<!-- Top header starts-->
			<%@include file="file/FS_Header.file"%>
			<!-- Top header ends-->

			<!--main 上索引starts-->
			<div class="dash-breadcrumb">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="dash-breadcrumb-content">
								<div class="dash-breadcrumb-left">
									<div class="breadcrumb-menu text-right sm-left">
										<ul>
											<li class="active"><a
												href="<%=request.getContextPath()%>/download/FS-my-profile.jsp">會員專區</a></li>
											<li class="active"><a
												href="<%=request.getContextPath()%>/download/FS-edit-profile.jsp">編輯基本資料</a></li>

										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--main 上索引ends-->
			<!--main content starts-->
			<div class="dash-content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-10 offset-md-1">
							<div class="invoice-panel">
								<div class="act-title">
									<h5>
										<i class="ion-gear"></i>編輯基本資料<br> <span
													class="error errorMsgsOnly">${errorMsgs.exception}</span>
									</h5>
								</div>
								<div class="profile-wrap">
									<!-- 多的-->
									<div class="row">
										<div class="col-md-12">
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/member/member.do"
												name="form1">
												<table>
													<tr>
														<td>Email :</td>
														<td><input type="TEXT" name="email" size="30"
															value="${memberVO.email}" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.email}</span></td>
													</tr>
													<tr>
														<td>密碼 :</td>
														<td><input type="TEXT" name="password" size="30"
															value="${memberVO.password}" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.password}</span></td>
													</tr>
													<tr>
														<td>姓氏 :</td>
														<td><input type="TEXT" name="lastname" size="30"
															value="${memberVO.lastname}" placeholder="請輸入姓氏" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.lastname}</span></td>
													</tr>
													<tr>
														<td>名字 :</td>
														<td><input type="TEXT" name="firstname" size="30"
															value="${memberVO.firstname}" placeholder="請輸入名字" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.firstname}</span></td>
													</tr>
													<tr>
														<td>身分證字號 :</td>
														<td><input type="TEXT" name="idno" size="30"
															value="${memberVO.idno}" placeholder="請輸入身分證字號" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.idno}</span></td>
													</tr>
													<tr>
														<td>性別 :</td>
														<td><select class="w-37" name="gender">
																<option value="">請選擇</option>
																<option value="男"
																	${memberVO.gender=="男"
                                                                            ? 'selected="selected"' : '' }>男</option>
																<option value="女"
																	${memberVO.gender=="女"
                                                                            ? 'selected="selected"' : '' }>女</option>
														</select></td>
													</tr>
													<tr>
														<td>生日 :</td>
														<td>
															<div id="datepicker-from" class="input-group date"
																class="w-37" data-date-format="yyyy-mm-dd">
																<input name="dateofbirth" class="form-control"
																	type="text" placeholder="請選擇生日" autocomplete="off"
																	value="${memberVO.dateofbirth}"> <span
																	class="input-group-addon"><i
																	class="icofont-ui-calendar"></i></span>
															</div>
														<br> <span
													class="error errorMsgsOnly">${errorMsgs.dateofbirth}</span></td>
													</tr>
													<tr>
														<td>國家 :</td>
														<td><%@include file="file/select-country.file"%>
														</td>
													</tr>
													<tr>
														<td>手機 :</td>
														<td><input type="TEXT" name="phone" width="30rpx"
															height="20rpx" value="${memberVO.phone}"
															placeholder="請輸入手機" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.phone}</span></td>
													</tr>
													<tr>
														<td>暱稱 :</td>
														<td><input type="TEXT" name="nickname" width="30rpx"
															height="20rpx" value="${memberVO.nickname}"
															placeholder="請輸入暱稱" /><br> <span
													class="error errorMsgsOnly">${errorMsgs.nickname}</span></td>
													</tr>
												</table>
												<div class="bottom">
													<input type="hidden" name="action" value="update">
													<input type="hidden" name="memberid"
														value="${memberVO.memberid}">
													<button type="submit" class="btn v3">送出</button>
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
			<!--main content ends-->

			<!--Dashboard footer starts-->
			<%@include file="file/FS_footer.file"%>
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
