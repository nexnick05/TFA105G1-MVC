<%@ page import="com.product.product.model.ProductBean"%>
<%@ page import="java.sql.*, com.product.productimg.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="java.util.*, org.springframework.context.ApplicationContext, org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="com.product.product.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>
	


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
<link href="css/plugin.css" rel="stylesheet" />
<!-- style CSS -->
<link href="css/style.css" rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet" href="css/switcher/skin-aqua.css" media="screen"
	id="style-colors" />
<!-- Document Title -->
<title>首頁/行程總覽</title>
</head>

<body>
	<!--Preloader starts-->
	<!-- <div class="preloader js-preloader">
        <img src="images/preloader.gif" alt="...">
    </div> -->
	<!--Preloader ends-->
	<!--Page Wrapper starts-->
	<div class="page-wrapper fixed-footer">
		<!--header starts-->
		<%@include file="/download/file/FS_Header.file"%>
		<!--Header ends-->
		<!--Breadcrumb section starts-->
		<div class="breadcrumb-section"
			style="background-image: url(images/sakura.jpg)">
			<div class="overlay op-5"></div>
			<div class="container">
				<div class="row align-items-center  pad-top-80">
					<div class="col-md-6 col-12">
						<div class="breadcrumb-menu">
							<h2 class="page-title">行程總覽</h2>
						</div>
					</div>
					<div class="col-md-6 col-12">
						<div class="breadcrumb-menu text-right sm-left">
							<ul>
								<li class="active"><a href="#">首頁</a></li>
								<li><a href="#">行程總覽</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Breadcrumb section ends-->
		<!--Listing Filter starts-->
		<div class="filter-wrapper style1 section-padding">
			<div class="container">
				<div class="row">
					<div class="col-xl-4 col-lg-12 option-box style1">
						<div class="filter-box style1 left">
							<div class="sidebar-title">
								<h2>篩選行程</h2>
							</div>
							<form method="post" action="<%=request.getContextPath() %>/MVC/ProductDisplayController">
								<div class="form-group filter-group">
									<input type="text" class="form-control filter-input"
										id="search-filter" name="keyword" placeholder="搜尋關鍵字" value="<%=request.getAttribute("keyword")==null ? "" : request.getAttribute("keyword") %>">
									<!-- <input type="text" class="form-control filter-input" id="location-filter" name="search-bar" placeholder="Location"> -->
									<% String type = (String)request.getAttribute("type");%>
									<select class="filter-input" id="option-select" name="type">
										<option>產品分類</option>
										<option <% if(type!=null && "一日遊".equals(type)){out.write("selected");} %>>一日遊</option>
										<option <% if(type!=null && "多日遊".equals(type)){out.write("selected");} %>>多日遊</option>
										<option <% if(type!=null && "包車".equals(type)){out.write("selected");} %>>包車</option>
										<option <% if(type!=null && "熱門票卷".equals(type)){out.write("selected");} %>>熱門票卷</option>
										<option <% if(type!=null && "獨特體驗".equals(type)){out.write("selected");} %>>獨特體驗</option>
									</select>
								</div>
								<div class="filter-sub-area style1">
									<div class="filter-title  mar-top-20 mar-bot-15">
										<p>
											價錢(TWD) &nbsp&nbsp 0~<span id="value333">0</span>
										</p>

									</div>
									<div>
										<input id="range33" type="range" min="0" max="20000" name="price"
											value="<%=request.getAttribute("price")==null ? "0" : request.getAttribute("price") %>" step="10" οninput="change()" οnchange="change()" style="width:300px">
									</div>

									<script>
										document.getElementById('range33')
												.addEventListener('change',
														change);
										function change() {

											var value = document
													.getElementById('range33').value;
											document.getElementById('value333').innerHTML = value;
										}
									</script>
<!-- 									<div id="slider-range" class="price-range mar-bot-30"></div> -->
								</div>
								<div class="filter-sub-menu style1 mar-bot-20">
 									<ul> 
 										<li class="has-sub"><a href="# ">更多篩選</a> 
											<ul class="explore__form-checkbox-list half-filter">
												<div class="filter-checkbox">
													<p>行程時間</p>
													<li><input id="check-a" type="checkbox" name="time" value="a">
														<label for="check-a">少於4小時</label></li>
													<li><input id="check-b" type="checkbox" name="time" value="b">
														<label for="check-b">4小時~1天</label></li>
													<li><input id="check-c" type="checkbox" name="time" value="c">
														<label for="check-c">1天~2天</label></li>
													<li><input id="check-d" type="checkbox" name="time" value="d">
														<label for="check-d">大於兩天</label></li>
<!--  													<li><input id="check-f" type="checkbox" name="check"> -->
<!--                                                         <label for="check-f">Events</label></li>  -->
<!--                                                     <li><input id="check-e" type="checkbox" name="check">  -->
<!--                                                          <label for="check-e">Free Wifi</label></li>  -->
												</div>
