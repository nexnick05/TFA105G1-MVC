<%@page import="com.product.product.model.ProductBean"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.member.model.*, com.order.orderdetail.model.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>


<%
// List orderdetailBeans = (List) session.getAttribute("orderdetailBean"); //EmpServlet.java(Concroller), 存入req的empVO物件

// SessionFactory sessionFactory = HibernateUtil.getSessionfactory();

// OrderdetailDAOHibernate orderdetailDAO = new OrderdetailDAOHibernate(sessionFactory);
// OrderdetailService orderdetailService = new OrderdetailService(orderdetailDAO);

// List<OrderdetailBean> list = orderdetailService.select(null);
//這裡開始

// List<OrderdetailBean> list = orderdetailService.select(null);
// request.setAttribute("list",list);



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
<title>訂單明細管理</title>


<style>

.send{
margin-top:5px;
}

.btn.v2{
margin-top:5px;
}
.viewd-item-wrap {
	padding: 30px;
}

.move {
	color: brown;
	font-weight: bold;
	text-decoration: underline;
	font-size: 16px;
}

table {
	width: 900px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	font-size: 14px;
		border-collapse: collapse;
	color: #777;
	font-family: 'poppins', sans-serif;
	font-size: 14px;
	font-weight: 300;
	text-indent: initial;
	border-spacing: 2px;
	border: none;
}

th {
	text-align: center;
	padding: 5px;
	font-weight: normal;
	background: white;
	line-height: 1.5;
	border-bottom: 1px solid gray;
}

td {
	text-align: center;
	padding: 5px;
	font-weight: normal;
	background: white;
	line-height: 1.5;
}
</style>

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
											<li class="active"><a
												href="<%=request.getContextPath()%>/order.do">訂單首頁</a></li>
											<li>訂單明細</li>
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
										<i class="ion-social-buffer-outline"></i> 訂單明細
									</h5>
								</div>

								<div class="viewd-item-wrap">
									<h4>
										<a class="move" href="listAllOrder.jsp">回訂單首頁</a>
									</h4>


									<table>
										<tr>
											<th>訂單明細編號</th>
											<th>訂單編號</th>
											<th>商品編號</th>
											<th>商品名稱</th>
											<th>人數</th>
											<th>商品價格</th>
											<th>回饋點數</th>
											<th>特殊需求</th>
											<th>團員表</th>
<!-- 											<th>修改</th> -->
<!-- 											<th>刪除</th> -->
										</tr>
										<%
// 										List<OrderBean> list = (List)session.getAttribute("list");  
										List<OrderdetailBean> list = (List)session.getAttribute("list");  
										List<ProductBean> products = (List<ProductBean>) session.getAttribute("allProducts");
										%>
										<%for(int i=0;i<list.size();i++){  %>
											
										
<%-- 										<c:forEach var="orderdetailBean" items="${list}"> --%>
											<tr>

												<td><%=list.get(i).getOrderdetailno()%></td>
												<td><%=list.get(i).getOrderid()%></td>
										
											
												<!-- 												<td></td>{memberSvc.select(orderdetailBean.memberid).name} -->
												<td><%=list.get(i).getProductid()%></td>
												
												<%String productname = null;
												for(int j=0;j<products.size();j++){
												if(list.get(i).getProductid()== products.get(j).getProductid())
													productname =  products.get(j).getProductname();
                                       				  }%>
												<td><%=productname%></td>
												<td><%=list.get(i).getNumberoftraveler()%></td>
												<td><%=list.get(i).getProductprice()%></td>
												<td><%=list.get(i).getOrderrewardpoints()%></td>
												<td><%=list.get(i).getSpecialneeds()%></td>

												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/travelerlist.do">
														<input type="submit" value="團員表" class="send"> <input
															type="hidden" name="orderdetailno"
															value="<%=list.get(i).getOrderdetailno()%>"> <input
															type="hidden" name="action"
															 value="getOne_For_Travelerlist">
													</FORM>
												</td>
<!-- 												<td> -->
<!-- 													<FORM METHOD="post" -->
<%-- 														ACTION="<%=request.getContextPath()%>/orderdetail.do"> --%>
<!-- 														<input type="submit" value="修改" class="btn v2"> <input -->
<!-- 															type="hidden" name="orderdetailno" -->
<%-- 															value="<%=list.get(i).getOrderdetailno()%>"> <input --%>
<!-- 															type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 													</FORM> -->
<!-- 												</td> -->
<!-- 												<td> -->
<!-- 													<FORM METHOD="post" -->
<%-- 														ACTION="<%=request.getContextPath()%>/orderdetail.do" --%>
<!-- 														style="margin-bottom: 0px;"> -->
<!-- 														<input type="submit" value="刪除" class="btn v5" id="delete"> -->
<!-- 														<input type="hidden" name="orderdetailno" -->
<%-- 															value="<%=list.get(i).getOrderdetailno()%>"> <input --%>
<!-- 															type="hidden" name="action" value="delete"> -->
<!-- 													</FORM> -->
<!-- 												</td> -->
											</tr>
											<% } %>
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
	<script src="<%=request.getContextPath()%>/order/js/plugin.js"></script>
	<!--Perfect Scrollbar JS-->
	<script
		src="<%=request.getContextPath()%>/order/js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="<%=request.getContextPath()%>/order/js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="<%=request.getContextPath()%>/order/js/dashboard.js"></script>

	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>

	<script>
		$("#delete").on("click", function() {
			var yes = confirm("你確定要刪除嗎?")

		})
	</script>


</body>
</html>