<%@ page import="com.product.product.model.ProductBean"%>
<%@ page import="java.sql.*, com.product.productimg.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="java.util.*, org.springframework.context.ApplicationContext, org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="com.product.product.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

<!DOCTYPE html>
<html lang="en">

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
    <link href="css/plugin.css" rel="stylesheet" />
    <!-- Perfect scrollbar CSS-->
    <link href="css/perfect-scrollbar.css" rel="stylesheet">
    <!-- style CSS -->
    <link href="css/style.css" rel="stylesheet" />
    <!-- Dashboard CSS -->
    <link href="css/dashboard.css" rel="stylesheet" />
    <!--color switcher css-->
    <link rel="stylesheet" href="css/switcher/skin-aqua.css" media="screen" id="style-colors" />
    <!-- Document Title -->
    <title>會員專區/我的收藏</title>

</head>

<body>
    <div class="page-wrapper">

        <!--Sidebar Menu Starts-->
        <%@include file="/download/file/FS_Sidebar Menu.file"%>
<!--         <aside class="menu-sidebar js-right-sidebar d-block d-lg-none"> -->
<!--             <div class="logo"> -->
<!--                 <a href="#"> -->
<!--                     <img src="images/logo-black.png" alt="Listagram" /> -->
<!--                 </a> -->
<!--             </div> -->
<!--             <div class="menu-sidebar__content js-scrollbar2"> -->
<!--                 <div class="account-img"> -->
<!--                     <img src="images/clients/reviewer-4.png" alt="Steve Austin" /> -->
<!--                 </div> -->
<!--                 <h4 class="name">Howdy, Steve!</h4> -->
<!--                 <nav class="navbar-sidebar2"> -->
<!--                     <ul class="list-unstyled navbar__list"> -->
<!--                         <li> -->
<!--                             <a class="active" href="db.html"> -->
<!--                                 <i class="ion-ios-gear-outline"></i>Dashboard -->
<!--                             </a> -->
<!--                         </li> -->
<!--                         <li class="has-sub"> -->
<!--                             <a class="js-arrow" href="#"> -->
<!--                                 <i class="ion-social-buffer-outline"></i>My Listings -->
<!--                             </a> -->
<!--                             <ul class="list-unstyled navbar__sub-list js-sub-list"> -->
<!--                                 <li> -->
<!--                                     <a href="db-my-listing.html">Active</a> -->
<!--                                     <span class="inbox-num active">6</span> -->
<!--                                 </li> -->
<!--                                 <li> -->
<!--                                     <a href="db-my-listing.html">Pending</a> -->
<!--                                     <span class="inbox-num pending">8</span> -->
<!--                                 </li> -->
<!--                                 <li> -->
<!--                                     <a href="db-my-listing.html">Expired</a> -->
<!--                                     <span class="inbox-num expired">12</span> -->
<!--                                 </li> -->
<!--                             </ul> -->
<!--                         </li> -->

<!--                         <li> -->
<!--                             <a href="db-bookings.html"> -->
<!--                                 <i class="ion-ios-copy-outline"></i>Bookings</a> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                             <a href="db-messages.html"> -->
<!--                                 <i class="ion-ios-email-outline"></i>Inbox</a> -->
<!--                             <span class="inbox-num pending">3</span> -->
<!--                         </li> -->

<!--                         <li> -->
<!--                             <a href="db-favourites.html"> -->
<!--                                 <i class="ion-ios-heart-outline"></i>Favourites</a> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                             <a href="db-add-listing.html"> -->
<!--                                 <i class="ion-ios-plus-outline"></i>Add Listings</a> -->
<!--                         </li> -->
<!--                         <li class="has-sub"> -->
<!--                             <a class="js-arrow" href="#"> -->
<!--                                 <i class="ion-ios-star-outline"></i>Reviews -->
<!--                             </a> -->
<!--                             <ul class="list-unstyled navbar__sub-list js-sub-list"> -->
<!--                                 <li> -->
<!--                                     <a href="db-recieve-reviews.html"> -->
<!--                                         Recieved Reviews</a> -->
<!--                                     <span class="inbox-num active">6</span> -->
<!--                                 </li> -->
<!--                                 <li> -->
<!--                                     <a href="db-submit-reviews.html"> -->
<!--                                         Submitted reviews</a> -->
<!--                                     <span class="inbox-num pending">8</span> -->
<!--                                 </li> -->
<!--                             </ul> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                             <a href="db-my-profile.html"> -->
<!--                                 <i class="ion-ios-person-outline"></i>My profile</a> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                             <a href="db-invoices.html"> -->
<!--                                 <i class="ion-ios-printer-outline"></i>Invoices</a> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                             <a href="#"> -->
<!--                                 <i class="ion-ios-upload-outline"></i>Logout</a> -->
<!--                         </li> -->
<!--                     </ul> -->
<!--                 </nav> -->
<!--             </div> -->
<!--         </aside> -->
        <!--Sidebar Menu ends-->

        <!--Dashboard content Wrapper starts-->
        <div class="dash-content-wrap">
		<%@include file="/download/file/FS_Header.file"%>
            <!-- Top header starts-->
