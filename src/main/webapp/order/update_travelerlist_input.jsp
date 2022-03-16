<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="com.order.travelerlist.model.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>


<%
TravelerlistBean travelerlistBean = (TravelerlistBean) session.getAttribute("travelerlistBean"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<head>
<!-- Metas -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="LionCoders" />
<!-- Links -->
<link rel="icon" type="image/png" href="#" />
<!-- google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800"
	rel="stylesheet">
<!-- Plugins CSS -->
<link href="<%=request.getContextPath()%>/order/css/plugin.css" rel="stylesheet" />
<!-- Perfect scrollbar CSS-->
<link href="<%=request.getContextPath()%>/order/css/perfect-scrollbar.css" rel="stylesheet">
<!-- style CSS -->
<link href="<%=request.getContextPath()%>/order/css/style.css" rel="stylesheet" />
<!-- Dashboard CSS -->
<link href="<%=request.getContextPath()%>/order/css/dashboard.css" rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet" href="<%=request.getContextPath()%>/order/css/switcher/skin-aqua.css" media="screen"
	id="style-colors" />
<!-- Document Title -->
<!-- <title>listagram - Directory Listing HTML Template</title> -->
<title>後台管理</title>

</head>

<body>
	<div class="page-wrapper">

		<!--Sidebar Menu Starts-->
		<%@ include file="/download/file/BS_Sidebar Menu.file"%>
		<!--Sidebar Menu ends-->

		<!--Dashboard content Wrapper starts-->
		<div class="dash-content-wrap">

			<!-- Top header starts-->
			<%@ include file="/download/file/BS_Top header.file"%>
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
											<li class="active"><a href="listAllOrder.jsp">訂單首頁</a></li>
											<li>訂單修改</li>
										</ul>
									</div>
								</div>
								<!-- <a class="btn v3" href="add-listing.html"><i class="ion-plus-round"></i>Add Listing </a> -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--Dashboard breadcrumb ends-->

			<!-- Dashboard Content starts-->
			<div class="dash-content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="recent-activity my-listing">
								<div class="act-title">
									<h5>
										<i class="ion-social-buffer-outline"></i>修改團員資料
									</h5>
								</div>

								<div class="viewd-item-wrap">
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">請修正以下錯誤:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red; font-size: 16px">${message}</li>
											</c:forEach>
										</ul>
									</c:if>


									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/travelerlist.do"
										name="form1">

										<table>
											<tr>
												<td>團員編號:</td>
												<td><%=travelerlistBean.getTravelerlistno()%></td>
											</tr>
											<tr>
												<td>訂單明細編號:</td>
												<input class="input_update" type="hidden"
													name="orderdetailno" size="45"
													value="<%=travelerlistBean.getOrderdetailno()%>" />
													<td><%=travelerlistBean.getOrderdetailno()%></td>
											</tr>
											<tr>
												<td>姓:</td>
												<td><input class="input_update" type="TEXT"
													name="lastname" size="45"
													value="<%=travelerlistBean.getLastname()%>" /></td>
											</tr>
											<tr>
												<td>名:</td>
												<td><input class="input_update" type="TEXT"
													name="firstname" size="45"
													value="<%=travelerlistBean.getFirstname()%>" /></td>
											</tr>
											<tr>
												<td>性別:</td>
												<td><input class="input_update" type="TEXT"
													name="gender" size="45"
													value="<%=travelerlistBean.getGender()%>" /></td>
											</tr>
											<tr>
												<td>生日:</td>
												<td><input class="input_update" type="TEXT"
													name="birthday" size="45"
													value="<%=travelerlistBean.getBirthday()%>" /></td>
											</tr>
											<tr>
												<td>身分證字號:</td>
												<td><input class="input_update" type="TEXT" name="idno"
													size="45" value="<%=travelerlistBean.getIdno()%>" /></td>
											</tr>

										</table>
										<br> <input type="hidden" name="action" value="update" />
										<input type="hidden" name="travelerlistno"
											value="<%=travelerlistBean.getTravelerlistno()%>" /> <input
											class="send" type="submit" value="送出修改" />
									</FORM>




								</div>

							</div>

						</div>
					</div>
				</div>
			</div>
			<!-- Dashboard Content ends-->

			<!--Dashboard footer starts-->
			<div class="dash-footer">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="copyright">
								<p>© 2019 Listagram . All rights reserved.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
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


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
java.sql.Date orderdate = null;
try {
	// 	orderdate = orderVO.getOrderdate();
} catch (Exception e) {
	orderdate = new java.sql.Date(System.currentTimeMillis());
}
%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
form {
	height: 550px;
	padding: 10px;
}

.input_update {
	width: 250px;
	height: 30px;
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 10px;
	margin-right: 350px;
}

td {
	background: white;
	text-align: left;
	padding: 5px;
}

table {
	border: none;
}

.send {
	color: #fff;
	border: 1px solid transparent;
	padding: 9px 15px;
	border-radius: 10px;
	font-size: 14px;
	background: #FD901B;
	line-height: 1;
	margin-left: 410px;
	height: 30px;
	margin-top: 10px
}

.send:hover {
	color: black;
	border: 1px solid #BDC1CA;
	font-weight: bold;
}

.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=orderdate%>
	', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

</script>
</html>