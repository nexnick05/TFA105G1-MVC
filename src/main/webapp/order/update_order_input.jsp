<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="com.order.order.model.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>


<%
OrderBean orderBean = (OrderBean) session.getAttribute("orderBean"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
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
<link href="css/plugin.css" rel="stylesheet" />
<!-- Perfect scrollbar CSS-->
<link href="css/perfect-scrollbar.css" rel="stylesheet">
<!-- style CSS -->
<link href="css/style.css" rel="stylesheet" />
<!-- Dashboard CSS -->
<link href="css/dashboard.css" rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet" href="css/switcher/skin-aqua.css" media="screen"
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
											<li class="active"><a href="<%=request.getContextPath()%>/order.do">訂單首頁</a></li>
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
										<i class="ion-social-buffer-outline"></i>修改訂單資料
									</h5>
								</div>

								<div class="viewd-item-wrap">
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">請修正以下錯誤:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red;font-size:16px">${message}</li>
											</c:forEach>
										</ul>
									</c:if>


									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/order.do" name="form1">

										<h13>訂單編號:</h13>
										<h14><%=orderBean.getOrderid()%></h14>
										<br><br>
										
										<h12>會員編號:&nbsp&nbsp&nbsp&nbsp</h12>
										<td><input class="input_update" type="TEXT"
											name="memberid" size="45"
											value="<%=orderBean.getMemberid()%>" /></td> <br> <br>
										
										<h12>訂單日期:&nbsp&nbsp&nbsp&nbsp</h12>
										<input class="input_update" name="orderdate" id="f_date1"
											type="text" /><br> <br>
											
										<h12>訂單總金額:&nbsp</h12>
										<td><input class="input_update" type="TEXT"
											name="orderpriceamount" size="45" value="<%=orderBean.getOrderpriceamount()%>" /></td>
										<br> <br>
										<h12>折抵點數:&nbsp&nbsp&nbsp&nbsp</h12>
										<td><input class="input_update" type="TEXT"
											name="usedfunpoints" size="45"
											value="<%=orderBean.getUsedfunpoints()%>" /></td> <br> 
											
											<input
											type="hidden" name="action" value="update" /> 
											
											<input
											type="hidden" name="orderid"
											value="<%=orderBean.getOrderid()%>" /> 
											
											<input
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
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>

form{
height:380px;
padding:20px;
}

.input_update {
	width: 250px;
	height: 30px;
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 10px;
	margin-right: 350px;
}

h14 {
	font-size: 16px;
	margin-left: 20px;
	color: black;
	font-weight: normal;
}

h12 {
	font-size: 16px;
	margin-left: 50px;
	color: black;
	font-weight: normal;
}

h13 {
	font-size: 16px;
	margin-left: 50px;
	color: black;
	font-weight: normal;
}

.send {
	float: right;
	color: #fff;
	border: 1px solid transparent;
	padding: 9px 15px;
	border-radius: 10px;
	font-size: 14px;
	transition: 0.5s;
	background: #FD901B;
	line-height: 1;
	margin-left: 5px;
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
		   value: '<%=orderdate%> ', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.以下為某一天之後的日期無法選擇
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});
</script>
</html>