<!-- 												<div class="filter-checkbox"> -->
<!-- 													<p>依評價篩選</p> -->
<!-- 													<div> -->
<!-- 														<input id="check-w" type="checkbox" name="check"> -->
<!-- 														<label for="check-w"> </label> -->
<!-- 														<div class="list-ratings"> -->
<!-- 															<span class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 													<div> -->
<!-- 														<input id="check-x" type="checkbox" name="check"> -->
<!-- 														<label for="check-x"> </label> -->
<!-- 														<div class="list-ratings"> -->
<!-- 															<span class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star-outline"></span> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 													<div> -->
<!-- 														<input id="check-y" type="checkbox" name="check"> -->
<!-- 														<label for="check-y"> </label> -->
<!-- 														<div class="list-ratings"> -->
<!-- 															<span class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star-outline"></span> <span -->
<!-- 																class="ion-android-star-outline"></span> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 													<div> -->
<!-- 														<input id="check-z" type="checkbox" name="check"> -->
<!-- 														<label for="check-z"> </label> -->
<!-- 														<div class="list-ratings"> -->
<!-- 															<span class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star"></span> <span -->
<!-- 																class="ion-android-star-outline"></span> <span -->
<!-- 																class="ion-android-star-outline"></span> <span -->
<!-- 																class="ion-android-star-outline"></span> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 												</div> -->
												<div class="filter-checkbox">
													<p>依地區篩選</p>
													<input id="check-ab" type="checkbox" name="city" value="台北市">
													<label for="check-ab">台北市</label> 
													<input id="check-bc" type="checkbox" name="city" value="新北市"> 
													<label for="check-bc">新北市</label> 
													<input id="check-cd" type="checkbox" name="city" value="台中市"> 
													<label for="check-cd">台中市</label> 
													<input id="check-df" type="checkbox" name="city" value="高雄市"> 
													<label for="check-df">高雄市 </label>
													<input id="check-fg" type="checkbox" name="city" value="台東市">
													<label for="check-fg">台東市 </label>
													<input id="check-gh" type="checkbox" name="city" value="花蓮縣">
													<label for="check-gh">花蓮縣 </label>
													<input id="check-hi" type="checkbox" name="city" value="彰化縣">
													<label for="check-hi">彰化縣 </label>
													<input id="check-ij" type="checkbox" name="city" value="台南市">
													<label for="check-ij">台南市 </label>
								
												</div>
											</ul></li>
<!-- 									</ul> -->
								</div>
								<button type="submit" class="btn v1">搜尋</button>
							</form>
						</div>
					</div>
					<div class="col-xl-8 col-lg-12">
						<div class="row pad-bot-30 align-items-center">
							<div class="col-lg-4 col-sm-4 col-12">
								<div class="item-view-mode res-box">
									<!-- item-filter-list start -->
									<ul class="nav item-filter-list" role="tablist">
<!-- 										<<li><a data-toggle="tab" href="#grid-view"><i class="ion-grid"></i></a></li> -->
<!--                                         <li><a class="active" data-toggle="tab" href="#list-view"><i class="ion-ios-list"></i></a></li> --> 
									</ul>
									<!-- item-filter-list end -->
								</div>
							</div>
							<div class="col-lg-8 col-sm-8 col-12">
								<div class="item-element res-box  text-right xs-left">
									<p>
										共 <span><%=session.getAttribute("totalproduct") %></span> 項行程
									</p>
								</div>
							</div>
						</div>
