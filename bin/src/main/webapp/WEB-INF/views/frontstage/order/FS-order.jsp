<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

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
    <title>listagram - Directory Listing HTML Template</title>

</head>

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
                                        <li class="active"><a href="#">Home</a></li>
                                        <li class="active"><a href="#">Dashboard</a></li>
                                        <li>訂單管理</li>
                                    </ul>
                                </div>
                            </div>
                            <a class="btn v3" href="add-listing.html"><i class="ion-plus-round"></i>Add Listing </a>
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
                                <h5><i class="ion-social-buffer-outline"></i> 訂單管理</h5>
                            </div>

                            <div class="viewd-item-wrap">
                                <div class="most-viewed-item">
                                    <div class="most-viewed-img">
                                        <a href="#"><img src="images/single-listing/gallery-6.jpg" alt="..."></a>
                                    </div>
                                    <div class="most-viewed-detail">
                                        <a class="category" href="#"><span class="list-bg aqua"><i class="icofont-hotel"></i></span>Hotel</a>
                                        <h3><a href="#">Four Seasons Resort</a></h3>
                                        <p class="list-address"><i class="icofont-google-map"></i>4210 Khale Street, Florence, USA</p>

                                        <div class="ratings">
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star-half"></i>
                                        </div>
                                        <div class="views">Views : <span>325</span></div>
                                    </div>
                                    <div class="listing-button">
                                        <a href="#" class="btn v5"><i class="ion-android-delete"></i>細項</a>
                                    </div>
                                </div>
                                <div class="most-viewed-item">
                                    <div class="most-viewed-img">
                                        <a href="#"><img src="images/single-listing/restaurant-2.jpg" alt="..."></a>
                                    </div>
                                    <div class="most-viewed-detail">
                                        <a class="category" href="#"><span class="list-bg red"><i class="icofont-hotel"></i></span>Restaurent</a>
                                        <h3><a href="#">La Quo Vadis</a></h3>
                                        <p class="list-address"><i class="icofont-google-map"></i>42 Albemarle st. Mayfair,London</p>

                                        <div class="ratings">
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star-half"></i>
                                        </div>
                                        <div class="views">Views : <span>325</span></div>
                                    </div>
                                    <div class="listing-button">
                                        <a href="#" class="btn v5"><i class="ion-android-delete"></i> Delete</a>
                                    </div>
                                </div>
                                <div class="most-viewed-item">
                                    <div class="most-viewed-img">
                                        <a href="#"><img src="images/category/event/muay.jpg" alt="..."></a>
                                    </div>
                                    <div class="most-viewed-detail">
                                        <a class="category" href="#"><span class="list-bg violate"><i class="icofont-movie"></i></span>Movie</a>
                                        <h3><a href="#">Muay Thai Live Show</a></h3>
                                        <p class="list-address"><i class="icofont-google-map"></i>1690 Brown Avenue,Barline</p>

                                        <div class="ratings">
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star-half"></i>
                                        </div>
                                        <div class="views">Views : <span>325</span></div>
                                    </div>
                                    <div class="listing-button">
                                        <a href="#" class="btn v5"><i class="ion-android-delete"></i> Delete</a>
                                    </div>
                                </div>
                                <div class="most-viewed-item">
                                    <div class="most-viewed-img">
                                        <a href="#"><img src="images/category/event/3.jpg" alt="..."></a>
                                    </div>
                                    <div class="most-viewed-detail">
                                        <a class="category" href="#"><span class="list-bg aqua"><i class="icofont-music-alt"></i></span>Music</a>
                                        <h3><a href="#">Bolton music fair </a></h3>
                                        <p class="list-address"><i class="icofont-google-map"></i>20 Hogh Street, Bolton, France</p>

                                        <div class="ratings">
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star"></i>
                                            <i class="ion-ios-star-half"></i>
                                        </div>
                                        <div class="views">Views : <span>325</span></div>
                                    </div>
                                    <div class="listing-button">
                                        <a href="#" class="btn v5"><i class="ion-android-delete"></i> Delete</a>
                                    </div>
                                </div>
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
    <script src="js/plugin.js"></script>
    <!--Perfect Scrollbar JS-->
    <script src="js/perfect-scrollbar.min.js"></script>
    <!-- Main JS-->
    <script src="js/main.js"></script>
    <!-- Dashboard JS-->
    <script src="js/dashboard.js"></script>
</body>

</html>