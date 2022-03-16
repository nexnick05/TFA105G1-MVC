<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*, com.product.product.model.*, javax.servlet.ServletContext, org.springframework.context.ApplicationContext, org.springframework.web.context.WebApplicationContext "%>
<%@ page import="com.product.city.model.*, java.util.*, java.sql.*" %>

<% ServletContext applicationContext = this.getServletContext();
		ApplicationContext context = (ApplicationContext) applicationContext.getAttribute
				(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		ProductService productService = context.getBean("productService", ProductService.class); 
		List<ProductBean> list = productService.select(null);
		CityService cityService = context.getBean("cityService", CityService.class);	
		List<CityBean> cities = cityService.select(null);
		
		
		List imgids = new ArrayList();
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei",
				"root", "password");
			for (int i = 0; i < 6; i++) {
				if (list.get(i) != null) {
					PreparedStatement ps = connection
							.prepareStatement("SELECT * FROM PRODUCT_IMG where PRODUCT_ID = ? limit 1");
					ps.setInt(1, list.get(i).getProductid());
					ResultSet rSet = ps.executeQuery();

					while (rSet.next()) {
						imgids.add(rSet.getInt(1));
					}
				}
			}

		
%>

<!DOCTYPE html>
<html dir="ltr" lang="en-US">

<head>
    <!-- Metas -->
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="LionCoders" />
    <!-- Links -->
    <link rel="<%=request.getContextPath()%>/download/icon" type="image/png" href="#" />
    <!-- google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800" rel="stylesheet">
    <!-- Plugins CSS -->
    <link href="<%=request.getContextPath()%>/download/css/plugin.css" rel="stylesheet" />
    <!-- style CSS -->
    <link href="<%=request.getContextPath()%>/download/css/style.css" rel="stylesheet" />
    <!--color switcher css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/download/css/switcher/skin-red.css" media="screen" id="style-colors" />
    <!-- Document Title -->
    <!-- <title>listagram - Directory Listing HTML Template</title> -->
    <title>Fun心遊台灣 - 開始探索</title>
</head>
<!-- 21, 39, 34, 47-59, 63-128, 132-162, 166-177, 181-192, 197, 221, 228, 232, 283-293, 239, 245, 257 -->
<!-- style.css 1575-1585-->
<body>
   <!--Preloader starts-->
    <!-- <div class="preloader js-preloader">
        <img src="images/preloader.gif" alt="...">
    </div> -->
    <!--Preloader ends-->
    <!--Page Wrapper starts-->
    <div class="page-wrapper">
        <!--header starts-->
        <%@include file="file/FS_Header.file"%>
        <!--Header ends-->
        <!--Hero section starts-->
        <div class="hero v2 section-padding" style="background-image: url(<%=request.getContextPath() %>/download/images/taiwan.jpg)">
            <div class="overlay op-5"></div>
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <h1 class="hero-title v2">
                            <!-- Explore Your City. -->
                            探索屬於你的台灣
                        </h1>
                        <p class="hero-desc v2">
                            <!-- You can’t imagine, what is waiting for you around your city -->
                            你無法想像還有什麼好玩的景點在等著你!
                        </p>
                    </div>
                    <div class="col-md-8 text-center mar-top-20" style="left: 17%;">
                        <form class="hero__form v2" method="post" action="<%=request.getContextPath() %>/MVC/ProductDisplayController">
                            <div class="row">
                                <div class="col-lg-10 col-md-12">
                                    <input class="hero__form-input custom-select" type="text" name="keyword" id="place-event" placeholder="輸入關鍵字搜尋">
                                    <!-- <input class="hero__form-input custom-select" type="text" name="place-event" id="place-event" placeholder="What are you looking for?"> -->
                                </div>