<!-- 						<div class="item-wrapper"> -->
<!-- 							<div class="tab-content"> -->
								<div id="grid-view" class="tab-pane product-grid">
									<div class="row">


										                                        <!-- <div class="col-lg-6 col-md-12 col-12"> -->
										<!--                                             <div class="trending-place-item"> -->
										<!--                                                 <div class="trending-img"> -->
										<!--                                                     <img src="images/category/places/place-1.jpg" alt="#"> -->
										<!--                                                     <span class="trending-rating-green">7</span> -->
										<!--                                                     <span class="save-btn"><i class="icofont-heart"></i></span> -->
										<!--                                                 </div> -->
										<!--                                                 <div class="trending-title-box"> -->
										<!--                                                     <h4><a href="single-listing-one.html">Four Seasons Resort</a></h4> -->
										<!--                                                     <div class="customer-review"> -->
										<!--                                                         <div class="rating-summary float-left"> -->
										<!--                                                             <div class="rating-result" title="60%"> -->
										<!--                                                                 <ul class="product-rating"> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                 </ul> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="review-summury float-right"> -->
										<!--                                                             <p><a href="#">3 Reviews</a></p> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                     <ul class="trending-address"> -->
										<!--                                                         <li><i class="ion-ios-location"></i> -->
										<!--                                                             <p>4210 Khale Street,Florence,USA</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-ios-telephone"></i> -->
										<!--                                                             <p>+843-600-2040</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-android-globe"></i> -->
										<!--                                                             <p>www.laresorta.com</p> -->
										<!--                                                         </li> -->
										<!--                                                     </ul> -->
										<!--                                                     <div class="trending-bottom mar-top-15 pad-bot-30"> -->
										<!--                                                         <div class="trend-left float-left"> -->
										<!--                                                             <span class="round-bg pink"><i class="icofont-hotel"></i></span> -->
										<!--                                                             <p><a href="#">Hotel</a></p> -->

										<!--                                                         </div> -->
										<!--                                                         <div class="trend-right float-right"> -->
										<!--                                                             <div class="trend-open"><i class="ion-clock"></i> -->
										<!--                                                                 Open <p>till 11.00pm</p> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                 </div> -->
										<!--                                             </div> -->
										<!--                                         </div>  -->
										<!-- 單項商品結束  -->
										<!--                                         <div class="col-lg-6 col-md-12 col-12"> -->
										<!--                                             <div class="trending-place-item"> -->
										<!--                                                 <div class="trending-img"> -->
										<!--                                                     <img src="images/category/places/cafe.jpg" alt="#"> -->
										<!--                                                     <span class="trending-rating-pink">9</span> -->
										<!--                                                     <span class="save-btn"><i class="icofont-heart"></i></span> -->
										<!--                                                 </div> -->
										<!--                                                 <div class="trending-title-box"> -->
										<!--                                                     <h4><a href="single-listing-two.html">Cafe Intermezzo</a></h4> -->
										<!--                                                     <div class="customer-review"> -->
										<!--                                                         <div class="rating-summary float-left"> -->
										<!--                                                             <div class="rating-result" title="60%"> -->
										<!--                                                                 <ul class="product-rating"> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                 </ul> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="review-summury float-right"> -->
										<!--                                                             <p><a href="#">5 Reviews</a></p> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                     <ul class="trending-address"> -->
										<!--                                                         <li><i class="ion-ios-location"></i> -->
										<!--                                                             <p>2721 Andy Street,ELLSWORTH,USA</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-ios-telephone"></i> -->
										<!--                                                             <p>+605-344-1198</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-android-globe"></i> -->
										<!--                                                             <p>www.cafemezzo.com</p> -->
										<!--                                                         </li> -->

										<!--                                                     </ul> -->

										<!--                                                     <div class="trending-bottom mar-top-15 pad-bot-30"> -->
										<!--                                                         <div class="trend-left float-left"> -->
										<!--                                                             <span class="round-bg green"><i class="icofont-tea"></i></span> -->
										<!--                                                             <p><a href="#">Cafe</a></p> -->
										<!--                                                         </div> -->

										<!--                                                         <div class="trend-right float-right"> -->
										<!--                                                             <div class="trend-closed"> -->
										<!--                                                                 Closed -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                 </div> -->
										<!--                                             </div> -->
										<!--                                         </div> -->
										<!--                                         <div class="col-lg-6 col-md-12 col-12"> -->
										<!--                                             <div class="trending-place-item"> -->
										<!--                                                 <div class="trending-img"> -->
										<!--                                                     <img src="images/category/places/place-5.jpg" alt="#"> -->
										<!--                                                     <span class="trending-rating-orange">6.5</span> -->
										<!--                                                     <span class="save-btn"><i class="icofont-heart"></i></span> -->
										<!--                                                 </div> -->
										<!--                                                 <div class="trending-title-box"> -->
										<!--                                                     <h4><a href="single-listing-one.html">Lagoon Theme Park</a></h4> -->
										<!--                                                     <div class="customer-review"> -->
										<!--                                                         <div class="rating-summary float-left"> -->
										<!--                                                             <div class="rating-result" title="60%"> -->
										<!--                                                                 <ul class="product-rating"> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                 </ul> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="review-summury float-right"> -->
										<!--                                                             <p><a href="#">3 Reviews</a></p> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                     <ul class="trending-address"> -->
										<!--                                                         <li><i class="ion-ios-location"></i> -->
										<!--                                                             <p>1301 Avenue, Brooklyn, NY 11230</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-ios-telephone"></i> -->
										<!--                                                             <p>+44 20 7336 8898</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-android-globe"></i> -->
										<!--                                                             <p>www.burgerandlobster.com</p> -->
										<!--                                                         </li> -->

										<!--                                                     </ul> -->

										<!--                                                     <div class="trending-bottom mar-top-15 pad-bot-30"> -->
										<!--                                                         <div class="trend-left float-left"> -->
										<!--                                                             <span class="round-bg red"><i class="icofont-travelling"></i></span> -->
										<!--                                                             <p><a href="#">Travel</a></p> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="trend-right float-right"> -->
										<!--                                                             <div class="trend-open"><i class="ion-clock"></i> -->
										<!--                                                                 Open <p>till 10.00pm</p> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                 </div> -->
										<!--                                             </div> -->
										<!--                                         </div> -->
										<!--                                         <div class="col-lg-6 col-md-12 col-12"> -->
										<!--                                             <div class="trending-place-item"> -->
										<!--                                                 <div class="trending-img"> -->
										<!--                                                     <img src="images/category/places/place-4.jpg" alt="#"> -->
										<!--                                                     <span class="trending-rating-pink">8</span> -->
										<!--                                                     <span class="save-btn"><i class="icofont-heart"></i></span> -->
										<!--                                                 </div> -->
										<!--                                                 <div class="trending-title-box"> -->
										<!--                                                     <h4><a href="single-listing-one.html">The Katikies</a></h4> -->
										<!--                                                     <div class="customer-review"> -->
										<!--                                                         <div class="rating-summary float-left"> -->
										<!--                                                             <div class="rating-result" title="60%"> -->
										<!--                                                                 <ul class="product-rating"> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                 </ul> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="review-summury float-right"> -->
										<!--                                                             <p><a href="#">3 Reviews</a></p> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                     <ul class="trending-address"> -->
										<!--                                                         <li><i class="ion-ios-location"></i> -->
										<!--                                                             <p>1301 Avenue, Brooklyn, NY 11230</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-ios-telephone"></i> -->
										<!--                                                             <p>+44 20 7336 8898</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-android-globe"></i> -->
										<!--                                                             <p>www.burgerandlobster.com</p> -->
										<!--                                                         </li> -->

										<!--                                                     </ul> -->

										<!--                                                     <div class="trending-bottom mar-top-15 pad-bot-30"> -->
										<!--                                                         <div class="trend-left float-left"> -->
										<!--                                                             <span class="round-bg pink"><i class="icofont-hotel"></i></span> -->
										<!--                                                             <p><a href="#">Hotel</a></p> -->

										<!--                                                         </div> -->
										<!--                                                         <div class="trend-right float-right"> -->
										<!--                                                             <div class="trend-open"><i class="ion-clock"></i> -->
										<!--                                                                 Open <p>till 10.00pm</p> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                 </div> -->
										<!--                                             </div> -->
										<!--                                         </div> -->
										<!--                                         <div class="col-lg-6 col-md-12 col-12"> -->
										<!--                                             <div class="trending-place-item"> -->
										<!--                                                 <div class="trending-img"> -->
										<!--                                                     <img src="images/category/places/place-9.jpg" alt="#"> -->
										<!--                                                     <span class="trending-rating-green">6.5</span> -->
										<!--                                                     <span class="save-btn"><i class="icofont-heart"></i></span> -->
										<!--                                                 </div> -->
										<!--                                                 <div class="trending-title-box"> -->
										<!--                                                     <h4><a href="single-listing-two.html">Genji Restaurant</a></h4> -->
										<!--                                                     <div class="customer-review"> -->
										<!--                                                         <div class="rating-summary float-left"> -->
										<!--                                                             <div class="rating-result" title="60%"> -->
										<!--                                                                 <ul class="product-rating"> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                 </ul> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="review-summury float-right"> -->
										<!--                                                             <p><a href="#">3 Reviews</a></p> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                     <ul class="trending-address"> -->
										<!--                                                         <li><i class="ion-ios-location"></i> -->
										<!--                                                             <p>1301 Avenue, Brooklyn, NY 11230</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-ios-telephone"></i> -->
										<!--                                                             <p>+44 20 7336 8898</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-android-globe"></i> -->
										<!--                                                             <p>www.burgerandlobster.com</p> -->
										<!--                                                         </li> -->
										<!--                                                     </ul> -->
										<!--                                                     <div class="trending-bottom mar-top-15 pad-bot-30"> -->
										<!--                                                         <div class="trend-left float-left"> -->
										<!--                                                             <span class="round-bg green"><i class="icofont-fast-food"></i></span> -->
										<!--                                                             <p><a href="#">Restaurant</a></p> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="trend-right float-right"> -->
										<!--                                                             <div class="trend-open"><i class="ion-clock"></i> -->
										<!--                                                                 Open <p>till 10.00pm</p> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                 </div> -->
										<!--                                             </div> -->
										<!--                                         </div> -->
										<!--                                         <div class="col-lg-6 col-md-12 col-12"> -->
										<!--                                             <div class="trending-place-item"> -->
										<!--                                                 <div class="trending-img"> -->
										<!--                                                     <img src="images/category/places/place-11.jpg" alt="#"> -->
										<!--                                                     <span class="trending-rating-green">8</span> -->
										<!--                                                     <span class="save-btn"><i class="icofont-heart"></i></span> -->
										<!--                                                 </div> -->
										<!--                                                 <div class="trending-title-box"> -->
										<!--                                                     <h4><a href="single-listing-one.html">The Straling</a></h4> -->
										<!--                                                     <div class="customer-review"> -->
										<!--                                                         <div class="rating-summary float-left"> -->
										<!--                                                             <div class="rating-result" title="60%"> -->
										<!--                                                                 <ul class="product-rating"> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                     <li><i class="ion-android-star-half"></i></li> -->
										<!--                                                                 </ul> -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="review-summury float-right"> -->
										<!--                                                             <p><a href="#">3 Reviews</a></p> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                     <ul class="trending-address"> -->
										<!--                                                         <li><i class="ion-ios-location"></i> -->
										<!--                                                             <p>1301 Avenue, Brooklyn, NY 11230</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-ios-telephone"></i> -->
										<!--                                                             <p>+44 20 7336 8898</p> -->
										<!--                                                         </li> -->
										<!--                                                         <li><i class="ion-android-globe"></i> -->
										<!--                                                             <p>www.burgerandlobster.com</p> -->
										<!--                                                         </li> -->
										<!--                                                     </ul> -->
										<!--                                                     <div class="trending-bottom mar-top-15 pad-bot-30"> -->
										<!--                                                         <div class="trend-left float-left"> -->
										<!--                                                             <span class="round-bg green"><i class="ion-ios-cart"></i></span> -->
										<!--                                                             <p><a href="#">Shop</a></p> -->
										<!--                                                         </div> -->
										<!--                                                         <div class="trend-right float-right"> -->
										<!--                                                             <div class="trend-closed"> -->
										<!--                                                                 closed -->
										<!--                                                             </div> -->
										<!--                                                         </div> -->
										<!--                                                     </div> -->
										<!--                                                 </div> -->
										<!--                                             </div> -->
										<!--                                         </div> -->
									</div>
									<!-- row結束 -->
								</div>
								
								<div id="list-view" class="tab-pane active product-list">
								<%   List<ProductBean> list2 = (List)request.getAttribute("list2");
									List imgids = 	(List)request.getAttribute("imgids");
									List<String> introStrings = (List<String>)request.getAttribute("introStrings");
									List<Integer> commentcount = (List<Integer>)request.getAttribute("commentcount");
									List<Double> avg = (List<Double>)request.getAttribute("avg");
									List<String> cities = (List<String>)request.getAttribute("cities");
									
									if(list2.size()==0){ out.print("<h5>查無資料!</h5>");} 
							    %>      
								<%  for(int i=0; i < list2.size();i++){ %>
								
								
								<!-- 單項商品開始 -->
									<div class="row trending-place-item">
										<div class="col-md-6 no-pad-lr">
											<div class="trending-img">
												<img src="<%=request.getContextPath()%>/ProductImageReader?imgid=<%=imgids.get(i) %> " alt="#">
												<span class="trending-rating-green"><%=avg.get(i) %></span> <span
													class="save-btn"><i class="icofont-heart"></i></span>
											</div>
										</div>
										<div class="col-md-6 no-pad-lr">
											<div class="trending-title-box">
												<h4>
													<a href="<%=request.getContextPath() %>/MVC/ProductDetail?productid=<%=list2.get(i).getProductid() %>" target="_blank"><%=list2.get(i).getProductname() %></a>
												</h4>
												<div class="customer-review">
													<div class="rating-summary float-left">
<!-- 														<div class="rating-result" title="60%"> -->
<!-- 															<ul class="product-rating"> -->
<!-- 																<li><i class="ion-android-star"></i></li> -->
<!-- 																<li><i class="ion-android-star"></i></li> -->
<!-- 																<li><i class="ion-android-star"></i></li> -->
<!-- 																<li><i class="ion-android-star-half"></i></li> -->
<!-- 																<li><i class="ion-android-star-half"></i></li> -->
<!-- 															</ul> -->
<!-- 														</div> -->
													</div>
													<div class="review-summury float-right">
														<p>
															<a href="#"><%=commentcount.get(i) %> 則評論</a>
														</p>
													</div>
												</div>
												<ul class="trending-address">
													<li><i class="ion-ios-location"></i>
														<p><%=cities.get(i) %></p></li>
														<li>
														<p><%=introStrings.get(i) %></p>
														</li>
<!-- 													<li><i class="ion-ios-telephone"></i> -->
<!-- 														<p>+843-600-2040</p></li> -->
<!-- 													<li><i class="ion-android-globe"></i> -->
<!-- 														<p>www.laresorta.com</p></li> -->
												</ul>
												<div class="trending-bottom mar-top-15 pad-bot-30">
													<div class="trend-left float-left">
<!-- 														<span class="round-bg pink"><i -->
<!-- 															class="icofont-hotel"></i></span> -->
														<p>
															<%=list2.get(i).getProducttype() %>
														</p>

													</div>
													<div class="trend-right float-right">
														<div class="trend-open">
<!-- 															<i class="ion-clock"></i>  -->
															<p><strong> TWD &nbsp<%= list2.get(i).getProductprice() %></strong> </p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 單項商品結束 -->


									<%} %>

									<!--                                     <div class="row trending-place-item"> -->
									<!--                                         <div class="col-md-6 no-pad-lr"> -->
									<!--                                             <div class="trending-img"> -->
									<!--                                                 <img src="images/category/places/cafe.jpg" alt="#"> -->
									<!--                                                 <span class="trending-rating-pink">9</span> -->
									<!--                                                 <span class="save-btn"><i class="icofont-heart"></i></span> -->
									<!--                                             </div> -->
									<!--                                         </div> -->
									<!--                                         <div class="col-md-6 no-pad-lr"> -->
									<!--                                             <div class="trending-title-box"> -->
									<!--                                                 <h4><a href="single-listing-two.html">我我</a></h4> -->
									<!--                                                 <div class="customer-review"> -->
									<!--                                                     <div class="rating-summary float-left"> -->
									<!--                                                         <div class="rating-result" title="60%"> -->
									<!--                                                             <ul class="product-rating"> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star-half"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star-half"></i></li> -->
									<!--                                                             </ul> -->
									<!--                                                         </div> -->
									<!--                                                     </div> -->
									<!--                                                     <div class="review-summury float-right"> -->
									<!--                                                         <p><a href="#">5 Reviews</a></p> -->
									<!--                                                     </div> -->
									<!--                                                 </div> -->
									<!--                                                 <ul class="trending-address"> -->
									<!--                                                     <li><i class="ion-ios-location"></i> -->
									<!--                                                         <p>2721 Andy Street,ELLSWORTH,USA</p> -->
									<!--                                                     </li> -->
									<!--                                                     <li><i class="ion-ios-telephone"></i> -->
									<!--                                                         <p>+605-344-1198</p> -->
									<!--                                                     </li> -->
									<!--                                                     <li><i class="ion-android-globe"></i> -->
									<!--                                                         <p>www.cafemezzo.com</p> -->
									<!--                                                     </li> -->

									<!--                                                 </ul> -->

									<!--                                                 <div class="trending-bottom mar-top-15 pad-bot-30"> -->
									<!--                                                     <div class="trend-left float-left"> -->
									<!--                                                         <span class="round-bg green"><i class="icofont-tea"></i></span> -->
									<!--                                                         <p><a href="#">Cafe</a></p> -->
									<!--                                                     </div> -->

									<!--                                                     <div class="trend-right float-right"> -->
									<!--                                                         <div class="trend-closed"> -->
									<!--                                                             Closed -->
									<!--                                                         </div> -->
									<!--                                                     </div> -->
									<!--                                                 </div> -->
									<!--                                             </div> -->
									<!--                                         </div> -->
									<!--                                     </div> -->
									<!--                                     <div class="row trending-place-item"> -->
									<!--                                         <div class="col-md-6 no-pad-lr"> -->
									<!--                                             <div class="trending-img"> -->
									<!--                                                 <img src="images/category/places/place-5.jpg" alt="#"> -->
									<!--                                                 <span class="trending-rating-orange">6.5</span> -->
									<!--                                                 <span class="save-btn"><i class="icofont-heart"></i></span> -->
									<!--                                             </div> -->
									<!--                                         </div> -->
									<!--                                         <div class="col-md-6 no-pad-lr"> -->
									<!--                                             <div class="trending-title-box"> -->
									<!--                                                 <h4><a href="single-listing-one.html">Lagoon Theme Park</a></h4> -->
									<!--                                                 <div class="customer-review"> -->
									<!--                                                     <div class="rating-summary float-left"> -->
									<!--                                                         <div class="rating-result" title="60%"> -->
									<!--                                                             <ul class="product-rating"> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star-half"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star-half"></i></li> -->
									<!--                                                             </ul> -->
									<!--                                                         </div> -->
									<!--                                                     </div> -->
									<!--                                                     <div class="review-summury float-right"> -->
									<!--                                                         <p><a href="#">3 Reviews</a></p> -->
									<!--                                                     </div> -->
									<!--                                                 </div> -->
									<!--                                                 <ul class="trending-address"> -->
									<!--                                                     <li><i class="ion-ios-location"></i> -->
									<!--                                                         <p>1301 Avenue, Brooklyn, NY 11230</p> -->
									<!--                                                     </li> -->
									<!--                                                     <li><i class="ion-ios-telephone"></i> -->
									<!--                                                         <p>+44 20 7336 8898</p> -->
									<!--                                                     </li> -->
									<!--                                                     <li><i class="ion-android-globe"></i> -->
									<!--                                                         <p>www.burgerandlobster.com</p> -->
									<!--                                                     </li> -->

									<!--                                                 </ul> -->

									<!--                                                 <div class="trending-bottom mar-top-15 pad-bot-30"> -->
									<!--                                                     <div class="trend-left float-left"> -->
									<!--                                                         <span class="round-bg red"><i class="icofont-travelling"></i></span> -->
									<!--                                                         <p><a href="#">Travel</a></p> -->
									<!--                                                     </div> -->
									<!--                                                     <div class="trend-right float-right"> -->
									<!--                                                         <div class="trend-open"><i class="ion-clock"></i> -->
									<!--                                                             Open <p>till 10.00pm</p> -->
									<!--                                                         </div> -->
									<!--                                                     </div> -->
									<!--                                                 </div> -->
									<!--                                             </div> -->
									<!--                                         </div> -->
									<!--                                     </div> -->
									<!--                                     <div class="row trending-place-item"> -->
									<!--                                         <div class="col-md-6 no-pad-lr"> -->
									<!--                                             <div class="trending-img"> -->
									<!--                                                 <img src="images/category/places/place-4.jpg" alt="#"> -->
									<!--                                                 <span class="trending-rating-pink">8</span> -->
									<!--                                                 <span class="save-btn"><i class="icofont-heart"></i></span> -->
									<!--                                             </div> -->
									<!--                                         </div> -->
									<!--                                         <div class="col-md-6 no-pad-lr"> -->
									<!--                                             <div class="trending-title-box"> -->
									<!--                                                 <h4><a href="single-listing-one.html">The Katikies</a></h4> -->
									<!--                                                 <div class="customer-review"> -->
									<!--                                                     <div class="rating-summary float-left"> -->
									<!--                                                         <div class="rating-result" title="60%"> -->
									<!--                                                             <ul class="product-rating"> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star-half"></i></li> -->
									<!--                                                                 <li><i class="ion-android-star-half"></i></li> -->
									<!--                                                             </ul> -->
									<!--                                                         </div> -->
									<!--                                                     </div> -->
									<!--                                                     <div class="review-summury float-right"> -->
									<!--                                                         <p><a href="#">3 Reviews</a></p> -->
									<!--                                                     </div> -->
									<!--                                                 </div> -->
									<!--                                                 <ul class="trending-address"> -->
									<!--                                                     <li><i class="ion-ios-location"></i> -->
									<!--                                                         <p>1301 Avenue, Brooklyn, NY 11230</p> -->
									<!--                                                     </li> -->
									<!--                                                     <li><i class="ion-ios-telephone"></i> -->
									<!--                                                         <p>+44 20 7336 8898</p> -->
									<!--                                                     </li> -->
									<!--                                                     <li><i class="ion-android-globe"></i> -->
									<!--                                                         <p>www.burgerandlobster.com</p> -->
									<!--                                                     </li> -->

									<!--                                                 </ul> -->

									<!--                                                 <div class="trending-bottom mar-top-15 pad-bot-30"> -->
									<!--                                                     <div class="trend-left float-left"> -->
									<!--                                                         <span class="round-bg pink"><i class="icofont-hotel"></i></span> -->
									<!--                                                         <p><a href="#">Hotel</a></p> -->

									<!--                                                     </div> -->
									<!--                                                     <div class="trend-right float-right"> -->
									<!--                                                         <div class="trend-open"><i class="ion-clock"></i> -->
									<!--                                                             Open <p>till 1000.00pm</p> -->
									<!--                                                         </div> -->
									<!--                                                     </div> -->
									<!--                                                 </div> -->
									<!--                                             </div> -->
									<!--                                         </div> -->
									<!--                                     </div> -->
								</div>
								<!--pagination starts-->
								<div class="post-nav nav-res pad-top-10">
									<div class="row">
										<div class="col-md-8 offset-md-2  col-xs-12 ">
											<div class="page-num text-center">
												<ul>
													<% Integer totalpage = (Integer)request.getAttribute("totalpage");
														Integer pageaa = Integer.valueOf((String)request.getAttribute("page"));
														for(int i =1; i<= totalpage; i++){
													%>	
													<li <% if(i==pageaa){out.write("class='active'");} %>><a href="<%=request.getContextPath() %>/MVC/PageHandler?page=<%=i %>"><%=i %></a></li>
													
													<% } %>
