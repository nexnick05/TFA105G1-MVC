<%@page import="com.member.model.MemberVO"%>
<%@page import="com.order.orderdetail.model.OrderdetailService"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.order.orderdetail.model.OrderdetailBean"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.* ,java.sql.*"%>
<%@ page
	import="java.time.LocalDateTime,java.time.format.DateTimeFormatter,com.order.order.model.*,com.order.orderdetail.model.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>
<!DOCTYPE html>

<%
// SessionFactory sessionFactory = HibernateUtil.getSessionfactory();

// OrderDAOHibernate orderDAO = new OrderDAOHibernate(sessionFactory);
// OrderService orderService = new OrderService(orderDAO);

// List<OrderBean> list = orderService.select(null);
// request.setAttribute("list", list);

// OrderdetailBean bean = new OrderdetailBean();
// OrderdetailDAOHibernate orderdetailDAO = new OrderdetailDAOHibernate(sessionFactory);
// OrderdetailService svc = new OrderdetailService(orderdetailDAO);
// List<OrderdetailBean> list123 = svc.select(null);
%>


<html>
<head>
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

<link href="<%=request.getContextPath()%>/order/css/plugin.css"
	rel="stylesheet" />
<!-- Perfect scrollbar CSS-->
<link
	href="<%=request.getContextPath()%>/order/css/perfect-scrollbar.css"
	rel="stylesheet">
<!-- style CSS -->
<link href="<%=request.getContextPath()%>/order/css/style.css"
	rel="stylesheet" />
<!-- Dashboard CSS -->
<link href="<%=request.getContextPath()%>/order/css/dashboard.css"
	rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/order/css/switcher/skin-aqua.css"
	media="screen" id="style-colors" />
<!-- Document Title -->
<!-- <title>listagram - Directory Listing HTML Template</title> -->
<title>??????????????????</title>
</head>

<style>
.send {
	background: #BDC1CA;
	padding: 9px 15px;
	border-radius: 50px;
	color: #fff;
	transition: 0.3s;
	border: 1px solid transparent;
	font-size: 14px;
	transition: 0.5s;
	line-height: 1;
}

table {
	border-collapse: collapse;
	color: #777;
	font-family: 'poppins', sans-serif;
	font-size: 16px;
	font-weight: 300;
	text-indent: initial;
	border-spacing: 2px;
	border: none;
	line-height: 1.5;
}

th, td {
	background: white;
}

th{
border-bottom: 1px solid gray;
}

.detail {
	color: blue;
	font-weight: bold;
}

