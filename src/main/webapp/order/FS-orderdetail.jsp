<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.product.model.*, com.order.order.model.*,com.order.orderdetail.model.* ,org.springframework.context.ApplicationContext,org.springframework.web.context.WebApplicationContext, org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

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
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800" rel="stylesheet">
    <!-- Plugins CSS -->
    <link href="<%=request.getContextPath()%>/download/css/plugin.css" rel="stylesheet" />
    <!-- Perfect scrollbar CSS-->
    <link href="<%=request.getContextPath()%>/download/css/perfect-scrollbar.css" rel="stylesheet">
    <!-- style CSS -->
    <link href="<%=request.getContextPath()%>/download/css/style.css" rel="stylesheet" />
    <!-- Dashboard CSS -->
    <link href="<%=request.getContextPath()%>/download/css/dashboard.css" rel="stylesheet" />
    <!--color switcher css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/download/css/switcher/skin-aqua.css" media="screen" id="style-colors" />
    <!-- Document Title -->
    <title>訂單明細管理</title>

</head>

<style>
h5{
color:#777;
font-size: 18px;
font-weight:normal;
}

body{
color:#777;
}

.viewd-item-wrap{
padding:20px;
}

.most-viewed-detail {
padding-left:50px;

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
                                        <li class="active"><a href="<%=request.getContextPath()%>/download/FS-my-profile.jsp">會員中心</a></li>
                                        <li class="active"><a href="<%=request.getContextPath()%>/order/FS-order.jsp">訂單</a></li>
                                        <li class="active">訂單明細</li>
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
                                <h5><i class="ion-social-buffer-outline"></i> 訂單明細</h5>
                            </div>
                            		
										
                                   		 
<%-- 							<c:forEach var="orderdetailBean" items="${orderdetailBean}"> --%>
										<%
										List<OrderdetailBean> list = (List)session.getAttribute("list");  
										List<ProductBean> productBeans = (List<ProductBean>) session.getAttribute("products");
										List<ProductBean> products = (List<ProductBean>) session.getAttribute("allProducts");
										List<Integer> imgids = (List<Integer>) session.getAttribute("imgids");
										%>
										<%for(int i=0;i<list.size();i++){  %>
										
											<%String productname = null;
												for(int j=0;j<products.size();j++){
												if(list.get(i).getProductid()== products.get(j).getProductid())
													productname =  products.get(j).getProductname();
                                       				  }
                                       		Date startdate = null;
												for(int j=0;j<products.size();j++){
												if(list.get(i).getProductid()== products.get(j).getProductid())
													startdate =  products.get(j).getStartdate();
                                       				 }%>
                                       				 
                                       			 	
                                       				 
                                       				 
                            <div class="viewd-item-wrap">
                                <div class="most-viewed-item">
                                    <div class="most-viewed-img">
                                        <a href="#"><img src="<%=request.getContextPath()%>/ProductImageReader?imgid=<%=list.get(i).getImgid()%>" alt="..."></a>
                                    </div>
                                  
                                    <div class="most-viewed-detail">
                                        <a class="category" href="#"><span class="list-bg violate"><i class="icofont-movie"></i></span>訂單明細:<%=list.get(i).getOrderdetailno()%></a>
                                        <h3><a href="#"><%=productname%></a></h3>
                                        <p class="list-address"><i class="ion-android-time"></i>出發日期: <%=startdate%></p>
										 <p class="list-address"><i class="ion-android-person"></i>人數: <%=list.get(i).getNumberoftraveler()%></p>
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
														ACTION="<%=request.getContextPath()%>/traveler.do">
														 TWD&nbsp<%=list.get(i).getProductprice()%>
														<input type="submit" value="團員表" class="btn v5"> <input
															type="hidden" name="orderdetailno"
															value="<%=list.get(i).getOrderdetailno()%>"> <input
															type="hidden" name="action"
															 value="getOne_For_Travelerlist">
													</FORM>
                                    
<%--                                     TWD&nbsp<%=list.get(i).getProductprice()%> --%>
<!--                                         <a href="#" class="btn v5"><i class="ion-ios-star"></i>團員表</a> -->
                                  
                                    </div>
                                </div>
                                
                            </div>
                             <hr>
                         		<% } %>
<%--                             </c:forEach> --%>
							
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
    <script src="<%=request.getContextPath()%>/download/js/perfect-scrollbar.min.js"></script>
    <!-- Main JS-->
    <script src="<%=request.getContextPath()%>/download/js/main.js"></script>
    <!-- Dashboard JS-->
    <script src="<%=request.getContextPath()%>/download/js/dashboard.js"></script>
</body>

</html>