<!-- 													<li><a href="#">2</a></li> -->
<!-- 													<li><a href="#">3</a></li> -->
<!-- 													<li><a href="#">4</a></li> -->
<!-- 													<li><a href="#"><i class="ion-ios-arrow-right"></i></a></li> -->
												</ul>
											</div>
										</div>
									</div>
								</div>
								<!--pagination ends-->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Listing Filter ends-->
		<!-- Scroll to top starts-->
		<span class="scrolltotop"><i class="ion-arrow-up-c"></i></span>
		<!-- Scroll to top ends-->
	</div>
	<!--Page Wrapper ends-->
	<!--Footer Starts-->
	<div class="footer-wrapper no-pad-tb v2">
		<div class="footer-top-area section-padding">
			<div class="container">
				<div class="row nav-folderized">
					<div class="col-lg-3 col-md-12">
						<div class="footer-logo">
							<!-- <a href="index.html"> <img src="images/f.png" alt="logo"></a> -->
							<a href="index.html">
								<h1>Fun心遊台灣</h1>
							</a>
							<div class="company-desc">
								<p>
									我們致力於給每一位旅客最好的旅遊體驗，每一段旅程都將成為人生精采的回憶。
									<!-- Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio excepturi nam totam sequi, ipsam consequatur repudiandae libero illum. -->
								</p>
							</div>
						</div>
					</div>
					<!-- <div class="col-lg-3 col-md-12">
                        <div class="footer-content nav">
                            <h2 class="title" >相關連結</h2>
                            <ul class="list">
                                <li><a class="link-hov style2" href="#" >登入</a></li>
                                <li><a class="link-hov style2" href="#" >會員中心</a></li>
                                <li><a class="link-hov style2" href="#" >購物車</a></li>
                                <li><a class="link-hov style2" href="#" >隱私權保護政策</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-12">
                        <div class="footer-content nav">
                            <h2 class="title" >產品分類</h2>
                            <ul class="list">
                                <li><a class="link-hov style2" href="#" >一日遊</a></li>
                                <li><a class="link-hov style2" href="#" >多日遊</a></li>
                                <li><a class="link-hov style2" href="#" >包車</a></li>
                                <li><a class="link-hov style2" href="#" ></a></li>

                            </ul>
                        </div>
                    </div> -->
					<div class="col-lg-3 col-md-12">
						<div class="footer-content nav">
							<h2 class="title">聯絡我們</h2>
							<ul class="list footer-list">
								<li>
									<div class="contact-info">
										<div class="icon">
											<i class="ion-ios-location"></i>
										</div>
										<div class="text">緯育Tibame-TFA105第一組</div>
									</div>
								</li>
								<li>
									<div class="contact-info">
										<div class="icon">
											<i class="ion-email"></i>
										</div>
										<div class="text">
											<a href="#">組員個人履歷</a>
										</div>
									</div>
								</li>
								<!-- <li>
                                    <div class="contact-info">
                                        <div class="icon">
                                            <i class="ion-ios-telephone"></i>
                                        </div>
                                        <div class="text">+81 02 2955 3611</div>
                                    </div>
                                </li> -->
							</ul>
							<!-- <ul class="social-buttons style2">
                                <li><a href="#"><i class="ion-social-facebook"></i></a></li>
                                <li><a href="#"><i class="ion-social-twitter"></i></a></li>
                                <li><a href="#"><i class="ion-social-pinterest"></i></a></li>
                                <li><a href="#"><i class="ion-social-youtube"></i></a></li>
                                <li><a href="#"><i class="ion-social-dribbble"></i></a></li>
                            </ul> -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- <div class="footer-bottom-area">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="payment-method">
                            <img src="images/payment/payment-1.png" alt="...">
                            <img src="images/payment/payment-2.png" alt="...">
                            <img src="images/payment/payment-3.png" alt="...">
                        </div>
                    </div>
                    <div class="col-md-6 text-right sm-left">
                        <ul class="additional-link">
                            <li><a href="#">Terms &amp; Condition</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="login.html">Login</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div> -->
	</div>
	<!--Footer ends-->
	<!--Color switcher starts-->
	<div class="color-switcher hide-color-switcher">
		<a class="switcher-button"><i class="ion-android-settings"></i></a>
		<div class="color-switcher-title text-center">
			<h5>Switch Colors</h5>
		</div>
		<div class="color-list text-center">
			<a class="color green-theme" title="green"></a> <a
				class="color red-theme" title="red"></a> <a class="color blue-theme"
				title="blue"></a> <a class="color orange-theme" title="orange"></a>
			<a class="color pink-theme" title="pink"></a> <a
				class="color purple-theme" title="purple"></a> <a
				class="color violet-theme" title="violet"></a> <a
				class="color aqua-theme" title="aqua"></a>
		</div>
	</div>
	<!--Color switcher ends-->
	<!--Scripts starts-->
	<!--plugin js-->
	<script src="js/plugin.js"></script>
	<!--google maps-->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_8C7p0Ws2gUu7wo0b6pK9Qu7LuzX2iWY&amp;libraries=places&amp;callback=initAutocomplete"></script>
	<!--Main js-->
	<script src="js/main.js"></script>
	<!--Scripts ends-->
	
	<script>
	window.addEventListener('load', change);
	
	
	</script>

</body>

</html>