.add {
	margin-left: 140px;
	color: brown;
	width: 70px;
	font-weight: bold;
	text-decoration: underline;
}
</style>
<body>

	<div class="page-wrapper">

		<!--Sidebar Menu Starts-->
		<%@ include file="/download/file/BS_Sidebar Menu.file"%>
		<!--Sidebar Menu ends-->

		<!--Dashboard content Wrapper starts-->
		<div class="dash-content-wrap">

			<!-- Top header starts-->
			<%@ include file="/download/file/BS_Top header.file"%>
			<%-- <jsp:include page="<%request.getContextPath()%>/order/file/Sidebar.file" / > --%>
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
											<li class="active"><a href="listAllOrder.jsp">????????????</a></li>

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
										<i class="ion-social-buffer-outline"></i> ????????????
									</h5>
								</div>

								<div class="viewd-item-wrap">
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">?????????????????????:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>

									<table>
										<tr>
											<th>????????????</th>
											<th>????????????</th>
											<th>???</th>
											<th>???</th>
											<th>???????????????</th>
											<th>????????????</th>
											<th>????????????</th>
										</tr>




										<FORM METHOD="post"
											ACTION="<%=request.getContextPath()%>/orderdetail.do">
											<div class="above">
												<h10 style="color:brown">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp??????????????????
												(???1):</h10>
												<h11>&nbsp</h11>
												<input type="text" name="orderid" class="select"> <input
													type="hidden" name="action" value="getOne_For_Orderdetail">
												<input type="submit" value="??????" class="send">
											</div>
										</FORM>

										<%-- 										<c:forEach var="orderBean" items="${list}"> --%>

										<%
										List<OrderBean> list = (List) session.getAttribute("list");
										List<OrderdetailBean> list123 = (List) session.getAttribute("list123");
										List<MemberVO> allMembers = (List<MemberVO>) session.getAttribute("allMembers");
										%>
										<%
										for (int i = 0; i < list.size(); i++) {
										%>
										<tr>
											<td><%=list.get(i).getOrderid()%></td>
											<td><%=list.get(i).getOrderdate()%></td>

											<%
											String lastname = null;
											for (int j = 0; j < allMembers.size(); j++) {
												if (list.get(i).getMemberid() == allMembers.get(j).getMemberid())
												lastname = allMembers.get(j).getLastname();
											}

											String firstname = null;
											for (int k = 0; k < allMembers.size(); k++) {
												if (list.get(i).getMemberid() == allMembers.get(k).getMemberid())
												firstname = allMembers.get(k).getFirstname();
											}
											%>


											<td><%=lastname%></td>
											<td><%=firstname%></td>

											<%
											int amount = 0;
											%>

											<%
											for (int a = 0; a < list123.size(); a++) {

												if (list.get(i).getOrderid() == list123.get(a).getOrderid()) {
													amount = amount + list123.get(a).getProductprice();

												}
											}
											%>
											<td><%=list.get(i).getOrderpriceamount()%></td>

											<%
											int total = 0;
											%>
											<%
											for (int b = 0; b < list123.size(); b++) {
												if (list.get(i).getOrderid() == list123.get(b).getOrderid()) {
													total = total + list123.get(b).getOrderrewardpoints();
												}
											}
											%>
											<td><%=total%></td>


											<td>
												<FORM METHOD="post"
													ACTION="<%=request.getContextPath()%>/orderdetail.do">
													<input type="submit" value="??????" class="send"> <input
														type="hidden" name="orderid"
														value="<%=list.get(i).getOrderid()%>"> <input
														type="hidden" name="action" value="getOne_For_Orderdetail">
														
												</FORM>
											</td>
											<!-- 												<td></td> -->
											<%-- 												<% request.setAttribute("list123",list123);%> --%>
											<%-- 										<c:forEach var="orderdetailBean" items="${list123}"> --%>
											<%-- 											<c:if test="${orderBean.orderid==orderdetailBean.orderid}"> --%>
											<%-- 	                    								${deptVO.deptno}???${deptVO.dname} - ${deptVO.loc}??? --%>
											<%--                     								</c:if> --%>
											<%-- 										</c:forEach> --%>
											<%-- 												<td>${orderBean.orderpriceamount}</td> --%>
											<%
											}
											%>







											<!-- 												<td> -->
											<!-- 													<FORM METHOD="post" -->
											<%-- 														ACTION="<%=request.getContextPath()%>/order.do" --%>
											<!-- 														style="margin-bottom: 0px;"> -->
											<!-- 														<input type="submit" value="??????" class="btn v5">  -->
											<!-- 														<input -->
											<%-- 															type="hidden" name="orderid" value="${orderBean.orderid}"> --%>
											<!-- 														<input type="hidden" name="action" value="delete"> -->
											<!-- 													</FORM> -->
											<!-- 												</td> -->
										</tr>
										<%-- 										</c:forEach> --%>
									</table>



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
								<p>?? 2019 Listagram . All rights reserved.</p>
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
	<script src="<%=request.getContextPath()%>/order/js/plugin.js"></script>
	<!--Perfect Scrollbar JS-->
	<script
		src="<%=request.getContextPath()%>/order/js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="<%=request.getContextPath()%>/order/js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="<%=request.getContextPath()%>/order/js/dashboard.js"></script>

</body>
</html>