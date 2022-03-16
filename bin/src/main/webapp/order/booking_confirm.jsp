<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="com.order.order.model.* , org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>

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
<link href="css_scuess/plugin.css" rel="stylesheet" />
<!-- style CSS -->
<link href="css_scuess/style.css" rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet" href="css_scuess/switcher/skin-aqua.css"
	media="screen" id="style-colors" />
<!-- Document Title -->
<title>listagram - Directory Listing HTML Template</title>
</head>

<style>
/* .footer-wrapper no-pad-tb v20{ */
/* 	margin-top:600px; */
/* } */
</style>

<body>
	<!--Page Wrapper starts-->
	<div class="page-wrapper fixed-footer">
		<!--header starts-->
		<%@ include file="/download/file/FS_Header.file"%>
		<!--Header ends-->
		<!--Booking confirmation starts-->
		<div class="list-details-section section-padding add_list mar-top-40">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="booking-confirmation-page">
							<i class="ion-android-checkmark-circle"></i>
							<h2 class="margin-top-30">謝謝您的訂購!</h2>
							<p>您可於信箱內查看購買行程的確認信</p>
<!-- 							<FORM METHOD="post" -->
<%-- 								ACTION="<%=request.getContextPath()%>/fsorder.do"> --%>
<!-- 								<input type="submit" value="查看訂單" class="button margin-top-30"> <input -->
<!-- 									type="hidden" name="orderid" -->
<%-- 									value="<%=list.get(i).getOrderid()%>"> <input --%>
<!-- 									type="hidden" name="action" value="getOne_For_Orderdetail"> -->
<!-- 							</FORM> -->
							<a href="<%=request.getContextPath()%>/order/FS-order.jsp" class="button margin-top-30">查看訂單</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Booking confirmation ends-->
		<!-- Scroll to top starts-->
		<span class="scrolltotop"><i class="ion-arrow-up-c"></i></span>
		<!-- Scroll to top ends-->
	</div>
	<!--Page Wrapper ends-->
	<!--Footer Starts-->
	<%@ include file="/download/file/FS_footer.file"%>
	<!--Footer ends-->
	<!--Color switcher starts-->
	<!--     <div class="color-switcher hide-color-switcher"> -->
	<!--         <a class="switcher-button"><i class="ion-android-settings"></i></a> -->
	<!--         <div class="color-switcher-title text-center"> -->
	<!--             <h5>Switch Colors</h5> -->
	<!--         </div> -->
	<!--         <div class="color-list text-center"> -->
	<!--             <a class="color green-theme" title="green"></a> -->
	<!--             <a class="color red-theme" title="red"></a> -->
	<!--             <a class="color blue-theme" title="blue"></a> -->
	<!--             <a class="color orange-theme" title="orange"></a> -->
	<!--             <a class="color pink-theme" title="pink"></a> -->
	<!--             <a class="color purple-theme" title="purple"></a> -->
	<!--             <a class="color violet-theme" title="violet"></a> -->
	<!--             <a class="color aqua-theme" title="aqua"></a> -->
	<!--         </div> -->
	<!--     </div> -->
	<!--Color switcher ends-->
	<!--Scripts starts-->
	<!--plugin js-->
	<script src="js_scuess/plugin.js"></script>
	<!--google maps-->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_8C7p0Ws2gUu7wo0b6pK9Qu7LuzX2iWY&amp;libraries=places&amp;callback=initAutocomplete"></script>
	<!--Main js-->
	<script src="js_scuess/main.js"></script>
	<!--Scripts ends-->
</body>

</html>