<!--                                 <div class="col-lg-3 col-md-12"> -->
<!--                                     <select class="hero__form-input  custom-select"> -->
<!--                                         <option>Select Location </option> -->
<!--                                         <option>選擇地點 </option> -->
<!--                                         <option>New York</option> -->
<!--                                         <option>California</option> -->
<!--                                         <option>Washington</option> -->
<!--                                         <option>New Jersey</option> -->
<!--                                         <option>Los Angeles</option> -->
<!--                                         <option>Florida</option> -->
<!--                                     </select> -->
<!--                                 </div> -->
<!--                                 <div class="col-lg-3 col-md-12"> -->
<!--                                     <select class="hero__form-input  custom-select"> -->
<!--                                         <option>Select Categories</option> -->
<!--                                         <option>選擇分類</option> -->
<!--                                         <option>Art's</option> -->
<!--                                         <option>Health</option> -->
<!--                                         <option>Hotels</option> -->
<!--                                         <option>Real Estate</option> -->
<!--                                         <option>Rentals</option> -->
<!--                                     </select> -->
<!--                                 </div> -->
                                <div class="col-lg-2 col-md-12">
                                    <div class="submit_btn text-right md-left">
                                        <button class="btn v3  mar-right-5" type="submit"><i class="ion-search" aria-hidden="true"></i> 搜尋</button>
                                        <!-- <button class="btn v3  mar-right-5" type="submit"><i class="ion-search" aria-hidden="true"></i> Search</button> -->
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-10 offset-md-1">
                        <div class="hero-catagory-menu text-center">
                            <p>或是看看以下熱門分類:</p>
                            <!-- <p>Or browse Popular Categories</p> -->
                            <ul>
                                <!-- <li><a href="all-categories.html"><i class="ion-android-restaurant"></i> Restaurant</a></li>
                                <li><a href="all-categories.html"><i class="ion-ios-musical-notes"></i> Event</a></li>
                                <li><a href="all-categories.html"><i class="ion-ios-home-outline"></i> Hotel</a></li>
                                <li><a href="all-categories.html"><i class="ion-ios-cart-outline"></i> Shopping</a></li> -->
                                <li><a href="<%=request.getContextPath() %>/MVC/ProductDisplayController?type=多日遊"><i class="icofont-hotel"></i> 多日遊</a></li>
                                <li><a href="<%=request.getContextPath() %>/MVC/ProductDisplayController?type=包車"><i class="ion-android-bus"></i> 包車</a></li>
                                <li><a href="<%=request.getContextPath() %>/MVC/ProductDisplayController?type=熱門票卷"><i class="icofont-ticket"></i> 熱門票卷</a></li>
                                <li><a href="<%=request.getContextPath() %>/MVC/ProductDisplayController?type=獨特體驗"><i class="icofont-camping-vest"></i> 獨特體驗</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Hero section ends-->
        <!--Popular City starts-->
        <div class="popular-cities section-padding mar-top-20">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 offset-md-2 text-center">
                        <h2 class="section-title v1">熱門地點</h2>
                    </div>
                    <div class="col-md-12">
                        <div class="swiper-container popular-place-wrap v2">
                            <div class="swiper-wrapper">
                            
                           
                            <% for(int i = 0; i < 5 ; i++) {%>
                                <div class="swiper-slide popular-item">
                                    <div class="single-place">
                                        <img class="single-place-image" src="<%=request.getContextPath() %>/download/images/city<%= i+1 %>.jpg" alt="place-image" style="height:233px">
                                        <div class="single-place-content">
                                            <h2 class="single-place-title">
                                                <a href="grid-fullwidth-map.html"><%=cities.get(i).getCity() %></a>
                                            </h2>
<!--                                             <ul class="single-place-list"> -->
<!--                                                 <li><span>5</span> Cities</li> -->
<!--                                                 <li><span>255</span> Listing</li> -->
<!--                                             </ul> -->
                                            <a class="btn v6 explore-place" href="<%=request.getContextPath() %>/MVC/ProductDisplayController?city=<%=cities.get(i).getCity() %>">探索更多</a>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
<!--                                 <div class="swiper-slide popular-item"> -->
<!--                                     <div class="single-place"> -->
<!--                                         <img class="single-place-image" src="images/category/thailand.jpg" alt="place-image"> -->
<!--                                         <div class="single-place-content"> -->
<!--                                             <h2 class="single-place-title"> -->
<!--                                                 <a href="grid-fullwidth-map.html">Thailand</a> -->
<!--                                             </h2> -->
<!--                                             <ul class="single-place-list"> -->
<!--                                                 <li><span>5</span> Cities</li> -->
<!--                                                 <li><span>255</span> Listing</li> -->
<!--                                             </ul> -->
<!--                                             <a class="btn v6 explore-place" href="grid-fullwidth-map.html">Explore</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="swiper-slide popular-item"> -->
<!--                                     <div class="single-place"> -->
<!--                                         <img class="single-place-image" src="images/category/italy-5.jpg" alt="place-image"> -->
<!--                                         <div class="single-place-content"> -->
<!--                                             <h2 class="single-place-title"> -->
<!--                                                 <a href="grid-fullwidth-map.html">Italy</a> -->
<!--                                             </h2> -->
<!--                                             <ul class="single-place-list"> -->
<!--                                                 <li><span>5</span> Cities</li> -->
<!--                                                 <li><span>255</span> Listing</li> -->
<!--                                             </ul> -->
<!--                                             <a class="btn v6 explore-place" href="grid-fullwidth-map.html">Explore</a> -->
<!--                                         </div> -->
<!--                                     </div> -->

<!--                                 </div> -->
<!--                                 <div class="swiper-slide popular-item"> -->
<!--                                     <div class="single-place"> -->
<!--                                         <img class="single-place-image" src="images/category/spain.jpg" alt="place-image"> -->
<!--                                         <div class="single-place-content"> -->
<!--                                             <h2 class="single-place-title"> -->
<!--                                                 <a href="grid-fullwidth-map.html">Spain</a> -->
<!--                                             </h2> -->
<!--                                             <ul class="single-place-list"> -->
<!--                                                 <li><span>5</span> Cities</li> -->
<!--                                                 <li><span>255</span> Listing</li> -->
<!--                                             </ul> -->
<!--                                             <a class="btn v6 explore-place" href="grid-fullwidth-map.html">Explore</a> -->
<!--                                         </div> -->
<!--                                     </div> -->

<!--                                 </div> -->
<!--                                 <div class="swiper-slide popular-item"> -->
<!--                                     <div class="single-place"> -->
<!--                                         <img class="single-place-image" src="images/category/turkey.jpg" alt="place-image"> -->
<!--                                         <div class="single-place-content"> -->
<!--                                             <h2 class="single-place-title"> -->
<!--                                                 <a href="grid-fullwidth-map.html">Turkey</a> -->
<!--                                             </h2> -->
<!--                                             <ul class="single-place-list"> -->
<!--                                                 <li><span>5</span> Cities</li> -->
<!--                                                 <li><span>255</span> Listing</li> -->
<!--                                             </ul> -->
<!--                                             <a class="btn v6 explore-place" href="grid-fullwidth-map.html">Explore</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->

                            </div>
                        </div>
                        <div class="slider-btn v1 popular-next style2"><i class="ion-arrow-right-c"></i></div>
                        <div class="slider-btn v1 popular-prev style2"><i class="ion-arrow-left-c"></i></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Popular City ends-->
        <!--Trending events starts-->
        <div class="trending-places section-padding pad-bot-130 bg-pn">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 offset-md-2 text-center">
                        <h2 class="section-title v1">熱門行程</h2>
                    </div>
                    <div class="col-md-12">
                        <div class="swiper-container trending-place-wrap">
                            <div class="swiper-wrapper">
                            
                            <% for (int i=0;i < 6; i++) {%>
                                <div class="swiper-slide trending-place-item">
                                    <div class="trending-img">
                                        <img src="<%=request.getContextPath() %>/ProductImageReader?imgid=<%=imgids.get(i) %>" alt="#" style="height:233px">
                                        <span class="trending-rating-orange">6.5</span>
                                        <span class="save-btn"><i class="icofont-heart"></i></span>
                                    </div>
                                    <div class="trending-title-box">
                                        <h4><a href="<%=request.getContextPath() %>/MVC/ProductDetail?productid=<%=list.get(i).getProductid() %>"><%=list.get(i).getProductname() %></a></h4>
                                        <div class="customer-review">
                                            <div class="rating-summary float-left">
<!--                                                 <div class="rating-result" title="60%"> -->
<!--                                                     <ul class="product-rating"> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                     </ul> -->
<!--                                                 </div> -->
                                            </div>
                                            <div class="review-summury float-right">
                                                <p><a href="#">3 Reviews</a></p>
                                            </div>
                                        </div>
<!--                                         <ul class="trending-address"> -->
<!--                                             <li><i class="ion-ios-location"></i> -->
<!--                                                 <p>1690 Brown Avenue,Barline</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-ios-telephone"></i> -->
<!--                                                 <p>+864-940-3419</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-android-globe"></i> -->
<!--                                                 <p>www.thaishow.com</p> -->
<!--                                             </li> -->
<!--                                         </ul> -->
                                        <div class="trending-bottom mar-top-15 pad-bot-30">
                                            <div class="trend-left float-left">
<!--                                                 <span class="round-bg green"><i class="icofont-movie"></i></span> -->
                                                <p><%=list.get(i).getProducttype() %></p>
                                            </div>
                                            <div class="trend-right float-right">
                                                <div class="trend-open mar-top-5"> TWD&nbsp<%=list.get(i).getProductprice() %></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% }%>
<!--                                 <div class="swiper-slide trending-place-item"> -->
<!--                                     <div class="trending-img"> -->
<!--                                         <img src="images/category/event/photo1.jpg" alt="#"> -->
<!--                                         <span class="trending-rating-pink">6.5</span> -->
<!--                                         <span class="save-btn"><i class="icofont-heart"></i></span> -->
<!--                                     </div> -->
<!--                                     <div class="trending-title-box"> -->
<!--                                         <h4><a href="single-listing-one.html">Carolina photo exibition</a></h4> -->
<!--                                         <div class="customer-review"> -->
<!--                                             <div class="rating-summary float-left"> -->
<!--                                                 <div class="rating-result" title="60%"> -->
<!--                                                     <ul class="product-rating"> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                     </ul> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                             <div class="review-summury float-right"> -->
<!--                                                 <p><a href="#">10 Reviews</a></p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <ul class="trending-address"> -->
<!--                                             <li><i class="ion-ios-location"></i> -->
<!--                                                 <p>32 down Ave, North Carolina,USA</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-ios-telephone"></i> -->
<!--                                                 <p>+251 7336 8898</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-android-globe"></i> -->
<!--                                                 <p>www.photoexpo.com</p> -->
<!--                                             </li> -->
<!--                                         </ul> -->
<!--                                         <div class="trending-bottom mar-top-15 pad-bot-30"> -->
<!--                                             <div class="trend-left float-left"> -->
<!--                                                 <span class="round-bg pink"><i class="icofont-camera"></i></span> -->
<!--                                                 <p><a href="#">Photography</a></p> -->
<!--                                             </div> -->
<!--                                             <div class="trend-right float-right"> -->
<!--                                                 <div class="trend-open mar-top-5"><i class="ion-clock"></i>5.00 pm</div> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="swiper-slide trending-place-item"> -->
<!--                                     <div class="trending-img"> -->
<!--                                         <img src="images/category/event/coffee.jpg" alt="#"> -->
<!--                                         <span class="trending-rating-green">6.5</span> -->
<!--                                         <span class="save-btn"><i class="icofont-heart"></i></span> -->
<!--                                     </div> -->
<!--                                     <div class="trending-title-box"> -->
<!--                                         <h4><a href="single-listing-one.html">European coffee expo </a></h4> -->
<!--                                         <div class="customer-review"> -->
<!--                                             <div class="rating-summary float-left"> -->
<!--                                                 <div class="rating-result" title="60%"> -->
<!--                                                     <ul class="product-rating"> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                     </ul> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                             <div class="review-summury float-right"> -->
<!--                                                 <p><a href="#">7 Reviews</a></p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <ul class="trending-address"> -->
<!--                                             <li><i class="ion-ios-location"></i> -->
<!--                                                 <p>1301 Avenue, Brooklyn, NY 11230</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-ios-telephone"></i> -->
<!--                                                 <p>+44 20 7336 8898</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-android-globe"></i> -->
<!--                                                 <p>www.burgerandlobster.com</p> -->
<!--                                             </li> -->
<!--                                         </ul> -->
<!--                                         <div class="trending-bottom mar-top-15 pad-bot-30"> -->
<!--                                             <div class="trend-left float-left"> -->
<!--                                                 <span class="round-bg red"><i class="icofont-tea"></i></span> -->
<!--                                                 <p><a href="#">Eat &amp; Drink</a></p> -->
<!--                                             </div> -->
<!--                                             <div class="trend-right float-right"> -->
<!--                                                 <div class="trend-open mar-top-5"><i class="ion-clock"></i> 10.30 am</div> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="swiper-slide trending-place-item"> -->
<!--                                     <div class="trending-img"> -->
<!--                                         <img src="images/category/event/3.jpg" alt="#"> -->
<!--                                         <span class="trending-rating-pink">6.5</span> -->
<!--                                         <span class="save-btn"><i class="icofont-heart"></i></span> -->
<!--                                     </div> -->
<!--                                     <div class="trending-title-box"> -->
<!--                                         <h4><a href="single-listing-one.html">Bolton music fair </a></h4> -->
<!--                                         <div class="customer-review"> -->
<!--                                             <div class="rating-summary float-left"> -->
<!--                                                 <div class="rating-result" title="60%"> -->
<!--                                                     <ul class="product-rating"> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                     </ul> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                             <div class="review-summury float-right"> -->
<!--                                                 <p><a href="#">3 Reviews</a></p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <ul class="trending-address"> -->
<!--                                             <li><i class="ion-ios-location"></i> -->
<!--                                                 <p>20 Hogh Street, Bolton, France</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-ios-telephone"></i> -->
<!--                                                 <p>+33 20 7336 8898</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-android-globe"></i> -->
<!--                                                 <p>www.bookmusic.com</p> -->
<!--                                             </li> -->
<!--                                         </ul> -->

<!--                                         <div class="trending-bottom mar-top-15 pad-bot-30"> -->
<!--                                             <div class="trend-left float-left"> -->
<!--                                                 <span class="round-bg green"><i class="icofont-music-alt"></i></span> -->
<!--                                                 <p><a href="#">Music</a></p> -->
<!--                                             </div> -->
<!--                                             <div class="trend-right float-right"> -->
<!--                                                 <div class="trend-open mar-top-5"><i class="ion-clock"></i> 5.00 pm</div> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="swiper-slide trending-place-item"> -->
<!--                                     <div class="trending-img"> -->
<!--                                         <img src="images/category/event/sea6.jpg" alt="#"> -->
<!--                                         <span class="trending-rating-green">6.5</span> -->
<!--                                         <span class="save-btn"><i class="icofont-heart"></i></span> -->
<!--                                     </div> -->
<!--                                     <div class="trending-title-box"> -->
<!--                                         <h4><a href="single-listing-one.html">Miami seafood show</a></h4> -->
<!--                                         <div class="customer-review"> -->
<!--                                             <div class="rating-summary float-left"> -->
<!--                                                 <div class="rating-result" title="60%"> -->
<!--                                                     <ul class="product-rating"> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                         <li><i class="ion-android-star-half"></i></li> -->
<!--                                                     </ul> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                             <div class="review-summury float-right"> -->
<!--                                                 <p><a href="#">3 Reviews</a></p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <ul class="trending-address"> -->
<!--                                             <li><i class="ion-ios-location"></i> -->
<!--                                                 <p>400 NW North River Dr, Miami, USA</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-ios-telephone"></i> -->
<!--                                                 <p>+00 20 536 551</p> -->
<!--                                             </li> -->
<!--                                             <li><i class="ion-android-globe"></i> -->
<!--                                                 <p>www.opentable.com</p> -->
<!--                                             </li> -->
<!--                                         </ul> -->
<!--                                         <div class="trending-bottom mar-top-15 pad-bot-30"> -->
<!--                                             <div class="trend-left float-left"> -->
<!--                                                 <span class="round-bg green"><i class="icofont-restaurant"></i></span> -->
<!--                                                 <p><a href="#">Eat &amp; Drink</a></p> -->
<!--                                             </div> -->
<!--                                             <div class="trend-right float-right"> -->
<!--                                                 <div class="trend-right float-right"> -->
<!--                                                     <div class="trend-open mar-top-5"><i class="ion-clock"></i> 9.00 am</div> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
                            </div>
                        </div>
                        <div class="trending-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Trending events ends-->
        <!--Popular Category starts-->
<!--         <div class="popular-catagory pad-bot-50 section-padding"> -->
<!--             <div class="container"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-md-8 offset-md-2 text-center"> -->
<!--                         <h2 class="section-title v1">Explore What To do</h2> -->
<!--                     </div> -->
<!--                     <div class="col-md-4"> -->
<!--                         <a href="#"> -->
<!--                             <div class="popular-catagory-content"> -->

<!--                                 <div class="popular-catagory-img"> -->
<!--                                     <img src="images/category/cat-1.jpg" alt="hotel" class="img_fluid"> -->
<!--                                 </div> -->
<!--                                 <div class="cat-content"> -->
<!--                                     <h4 class="title">Hotel</h4> -->
<!--                                     <span>23 Listings</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                     <div class="col-md-8"> -->
<!--                         <a href="#"> -->
<!--                             <div class="popular-catagory-content"> -->
<!--                                 <div class="popular-catagory-img"> -->
<!--                                     <img src="images/category/cat-2.jpg" alt="hotel" class="img_fluid"> -->
<!--                                 </div> -->
<!--                                 <div class="cat-content"> -->
<!--                                     <h4 class="title">Shopping</h4> -->
<!--                                     <span>15 Listings</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                     <div class="col-md-8"> -->
<!--                         <a href="#"> -->
<!--                             <div class="popular-catagory-content"> -->
<!--                                 <div class="popular-catagory-img"> -->
<!--                                     <img src="images/category/cat-3.jpg" alt="restaurent" class="img_fluid"> -->
<!--                                 </div> -->
<!--                                 <div class="cat-content"> -->
<!--                                     <h4 class="title">Eat &amp; Drink</h4> -->
<!--                                     <span>34 Listings</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                     <div class="col-md-4"> -->
<!--                         <a href="#"> -->
<!--                             <div class="popular-catagory-content"> -->
<!--                                 <div class="popular-catagory-img"> -->
<!--                                     <img src="images/category/cat-4.jpg" alt="hotel" class="img_fluid"> -->
<!--                                 </div> -->
<!--                                 <div class="cat-content"> -->
<!--                                     <h4 class="title">Travel</h4> -->
<!--                                     <span>20 Listings</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        <!--Popular Category ends-->
        <!--Work-process starts-->
<!--         <div class="work-process pad-bot-90 section-padding" style="background-image: url(images/others/dots-bg.svg)"> -->
<!--             <div class="container"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-md-8 offset-md-2 text-center"> -->
<!--                         <h2 class="section-title v1">See How It Works</h2> -->
<!--                     </div> -->
<!--                     <div class="col-md-4"> -->
<!--                         <div class="work-process-content v1 text-center"> -->
<!--                             <div class="process-icon v1"> -->
<!--                                 <img src="images/others/1.png" alt="..."> -->
<!--                                 <span>1</span> -->
<!--                             </div> -->
<!--                             <h4 class="title">Explore The City</h4> -->
<!--                             <p class="info"> -->
<!--                                 Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique iste aliquam possimus, quaerat aut veritatis minima atque quam. Placeat, molestiae? -->
<!--                             </p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-md-4"> -->
<!--                         <div class="work-process-content v1 text-center"> -->
<!--                             <div class="process-icon v1"> -->
<!--                                 <img src="images/others/2.png" alt="..."> -->

<!--                                 <span>2</span> -->

<!--                             </div> -->
<!--                             <h4 class="title">Find The Best Place</h4> -->
<!--                             <p class="info"> -->
<!--                                 Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique iste aliquam possimus, quaerat aut veritatis minima atque quam. Placeat, molestiae? -->
<!--                             </p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-md-4"> -->
<!--                         <div class="work-process-content v1 text-center"> -->
<!--                             <div class="process-icon v1"> -->
<!--                                 <img src="images/others/3.png" alt="..."> -->

<!--                                 <span>3</span> -->
<!--                             </div> -->
<!--                             <h4 class="title">Add Your Listing</h4> -->
<!--                             <p class="info"> -->
<!--                                 Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique iste aliquam possimus, quaerat aut veritatis minima atque quam. Placeat, molestiae? -->
<!--                             </p> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        <!--Work-process ends-->
        <!--Coupon starts-->
<!--         <div class="coupon-section section-padding"> -->
<!--             <div class="container "> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-md-8 offset-md-2 text-center"> -->
<!--                         <h2 class="section-title v1"> Coupons &amp; Deals</h2> -->
<!--                     </div> -->
<!--                     <div class="col-md-12"> -->
<!--                         <div class="swiper-container coupon-wrap"> -->
<!--                             <div class="swiper-wrapper"> -->
<!--                                 <div class="swiper-slide coupon-content"> -->
<!--                                     <div class="row"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-img"> -->
<!--                                                 <img class="img-fluid" src="images/category/coupon/3.jpg" alt="..."> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-desc float-right"> -->
<!--                                                 <h4>30% Discount</h4> -->
<!--                                                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id porta leo.</p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="row align-items-center"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-owner mar-top-20"> -->
<!--                                                 <a href="store.html">Favola Restaurant</a> -->
<!--                                                 <a href="#" class="rating"> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="float-left"> -->
<!--                                                 <a class="btn v1" data-toggle="modal" data-target="#coupon_wrap"> -->
<!--                                                     Get Coupon -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="swiper-slide coupon-content"> -->
<!--                                     <div class="row"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-img"> -->
<!--                                                 <img class="img-fluid" src="images/category/coupon/5.jpg" alt="..."> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-desc float-right"> -->
<!--                                                 <h4>20% Off</h4> -->
<!--                                                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id porta leo.</p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="row align-items-center"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-owner mar-top-20"> -->
<!--                                                 <a href="store.html">Orion Spa</a> -->
<!--                                                 <a href="#" class="rating"> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="float-left"> -->
<!--                                                 <a class="btn v1" data-toggle="modal" data-target="#coupon_wrap"> -->
<!--                                                     Get Coupon -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->

<!--                                 </div> -->
<!--                                 <div class="swiper-slide coupon-content"> -->
<!--                                     <div class="row"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-img"> -->
<!--                                                 <img class="img-fluid" src="images/category/coupon/4.jpg" alt="..."> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-desc float-right"> -->
<!--                                                 <h4>25% Discount</h4> -->
<!--                                                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id porta leo.</p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="row align-items-center"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-owner mar-top-20"> -->
<!--                                                 <a href="store.html">Hotel La Muro</a> -->
<!--                                                 <a href="#" class="rating"> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="float-left"> -->
<!--                                                 <a class="btn v1" data-toggle="modal" data-target="#coupon_wrap"> -->
<!--                                                     Get Coupon -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="swiper-slide coupon-content"> -->
<!--                                     <div class="row"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-img"> -->
<!--                                                 <img class="img-fluid" src="images/category/coupon/1.jpg" alt="..."> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-desc float-right"> -->
<!--                                                 <h4>50% OFF</h4> -->
<!--                                                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean id porta leo.</p> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="row align-items-center"> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="coupon-owner mar-top-20"> -->
<!--                                                 <a href="store.html">Penguin Shop</a> -->
<!--                                                 <a href="#" class="rating"> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                     <i class="ion-android-star-half"></i> -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-md-6"> -->
<!--                                             <div class="float-left"> -->
<!--                                                 <a class="btn v1" data-toggle="modal" data-target="#coupon_wrap"> -->
<!--                                                     Get Coupon -->
<!--                                                 </a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->

<!--                                 </div> -->

<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="slider-btn v1 coupon-next"><i class="ion-arrow-right-c"></i></div> -->
<!--                         <div class="slider-btn v1 coupon-prev"><i class="ion-arrow-left-c"></i></div> -->
<!--                         <div class="modal fade" id="coupon_wrap"> -->
<!--                             <div class="modal-dialog modal-dialog-centered" role="document"> -->
<!--                                 <div class="modal-content"> -->
<!--                                     <div class="modal-header"> -->
<!--                                         <h4 class="modal-title" id="myModalLabel">Get a Coupon</h4> -->
<!--                                         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="ion-ios-close-empty"></i></span></button> -->
<!--                                     </div> -->
<!--                                     <div class="modal-body"> -->
<!--                                         <div class="modal-coupon-code"> -->
<!--                                             <div class="store-content"> -->
<!--                                                 <div class="text"> -->
<!--                                                     Stores : -->
<!--                                                     <span> La Poma ,</span> -->
<!--                                                     <span>Gucci</span> -->
<!--                                                 </div> -->
<!--                                                 <div class="store-content">Cashback : <span>25% cashback </span></div> -->
<!--                                                 <div class="store-content">Valid till : <span>25-5-2019 </span></div> -->
<!--                                                 <div class="cashback-text"> -->
<!--                                                     <p>Cashback will be added in your wallet in next 5 Minute of your purchase.</p> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                             <div class="coupon-code"> -->
<!--                                                 <h5> -->
<!--                                                     Coupon Code: <span class="coupon-code-wrapper"> -->
<!--                                                         <i class="fa fa-scissors"></i> -->
<!--                                                         12345 -->
<!--                                                     </span> -->
<!--                                                 </h5> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="coupon-bottom"> -->
<!--                                         <div class="float-left"><a href="single-listing-one.html" class="btn v1">Go to Deal</a></div> -->
<!--                                         <button type="button" class="btn v1 float-right" data-dismiss="modal">Close</button> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        <!--Coupon ends-->
        <!--Blog Posts starts-->
<!--         <div class="blog-posts v1 pad-bot-60 pad-top-70"> -->
<!--             <div class="container"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-md-8 offset-md-2 text-center"> -->
<!--                         <h2 class="section-title v1">Popular Posts</h2> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-lg-4"> -->
<!--                         <div class="card single-blog-item v1"> -->
<!--                             <img src="images/blog/news_7.jpg" alt="..."> -->
<!--                             <a href="#" class="blog-cat btn v6 red">Hotel</a> -->
<!--                             <div class="card-body"> -->
<!--                                 <h4 class="card-title"><a href="single-news-one.html">Top 10 Homestay in London That you don't miss out</a></h4> -->
<!--                                 <div class="bottom-content"> -->
<!--                                     <p class="date">Sep 28th , 2018 by <a href="#" class="text-dark">Louis Fonsi</a></p> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-lg-4"> -->
<!--                         <div class="card single-blog-item v1"> -->
<!--                             <img src="images/blog/news_8.jpg" alt="..."> -->
<!--                             <a href="#" class="blog-cat btn v6 red">Restaurant</a> -->
<!--                             <div class="card-body"> -->
<!--                                 <h4 class="card-title"><a href="single-news-one.html">Cappuccino Coffee at Broklyn for Coffee Lover.</a></h4> -->
<!--                                 <div class="bottom-content"> -->
<!--                                     <p class="date">Dec 5th , 2018 by <a href="#" class="text-dark">Adam D'Costa</a></p> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-lg-4"> -->
<!--                         <div class="card single-blog-item v1"> -->
<!--                             <img src="images/blog/news_9.jpg" alt="..."> -->
<!--                             <a href="#" class="blog-cat btn v6 red">Travel</a> -->
<!--                             <div class="card-body"> -->
<!--                                 <h4 class="card-title"><a href="single-news-one.html">Top 50 Greatest Street Arts in Paris</a></h4> -->
<!--                                 <div class="bottom-content"> -->
<!--                                     <p class="date">Mar 13th , 2018 by <a href="#" class="text-dark">Mark Henri</a></p> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        <!--Blog Posts ends-->
      <!-- Scroll to top starts-->
        <span class="scrolltotop"><i class="ion-arrow-up-c"></i></span>
        <!-- Scroll to top ends-->
    </div>
    <!--Page Wrapper ends-->
    <!--Footer Starts-->
    <div class="footer-wrapper no-pad-tb v2">
        <div class="footer-top-area section-padding" >
            <div class="container">
                <div class="row nav-folderized">
                    <div class="col-lg-3 col-md-12" >
                        <div class="footer-logo">
                            <!-- <a href="index.html"> <img src="images/f.png" alt="logo"></a> -->
                            <a href="index.html"> <h1>Fun心遊台灣</h1></a>
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
                            <h2 class="title" >聯絡我們</h2>
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
                                        <div class="text"><a href="#">組員個人履歷</a></div>
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
            <a class="color green-theme" title="green"></a>
            <a class="color red-theme" title="red"></a>
            <a class="color blue-theme" title="blue"></a>
            <a class="color orange-theme" title="orange"></a>
            <a class="color pink-theme" title="pink"></a>
            <a class="color purple-theme" title="purple"></a>
            <a class="color violet-theme" title="violet"></a>
            <a class="color aqua-theme" title="aqua"></a>
        </div>
    </div>
    
    <!--Color switcher ends-->
    <!--Scripts starts-->
    <!--plugin js-->
    <script src="<%=request.getContextPath() %>/download/js/plugin.js"></script>
    <!--google maps-->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_8C7p0Ws2gUu7wo0b6pK9Qu7LuzX2iWY&amp;libraries=places&amp;callback=initAutocomplete"></script>
    <!--Main js-->
    <script src="<%=request.getContextPath() %>/download/js/main.js"></script>
    <!--Scripts ends-->
</body>

</html>