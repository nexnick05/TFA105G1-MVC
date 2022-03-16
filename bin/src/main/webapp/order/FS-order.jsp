<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.order.order.model.*,com.order.orderdetail.model.* ,org.springframework.context.ApplicationContext,org.springframework.web.context.WebApplicationContext, org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

<!DOCTYPE html>
<html dir="ltr" lang="en-US">

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
<link href="<%=request.getContextPath()%>/download/css/plugin.css" rel="stylesheet" />
<!-- Perfect scrollbar CSS-->
<link href="<%=request.getContextPath()%>/download/css/perfect-scrollbar.css" rel="stylesheet">
<!-- style CSS -->
<link href="<%=request.getContextPath()%>/download/css/style.css" rel="stylesheet" />
<!-- Dashboard CSS -->
<link href="<%=request.getContextPath()%>/download/css/dashboard.css" rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet" href="<%=request.getContextPath()%>/download/css/switcher/skin-aqua.css" media="screen"
	id="style-colors" />
<!-- Document Title -->
<title>訂單管理</title>

</head>

<style>
h3 {
	color: black;
}

h6 {
	color: #777;
	font-weight: normal;
	display: inline;
}

h5 {
	color: #777;
	font-size: 18px;
	font-weight: normal;
}

body {
	color: #777;
}

.viewd-item-wrap {
	padding: 20px;
	line-height: 1.5;
}

.most-viewed-detail {
	padding-left: 50px;
}
</style>

<%
ServletContext applicationContext = this.getServletContext();
ApplicationContext context = (ApplicationContext) applicationContext
		.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);

Integer memberid = (Integer) session.getAttribute("memberid");
OrderService orderService = context.getBean("orderService", OrderService.class);
OrderdetailService orderdetailService = context.getBean("orderdetailService", OrderdetailService.class);
List<OrderBean> orderBean = orderService.getMemberOrder(memberid);
pageContext.setAttribute("orderBean", orderBean);
%>

<body>

	<!--Sidebar Menu Starts-->
	<%@ include file="/download/file/FS_Sidebar Menu.file"%>
	<!--Sidebar Menu ends-->

	<!--Dashboard content Wrapper starts-->
	<div class="dash-content-wrap">
		<!-- Top header starts-->
		<%@ include file="/download/file/FS_Header.file"%>
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
											href="<%=request.getContextPath()%>/download/FS-my-profile.jsp">會員中心</a></li>
										<li class="active">訂單</li>
									</ul>
								</div>
							</div>
							<!--                             <a class="btn v3" href="add-listing.html"><i class="ion-plus-round"></i>Add Listing </a> -->
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
									<i class="ion-social-buffer-outline"></i> 訂單管理
								</h5>
							</div>



							<c:forEach var="orderBean" items="${orderBean}">

								<div class="viewd-item-wrap">
									<div class="most-viewed-item">
										<!--                                     <div class="most-viewed-img"> -->
										<!--                                         <a href="#"><img src="images/category/event/muay.jpg" alt="..."></a> -->
										<!--                                     </div> -->

										<div class="most-viewed-detail">
											<%--                                         <a class="category" href="#"><span class="list-bg violate"><i class="icofont-movie"></i></span>訂單編號:${orderBean.orderid}</a> --%>
											<h3>
												<a class="category" href="#"><span
													class="list-bg violate"><i class="icofont-movie"></i></span></a>訂單編號:${orderBean.orderid}
											</h3>
											<%--                                         <h3><a> <span class="list-bg violate"><i class="icofont-movie"></i></span>訂單編號:${orderBean.orderid}</a></h3> --%>
											<p class="list-address">
												<i class="ion-android-time"></i>購買日期${orderBean.orderdate}
											</p>
											<%--                                          <p class="list-address"><i class="icofont-credit-card"></i>數量:<%=orderdetailBean.size()%></p> --%>
											<p class="list-address">
												<i class="icofont-credit-card"></i>付款方式:信用卡
											</p>

											<!--                                         <div class="ratings"> -->
											<!--                                             <i class="ion-ios-star"></i> -->
											<!--                                             <i class="ion-ios-star"></i> -->
											<!--                                             <i class="ion-ios-star"></i> -->
											<!--                                             <i class="ion-ios-star"></i> -->
											<!--                                             <i class="ion-ios-star-half"></i> -->
											<!--                                         </div> -->
											<!--                                         <div class="views">Views : <span>325</span></div> -->
										</div>

										<div class="listing-button">


											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/fsorder.do">
												<h6>TWD ${orderBean.orderpriceamount}&nbsp&nbsp</h6>
												<input type="submit" value="查看明細" class="btn v5" id="btn">
												<input type="hidden" name="orderid"
													value="${orderBean.orderid}"> <input type="hidden"
													name="action" value="getOne_For_Orderdetail">
											</FORM>

											<%--                                         <a href="<%=request.getContextPath()%>/order/FS-orderdetail.jsp" class="btn v5"><i class="ion-ios-star"></i>查看明細</a> --%>
										</div>

									</div>

								</div>
								<hr>

							</c:forEach>

						</div>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<!-- Dashboard Content ends-->

		<!--Dashboard footer starts-->
		<div class="dash-footer">
			<div class="container-fluid">
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

	<!-- Plugin JS-->
	<script src="<%=request.getContextPath()%>/download/js/plugin.js"></script>
	<!--Perfect Scrollbar JS-->
	<script src="<%=request.getContextPath()%>/download/js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="<%=request.getContextPath()%>/download/js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="<%=request.getContextPath()%>/download/js/dashboard.js"></script>
</body>

</html>