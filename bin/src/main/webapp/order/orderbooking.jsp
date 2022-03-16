<%@page import="com.product.product.model.ProductBean"%>
<%@page import="com.order.travelerlist.model.TravelerlistBean"%>
<%@page import="com.order.orderdetail.model.OrderdetailService"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.order.orderdetail.model.OrderdetailBean"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.* ,java.sql.*"%>
<%@ page
	import="com.product.product.*, com.member.model.*,com.order.order.model.*,com.order.orderdetail.model.*, org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction "%>
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
<link
	href="<%=request.getContextPath()%>/order/css_orderbooking/plugin.css"
	rel="stylesheet" />
<!-- style CSS -->
<link
	href="<%=request.getContextPath()%>/order/css_orderbooking/style.css"
	rel="stylesheet" />
<!--color switcher css-->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/order/css_orderbooking/switcher/skin-red.css"
	media="screen" id="style-colors" />
<!-- Document Title -->
<!-- <title>listagram - Directory Listing HTML Template</title> -->
<title>Fun心遊台灣 - 開始探索</title>
</head>
<!-- 21, 39, 34, 47-59, 63-128, 132-162, 166-177, 181-192, 197, 221, 228, 232, 283-293, 239, 245, 257 -->
<!-- style.css 1575-1585-->

<style>

.form_control {
	width: 211px;
	height: 44px;
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-top: 2px;
}

.birthday,.numberoftraveler,.traveler_id,.traveler_last_name,.traveler_first_name,.traveler_gender{
	width: 211px;
	height: 44px;
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-top: 2px;

}

.date {
	font-size: 15px;
	font-weight: 400;
	margin-top: 10px;
	color: #737882;
}

.product_intro {
	margin-left: 200px;
	line-height: 1.8;
}

.productname1 {
	font-size: 24px;
	font-weight: bold;
}

.pic {
	height: 120px;
	border-radius: 4px;
	float: left;
}

.pic_bottom {
	height: 80px;
	float: left;
	display: inline;
	border-radius: 4px;
}

.amount {
	font-weight: 700;
}

.board2 {
	margin: 20px auto;
}

.pull_right {
	float: right;
	color: #26bec9;
	font-weight: 500;
}

.price_detail {
	font-size: 16px;
}

.cart_detail {
	margin-left: 150px
}

.product_detail {
	font-size: 16px;
	font-weight: bold;
	color: black;
}

#traveler_gender {
	margin-left: 10px;
}

.btn_primary {
	margin-left: 15px;
}

.buyer_board {
	height: 500px;
}

.traveler_board {
	height: inherit;
}

.traveler_infor {
	height: 480px;
	margin-top: 20px
}

ul.list>li>div.inner_block2 {
	height: inherit;
}

.input_add {
	width: 250px;
	height: 30px;
	padding: 10px 12px;
	border: 1px solid #ccc;
	border-radius: 10px;
}

td {
	padding: 10px;
}

.sub_title1 {
	font-size: large;
	font-weight: bold;
	margin-left: 10px;
	margin-top: 10px;
}

.productname {
	font-size: 24px;
	font-weight: bold;
	margin-left: 10px;
}
</style>

