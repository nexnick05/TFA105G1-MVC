<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="com.order.order.model.*, org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

<%
OrderBean orderBean = (OrderBean) session.getAttribute("orderBean");
%>

<html>
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
		<aside class="menu-sidebar js-right-sidebar d-block d-lg-none">
			<div class="logo" style="background-color: rgb(32, 69, 99)">
				<a href="#"> <img src="images/f.png" alt="Listagram" />
				</a>
			</div>
			<div class="menu-sidebar__content js-scrollbar2">
				<!-- <div class="account-img">
                    <img src="images/clients/reviewer-4.png" alt="Steve Austin" />
                </div> -->
				<!-- <h4 class="name">Howdy, Steve!</h4> -->
				<nav class="navbar-sidebar2">
					<ul class="list-unstyled navbar__list">
						<li><a class="active" href="db.html"> <i
								class="ion-ios-gear-outline"></i>首頁公告
						</a></li>
						<li><a href="listAllOrder.jsp"> <i
								class="ion-social-buffer-outline"></i>訂單管理
						</a> <!-- <ul class="list-unstyled navbar__sub-list js-sub-list">
                                <li>
                                    <a href="db-my-listing.html">Active</a>
                                    <span class="inbox-num active">6</span>
                                </li>
                                <li>
                                    <a href="db-my-listing.html">Pending</a>
                                    <span class="inbox-num pending">8</span>
                                </li>
                                <li>
                                    <a href="db-my-listing.html">Expired</a>
                                    <span class="inbox-num expired">12</span>
                                </li>
                            </ul> --></li>

						<li><a href="db-bookings.html"> <i
								class="ion-ios-copy-outline"></i>行程總覽
						</a></li>
						<li><a href="db-messages.html"> <i
								class="ion-ios-email-outline"></i>會員管理
						</a> <span class="inbox-num pending">3</span></li>

						<li><a href="db-favourites.html"> <i
								class="ion-ios-heart-outline"></i>admin管理
						</a></li>
						<li><a href="db-add-listing.html"> <i
								class="ion-ios-plus-outline"></i>論壇管理
						</a></li>
						<li><a class="js-arrow" href="#"> <i
								class="ion-ios-star-outline"></i>客服系統管理
						</a> <!-- <ul class="list-unstyled navbar__sub-list js-sub-list">
                                <li>
                                    <a href="db-recieve-reviews.html">
                                        Recieved Reviews</a>
                                    <span class="inbox-num active">6</span>
                                </li>
                                <li>
                                    <a href="db-submit-reviews.html">
                                        Submitted reviews</a>
                                    <span class="inbox-num pending">8</span>
                                </li>
                            </ul> --></li>
						<!-- <li>
                            <a href="db-my-profile.html">
                                <i class="ion-ios-person-outline"></i>My profile</a>
                        </li>
                        <li>
                            <a href="db-invoices.html">
                                <i class="ion-ios-printer-outline"></i>Invoices</a>
                        </li> -->
						<li><a href="#"> <i class="ion-ios-upload-outline"></i>登出
						</a></li>
					</ul>
				</nav>
			</div>
		</aside>
		<!--Sidebar Menu ends-->

		<!--Dashboard content Wrapper starts-->
		<div class="dash-content-wrap">

			<!-- Top header starts-->
			<header class="db-top-header"
				style="background-color: rgb(32, 69, 99)">
				<div class="container-fluid">
					<div class="row align-items-center">
						<div class="col-md-9 col-sm-6 col-4">
							<div class="site-navbar-wrap v2"
								style="background-color: rgb(32, 69, 99)">
								<div class="site-navbar">
									<div class="row align-items-center">
										<nav class="site-navigation float-left">
											<div class="container">
												<ul class="site-menu js-clone-nav d-none d-lg-block">
													<li class="has-children"><a href="#"
														style="color: white">首頁</a> <!-- <ul class="dropdown">
                                                    <li><a href="home-v1.html">Home Tab</a></li>
                                                    <li><a href="home-v2.html">Home Hero</a></li>
                                                    <li><a href="home-v3.html">Home Video</a></li>
                                                    <li><a href="home-v4.html">Home parallax</a></li>
                                                    <li><a href="home-v5.html">Home Classic</a></li>
                                                    <li><a href="home-v6.html">Home Map</a></li>
                                                    <li><a href="home-v7.html">Home Slider</a></li>
                                                    <li><a href="home-v8.html">Home Video Fullscreen</a></li>
                                                    <li><a href="home-v9.html">Home Hero Fullscreen</a></li>
                                                    <li><a href="home-v10.html">Home Map Fullscreen</a></li>
                                                </ul> --></li>
													<li class="has-children"><a href="#"
														style="color: white">產品分類</a>
														<ul class="dropdown">
															<li><a href="home-v1.html">一日遊</a></li>
															<li><a href="home-v2.html">多日遊</a></li>
															<li><a href="home-v3.html">包車</a></li>
															<li><a href="home-v4.html">熱門票卷</a></li>
															<li><a href="home-v5.html">獨特體驗</a></li>
															<!-- <li class="has-children">
                                                        <a href="#">List Layout</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="list-fullwidth.html">Full Width</a></li>
                                                            <li><a href="list-fullwidth-map.html">Fullwidth with map</a></li>
                                                            <li><a href="list-left-sidebar.html">Left Sidebar</a></li>
                                                            <li><a href="list-right-sidebar.html">Right Sidebar</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="has-children">
                                                        <a href="#">Grid Layout</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="grid-fullwidth.html">Full Width</a></li>
                                                            <li><a href="grid-fullwidth-map.html">Fullwidth with map</a></li>
                                                            <li><a href="grid-two-column.html">Grid two column</a></li>
                                                            <li><a href="grid-left-sidebar.html">Left Sidebar</a></li>
                                                            <li><a href="grid-right-sidebar.html">Right Sidebar</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="has-children">
                                                        <a href="#">Map sidebar Layout</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="list-left-sidemap.html">List Left sidemap</a></li>
                                                            <li><a href="list-right-sidemap.html">List Right sidemap</a></li>
                                                            <li><a href="grid-left-sidemap.html">grid Left sidemap</a></li>
                                                            <li><a href="grid-right-sidemap.html">grid Right sidemap</a></li>
                                                            <li><a href="grid-search-half-map.html">advanced search</a></li>
                                                            <li><a href="grid-search-half-map.html">advanced search</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="has-children">
                                                        <a href="#">Category Listings</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="all-categories.html">All Category</a></li>
                                                            <li><a href="all-locations.html">All Locations</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="has-children">
                                                        <a href="#">Listing Details</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="single-listing-one.html">Single Listing one</a></li>
                                                            <li><a href="single-listing-two.html">Single Listing two</a></li>
                                                            <li><a href="single-listing-three.html">Single Listing three</a></li>
                                                            <li><a href="single-listing-four.html">Single Listing four</a></li>
                                                            <li><a href="single-listing-five.html">Single Listing five</a></li>
                                                        </ul>
                                                    </li> -->
														</ul></li>
													<li class="has-children"><a href="#"
														style="color: white">論壇</a> <!-- <ul class="dropdown">
                                                    <li><a href="about.html">About us</a></li>
                                                    <li><a href="contact.html">Contact us</a></li>
                                                    <li class="has-children">
                                                        <a href="#">News Layout</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="news-left-sidebar.html">News Left sidebar</a></li>
                                                            <li><a href="news-right-sidebar.html">News right sidebar</a></li>
                                                            <li><a href="news-without-sidebar.html">News without sidebar</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="has-children">
                                                        <a href="#">Single News Layout</a>
                                                        <ul class="dropdown sub-menu">
                                                            <li><a href="single-news-one.html">Single News one</a></li>
                                                            <li><a href="single-news-two.html">Single News two</a></li>
                                                            <li><a href="single-news-three.html">Single News three</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="404-page.html">404 error</a></li>
                                                    <li><a href="add-listing.html">Add Listing</a></li>
                                                    <li><a href="booking.html">Booking Page</a></li>
                                                    <li><a href="booking-confirmation.html">Booking Confirmation</a></li>
                                                    <li><a href="login.html">Login</a></li>
                                                    <li><a href="pricing-table.html">Pricing Table</a></li>
                                                    <li><a href="user-profile.html">User profile</a></li>
                                                    <li><a href="faq.html">FAQ</a></li>
                                                    <li><a href="invoice.html">invoice</a></li>
                                                </ul> --></li>
													<li class="has-children"><a href="#"
														style="color: white">會員專區</a> <!-- <ul class="dropdown">
                                                    <li><a href="db.html">Dashboard</a></li>
                                                    <li><a href="db-my-listing.html">My Listings</a></li>
                                                    <li><a href="db-bookings.html">Bookings</a></li>
                                                    <li><a href="db-messages.html">Inbox</a></li>
                                                    <li><a href="db-favourites.html">Favourite Listing</a></li>
                                                    <li><a href="db-add-listing.html">Add Listing</a></li>
                                                    <li><a href="db-recieve-reviews.html">Reviews</a></li>
                                                    <li><a href="db-my-profile.html">User Profile</a></li>
                                                    <li><a href="db-invoices.html">Invoices </a></li>

                                                </ul> --></li>
													<div class="add-list float-right"></div>
													<li class="d-lg-none"><a class="btn v1"
														href="add-listing.html">Add Listing <i
															class="ion-plus-round"></i></a></li>
												</ul>
											</div>
										</nav>
										<div class="d-lg-none sm-right">
											<a href="#" class="mobile-bar js-menu-toggle"> <span
												class="ion-android-menu"></span>
											</a>
										</div>
									</div>
								</div>
								<div class="site-mobile-menu">
									<div class="site-mobile-menu-header">
										<div class="site-mobile-menu-close  js-menu-toggle">
											<span class="ion-ios-close-empty"></span>
										</div>
									</div>
									<div class="site-mobile-menu-body"></div>
								</div>
							</div>
						</div>
						<div class="col-md-3 col-sm-6 col-8">
							<img src="images/f.png" alt="">
						</div>
						<!-- <div class="col-md-3 col-sm-6 col-8">
                            <div class="header-button">
                                <div class="header-button-item has-noti js-item-menu"> -->
						<!-- <i class="ion-ios-bell-outline"></i> -->
						<!-- <div class="notifi-dropdown js-dropdown">
                                        <div class="notifi__title">
                                            <p>You have 2 Notifications</p>
                                        </div>
                                        <div class="notifi__item">
                                            <div class="bg-c1 red">
                                                <i class="icofont-check"></i>
                                            </div>
                                            <div class="content">
                                                <p>Your listing <b>Hotel Ocean Paradise</b> has been approved!</p>
                                                <span class="date">5min ago</span>
                                            </div>
                                        </div>
                                        <div class="notifi__item">
                                            <div class="bg-c1 green"> -->
						<!-- <i class="icofont-ui-message"></i>
                                            </div>
                                            <div class="content">
                                                <p>You have 3 unread Messages</p>
                                                <span class="date">5min ago</span>
                                            </div>
                                        </div>
                                        <div class="notify-bottom text-center pad-tb-20">
                                            <a href="#">View All Notification</a>
                                        </div> -->
						<!-- </div>
                                </div>
                                <div class="header-button-item js-sidebar-btn">
                                    <img src="images/clients/reviewer-4.png" alt="...">
                                    <span>Steve <i class="ion-arrow-down-b"></i></span>
                                </div>
                                <div class="setting-menu js-right-sidebar d-none d-lg-block">
                                    <div class="account-dropdown__body">
                                        <div class="account-dropdown__item">
                                            <a href="db.html"> -->
						<!-- <i class="ion-ios-gear-outline"></i>Dashboard</a>
                                        </div>
                                        <div class="account-dropdown__item">
                                            <a href="db-my-listing.html">
                                                <i class="ion-social-buffer-outline"></i>Listings</a>
                                        </div>
                                        <div class="account-dropdown__item">
                                            <a href="db-bookings.html">
                                                <i class="ion-ios-copy-outline"></i>Bookings</a>
                                        </div>
                                        <div class="account-dropdown__item">
                                            <a href="db-recieve-reviews.html">
                                                <i class="ion-ios-star-outline"></i>Reviews</a> -->
						<!-- </div>
                                        <div class="account-dropdown__item">
                                            <a href="db-messages.html">
                                                <i class="ion-ios-email-outline"></i>Inbox</a>
                                        </div>
                                        <div class="account-dropdown__item">
                                            <a href="db-my-profile.html">
                                                <i class="ion-ios-person-outline"></i>Profile</a>
                                        </div>
                                        <div class="account-dropdown__item">
                                            <a href="#"> -->
						<!-- <i class="ion-ios-upload-outline"></i>Logout</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> -->
					</div>
				</div>
			</header>
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
											<li>新增訂單</li>
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
										<i class="ion-social-buffer-outline"></i> 新增訂單資料
									</h5>
								</div>

								<div class="viewd-item-wrap">

									<a class="move" href="listAllOrder.jsp">回訂單首頁</a>

									<%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
										<br>
										<font style="color: red">請修正以下錯誤:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red; font-size: 16px">${message}</li>
											</c:forEach>
										</ul>
									</c:if>

									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/order.do" name="form1">
										<table>
											<tr>
												<td>會員編號:</td>
												<td><input class="input_add" type="TEXT"
													name="memberid" size="45"
													value="<%=(orderBean == null) ? " 5" : orderBean.getMemberid()%>" /></td>
											</tr>
									
											<tr>
												<td>訂購日期:</td>
												<td><input class="input_add" name="orderdate"
													id="f_date1" type="text" 
													value="<%=(orderBean == null) ? "2021-10-21" : orderBean.getOrderdate()%>" /></td>
													
											</tr>
											<tr>
												<td>訂單總金額:</td>
												<td><input class="input_add" type="TEXT"
													name="orderpriceamount" size="45"
													value="<%=(orderBean == null) ? "100" : orderBean.getOrderpriceamount()%>" /></td>
											</tr>
											<tr>
												<td>折抵點數:</td>
												<td><input class="input_add" type="TEXT"
													name="usedfunpoints" size="45"
													value="<%=(orderBean == null) ? "10" : orderBean.getUsedfunpoints()%>" /></td>
											</tr>
										

								
										</table>
										<br> <input type="hidden" name="action" value="insert">
										<input class="send" type="submit" value="送出新增">
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
// 	orderdate = orderBean.getOrderdate();
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
.viewd-item-wrap {
	padding: 30px;
	height: 380px;
}

td {
	background: white;
	text-align: left;
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

.move {
	color: brown;
	font-weight: bold;
	text-decoration: underline;
	margin-top: 100px;
}

table {
	border: none;
}

.input_add {
	width: 250px;
	height: 30px;
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 10px;
	margin-right: 350px;
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