<!--             <header class="db-top-header"> -->
<!--                 <div class="container-fluid"> -->
<!--                     <div class="row align-items-center"> -->
<!--                         <div class="col-md-9 col-sm-6 col-4"> -->
<!--                             <div class="site-navbar-wrap v2"> -->
<!--                                 <div class="site-navbar"> -->
<!--                                     <div class="row align-items-center"> -->
<!--                                         <nav class="site-navigation float-left"> -->
<!--                                     <div class="container"> -->
<!--                                         <ul class="site-menu js-clone-nav d-none d-lg-block"> -->
<!--                                             <li class="has-children"> -->
<!--                                                 <a href="#">Home</a> -->
<!--                                                 <ul class="dropdown"> -->
<!--                                                     <li><a href="home-v1.html">Home Tab</a></li> -->
<!--                                                     <li><a href="home-v2.html">Home Hero</a></li> -->
<!--                                                     <li><a href="home-v3.html">Home Video</a></li> -->
<!--                                                     <li><a href="home-v4.html">Home parallax</a></li> -->
<!--                                                     <li><a href="home-v5.html">Home Classic</a></li> -->
<!--                                                     <li><a href="home-v6.html">Home Map</a></li> -->
<!--                                                     <li><a href="home-v7.html">Home Slider</a></li> -->
<!--                                                     <li><a href="home-v8.html">Home Video Fullscreen</a></li> -->
<!--                                                     <li><a href="home-v9.html">Home Hero Fullscreen</a></li> -->
<!--                                                     <li><a href="home-v10.html">Home Map Fullscreen</a></li> -->
<!--                                                 </ul> -->
<!--                                             </li> -->
<!--                                             <li class="has-children"> -->
<!--                                                 <a href="#">Listings</a> -->
<!--                                                 <ul class="dropdown"> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">List Layout</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="list-fullwidth.html">Full Width</a></li> -->
<!--                                                             <li><a href="list-fullwidth-map.html">Fullwidth with map</a></li> -->
<!--                                                             <li><a href="list-left-sidebar.html">Left Sidebar</a></li> -->
<!--                                                             <li><a href="list-right-sidebar.html">Right Sidebar</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">Grid Layout</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="grid-fullwidth.html">Full Width</a></li> -->
<!--                                                             <li><a href="grid-fullwidth-map.html">Fullwidth with map</a></li> -->
<!--                                                             <li><a href="grid-two-column.html">Grid two column</a></li> -->
<!--                                                             <li><a href="grid-left-sidebar.html">Left Sidebar</a></li> -->
<!--                                                             <li><a href="grid-right-sidebar.html">Right Sidebar</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">Map sidebar Layout</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="list-left-sidemap.html">List Left sidemap</a></li> -->
<!--                                                             <li><a href="list-right-sidemap.html">List Right sidemap</a></li> -->
<!--                                                             <li><a href="grid-left-sidemap.html">grid Left sidemap</a></li> -->
<!--                                                             <li><a href="grid-right-sidemap.html">grid Right sidemap</a></li> -->
<!--                                                             <li><a href="grid-search-half-map.html">advanced search</a></li> -->
<!--                                                             <li><a href="grid-search-half-map.html">advanced search</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">Category Listings</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="all-categories.html">All Category</a></li> -->
<!--                                                             <li><a href="all-locations.html">All Locations</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">Listing Details</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="single-listing-one.html">Single Listing one</a></li> -->
<!--                                                             <li><a href="single-listing-two.html">Single Listing two</a></li> -->
<!--                                                             <li><a href="single-listing-three.html">Single Listing three</a></li> -->
<!--                                                             <li><a href="single-listing-four.html">Single Listing four</a></li> -->
<!--                                                             <li><a href="single-listing-five.html">Single Listing five</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                 </ul> -->
<!--                                             </li> -->
<!--                                             <li class="has-children"> -->
<!--                                                 <a href="#">Pages</a> -->
<!--                                                 <ul class="dropdown"> -->
<!--                                                     <li><a href="about.html">About us</a></li> -->
<!--                                                     <li><a href="contact.html">Contact us</a></li> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">News Layout</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="news-left-sidebar.html">News Left sidebar</a></li> -->
<!--                                                             <li><a href="news-right-sidebar.html">News right sidebar</a></li> -->
<!--                                                             <li><a href="news-without-sidebar.html">News without sidebar</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                     <li class="has-children"> -->
<!--                                                         <a href="#">Single News Layout</a> -->
<!--                                                         <ul class="dropdown sub-menu"> -->
<!--                                                             <li><a href="single-news-one.html">Single News one</a></li> -->
<!--                                                             <li><a href="single-news-two.html">Single News two</a></li> -->
<!--                                                             <li><a href="single-news-three.html">Single News three</a></li> -->
<!--                                                         </ul> -->
<!--                                                     </li> -->
<!--                                                     <li><a href="404-page.html">404 error</a></li> -->
<!--                                                     <li><a href="add-listing.html">Add Listing</a></li> -->
<!--                                                     <li><a href="booking.html">Booking Page</a></li> -->
<!--                                                     <li><a href="booking-confirmation.html">Booking Confirmation</a></li> -->
<!--                                                     <li><a href="login.html">Login</a></li> -->
<!--                                                     <li><a href="pricing-table.html">Pricing Table</a></li> -->
<!--                                                     <li><a href="user-profile.html">User profile</a></li> -->
<!--                                                     <li><a href="faq.html">FAQ</a></li> -->
<!--                                                     <li><a href="invoice.html">invoice</a></li> -->
<!--                                                 </ul> -->
<!--                                             </li> -->
<!--                                             <li class="has-children"> -->
<!--                                                 <a href="#">User Panel</a> -->
<!--                                                 <ul class="dropdown"> -->
<!--                                                     <li><a href="db.html">Dashboard</a></li> -->
<!--                                                     <li><a href="db-my-listing.html">My Listings</a></li> -->
<!--                                                     <li><a href="db-bookings.html">Bookings</a></li> -->
<!--                                                     <li><a href="db-messages.html">Inbox</a></li> -->
<!--                                                     <li><a href="db-favourites.html">Favourite Listing</a></li> -->
<!--                                                     <li><a href="db-add-listing.html">Add Listing</a></li> -->
<!--                                                     <li><a href="db-recieve-reviews.html">Reviews</a></li> -->
<!--                                                     <li><a href="db-my-profile.html">User Profile</a></li> -->
<!--                                                     <li><a href="db-invoices.html">Invoices </a></li> -->