<body>
	<!--Preloader starts-->
	<!-- <div class="preloader js-preloader">
        <img src="images/preloader.gif" alt="...">
    </div> -->
	<!--Preloader ends-->
	<!--Page Wrapper starts-->
	<div class="page-wrapper">
		<!--header starts-->
		<%@ include file="/download/file/FS_Header.file"%>
		<!--Header ends-->
		<!--Hero section starts-->

		<div class="buyer_board">
			<div class="txt">訂購人資料</div>
			<hr>
			<div class="row">
				<div class="col-md-4 col-sm-6 col-xs-12">
					<div class="form_group">

						<%
						MemberVO member = (MemberVO) session.getAttribute("member");
						List<MemberVO> allMember = (List<MemberVO>) session.getAttribute("allMember");
						String lastname = null;
						Integer sum = 0;
						Integer productprice = 0;

						for (int i = 0; i < allMember.size(); i++) {
							if (member.getMemberid() == allMember.get(i).getMemberid()) {
								lastname = allMember.get(i).getLastname();
							}
						}

						String firstname = null;

						for (int i = 0; i < allMember.size(); i++) {
							if (member.getMemberid() == allMember.get(i).getMemberid()) {
								firstname = allMember.get(i).getFirstname();
							}
						}

						String memberid = null;

						for (int i = 0; i < allMember.size(); i++) {
							if (member.getMemberid() == allMember.get(i).getMemberid()) {
								memberid = allMember.get(i).getIdno();
							}
						}

						String phone = null;

						for (int i = 0; i < allMember.size(); i++) {
							if (member.getMemberid() == allMember.get(i).getMemberid()) {
								phone = allMember.get(i).getPhone();
							}
						}

						String email = null;

						for (int i = 0; i < allMember.size(); i++) {
							if (member.getMemberid() == allMember.get(i).getMemberid()) {
								email = allMember.get(i).getEmail();
							}
						}
						%>
						<%-- 						<form id="register-form" action="<%=request.getContextPath()%>/memberUpdate.do" method="post"> --%>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/order.do">
							<label>姓氏<span class="require_mark">*</span></label> <br> <input
								type="text" name="memberLastname" class="form_control"
								id="book_last_name" value="<%=lastname%>">
					</div>
					<div class="form_group">
						<label>名字<span class="require_mark">*</span></label> <br> <input
							type="text" name="memberFirstname" class="form_control"
							id="book_first_name" value="<%=firstname%>">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4 col-sm-6 col-xs-12">
					<div class="form_group">
						<label>身分證號碼 <span class="require_mark">*</span><br></label>
						<br> <input type="text" name="memberIdno"
							class="form_control" id="book_id" value="<%=memberid%>">
					</div>
					<div class="form_group">
						<label>連絡電話<span class="require_mark">*</span><br></label> <br>
						<input value="<%=phone%>" type="text" name="memberPhone"
							class="form_control" id="contact_phone">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="email_move">
					<label>電子郵件信箱<span class="require_mark">*</span><br></label> <br>
					<input value="<%=email%>" type="email" name="memberEmail"
						class="form_control_email">
					<div class="tip_text_danger">請輸入正確的Email的格式！</div>
				</div>

			</div>
			<div class="update_member">
				<input type="checkbox" id="update_member_id"> 同時更新會員資料
			</div>
			<!-- 				<div> -->
			<!-- 					<input type="submit" -->
			<!-- 						value="更新" class="btn_primary"> <input type="hidden" -->
			<!-- 						name="action" value="update"> -->
			<!-- 				</div>  -->
			<!-- 				</form> -->
		</div>




		<%
		List<ProductBean> productBeans = (List<ProductBean>) session.getAttribute("products");
		List<ProductBean> products = (List<ProductBean>) session.getAttribute("allProducts");
		List<Integer> imgids = (List<Integer>) session.getAttribute("imgids");
		%>

		<%
		for (int i = 0; i < productBeans.size(); i++) {
		%>

		<%
		String productname = null;
		for (int j = 0; j < products.size(); j++) {
			if (productBeans.get(i).getProductid() == products.get(j).getProductid()) {
				productname = products.get(j).getProductname();
			}
		}
		%>

		<%
		java.sql.Date startdate = null;
		for (int j = 0; j < products.size(); j++) {
			if (productBeans.get(i).getProductid() == products.get(j).getProductid()) {
				startdate = products.get(j).getStartdate();
			}
		}
		%>

		<%
		java.sql.Date enddate = null;
		for (int j = 0; j < products.size(); j++) {
			if (productBeans.get(i).getProductid() == products.get(j).getProductid()) {
				enddate = products.get(j).getEnddate();
			}
		}
		%>

		<div id="traveler_Infor">
			<div class="sub_title_traveler">旅客資料</div>

			<div class="traveler_board">
				<div>
					<img class="pic"
						src="<%=request.getContextPath()%>/ProductImageReader?imgid=<%=imgids.get(i)%> "
						alt="#">
				</div>
				<div class=product_intro>
					<div class="productname1"><%=productname%></div>
					<div class=date>
						<div>
							開始日期:
							<%=startdate%></div>
						<div>
							結束日期:
							<%=enddate%></div>
					</div>
				</div>
				<hr>
				<div class="sub_title1">團員人數</div>
				<br> <label style="margin-left: 10px">人數</label><span
					class="require_mark">*</span><br> <select
					style="margin-left: 10px" name="numberoftraveler" id="numberoftraveler"
					class="numberoftraveler">
					<!-- 							<option disabled="disabled" selected>請選擇</option> -->
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>

				</select>
				
				<div class="tmp"></div>

				<div class="sub_title">導覽語言</div>
				<div class="form_group">
					<label>行程導覽語言</label><span class="require_mark">*</span><br> <select
						name="" id="booking_guide_language" class="form_control">
						<option disabled="disabled" selected>請選擇</option>
						<option value="zh-tw">中文</option>
					</select>
					<div class="tip_text_danger">此欄位必填</div>
				</div>

				<!-- 				<div class="sub_title">緊急聯絡人</div> -->
				<!-- 				<div class="urgent_board"> -->
				<!-- 					<div class="form_group"> -->
				<!-- 						<label>聯絡人姓</label><span class="require_mark">*</span><br>  -->
				<!-- 						<input type="text" name="urgent_last_name" class="form_control"> -->
				<!-- 						<div class="tip_text_danger">此欄位必填</div> -->
				<!-- 					</div> -->
				<!-- 					<div class="form_group"> -->
				<!-- 						<label>聯絡人名</label><span class="require_mark">*</span><br> -->
				<!-- 						<input -->
				<!-- 							type="text" name="urgent_first_name" class="form_control"> -->
				<!-- 						<div class="tip_text_danger">此欄位必填</div> -->
				<!-- 					</div> -->
				<!-- 					<div class="form_group"> -->
				<!-- 						<label>連絡電話</label><span class="require_mark">*</span><br> -->
				<!-- 						 <input type="text" name="urgent_phone" class="form_control" -->
				<!-- 							id="urgent_phone"> -->
				<!-- 						<div class="tip_text_danger">此欄位必填</div> -->
				<!-- 					</div> -->
				<!-- 				</div> -->

				<div class="sub_title">特殊需求備註</div>
				<textarea id="booking_note" name="specialneeds" class="note_control"
					maxlength="900" rows="3"
					placeholder="此欄位僅限資料備註。不在商品規範內的個人需求，不保證提供。"></textarea>

			</div>
		</div>
		<%
		}
		%>

		<div>
			<div class="sub_title_traveler">付款</div>
			<div class="board_card" id="payment_board">
				<ul class="list">

					<li><a class="link_title" href="#">
							<button type="button" class="switch_btn">
								<span class="-plus">+</span><span class="-minus">-</span>
							</button> ★ 請選擇付款方式
					</a>
						<div class="inner_block">
							<hr>
							<div class="">
								<input type="radio" class="credit"> <span
									class="chekc_box_title">信用卡/簽帳金融卡</span>
								<hr>
								<div class="form_group2">
									<label class="gray_text3">信用卡號碼</label><br> <input
										type="text" class="card_number"
										placeholder="oooo oooo oooo oooo">
								</div>
								<div class="form_group2">
									<label class="gray_text3">有效期限</label><br> <input
										type="text" class="card_number" id="expire_date"
										placeholder="MM YY">
								</div>
								<div class="form_group2">
									<label class="gray_text3">背面末3碼</label><br> <input
										type="text" class="card_number" id="back_number"
										placeholder="CVC/CVV">
								</div>
							</div>
						</div></li>

				</ul>
			</div>

			<div class="board_card" id="payment_board">
				<ul class="list">

					<li><a class="link_title1" href="#">
							<button type="button" class="switch_btn">
								<span class="-plus">+</span><span class="-minus">-</span>
							</button> ★ 電子發票
					</a>
						<div class="inner_block1">
							<hr>
							<span class="chekc_box_title">旅行業代收轉付電子收據</span><br> <select
								name="" id="receipt_id" class="form_control1">
								<option disabled="disabled" selected>請選擇</option>
								<option value="zh-tw">寄至訂購人E-mail</option>
							</select>
						</div></li>

				</ul>
			</div>

			<div class="board_card" id="payment_board">
				<ul class="list">

					<li><a class="link_title2" href="#">
							<button type="button" class="switch_btn">
								<span class="-plus">+</span><span class="-minus">-</span>
							</button> ★ 付款明細
					</a>
						<div class="inner_block2">

							<table>

								<%
								for (int i = 0; i < productBeans.size(); i++) {

									String productname = null;
									for (int j = 0; j < products.size(); j++) {
										if (productBeans.get(i).getProductid() == products.get(j).getProductid()) {
									productname = products.get(j).getProductname();
										}
									}

									for (int k = 0; k < products.size(); k++) {
										if (productBeans.get(i).getProductid() == products.get(k).getProductid()) {
									productprice = products.get(k).getProductprice();
										}
									}
									sum += productprice;
								%>
								<div>
									<img class="pic_bottom"
										src="<%=request.getContextPath()%>/ProductImageReader?imgid=<%=imgids.get(i)%> "
										alt="#">
									<div class="cart_detail">
										<div class="product_detail" value=""><%=productname%></div>
										<div class="startdate" name="startdate" value="2021-12-31"></div>
										<div class="price_detail">
											<div class="pull_left">人數 x</div>
											<div>
												總金額<span class="pull_right">TWD <%=productprice%>
												</span>
											</div>
											<hr>
										</div>
									</div>
								</div>


								<!-- 								<tr> -->

								<!-- 									<td>商品名稱:</td> -->
								<!-- 									<td><input class="input_add" type="TEXT" -->
								<%-- 										name="productname" size="45" value="<%=productname%>" /></td> --%>
								<!-- 								</tr> -->


								<!-- 								<tr> -->
								<!-- 									<td>出發日期:</td> -->
								<!-- 									<td><input class="input_add" name="startdate" type="text" -->
								<!-- 										value="2021-12-31" /></td> -->

								<!-- 								</tr> -->
								<!-- 								<tr> -->
								<!-- 									<td>商品金額:</td> -->
								<!-- 									<td><input class="input_add" type="TEXT" -->
								<%-- 										name="productprice" size="45" value="<%=productprice%>" /></td> --%>
								<!-- 								</tr> -->

								<input class="input_add" type="hidden" name="productid"
									size="45" value="<%=productBeans.get(i).getProductid()%>" />

								<input class="input_add" type="hidden" name="productprice"
									size="45" value="<%=productBeans.get(i).getProductprice()%>" />
								
									<input class="input_add" type="hidden" name="imgid"
									size="45" value="<%=imgids.get(i)%>" />	

							

								<%
								}
								%>

							</table>
						</div></li>
				</ul>
				<hr>
			</div>

			<%
			Integer size = productBeans.size();
			%>



			<div class="board2" id="payment_board">
				<div class="gray_text2">
					<%=size%>件商品合計<span class="amount" name="orderpriceamount" value="<%=sum%>">TWD<%=sum%></span> <input
						type="submit" value="確認付款" class="btn_ex1"> <input
						type="hidden" name="action" value="insert">
				</div>
					<input class="input_add" type="hidden" name="orderpriceamount"
									size="45" value="<%=sum%>" />
			</div>

			</FORM>
		</div>
	</div>
	<!--Color switcher ends-->
	<!--Scripts starts-->
	<!--plugin js-->
	<script
		src="<%=request.getContextPath()%>/order/js_orderbooking/plugin.js"></script>
	<!--google maps-->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_8C7p0Ws2gUu7wo0b6pK9Qu7LuzX2iWY&amp;libraries=places&amp;callback=initAutocomplete"></script>
	<!--Main js-->

	<!--Scripts ends-->
