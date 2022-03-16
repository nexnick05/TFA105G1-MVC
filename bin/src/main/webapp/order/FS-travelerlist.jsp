<%@page import="com.order.travelerlist.model.TravelerlistBean"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.product.product.model.*, com.order.order.model.*,com.order.orderdetail.model.* ,org.springframework.context.ApplicationContext,org.springframework.web.context.WebApplicationContext, org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

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
<title>團員表</title>

</head>

<style>
.btn.v2{
    color: #fff;
    border: 1px solid transparent;
    padding: 9px 15px;
    border-radius: 50px;
    font-size: 14px;
    transition: 0.5s;
    background: #1CBBB4;
    line-height: 1;
}
h5 {
	color: #777;
	font-size: 18px;
	font-weight: normal;
}

table {
	width: 900px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	border-collapse: collapse;
	color: #777;
	font-family: 'poppins', sans-serif;
	font-size: 16px;
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

.viewd-item-wrap {
	padding: 20px;
}

.most-viewed-detail {
	padding-left: 50px;
}
</style>

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
										<li class="active"><a
											href="<%=request.getContextPath()%>/order/FS-order.jsp">訂單</a></li>
										<li class="active"><a
											href="<%=request.getContextPath()%>/fsorder.do">訂單明細</a></li>
										<li class="active">團員表</li>
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
									<i class="ion-social-buffer-outline"></i> 團員表
								</h5>
							</div>

							<div class="viewd-item-wrap">
								<table>
									<tr>
										<th>團員編號</th>
										<!-- 										<th>訂單明細編號</th> -->
										<th>姓</th>
										<th>名</th>
										<th>性別</th>
										<th>出生日期</th>
										<th>身分證字號</th>
										<th>修改</th>
										<!-- 											<th>刪除</th> -->
									</tr>

									<%-- 										<%List<TravelerlistBean> list = (List<TravelerlistBean>)session.getAttribute("list");%> --%>
									<c:forEach var="travelerlistBean" items="${list}">
										<%-- 										<%for(int i = 0;i<list.size();i++){ %> --%>


										<tr>

											<%-- 											<td><%=list.get(i).getTravelerlistno()%></td> --%>
											<%-- 											<td><%=list.get(i).getOrderdetailno()%></td> --%>
											<%-- 											<td><%=list.get(i).getLastname()%></td> --%>
											<%-- 											<td><%=list.get(i).getFirstname()%></td> --%>
											<%-- 											<td><%=list.get(i).getGender() %></td> --%>
											<%-- 											<td><%=list.get(i).getBirthday()%></td> --%>
											<%-- 											<td><%=list.get(i).getIdno()%></td> --%>
											<td>${travelerlistBean.travelerlistno}</td>
											<%-- 											<td>${travelerlistBean.orderdetailno}</td> --%>
											<td>${travelerlistBean.lastname}</td>
											<td>${travelerlistBean.firstname}</td>
											<td>${travelerlistBean.gender}</td>
											<td>${travelerlistBean.birthday}</td>
											<td>${travelerlistBean.idno}</td>


											<td>
												<FORM METHOD="post"
													ACTION="<%=request.getContextPath()%>/traveler.do"
													style="margin-bottom: 0px;">
													<input type="submit" value="修改" class="btn v2"> <input
														type="hidden" name="travelerlistno"
														value="${travelerlistBean.travelerlistno}"> <input
														type="hidden" name="action" value="getOne_For_Update">
												</FORM>
											</td>
											<!-- 												<td> -->
											<!-- 													<FORM METHOD="post" -->
											<%-- 														ACTION="<%=request.getContextPath()%>/travelerlist.do" --%>
											<!-- 														style="margin-bottom: 0px;"> -->
											<!-- 														<input type="submit" value="刪除" class="btn v5"　id="delete"> <input -->
											<!-- 															type="hidden" name="travelerlistno" -->
											<%-- 															value="${travelerlistBean.travelerlistno}"> <input --%>
											<!-- 															type="hidden" name="action" value="delete"> -->
											<!-- 													</FORM> -->
											<!-- 												</td> -->
										</tr>
										<%-- 										<% }%> --%>
									</c:forEach>
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
	<script
		src="<%=request.getContextPath()%>/download/js/perfect-scrollbar.min.js"></script>
	<!-- Main JS-->
	<script src="<%=request.getContextPath()%>/download/js/main.js"></script>
	<!-- Dashboard JS-->
	<script src="<%=request.getContextPath()%>/download/js/dashboard.js"></script>
</body>

</html>