<!--                                                 </ul> -->
<!--                                             </li> -->
<!--                                             <li class="d-lg-none"><a class="btn v1" href="add-listing.html">Add Listing <i class="ion-plus-round"></i></a></li> -->
<!--                                         </ul> -->
<!--                                     </div> -->
<!--                                 </nav> -->
<!--                                         <div class="d-lg-none sm-right"> -->
<!--                                             <a href="#" class="mobile-bar js-menu-toggle"> -->
<!--                                                 <span class="ion-android-menu"></span> -->
<!--                                             </a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="site-mobile-menu"> -->
<!--                                     <div class="site-mobile-menu-header"> -->
<!--                                         <div class="site-mobile-menu-close  js-menu-toggle"> -->
<!--                                             <span class="ion-ios-close-empty"></span> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="site-mobile-menu-body"></div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3 col-sm-6 col-8"> -->
<!--                             <div class="header-button"> -->
<!--                                 <div class="header-button-item has-noti js-item-menu"> -->
<!--                                     <i class="ion-ios-bell-outline"></i> -->
<!--                                     <div class="notifi-dropdown js-dropdown"> -->
<!--                                         <div class="notifi__title"> -->
<!--                                             <p>You have 2 Notifications</p> -->
<!--                                         </div> -->
<!--                                         <div class="notifi__item"> -->
<!--                                             <div class="bg-c1 red"> -->
<!--                                                 <i class="icofont-check"></i> -->
<!--                                             </div> -->
<!--                                             <div class="content"> -->
<!--                                                 <p>Your listing <b>Hotel Ocean Paradise</b> has been approved!</p> -->
<!--                                                 <span class="date">5min ago</span> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="notifi__item"> -->
<!--                                             <div class="bg-c1 green"> -->
<!--                                                 <i class="icofont-ui-message"></i> -->
<!--                                             </div> -->
<!--                                             <div class="content"> -->
<!--                                                 <p>You have 3 unread Messages</p> -->
<!--                                                 <span class="date">5min ago</span> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="notify-bottom text-center pad-tb-20"> -->
<!--                                             <a href="#">View All Notification</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="header-button-item js-sidebar-btn"> -->
<!--                                     <img src="images/clients/reviewer-4.png" alt="..."> -->
<!--                                     <span>Steve <i class="ion-arrow-down-b"></i></span> -->
<!--                                 </div> -->
<!--                                 <div class="setting-menu js-right-sidebar d-none d-lg-block"> -->
<!--                                     <div class="account-dropdown__body"> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="db.html"> -->
<!--                                                 <i class="ion-ios-gear-outline"></i>Dashboard</a> -->
<!--                                         </div> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="db-my-listing.html"> -->
<!--                                                 <i class="ion-social-buffer-outline"></i>Listings</a> -->
<!--                                         </div> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="db-bookings.html"> -->
<!--                                                 <i class="ion-ios-copy-outline"></i>Bookings</a> -->
<!--                                         </div> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="db-recieve-reviews.html"> -->
<!--                                                 <i class="ion-ios-star-outline"></i>Reviews</a> -->
<!--                                         </div> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="db-messages.html"> -->
<!--                                                 <i class="ion-ios-email-outline"></i>Inbox</a> -->
<!--                                         </div> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="db-my-profile.html"> -->
<!--                                                 <i class="ion-ios-person-outline"></i>Profile</a> -->
<!--                                         </div> -->
<!--                                         <div class="account-dropdown__item"> -->
<!--                                             <a href="#"> -->
<!--                                                 <i class="ion-ios-upload-outline"></i>Logout</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </header> -->
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
                                            <li class="active"><a href="<%=request.getContextPath() %>/download/FS-my-profile.jsp">會員專區</a></li>
                                            <li class="active"><a href="<%=request.getContextPath() %>/MVC/Mylikes">我的收藏</a></li>
                                            <!-- <li>My Listings</li> -->
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
                                    <h5><i class="ion-heart"></i> 我的收藏</h5>
                                </div>

                                <div class="viewd-item-wrap">
                                <form method='post' action='<%=request.getContextPath() %>/booking.do'>
                                	<input type='hidden' name='action' value='booking'>
                                
                                	<%  List<ProductBean> list = (List)request.getAttribute("list");
                                		List<Integer> imgids = (List<Integer>)request.getAttribute("imgids");
                                		List<Double> avg = (List<Double>)request.getAttribute("avg");
                                		List<Integer> cities = (List<Integer>)request.getAttribute("cities");
                                		if(list!=null && list.size()!=0){
                                		for(int i = 0; i < list.size(); i++){
                                	%>
                                
                                    <div class="most-viewed-item">
                                        <div class="most-viewed-img">
                                            <a href="#"><img src="<%=request.getContextPath() %>/ProductImageReader?imgid=<%=imgids.get(i) %>" ></a>
                                        </div>
                                        <div class="most-viewed-detail">
                                            <span class="list-bg aqua"></span><%=list.get(i).getProducttype() %>
                                            <h3><a href="<%=request.getContextPath() %>/MVC/ProductDetail?productid=<%=list.get(i).getProductid() %>" target="_blank"><%=list.get(i).getProductname() %></a></h3>
                                            <p class="list-address"><i class="icofont-google-map"></i><%=cities.get(i) %></p>
											<input class='ccccc' type='hidden' name='productid' value='<%=list.get(i).getProductid() %>'>
                                            <div class="ratings">
                                                <i class="ion-ios-star"></i>
                                                <%=avg.get(i) %>
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star-half"></i> -->
                                            </div>
<!--                                             <div class="views">Views : <span>325</span></div> -->
                                            
                                        </div>
                                        
                                        <div class="listing-button">
                                        	TWD&nbsp<span><%=list.get(i).getProductprice() %></span>&nbsp&nbsp
<!--                                             <a href="#" class="btn v2"><i class="ion-edit"></i> Edit</a> -->
                                            <button type='button' class="btn v5" onclick='deleteCart(event)' value='<%=list.get(i).getProductid() %>'><i class="ion-android-delete"></i> 刪除</button>
                                        </div>
                                    </div>
                                    
                                    <% } }else{ out.write("<h5>暫無收藏項目!</h5>");}
                                    
                                    
                                    %>
                                    
                                    