</body>

<%
TravelerlistBean travelerlistBean = new TravelerlistBean();
java.sql.Date birthday = null;
try {
	birthday = travelerlistBean.getBirthday();
} catch (Exception e) {
	birthday = new java.sql.Date(System.currentTimeMillis());
}
%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>


<script>
$.datetimepicker.setLocale('zh');
$('#f_date1').datetimepicker({
   theme: '',              //theme: 'dark',
   timepicker:false,       //timepicker:true,
   step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
   format:'Y-m-d',         //format:'Y-m-d H:i:s',
   value: '<%=birthday%> ', // value:   new Date(),
//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//startDate:	            '2017/07/10',  // 起始日
//minDate:               '-1970-01-01', // 去除今日(不含)之前
//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
});



 
//  $('.numberoftraveler').on('change', function () {
//     var numberoftraveler = $(this).val();
//     var e = $('.traveler_infor');
// //     e.not(':first').remove();
//     for (var i = 1; i < numberoftraveler; i++) {
//         e.first().clone().insertAfter(e);
//     }
    
// //     if(numberoftraveler>1){
// //     	$("#represent").val("");
// //     }

// }).trigger('change');

$('.numberoftraveler').on('change', function () {
    var numberoftraveler = $(this).val();
	var tmp = $(this).next("div.tmp");
	tmp.empty();
	var html = `<div class="traveler_infor">
					<div class="txt">
						旅客
						<button class="btn_ex" type="button" onclick="clear_info(this);">清空</button>
					</div>
					<div class="same_person">
						<select class="same_traveler">
							<option disabled="disabled" selected>請選擇</option>
							<option value="same">同訂購人資料</option>
						</select>
					</div>

					<div class="form_group">
						<label>出生日期 <span class="require_mark">*</span><br></label> <br>
						<input type="text" name="birthday" class="birthday"
							id="f_date1">
						<div class="tip_text_danger">此欄位必填</div>
					</div>
					<div class="form_group">
						<label style="margin-left: 10px">性別 <span
							class="require_mark">*</span><br></label> <br> <select
							name="gender" class="traveler_gender" id="traveler_gender">
							<!-- 							<option disabled="disabled" selected>請選擇</option> -->
							<option value="男">男生</option>
							<option value="女">女生</option>
						</select>
						<div class="tip_text_danger">此欄位必填</div>
					</div>
					<div class="form_group">
						<label>證件號碼(護照/身分證) <span class="require_mark">*</span><br></label>
						<br> <input type="text" name="idno" class="traveler_id"
							id="traveler_id">
						<div class="tip_text_danger">此欄位必填</div>
					</div>
					<div class="form_group">
						<label style="margin-left: 10px">姓氏<span
							class="require_mark">*</span><br></label> <br> <input
							style="margin-left: 10px" type="text" name="lastname"
							class="traveler_last_name" id="traveler_last_name">
						<div class="tip_text_danger">此欄位必填</div>
					</div>
					<div class="form_group">
						<label>名字</label><span class="require_mark">*</span><br> <input
							type="text" name="firstname" class="traveler_first_name"
							id="traveler_first_name">
						<div class="tip_text_danger">此欄位必填</div>
					</div>
</div>`;
    for (var i = 0; i < numberoftraveler; i++) {
        tmp.prepend(html);
    }
}).trigger('change');



		//同訂購人資料
	    $(".same_traveler").on("change", function () {
	        var book_last_name = $("#book_last_name").val();
	        var book_first_name = $("#book_first_name").val();
	        var book_id = $("#book_id").val();

	        // console.log(this)

	        if (($("#traveler_last_name").val()) == "") {
	            $("#traveler_last_name").val(book_last_name);
	        }


	        if (($("#traveler_first_name").val()) == "") {
	            $("#traveler_first_name").val(book_first_name);
	        }

	        if (($("#traveler_id").val()) == "") {
	            $("#traveler_id").val(book_id);
	        }
	    })

	    //清除
	    function clear_info (e){
			console.log(e);
			var father = $(e).closest("div.traveler_infor");
			father.find("input").val('');
	    	// $(".traveler_last_name").val("");
	        // $(".traveler_first_name").val("");
	        // $(".traveler_id").val("");
	        // $(".birthday").val("");
			
	        father.find(".traveler_gender").val("請選擇");
	        father.find(".same_traveler").val("請選擇");
		}

