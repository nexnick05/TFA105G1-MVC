<%@page import="com.product.product.model.ProductBean" %>
<%@page import="com.order.travelerlist.model.TravelerlistBean" %>
<%@page import="com.order.orderdetail.model.OrderdetailService" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="com.order.orderdetail.model.OrderdetailBean" %>
<%@page import="org.hibernate.internal.build.AllowSysOut" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.* ,java.sql.*" %>
<%@ page import="com.product.product.*, com.member.model.*,com.order.order.model.*,com.order.orderdetail.model.*, org.hibernate.Session, org.hibernate.SessionFactory, org.hibernate.Transaction " %>
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
	<link href="<%=request.getContextPath()%>/order/css_orderbooking/plugin.css" rel="stylesheet" />
	<!-- style CSS -->
	<link href="<%=request.getContextPath()%>/order/css_orderbooking/style.css" rel="stylesheet" />
	<!--color switcher css-->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/order/css_orderbooking/switcher/skin-aqua.css"
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

	.birthday,
	.numberoftraveler,
	.traveler_id,
	.traveler_last_name,
	.traveler_first_name,
	.traveler_gender {
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

	.pull_right {
		float: right;
		color: #26bec9;
		font-weight: 500;
	}
	
	.pull_right1 {
		float: right;
		color: #737882;
		font-weight: normal;
	}
	

	.price_detail {
		font-size: 16px;
	}

	.cart_detail {
		margin-left: 150px;
		margin-bottom: 20px;
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
		height: inherit;
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

<body onload="clone_form();">
	<!--Preloader starts-->
	<!-- <div class="preloader js-preloader">
        <img src="images/preloader.gif" alt="...">
    </div> -->
	<!--Preloader ends-->
	<!--Page Wrapper starts-->
	<form METHOD="post" ACTION="<%=request.getContextPath()%>/order.do">
		<div class="page-wrapper">
			<!--header starts-->
			<%@ include file="/download/file/FS_Header.file"%>
			<!--Header ends-->
			<!--Hero section starts-->
				
			<div class="buyer_board">
				<div class="txt">訂購人資料</div>
				<div>
								<c:if test="${not empty errorMsgs}">
									<font style="color: red">請修正以下錯誤:</font>
									<ul>
										<c:forEach var="message" items="${errorMsgs}">
											<li style="color: red">${message}</li>
										</c:forEach>
									</ul>
								</c:if>
							</div>
				<hr>
				<div class="row">
					<div class="col-md-4 col-sm-6 col-xs-12">
						<div class="form_group">

							<%
							OrderdetailBean orderdetailBean = (OrderdetailBean)session.getAttribute("travelernumber");
							List<TravelerlistBean> travelerlistBean = (List<TravelerlistBean>)session.getAttribute("traveler");
							MemberVO member = (MemberVO) request.getAttribute("member");
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


							<label>姓氏<span class="require_mark">*</span></label> <br> <input
								type="text" name="memberLastname" class="form_control"
								id="book_last_name" value='${(member==null)? "" : member.lastname }'>
<%-- 								id="book_last_name" value="<%=(member==null)? "" :member.getLastname()%>"> --%>
								
						</div>
						<div class="form_group">
							<label>名字<span class="require_mark">*</span></label> <br> <input
								type="text" name="memberFirstname" class="form_control"
								id="book_first_name" value='${(member==null)? "" : member.firstname}'>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 col-sm-6 col-xs-12">
						<div class="form_group">
							<label>身分證號碼 <span class="require_mark">*</span><br></label>
							<br> <input type="text" name="memberIdno"
								class="form_control" id="book_id" value='${(member==null)? "" : member.idno}'>
						</div>
						<div class="form_group">
							<label>連絡電話<span class="require_mark">*</span><br></label> <br>
							<input value='${(member==null)? "" : member.phone}' type="text" name="memberPhone"
								class="form_control" id="contact_phone">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="email_move">
						<label>電子郵件信箱<span class="require_mark">*</span><br></label>
						<br> <input value='${(member==null)? "" : member.email}' type="email"
							name="memberEmail" class="form_control_email">
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
					productname = (products.get(j).getProductname()).trim();
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

			<div class="traveler_Infor">


				<div class="traveler_board">
					<div class="sub_title_traveler">旅客資料</div>
					<div>
						<img class="pic"
							src="<%=request.getContextPath()%>/ProductImageReader?imgid=<%=imgids.get(i)%> "
							alt="#">
					</div>
					<div class=product_intro>
						<div class="productname1">
							<%=productname%>
						</div>
						<div class=date>
							<div>
								開始日期:
								<%=startdate%>
							</div>
							<div>
								結束日期:
								<%=enddate%>
							</div>
						</div>
					</div>
					<hr>
					<div class="sub_title1">團員人數</div>
					<br> <label style="margin-left: 10px">人數</label><span
						class="require_mark">*</span><br> <select
						style="margin-left: 10px" name="numberoftraveler"
						id="<%=productname%>" class="numberoftraveler <%=productname%>"
						productname="<%=productname%>" 
						value="<%= (orderdetailBean==null)? "xxx" : orderdetailBean.getNumberoftraveler()%>">
<!-- 						<option>請選擇</option> -->
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
					<input type="hidden" id="optionNum" value="<%=(orderdetailBean==null)? 1 :orderdetailBean.getNumberoftraveler()%>"></input>
					</select> <input type="hidden" productname="<%=productname%>"
						value="<%=productprice%>"></input>
						<script type="text/javascript">
								// 移掉了
						</script>
					<div class="tmp">
						<div class="traveler_infor">
							<div class="txt">
								旅客
								<button class="btn_ex" type="button" onclick="clear_info(this);">清空</button>
							</div>
							<div class="same_person">
								<select class="same_traveler" idtarget='0'>
									<option selected>請選擇</option>
									<option value="same">同訂購人資料</option>
								</select>
							</div>

							<div class="form_group">
								<label>出生日期 <span class="require_mark">*</span><br></label>
								<br> <input type="text" name="birthday" class="birthday"
									id="f_date1">
								<div class="tip_text_danger">此欄位必填</div>
							</div>
							<div class="form_group">
								<label style="margin-left: 10px">性別 <span
									class="require_mark">*</span><br></label> <br> <select
									name="gender" class="traveler_gender" id="traveler_gender">
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
									class="traveler_last_name" id="traveler_last_name${i}"
<%-- 									value="<%= (travelerlistBean==null)? "" : travelerlistBean.get().getLastname()%>" --%>
									>
								<div class="tip_text_danger">此欄位必填</div>
							</div>
							<div class="form_group">
								<label>名字</label><span class="require_mark">*</span><br> <input
									type="text" name="firstname" class="traveler_first_name"
									id="traveler_first_name" 
<%-- 									value= "<%= (travelerlistBean==null)? "" : travelerlistBean.getFirstname()%>" --%>
									>
								<div class="tip_text_danger">此欄位必填</div>
							</div>
						</div>
					</div>

					<div class="sub_title">導覽語言</div>
					<div class="form_group">
						<label>行程導覽語言</label><span class="require_mark">*</span><br>
						<select name="language" id="booking_guide_language" class="form_control" >
							<option disabled="disabled" selected>請選擇</option>
							<option value="zh-tw">中文</option>
						</select>
						<div class="tip_text_danger">此欄位必填</div>
					</div>


					<div class="sub_title">特殊需求備註</div>
					<textarea id="booking_note" name="specialneeds"
						class="note_control" maxlength="900" rows="3"
						placeholder="此欄位僅限資料備註。不在商品規範內的個人需求，不保證提供。"></textarea>

				</div>
			</div>
			<%
			}
			%>
			<div class="pay_board">

				<div class="board_card" id="payment_board1">
					<ul class="list">

						<li><a class="link_title" href="#"> ★ 請選擇付款方式
								<button type="button" class="switch_btn">
									<span class="-plus">+</span><span class="-minus">-</span>
								</button>

						</a>
							<div class="inner_block">
								<hr>
								<div class="">
									<input type="radio" class="credit" > <span
										class="chekc_box_title">信用卡/簽帳金融卡</span>
									<hr>
									<div class="form_group2">
										<label class="gray_text3">信用卡號碼</label><br> <input
											type="text" class="card_number" name="credit"
											placeholder="oooo oooo oooo oooo">
									</div>
									<div class="form_group2">
										<label class="gray_text3">有效期限</label><br> <input
											type="text" class="card_number" id="expire_date" name="expire"
											placeholder="MM YY">
									</div>
									<div class="form_group2">
										<label class="gray_text3">背面末3碼</label><br> <input
											type="text" class="card_number" id="back_number" name="CVC"
											placeholder="CVC/CVV">
									</div>
								</div>
							</div></li>

					</ul>
				</div>

				<div class="board_card" id="payment_board2">
					<ul class="list">

						<li><a class="link_title1" href="#"> ★ 電子發票
								<button type="button" class="switch_btn">
									<span class="-plus">+</span><span class="-minus">-</span>
								</button>

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

				<div class="board_card" id="payment_board3">
					<ul class="list">

						<li><a class="link_title2" href="#"> ★ 付款明細
								<button type="button" class="switch_btn">
									<span class="-plus">+</span><span class="-minus">-</span>
								</button>

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
									<div class="<%=productname%>">
										<img class="pic_bottom"
											src="<%=request.getContextPath()%>/ProductImageReader?imgid=<%=imgids.get(i)%> "
											alt="#">
										<div class="cart_detail">
											<div class="product_detail" value="">
												<%=productname%>
												<span class="pull_right1">TWD <%=productprice%></span>
											</div>

											<div class="startdate" name="startdate" value="2021-12-31">
											</div>
											<div class="price_detail">
												<div class="pull_left">
													人數 x
													<p class="numberperson <%=productname%>"></p>
												</div>
												<div>
													<input type="hidden" class="unitprice"
														value="<%=productprice%>"> 總金額<span
														class="pull_right">
														<p class="total <%=productname%>"></p>
													</span>
													<hr>
												</div>

											</div>
										</div>
									</div>


									<!-- 								<tr> -->

									<!-- 									<td>商品名稱:</td> -->
									<!-- 									<td><input class="input_add" type="TEXT" -->
									<%-- name="productname"
																							size="45"
																							value="<%=productname%>" />
																						</td>
																						--%>
									<!-- 								</tr> -->


									<!-- 								<tr> -->
									<!-- 									<td>出發日期:</td> -->
									<!-- 									<td><input class="input_add" name="startdate" type="text" -->
									<!-- 										value="2021-12-31" /></td> -->

									<!-- 								</tr> -->
									<!-- 								<tr> -->
									<!-- 									<td>商品金額:</td> -->
									<!-- 									<td><input class="input_add" type="TEXT" -->
									<%-- name="productprice"
																							size="45"
																							value="<%=productprice%>" />
																						</td>
																						--%>
									<!-- 								</tr> -->

									<input class="input_add" type="hidden" name="productid"
										size="45" value="<%=productBeans.get(i).getProductid()%>" />

									<input class="input_add" type="hidden" name="productprice"
										size="45" value="<%=productBeans.get(i).getProductprice()%>" />

									<input class="input_add" type="hidden" name="imgid" size="45"
										value="<%=imgids.get(i)%>" />



									<%
									}
									%>

								</table>
							</div></li>
					</ul>
				</div>

				<%
				Integer size = productBeans.size();
				%>

			</div>

			<div class="board2" id="payment_board">
				<div class="gray_text2">
					<p class="amount"></p>
					<%=size%>
					件商品合計<span class="amount" name="orderpriceamount" value="0">TWD<%=sum%>
						
					</span> <input type="submit" value="確認付款" class="btn_ex1"> <input
						type="hidden" name="action" value="insert">
				</div>
				<input id="orderpriceamountid" class="input_add" type="hidden" name="orderpriceamount" value="0"
					size="45"  />
			</div>
	</form>
	<!--Color switcher ends-r55555->
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