<!--                                     <div class="most-viewed-item"> -->
<!--                                         <div class="most-viewed-img"> -->
<!--                                             <a href="#"><img src="images/single-listing/restaurant-2.jpg" alt="..."></a> -->
<!--                                         </div> -->
<!--                                         <div class="most-viewed-detail"> -->
<!--                                             <a class="category" href="#"><span class="list-bg red"><i class="icofont-restaurant"></i></span>Restaurent</a> -->
<!--                                             <h3><a href="single-listing-two.html">La Quo Vadis</a></h3> -->
<!--                                             <p class="list-address"><i class="icofont-google-map"></i>42 Albemarle st. Mayfair,London</p> -->

<!--                                             <div class="ratings"> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star-half"></i> -->
<!--                                             </div> -->
<!--                                             <div class="views">Views : <span>280</span></div> -->
<!--                                         </div> -->
<!--                                         <div class="listing-button"> -->
<!--                                             <a href="#" class="btn v2"><i class="ion-edit"></i> Edit</a> -->
<!--                                             <a href="#" class="btn v5"><i class="ion-android-delete"></i> Delete</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="most-viewed-item"> -->
<!--                                         <div class="most-viewed-img"> -->
<!--                                             <a href="#"><img src="images/category/event/muay.jpg" alt="..."></a> -->
<!--                                         </div> -->
<!--                                         <div class="most-viewed-detail"> -->
<!--                                             <a class="category" href="#"><span class="list-bg violate"><i class="icofont-movie"></i></span>Movie</a> -->
<!--                                             <h3><a href="single-listing-three.html">Muay Thai Live Show</a></h3> -->
<!--                                             <p class="list-address"><i class="icofont-google-map"></i>1690 Brown Avenue,Barline</p> -->