// 	    $(".btn_ex").on("click", function () {
// 	        $(".traveler_last_name").val("");
// 	        $(".traveler_first_name").val("");
// 	        $(".traveler_id").val("");
// 	        $(".birthday").val("");
			
// 	        $(".traveler_gender").val("請選擇");
// 	        $(".same_traveler").val("請選擇");
// // 	        $(".form_control").val("");

// 	    })

	    //電話號碼數字綁定
	    $("#contact_phone").on("keydown", function (e) {
	        if ((e.which >= 48 && e.which <= 57) || e.which == 8) {
	            // console.log(e.which)    
	        } else {
	            e.preventDefault();
	        }
	    });

	    $("#urgent_phone").on("keydown", function (e) {
	        if ((e.which >= 48 && e.which <= 57) || e.which == 8) {
	            // console.log(e.which)

	        } else {
	            e.preventDefault();
	        }
	    });

	    $("#traveler_birthday").on("keydown", function (e) {
	        if ((e.which >= 48 && e.which <= 57) || e.which == 8) {
	            // console.log(e.which)    
	            if (e.target.value.length <= 7 || e.which == 8) {

	            } else {
	                e.preventDefault();
	            }
	        } else {
	            e.preventDefault();
	        }
	    });


	    //信用卡16碼
	    $(".card_number").on("keydown", function (e) {
	        //console.log(e.which);
	        if ((e.which >= 48 && e.which <= 57) || e.which == 8) {

	            //console.log(e.target.value.length);

	            if (e.target.value.length <= 18 || e.which == 8) {
	            } else {
	                e.preventDefault();
	            }

	        } else {
	            e.preventDefault();
	        }



	    });

	    $(".card_number").on("keyup", function (e) {

	        var value = $(this).val().replace(/\s/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
	        $(this).val(value);

	        // let str = e.target.value;
	       

	        //   let str = (e.target.value).replace(/\D/g, "");
	     
	        // if (str.length == 4) {
	        //     $(this).prepend();
	        // }
	    });

	    //信用卡有效期限
	    $("#expire_date").on("keydown", function (e) {
	        //console.log(e.which);
	        if ((e.which >= 48 && e.which <= 57) || e.which == 8) {

	            //console.log(e.target.value.length);

	            if (e.target.value.length <= 4 || e.which == 8) {
	            } else {
	                e.preventDefault();
	            }

	        } else {
	            e.preventDefault();
	        }

	    });

	    $("#expire_date").on("keyup", function (e) {

	        var value = $(this).val().replace(/\s/g, '').replace(/(\d{2})(?=\d)/g, "$1 ");
	        $(this).val(value)

	    });

	    //信用卡CVC

	    $("#back_number").on("keydown", function (e) {
	        //console.log(e.which);
	        if ((e.which >= 48 && e.which <= 57) || e.which == 8) {

	            //console.log(e.target.value.length);

	            if (e.target.value.length <= 2 || e.which == 8) {
	            } else {
	                e.preventDefault();
	            }

	        } else {
	            e.preventDefault();
	        }
	    });

	    $("#back_number").on("keyup", function (e) {

	        var value = $(this).val().replace(/\s/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
	        $(this).val(value)

	    });

	    $("a.link_title").on("click", function(e){
	        e.preventDefault();
	        $(this).closest("li").toggleClass("-on");
	        $(this).closest("li").find("div.inner_block").slideToggle();
	      });

	      $("a.link_title1").on("click", function(e){
	        e.preventDefault();
	        $(this).closest("li").toggleClass("-on");
	        $(this).closest("li").find("div.inner_block1").slideToggle();
	      });

	      $("a.link_title2").on("click", function(e){
	        e.preventDefault();
	        $(this).closest("li").toggleClass("-on");
	        $(this).closest("li").find("div.inner_block2").slideToggle();
	      });

	      //錯誤訊息
	      $("#book_last_name").on("blur",function(){
	          if(($("#book_last_name").val()) == ""){
	              $("#tip_text_danger_first").addClass("-on")

	          }else{
	            $("#tip_text_danger_first").removeClass("-on")
	          }
	      })

	      $("#book_first_name").on("blur",function(){
	        if(($("#book_first_name").val()) == ""){
	            $("#tip_text_danger_last").addClass("-on")

	        }else{
	          $("#tip_text_danger_last").removeClass("-on")
	        }
	    })

	    //   $(".form_control").on("blur",function(){
	    //     if(($(".form_control").val()) == ""){
	    //         $(".tip_text_danger").addClass("-on")

	    //     }else{
	    //       $(".tip_text_danger").removeClass("-on")
	    //     }
	    // })




	    /*----------------------------------------
	                        Preloader
	    ------------------------------------------*/
	    $('.js-preloader').preloadinator({
	        minTime: 2000,
	        scroll: false

	    });
	    /* ----------------------------------------
	           datepicker
	    ------------------------------------------- */
	    $("#datepicker-from").datepicker({
	        autoclose: true,
	        todayHighlight: true
	    });
	    $("#datepicker-to").datepicker({
	        autoclose: true,
	        todayHighlight: true
	    });

	    /*----------------------------------------
	          Scroll to top
	  ----------------------------------------*/
	    function BackToTop() {

	        $('.scrolltotop').on('click', function () {
	            $('html, body').animate({
	                scrollTop: 0
	            }, 800);
	            return false;
	        });

	        $(document).scroll(function () {
	            var y = $(this).scrollTop();
	            if (y > 600) {
	                $('.scrolltotop').fadeIn();
	            } else {
	                $('.scrolltotop').fadeOut();
	            }
	        });

	    }
	    BackToTop();

	    /*-------------------------------------------------*/
	    /*    scroll between sections
	    /*-------------------------------------------------*/

	    // Add scrollspy to <body>
	    $('body').scrollspy({
	        target: ".list_menu",
	        offset: 50
	    });

	    // Add smooth scrolling on all links inside the navbar
	    $("#list-menu a").on('click', function (event) {
	        if (this.hash !== "") {
	            event.preventDefault();

	            var hash = this.hash;


	            $('html, body').animate({
	                scrollTop: $(hash).offset().top
	            }, 800, function () {

	                // Add hash (#) to URL when done scrolling (default click behavior)
	                window.location.hash = hash;
	            });
	        } // End if
	    });

	    $('.list-details-tab li').on('click', (function () {
	        $('li').removeClass("active");
	        $(this).addClass("active");
	    }));


	    /* ----------------------------------------
	          Hide Show Header on Scroll
	    ------------------------------------------ */
	    function HideShowHeader() {

	        var didScroll;
	        var lastScrollTop = 0;
	        var delta = 50;
	        var navbarHeight = 75;
	        var navbarHideAfter = navbarHeight

	        $(window).scroll(function (event) {
	            didScroll = true;
	        });

	        if ($('.scroll-hide').length > 0) {

	            setInterval(function () {
	                if (didScroll) {
	                    hasScrolled();
	                    didScroll = false;
	                }
	            }, 100);
	        }
	        return false;

	        function hasScrolled() {
	            var st = $(this).scrollTop();

	            if (Math.abs(lastScrollTop - st) <= delta)
	                return;

	            if (st > lastScrollTop && st > navbarHideAfter) {
	                if ($('.scroll-hide').length > 0) {
	                    $('header').addClass('hide');
	                }
	            } else {
	                if ($('.scroll-hide').length > 0) {
	                    if (st + $(window).height() < $(document).height()) {
	                        $('header').removeClass('hide');
	                        $('.header.transparent').addClass('scroll');
	                    }
	                }

	                if ($(window).scrollTop() < 300) {
	                    $('.header.transparent').removeClass('scroll');
	                }
	            }

	            lastScrollTop = st;
	        }
	    }
	    HideShowHeader();

	    /*------------------------------------------
	          sticky single listing menu
	    -------------------------------------------*/
	    $(window).on('load resize', function () {
	        var containerWidth = $(".container").width();
	        $('.fixed_nav').css('width', containerWidth);
	    });
	    $(window).scroll(function () {
	        if ($(window).scrollTop() >= 700) {
	            $('.list_menu').addClass('fixed-header');
	        } else {
	            $('.list_menu').removeClass('fixed-header');
	        }
	    });
	    /* ----------------------------------------
	           CounteUp
	    ------------------------------------------*/
	    $('.counter-value').countUp({
	        'time': 2500,
	        'delay': 10
	    });
	    /*-------------------------------------------
	            Count Down Timer
	    ---------------------------------------------*/
	    $('[data-countdown]').each(function () {
	        var $this = $(this),
	            finalDate = $(this).data('countdown');
	        $this.countdown(finalDate, function (event) {
	            $this.html(event.strftime('<span class="cdown day"><span class="time-count">%-D</span> <p>Days</p></span> <span class="cdown hour"><span class="time-count">%-H</span> <p>Hours</p></span> <span class="cdown minutes"><span class="time-count">%M</span> <p>mins</p></span> <span class="cdown second"><span class="time-count">%S</span> <p>secs</p></span>'));
	        });
	    });

	    /*--------------------------------------------
	                       Video Player
	     --------------------------------------------*/
	    $(".player").mb_YTPlayer({
	        containment: '#video-wrapper',
	        mute: true,
	        autoplay: true,
	        showControls: false,
	        quality: 'hd720'
	    });

	    /* -----------------------------------------
	                    Google Map
	    -------------------------------------------*/
	    /* if ($('#map').length > 0) {
	         google.maps.event.addDomListener(window, 'load', init);
	 
	         function init() {
	             // Basic options for a simple Google Map
	             // For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
	             var mapOptions = {
	                 // How zoomed in you want the map to start at (always required)
	                 zoom: 15,
	 
	                 // The latitude and longitude to center the map (always required)
	                 center: new google.maps.LatLng(40.6700, -73.9400), // New York
	 
	                 scrollwheel: false,
	 
	 
	                 // How you would like to style the map.
	                 // This is where you would paste any style found on Snazzy Maps.
	                 styles: [{
	                             "featureType": "administrative",
	                             "elementType": "geometry",
	                             "stylers": [{
	                                 "visibility": "off"
	                             }]
	                         },
	                         {
	                             "featureType": "administrative.land_parcel",
	                             "elementType": "labels",
	                             "stylers": [{
	                                 "visibility": "off"
	                             }]
	                         },
	                         {
	                             "featureType": "poi",
	                             "stylers": [{
	                                 "visibility": "off"
	                             }]
	                         },
	                         {
	                             "featureType": "road",
	                             "elementType": "labels.icon",
	                             "stylers": [{
	                                 "visibility": "off"
	                             }]
	                         },
	                         {
	                             "featureType": "road.local",
	                             "elementType": "labels",
	                             "stylers": [{
	                                 "visibility": "off"
	                             }]
	                         },
	                         {
	                             "featureType": "transit",
	                             "stylers": [{
	                                 "visibility": "off"
	                             }]
	                         }]
	             };
	 
	             // Get the HTML DOM element that will contain your map
	             // We are using a div with id="map" seen below in the <body>
	             var mapElement = document.getElementById('map');
	 
	             // Create the Google Map using our element and options defined above
	             var map = new google.maps.Map(mapElement, mapOptions);
	 
	             var image = 'images/others/marker.png';
	             // Let's also add a marker while we're at it
	             var marker = new google.maps.Marker({
	                 position: new google.maps.LatLng(40.6700, -73.9400),
	                 map: map,
	                 icon: image,
	                 draggable: true,
	                 animation: google.maps.Animation.DROP
	             });
	             marker.addListener('click', toggleBounce);
	 
	             function toggleBounce() {
	                 if (marker.getAnimation() !== null) {
	                     marker.setAnimation(null);
	                 } else {
	                     marker.setAnimation(google.maps.Animation.BOUNCE);
	                 }
	             }
	         }
	     }*/
	    // Intialize Map

	    jQuery(document).ready(function ($) {
	        "use strict";

	        /*------------------------------------
	                Color Switcher
	        --------------------------------------*/

	        // Show and hide color-switcher
	        $(".color-switcher .switcher-button").on('click', function () {
	            $(".color-switcher").toggleClass("show-color-switcher", "hide-color-switcher", 300);
	        });

	        // Color Skins
	        $('a.color').on('click', function () {
	            var title = $(this).attr('title');
	            $('#style-colors').attr('href', 'css/switcher/skin-' + title + '.css');
	            return false;
	        });
	        /* -------------------------------------
	              Footer Accordion
	        -------------------------------------- */
	        $(".nav-folderized h2").on('click', (function () {
	            $(this).parent(".nav").toggleClass("open");
	            $('html, body').animate({
	                scrollTop: $(this).offset().top - 170
	            }, 1500);
	        }));
	        /* -------------------------------------
	                Header tab
	        -------------------------------------- */
	        var listButton = $('.hero__list-item a');

	        listButton.on('click', function (event) {
	            event.preventDefault();

	            listButton.removeClass('active-list');
	            $(this).addClass('active-list');

	            var $this = $(this);

	            if (!$this.hasClass('place')) {
	                $this.parents('.hero')
	                    .addClass('hero-events')
	                    .find('.places-tab')
	                    .fadeOut(500, function () {
	                        $this.parents('.hero')
	                            .find('.events-tab')
	                            .fadeIn(500);
	                    });

	            } else {
	                $this.parents('.hero')
	                    .removeClass('hero-events')
	                    .find('.events-tab')
	                    .fadeOut(500, function () {
	                        $this.parents('.hero')
	                            .find('.places-tab')
	                            .fadeIn(500);
	                    });
	            }
	        });

	        /* -------------------------------------
	                Responsive menu
	        -------------------------------------- */
	        var siteMenuClone = function () {

	            $('.js-clone-nav').each(function () {
	                var $this = $(this);
	                $this.clone().attr('class', 'site-nav-wrap').appendTo('.site-mobile-menu-body');
	            });

	            setTimeout(function () {

	                var counter = 0;
	                $('.site-mobile-menu .has-children').each(function () {
	                    var $this = $(this);

	                    $this.prepend('<span class="arrow-collapse collapsed">');

	                    $this.find('.arrow-collapse').attr({
	                        'data-toggle': 'collapse',
	                        'data-target': '#collapseItem' + counter,
	                    });

	                    $this.find('> ul').attr({
	                        'class': 'collapse',
	                        'id': 'collapseItem' + counter,
	                    });

	                    counter++;

	                });

	            }, 1000);

	            $('body').on('click', '.js-menu-toggle', function (e) {
	                var $this = $(this);
	                e.preventDefault();

	                if ($('body').hasClass('offcanvas-menu')) {
	                    $('body').removeClass('offcanvas-menu');
	                    $this.removeClass('active');
	                } else {
	                    $('body').addClass('offcanvas-menu');
	                    $this.addClass('active');
	                }
	            })

	        };
	        siteMenuClone();

	        /*-------------------------------------------------
	                    rating stars in reviews 
	        /*-------------------------------------------------*/

	        var rateLine = $('.contact-form__rate-bx'),
	            rateActual = $('.rate-actual');

	        rateLine.find('i').on('hover', function () {
	            var indexStar = $(this).index();
	            for (var j = 0; j <= 9; j++) {
	                rateLine.find('i:lt(' + indexStar + 1 + ')').addClass('active');
	                rateLine.find('i:gt(' + indexStar + ')').removeClass('active');
	            }
	        });

	        rateLine.find('i').on('click', function () {
	            var indexStar = $(this).index();
	            for (var j = 0; j <= 9; j++) {
	                rateLine.find('i:lt(' + indexStar + 1 + ')').addClass('selected');
	                rateLine.find('i:gt(' + indexStar + ')').removeClass('selected');
	            }
	            rateActual.text(indexStar + 1);
	        });

	        rateLine.on('mouseout', function () {
	            rateLine.find('i').removeClass('active');
	        });

	        /* -------------------------------------
	                price range slider
	        -------------------------------------- */

	        $("#slider-range").slider({
	            range: true,
	            min: 0,
	            max: 200,
	            values: [0, 70],
	            slide: function (event, ui) {
	                $("#amount").val(ui.values[0] + "-" + ui.values[1] + " km");
	            }
	        });
	        $(" #amount").val($("#slider-range").slider("values", 0) +
	            " - " + $("#slider-range").slider("values", 1) + " km");
	        /* -------------------------------------
	                 Category menu Activation
	        -------------------------------------- */
	        $('.filter-sub-menu li.has-sub > a').on('click', function () {
	            $(this).removeAttr('href');
	            var element = $(this).parent('li');
	            if (element.hasClass('open')) {
	                element.removeClass('open');
	                element.find('li').removeClass('open');
	                element.find('ul').slideUp();
	            } else {
	                element.addClass('open');
	                element.children('ul').slideDown();
	                element.siblings('li').children('ul').slideUp();
	                element.siblings('li').removeClass('open');
	                element.siblings('li').find('li').removeClass('open');
	                element.siblings('li').find('ul').slideUp();
	            }
	        });

	        /* -------------------------------------
	                   Slider
	        -------------------------------------- */
	        //Hero-slider
	        var swiper_1 = new Swiper('.hero-slider', {
	            slidesPerView: 1,
	            spaceBetween: 0,
	            loop: true,
	            speed: 1000,
	            autoplay: {
	                delay: 4000,
	                disableOnInteraction: false,
	            },
	            navigation: {
	                nextEl: '.hero-next',
	                prevEl: '.hero-prev',
	            },
	            // Responsive breakpoints
	            breakpoints: {

	                767: {
	                    slidesPerView: 1,
	                    spaceBetween: 30
	                },
	            }
	        });
	        //Trending place slider
	        var swiper_2 = new Swiper('.trending-place-wrap', {
	            slidesPerView: 3,
	            spaceBetween: 30,
	            slidesPerGroup: 3,
	            speed: 1500,
	            loop: true,
	            pagination: {
	                el: '.trending-pagination',
	                clickable: true,
	            },
	            // Responsive breakpoints
	            breakpoints: {
	                767: {
	                    slidesPerView: 1,
	                    slidesPerGroup: 1,
	                    spaceBetween: 10
	                },
	                1024: {
	                    slidesPerView: 2,
	                    spaceBetween: 30
	                }
	            }
	        });
	        //Similar Listing Slider
	        var swiper_3 = new Swiper('.similar-list-wrap', {
	            slidesPerView: 2,
	            spaceBetween: 30,
	            loop: true,
	            speed: 1000,
	            navigation: {
	                nextEl: '.similar-next',
	                prevEl: '.similar-prev',
	            },
	            // Responsive breakpoints
	            breakpoints: {

	                767: {
	                    slidesPerView: 1,
	                    spaceBetween: 30
	                },
	            }
	        });
	        //Popular place slider one
	        var swiper = new Swiper('.popular-place-wrap', {
	            slidesPerView: 4,
	            spaceBetween: 20,
	            loop: true,
	            speed: 1000,
	            navigation: {
	                nextEl: '.popular-next',
	                prevEl: '.popular-prev',
	            },
	            // Responsive breakpoints
	            breakpoints: {

	                767: {
	                    slidesPerView: 1,
	                },
	                991: {
	                    slidesPerView: 2,
	                    spaceBetween: 30
	                },
	                1200: {
	                    slidesPerView: 3,
	                    spaceBetween: 30
	                }
	            }
	        });
	        //Popular place slider Two
	        var swiper_4 = new Swiper('.popular-place-wrap.v2', {
	            slidesPerView: 3,
	            spaceBetween: 30,
	            loop: true,
	            speed: 1000,
	            navigation: {
	                nextEl: '.popular-next.style2',
	                prevEl: '.popular-prev.style2',
	            },
	            // Responsive breakpoints
	            breakpoints: {

	                767: {
	                    slidesPerView: 1,
	                },
	                991: {
	                    slidesPerView: 2,
	                    spaceBetween: 30
	                }
	            }
	        });
	        //Coupon Slider
	        var swiper_5 = new Swiper('.coupon-wrap', {
	            slidesPerView: 2,
	            spaceBetween: 20,
	            loop: false,
	            speed: 1000,
	            navigation: {
	                nextEl: '.coupon-next',
	                prevEl: '.coupon-prev',
	            },
	            // Responsive breakpoints
	            breakpoints: {
	                991: {
	                    slidesPerView: 1,
	                },
	                1200: {
	                    slidesPerView: 2,
	                }
	            }
	        });
	        //Partner slider
	        var swiper_6 = new Swiper('.partner-wrap', {
	            slidesPerView: 5,
	            spaceBetween: 30,
	            loop: true,
	            speed: 1000,
	            navigation: {
	                nextEl: '.partner-next',
	                prevEl: '.partner-prev',
	            },
	            // Responsive breakpoints
	            breakpoints: {

	                575: {
	                    slidesPerView: 2,
	                    spaceBetween: 30
	                },
	                767: {
	                    slidesPerView: 3,
	                    spaceBetween: 30
	                },
	                991: {
	                    slidesPerView: 4,
	                    spaceBetween: 30
	                }
	            }
	        });
	        //Testimonial slider
	        var swiper_7 = new Swiper('.testimonial-wrapper', {
	            slidesPerView: 3,
	            loop: true,
	            speed: 1000,
	            autoplay: {
	                delay: 3000,
	                disableOnInteraction: false,
	            },
	            centeredSlides: true,
	            pagination: {
	                el: '.client-pagination',
	                clickable: true,
	            },
	            // Responsive breakpoints
	            breakpoints: {

	                991: {
	                    slidesPerView: 1,
	                }
	            }
	        });

	        //Team Slider
	        var swiper_8 = new Swiper('.team-wrapper', {
	            slidesPerView: 4,
	            loop: true,
	            speed: 1000,
	            spaceBetween: 30,
	            navigation: {
	                nextEl: '.team-next',
	                prevEl: '.team-prev',
	            },
	            // Responsive breakpoints
	            breakpoints: {
	                480: {
	                    slidesPerView: 1,
	                },
	                991: {
	                    slidesPerView: 2,
	                    spaceBetween: 30
	                },
	                1024: {
	                    slidesPerView: 3,
	                    spaceBetween: 30
	                }
	            }
	        });
	        //Listing details carousel
	        var swiper_9 = new Swiper('.listing-details-slider', {
	            slidesPerView: 2,
	            spaceBetween: 0,
	            loop: true,
	            speed: 1000,
	            navigation: {
	                nextEl: '.listing-details-next',
	                prevEl: '.listing-details-prev',
	            },
	            autoplay: {
	                delay: 3000,
	                disableOnInteraction: false,
	            },
	            breakpoints: {

	                767: {
	                    slidesPerView: 1,
	                    spaceBetween: 15,
	                }
	            }
	        });

	        /*---------------------------------
	                Date Picker
	        ------------------------------------*/
	        if ($("./*counter*/-widget").length > 0) {
	            var countCurrent = $(".counter-widget").attr("data-countDate");
	            $(".countdown").downCount({
	                date: countCurrent,
	                offset: 0
	            });
	        }

	    });

	    /*---------------------------------
	               Nice select
	    -----------------------------------*/
	    // $('select').niceSelect();

	    /*-------------------------------------
	              Quantity Slider
	     -------------------------------------*/
	    var quantitiy = 0;
	    $('.quantity-right-plus').on("click", function (e) {
	        e.preventDefault();
	        var quantity = parseInt($(this).parent().siblings("input.input-number").val(), 10);
	        $(this).parent().siblings("input.input-number").val(quantity + 1);
	    });
	    $('.quantity-left-minus').on("click", function (e) {
	        e.preventDefault();
	        var quantity = parseInt($(this).parent().siblings("input.input-number").val(), 10);
	        if (quantity > 0) {
	            $(this).parent().siblings("input.input-number").val(quantity - 1);
	        }
	    });


</script>
</html>