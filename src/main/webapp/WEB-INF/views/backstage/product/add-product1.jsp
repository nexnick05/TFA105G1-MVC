<%@page import="org.hibernate.internal.build.AllowSysOut"%>

<%@page import="com.product.product.model.ProductBean"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, org.springframework.context.ApplicationContext, org.springframework.web.context.WebApplicationContext"%>
<%@ page import="com.product.product.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

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
    <!-- <title>listagram - Directory Listing HTML Template</title> -->
    <title>行程總覽/新增商品</title>

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
		
		.picture_list{
			width:400px
		
		}
	</style>



</head>

<body>
    <div class="page-wrapper">

        <!--Sidebar Menu Starts-->
        <%@include file="/download/file/BS_Sidebar Menu.file"%>
        
        <!--Sidebar Menu ends-->

        <!--Dashboard content Wrapper starts-->
        <div class="dash-content-wrap">

            <!-- Top header starts-->
            <%@include file="/download/file/BS_Top header.file"%>
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
                                            <li class="active"><a href="<%=request.getContextPath() %>/MVC/ProductManageController">行程總覽</a></li>
                                            <li class="active">新增商品</li>
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
                        <form action="<%=request.getContextPath() %>/ProductManage" method="post" enctype="multipart/form-data" >
                        <div class="col-md-12">
                            <div class="db-add-list-wrap">
                                <div class="act-title">
                                <%  List<String> errorMsgs = (List)session.getAttribute("errorMsgsadd");  %>
                                    <h5><i class="ion-ios-information"></i> 請輸入商品資訊 :&nbsp&nbsp&nbsp&nbsp&nbsp 
                                    <span style="color:red">
                                    	<% if(errorMsgs!=null){
                                    		for(int i =0; i < errorMsgs.size(); i++){
                                    			out.write(errorMsgs.get(i)+",    ");
                                    		}
                                    	} %> 
                                    </span></h5>
                                    <% session.removeAttribute("errorMsgsadd"); %>
                                </div>
                                <div class="db-add-listing">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                            
                                            <% ProductBean bean = (ProductBean)session.getAttribute("ProductBean"); %>>
                                                <label>商品名稱</label>                                             <!-- Hotel Ocean paradise-->
                                                <input type="text" class="form-control filter-input" placeholder="" name="productname" value="<%= (bean==null)? "" : bean.getProductname()%>">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group" >
                                                <label>商品分類</label>
                                                <!--  下面div原本的屬性 class="nice-select filter-input" tabindex="0"-->
                                                <div ><span class="current">請選擇商品分類:</span>
                                                    <!-- <ul class="list">
                                                        <li class="option selected focus">一日遊</li>
                                                        <li class="option">多日遊</li>
                                                        <li class="option">包車</li>
                                                        <li class="option">熱門票卷</li>
                                                        <li class="option">獨特體驗</li> -->
                                                        <!-- <li class="option">Fitness</li> -->
                                                    <!-- </ul> -->
                                                    <select name="producttype" class="col-md-4" >
                                                    <% String[] x = {"一日遊", "多日遊", "包車", "熱門票卷", "獨特體驗"}; %>
                                                    <%   for(int i =0; i<x.length; i++) { %>
                                                       <% out.write( "<option " ); 
                                                       	  if(bean!=null){
	                                                       	  if(x[i].equals(bean.getProducttype())){
	                                                       		out.write( "selected" );
	                                                       	  }   
                                                       	  }
                                                       	  out.write(">" + x[i] +"</option>");
                                                       %> 
<!--                                                        <option>一日遊</option> -->
<!--                                                         <option>多日遊</option> -->
<!--                                                         <option>包車</option> -->
<!--                                                         <option>熱門票卷</option> -->
<!--                                                         <option>獨特體驗</option> -->
                                                    <% }; %>
                                        
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>商品價格</label>                                <!-- Keywords should be separated by commas-->
                                                <input type="text" class="form-control filter-input" placeholder="請輸入數字(台幣) 例如:999" name="productprice" value="<%= (bean==null)? "" : bean.getProductprice()%>">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>最少成團人數</label>
                                                <input type="text" class="form-control filter-input" placeholder="請輸入數字 例如:4" name="memberrequired" value="<%= (bean==null)? "" : bean.getMemberrequired()%>">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <!-- <form> -->
                                                <div class="form-group">
                                                    <label for="list_info">商品說明(請至少輸入50字)</label>
                                                    <textarea class="form-control" id="list_info" rows="4" placeholder="" name="productintro"><%= (bean==null)? "" : bean.getProductintro()%></textarea>
                                                </div>
                                            <!-- </form> -->
                                        </div>

                                        <div class="col-md-12">
                                            <!-- <form> -->
                                                <div class="form-group">
                                                    <label for="list_info">注意事項</label>
                                                    <textarea class="form-control" id="list_info" rows="4" placeholder="" name="attention"><%= (bean==null)? "" : bean.getAttention()%></textarea>
                                                </div>
                                            <!-- </form> -->
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>商品地區</label>
                                                <div class="filter-checkbox">
                                             		<% String[] str = (String[])session.getAttribute("cityid");%>
                                             		
                                             		<% if(str!=null) {%>
                                                    <input id="check-a" type="checkbox" name="cityid" value="1" <% if(Arrays.binarySearch(str, "1") >= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-a">台北市</label>
                                                    <input id="check-b" type="checkbox" name="cityid" value="2" <% if(Arrays.binarySearch(str, "2")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-b">新北市</label>
                                                    <input id="check-c" type="checkbox" name="cityid" value="3" <% if(Arrays.binarySearch(str, "3")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-c">台中市</label>
                                                    <input id="check-d" type="checkbox" name="cityid" value="4" <% if(Arrays.binarySearch(str, "4")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-d">高雄市</label>
                                                    <input id="check-f" type="checkbox" name="cityid" value="5" <% if(Arrays.binarySearch(str, "5")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-f">台東市</label>
                                                    <input id="check-e" type="checkbox" name="cityid" value="6" <% if(Arrays.binarySearch(str, "6")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-e">花蓮縣</label>
                                                    <input id="check-g" type="checkbox" name="cityid" value="7" <% if(Arrays.binarySearch(str, "7")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-g">彰化縣 </label>
                                                    <input id="check-h" type="checkbox" name="cityid" value="8" <% if(Arrays.binarySearch(str, "8")>= 0){ out.write("checked='checked'");   } %>>
                                                    <label for="check-h">台南市 </label>
                                                    <% } else { %>
                                                    	<input id="check-a" type="checkbox" name="cityid" value="1">
                                                        <label for="check-a">台北市</label>
                                                        <input id="check-b" type="checkbox" name="cityid" value="2">
                                                        <label for="check-b">新北市</label>
                                                        <input id="check-c" type="checkbox" name="cityid" value="3">
                                                        <label for="check-c">台中市</label>
                                                        <input id="check-d" type="checkbox" name="cityid" value="4">
                                                        <label for="check-d">高雄市</label>
                                                        <input id="check-f" type="checkbox" name="cityid" value="5">
                                                        <label for="check-f">台東市</label>
                                                        <input id="check-e" type="checkbox" name="cityid" value="6">
                                                        <label for="check-e">花蓮縣</label>
                                                        <input id="check-g" type="checkbox" name="cityid" value="7">
                                                        <label for="check-g">彰化縣 </label>
                                                        <input id="check-h" type="checkbox" name="cityid" value="8">
                                                        <label for="check-h">台南市 </label>
                                                    	
                                                    	
                                                    	
                                                    <%} %>
                                                    <% session.removeAttribute("cityid");%>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>開始日</label>
                                                    <input type=date autocomplete="false" class="form-control" name="startdate" placeholder="請輸入日期格式: yyyy-MM-dd" value="<%= (bean==null)? "" : bean.getStartdate()%>">
                                                </div>	
											
                                                <div class="col-md-6">
                                                    <label>結束日</label>
                                                    <input type="date" autocomplete="false" class="form-control" name="enddate" placeholder="請輸入日期格式: yyyy-MM-dd" value="<%= (bean==null)? "" : bean.getEnddate()%>">                         
                                                </div>
                                             
                                                <div class="col-md-6">
                                                    <label>旅行時數</label>
                                                    <input type="text" class="form-control filter-input" name="traveltime" placeholder="請輸入小時 例如: 18.5" value="<%= (bean==null)? "" : bean.getTraveltime()%>">
                                                </div>
                                                <!-- <div class="col-md-4">
                                                    <a href="#" class="btn v7 mar-top-20">Add Facts</a>
                                                </div> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="db-add-list-wrap">
                                <div class="act-title">
                                    <h5><i class="ion-image"></i> 商品圖片(請至少上傳一張圖片) :</h5>
                                </div>
									<div>
										<ul class="picture_list"></ul>
										<ul class="picture_list"></ul>
										<ul class="picture_list"></ul>
										<ul class="picture_list"></ul>
										<ul class="picture_list"></ul>
									</div>
									<div class="db-add-listing">
                                    <div class="form-group">
                                        <!-- <form class="photo-upload"> -->
                                            <div class="form-group">
                                                <div class="add-listing__input-file-box">
                                                    <input  type="file" name="file" id="file1" >
                                                    <input  type="file" name="file" id="file2" >
                                                    <input  type="file" name="file" id="file3" >
                                                    <input  type="file" name="file" id="file4" >
                                                    <input  type="file" name="file" id="file5" >
                                                    <!-- <div class="add-listing__input-file-wrap">
                                                        <i class="ion-ios-cloud-upload"></i>
                                                        <p>Click here to upload your images</p>
                                                    </div> -->
                                                </div>
<!--                                                 <div> -->
<!--                                                 	<ul class="picture_list"></ul> -->
<!--                                                 	<ul class="picture_list"></ul> -->
<!--                                                 	<ul class="picture_list"></ul> -->
<!--                                                 	<ul class="picture_list"></ul> -->
<!--                                                 	<ul class="picture_list"></ul> -->
<!--                                                 </div> -->
                                            </div>
                                        <!-- </form> -->

                                    </div>
                                    <!-- <div class="add-btn">
                                        <button type="submit" class="btn v8 mar-top-20">新增商品</button>
                                    </div> -->
                                </div>

                            </div>
                            
                            <div class="add-btn">
                                <input type="hidden" name="action"	value="insert">
                                <input type="submit" value="新增商品" class='send' onclick='clicked(event)'>
                                <script>          
													function clicked(e)
													{
													    if(!confirm('確定新增?')) {
													        e.preventDefault();
													    }
													}												
								</script>
<!--                                 <button type="submit" class="btn v8 mar-top-20">新增商品</button> -->
                            </div>
                        </form>
 
                            <!-- <div class="db-add-list-wrap">
                                <div class="act-title">
                                    <h5><i class="ion-ios-location"></i> Location/Contacts :</h5>
                                </div>
                                <div class="db-add-listing">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Select City</label>
                                                <div class="nice-select filter-input" tabindex="0"><span class="current">Select City</span>
                                                    <ul class="list">
                                                        <li class="option selected focus">New York</li>
                                                        <li class="option">Chicago</li>
                                                        <li class="option">Las Vegas</li>
                                                        <li class="option">Los Angeles</li>
                                                        <li class="option">Austin</li>
                                                        <li class="option">Downturn</li>
                                                        <li class="option">DownturnSan Diago</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Address</label>
                                                <input type="text" class="form-control filter-input" placeholder="ex. 250, Fifth Avenue...">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>State</label>
                                                <input type="text" class="form-control filter-input" placeholder="ex. New York">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Zip Code</label>
                                                <input type="text" class="form-control filter-input" placeholder="ex. 5858">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Longitude (Drag marker on the map)</label>
                                                <input type="text" class="form-control filter-input" placeholder="Map Longitude">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    Latitude (Drag marker on the map) </label>
                                                <input type="text" class="form-control filter-input" placeholder="Map Latitude">
                                            </div>
                                        </div>
                                        <div class="col-md-12 no-padding">
                                            <div id="map"></div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mar-top-15">
                                                <label>Website </label>
                                                <input type="text" class="form-control filter-input">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mar-top-15">
                                                <label>Phone </label>
                                                <input type="text" class="form-control filter-input">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="db-add-list-wrap">
                                <div class="act-title">
                                    <h5><i class="ion-ios-location"></i> Rooms/Pricing :</h5>
                                </div>
                                <div class="db-add-listing">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Room Title</label>
                                                <input type="text" class="form-control filter-input" placeholder="Standard family Room">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Capacity</label>
                                                <input type="text" class="form-control filter-input" placeholder="2 persons">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Price</label>
                                                <input type="text" class="form-control filter-input" placeholder="$180">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Room Details</label>
                                                <input type="text" class="form-control filter-input" placeholder="Total for 1 room, 2 nights">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <form class="photo-upload">
                                                    <div class="form-group">
                                                        <div class="add-listing__input-file-box">
                                                            <input class="add-listing__input-file" type="file" name="file" id="file">
                                                            <div class="add-listing__input-file-wrap">
                                                                <i class="ion-ios-cloud-upload"></i>
                                                                <p>Click here to upload your images</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <a href="#" class="btn v8 mar-top-15">Add Images</a>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Features</label>
                                                <div class="filter-checkbox">
                                                    <input id="check-m" type="checkbox" name="check">
                                                    <label for="check-m">Tv inside</label>
                                                    <input id="check-n" type="checkbox" name="check">
                                                    <label for="check-n">Air Conditioned</label>
                                                    <input id="check-o" type="checkbox" name="check">
                                                    <label for="check-o">Free Wi Fi</label>
                                                    <input id="check-p" type="checkbox" name="check">
                                                    <label for="check-p">Breakfast</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Title</label>
                                                    <input type="text" class="form-control filter-input" placeholder="Title">
                                                </div>
                                                <div class="col-md-4">
                                                    <label>Number</label>
                                                    <input type="text" class="form-control filter-input" placeholder="Number">
                                                </div>
                                                <div class="col-md-4">
                                                    <label>Icon</label>
                                                    <input type="text" class="form-control filter-input" placeholder="Icon">
                                                </div>
                                                <div class="col-md-4">
                                                    <a href="#" class="btn v8 mar-top-20">Add Facts</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="db-add-list-wrap">
                                <div class="act-title">
                                    <h5><i class="ion-clock"></i> Opening/Business Hours :</h5>
                                </div>
                                <div class="db-add-listing">
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Monday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Tuesday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Wednesday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Thursday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Friday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Saturday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-md-2">
                                            <label class="fix_spacing">Sunday</label>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="nice-select filter-input" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h4><i class="ion-clock"></i> Event Date :</h4>
                                        </div>
                                    </div>
                                    <div class="row mar-bot-30">
                                        <div class="col-sm-4 col-12">
                                            <div id="datepicker-from" class="input-group date" data-date-format="dd-mm-yyyy">
                                                <input class="form-control" type="text" placeholder="Select date">
                                                <span class="input-group-addon"><i class="icofont-ui-calendar"></i></span>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-4 col-12">
                                            <div class="nice-select filter-input mt-0" tabindex="0"><span class="current">Opening Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 col-12">
                                            <div class="nice-select filter-input mt-0" tabindex="0"><span class="current">Closing Time</span>
                                                <ul class="list">
                                                    <li class="option selected focus">7.00 am</li>
                                                    <li class="option">8.00 am</li>
                                                    <li class="option">9.00 am</li>
                                                    <li class="option">10.00 am</li>
                                                    <li class="option">11.00 am</li>
                                                    <li class="option">12.00 am</li>
                                                    <li class="option">1.00 pm</li>
                                                    <li class="option">2.00 pm</li>
                                                    <li class="option">3.00 pm</li>
                                                    <li class="option">4.00 pm</li>
                                                    <li class="option">5.00 pm</li>
                                                    <li class="option">6.00 pm</li>
                                                    <li class="option">7.00 pm</li>
                                                    <li class="option">8.00 pm</li>
                                                    <li class="option">9.00 pm</li>
                                                    <li class="option">10.00 pm</li>
                                                    <li class="option">11.00 pm</li>
                                                    <li class="option">12.00 pm</li>
                                                    <li class="option">00.00 am</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="db-add-list-wrap">
                                <div class="act-title">
                                    <h5><i class="icofont-ui-social-link"></i>Social Networks:</h5>
                                </div>
                                <div class="db-add-listing">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Facebook link (Optional)</label>
                                                <input type="text" class="form-control filter-input" placeholder="Facebook url">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Pinterest (Optional)</label>
                                                <input type="text" class="form-control filter-input" placeholder="Pinterest url">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Twitter link (Optional)</label>
                                                <input type="text" class="form-control filter-input" placeholder="Twitter url">
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-left">
                                            <div class="res-box mar-top-10">
                                                <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                                <label for="remember">I've read and accept <a href="terms.html">terms &amp; conditions</a></label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-right sm-left">
                                            <button class="btn v8" type="submit">Preview</button>
                                            <button class="btn v8" type="submit">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
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
    <script>
    window.addEventListener("load", function(){
    		
    	  var the_file_element = document.getElementById("file1");
    	  the_file_element.addEventListener("change", function(e){          

    	    // 寫在這
    	    var picture_list = document.getElementsByClassName("picture_list")[0];
    	    picture_list.innerHTML = ""; // 清空
    	    
    	    // 跑每個使用者選的檔案，留意 i 的部份
    	    for (let i = 0; i < this.files.length; i++) {
    	      let reader = new FileReader(); // 用來讀取檔案
    	      reader.readAsDataURL(this.files[i]); // 讀取檔案
    	      reader.addEventListener("load", function () {
    	        console.log(reader.result);
    	        let li_html = 
    	                "<li><img src="+ reader.result   +" ></li>"
    	              ;
    	        picture_list.insertAdjacentHTML("beforeend", li_html); // 加進節點
    	      });
    	    }

    	  });
    	  
    	  
    	  
    	  var the_file_element2 = document.getElementById("file2");
    	  the_file_element2.addEventListener("change", function(e){          

    	    // 寫在這
    	    var picture_list2 = document.getElementsByClassName("picture_list")[1];
    	    picture_list2.innerHTML = ""; // 清空
    	    
    	    // 跑每個使用者選的檔案，留意 i 的部份
    	    for (let i = 0; i < this.files.length; i++) {
    	      let reader = new FileReader(); // 用來讀取檔案
    	      reader.readAsDataURL(this.files[i]); // 讀取檔案
    	      reader.addEventListener("load", function () {
    	        console.log(reader.result);
    	        let li_html = 
    	                "<li><img src="+ reader.result   +" ></li>"
    	              ;
    	        picture_list2.insertAdjacentHTML("beforeend", li_html); // 加進節點
    	      });
    	    }

    	  });
    	  
    	  
    	  var the_file_element3 = document.getElementById("file3");
    	  the_file_element3.addEventListener("change", function(e){          

    	    // 寫在這
    	    var picture_list3 = document.getElementsByClassName("picture_list")[2];
    	    picture_list3.innerHTML = ""; // 清空
    	    
    	    // 跑每個使用者選的檔案，留意 i 的部份
    	    for (let i = 0; i < this.files.length; i++) {
    	      let reader = new FileReader(); // 用來讀取檔案
    	      reader.readAsDataURL(this.files[i]); // 讀取檔案
    	      reader.addEventListener("load", function () {
    	        console.log(reader.result);
    	        let li_html = 
    	                "<li><img src="+ reader.result   +" ></li>"
    	              ;
    	        picture_list3.insertAdjacentHTML("beforeend", li_html); // 加進節點
    	      });
    	    }

    	  });
    	  
    	  
    	  var the_file_element4 = document.getElementById("file4");
    	  the_file_element4.addEventListener("change", function(e){          

    	    // 寫在這
    	    var picture_list4 = document.getElementsByClassName("picture_list")[3];
    	    picture_list4.innerHTML = ""; // 清空
    	    
    	    // 跑每個使用者選的檔案，留意 i 的部份
    	    for (let i = 0; i < this.files.length; i++) {
    	      let reader = new FileReader(); // 用來讀取檔案
    	      reader.readAsDataURL(this.files[i]); // 讀取檔案
    	      reader.addEventListener("load", function () {
    	        console.log(reader.result);
    	        let li_html = 
    	                "<li><img src="+ reader.result   +" ></li>"
    	              ;
    	        picture_list4.insertAdjacentHTML("beforeend", li_html); // 加進節點
    	      });
    	    }

    	  });
    	  
    	  
    	  var the_file_element5 = document.getElementById("file5");
    	  the_file_element5.addEventListener("change", function(e){          

    	    // 寫在這
    	    var picture_list5 = document.getElementsByClassName("picture_list")[4];
    	    picture_list5.innerHTML = ""; // 清空
    	    
    	    // 跑每個使用者選的檔案，留意 i 的部份
    	    for (let i = 0; i < this.files.length; i++) {
    	      let reader = new FileReader(); // 用來讀取檔案
    	      reader.readAsDataURL(this.files[i]); // 讀取檔案
    	      reader.addEventListener("load", function () {
    	        console.log(reader.result);
    	        let li_html = 
    	                "<li><img src="+ reader.result   +" ></li>"
    	              ;
    	        picture_list5.insertAdjacentHTML("beforeend", li_html); // 加進節點
    	      });
    	    }

    	  });
    	  
    
    });
    
    
    
    
    </script>
</body>

</html>