<!--                                             <div class="ratings"> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star-half"></i> -->
<!--                                             </div> -->
<!--                                             <div class="views">Views : <span>200</span></div> -->
<!--                                         </div> -->
<!--                                         <div class="listing-button"> -->
<!--                                             <a href="#" class="btn v2"><i class="ion-edit"></i> Edit</a> -->
<!--                                             <a href="#" class="btn v5"><i class="ion-android-delete"></i> Delete</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="most-viewed-item"> -->
<!--                                         <div class="most-viewed-img"> -->
<!--                                             <a href="#"><img src="images/category/event/3.jpg" alt="..."></a> -->
<!--                                         </div> -->
<!--                                         <div class="most-viewed-detail"> -->
<!--                                             <a class="category" href="#"><span class="list-bg aqua"><i class="icofont-music-alt"></i></span>Music</a> -->
<!--                                             <h3><a href="single-listing-five.html">Bolton music fair </a></h3> -->
<!--                                             <p class="list-address"><i class="icofont-google-map"></i>20 Hogh Street, Bolton, France</p> -->

<!--                                             <div class="ratings"> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star"></i> -->
<!--                                                 <i class="ion-ios-star-half"></i> -->
<!--                                             </div> -->
<!--                                             <div class="views">Views : <span>180</span></div> -->
<!--                                         </div> -->
<!--                                         <div class="listing-button"> -->
<!--                                             <a href="#" class="btn v2"><i class="ion-edit"></i> Edit</a> -->
<!--                                             <a href="#" class="btn v5"><i class="ion-android-delete"></i> Delete</a> -->
<!--                                         </div>     -->
<!--                                     </div> -->
                    
                                    
                                    </form>
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
    
    <!-- AJAX部分 -->
    <script>
    function deleteCart(e){
//      var productid = $(e.target).next().next().val();
     console.log($(e.target).parent().parent());
		$.ajax({
         url: '<%=request.getContextPath() %>/AddLikes',
         type: 'POST',
         data: {
         	productid: $(e.target).val()
         },
         dataType: "html",
         success: function(){
             console.log("成功");
             var totalprice = parseInt($('.totalprice').text()); 
             var oneprice = parseInt($(e.target).prev().text());
             var priceafter = totalprice - oneprice;
             $('.totalprice').text(priceafter);
             
             $(e.target).parent().parent().remove();
             if($('.ccccc').val()==null){
            	 $('.viewd-item-wrap').html('<h5>暫無收藏商品!</h5>');
             }
             
             
     
         }
     });    		
	}

    </script>

</body>

</html>