<% TravelerlistBean travelerlistBean1=new TravelerlistBean(); java.sql.Date birthday=null; try {
	birthday=travelerlistBean1.getBirthday(); } catch (Exception e) { birthday=new
	java.sql.Date(System.currentTimeMillis()); } %>
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

	<script src="<%=request.getContextPath()%>/order/test.js"></script>
	<script>
		$.datetimepicker.setLocale('zh');
		$('.birthday').datetimepicker({
			theme: '',              //theme: 'dark',
			timepicker: false,       //timepicker:true,
			step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
			format: 'Y-m-d',         //format:'Y-m-d H:i:s',
			value: '<%=birthday%> ', // value:   new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			//startDate:	            '2017/07/10',  // 起始日
			//minDate:               '-1970-01-01', // 去除今日(不含)之前
			//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		});

	

		//清除
		function clear_info(e) {
			// console.log(e);
			var father = $(e).closest("div.traveler_infor");
			// father.find("input").val('');
			father.find(".traveler_last_name").val("");
			father.find(".traveler_first_name").val("");
			father.find(".traveler_id").val("");
			father.find(".birthday").val("");
			father.find(".traveler_gender").val("男");
			father.find(".same_traveler").val("請選擇");
			// $(".traveler_last_name").val("");
			// $(".traveler_first_name").val("");
			// $(".traveler_id").val("");
			// $(".birthday").val("");


		}

		
		
		
		
		
		

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

		$("a.link_title").on("click", function (e) {
			e.preventDefault();
			$(this).closest("li").toggleClass("-on");
			$(this).closest("li").find("div.inner_block").slideToggle();
		});

		$("a.link_title1").on("click", function (e) {
			e.preventDefault();
			$(this).closest("li").toggleClass("-on");
			$(this).closest("li").find("div.inner_block1").slideToggle();
		});

		$("a.link_title2").on("click", function (e) {
			e.preventDefault();
			$(this).closest("li").toggleClass("-on");
			$(this).closest("li").find("div.inner_block2").slideToggle();
		});


	</script>

</html>