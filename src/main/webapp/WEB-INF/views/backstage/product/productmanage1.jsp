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
    <title>行程總覽/所有商品</title>
    
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
                                            <li>所有商品</li>        
                                        </ul>             
                                    </div>
                                </div>
                                <div>
                                	<p><a href="<%=request.getContextPath() %>/MVC/ProductManageController?state=1">•上架中</a>&nbsp&nbsp&nbsp&nbsp<a href="<%=request.getContextPath() %>/MVC/ProductManageController?state=0">•下架中</a></p> 
                                </div>
                                <div>
                                	<form method="post" action="<%=request.getContextPath() %>/MVC/ProductManageController">
                              	   		<input type="number" placeholder="請輸入商品編號" name="productid" style="border-radius: 10px;">
                              	   		<input type="submit" value="搜尋">
                              	   </form>
                              	</div>
                             	   <a class="btn v3" href="<%=request.getContextPath() %>/MVC/AddProduct"><i class="ion-plus-round"></i>新增商品 </a>
                            
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
                            <div class="invoice-panel">
                                <div class="act-title">
                                	<%  List<String> errorMsgsdelete = (List)session.getAttribute("errorMsgsdelete");  %>                          	
                                    <h5>所有商品&nbsp&nbsp&nbsp&nbsp&nbsp <span style="color:red"></span></h5>
                                	<% session.removeAttribute("errorMsgsdelete"); %>
                                </div>                         
                                <div class="invoice-body">
                                    <div class="table-responsive">
                                        <table class="invoice-table">
                                            <thead>
                                                <tr class="invoice-headings">
                                                    <th>商品編號</th>
                                                    <th>商品名稱</th>
                                                    <th>上架狀態</th>
                                                    <th>商品價格(TWD)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            
<%--                                             <c:forEach var="productBean" items="${list}" > --%>
                                            <% 
                                           	
                                            	List<ProductBean> list1 = (List)request.getAttribute("list");
//                                             	ProductBean a = (ProductBean)list1.get(0);
												if(list1==null || list1.size()==0  ){
													out.write("<h5 style='color:red'>查無資料!</h5>");
												}
                                            	if(list1!=null && list1.size()!=0){
                                            	for(int i=0; i < list1.size();i++){ 
                                            %>
                                                <tr>  
                                                    <td> <%=list1.get(i).getProductid() %> </td>
                                                    <td> <%=list1.get(i).getProductname() %></td>
                                                    <td> <span><% if(list1.get(i).getState()==0) {
                                                    			out.write("下架中");
                                            				}else{ 
                                            					out.write("上架中");
                                            				}; %> </span>
<%--                                             			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/MVC/PutonGetoff" > --%>
			     											<% if(list1.get(i).getState()==0) { %>
			     												<button class="puton" onclick='putongo(event)'>上架</button>
			     												<input type="hidden" name="action"	value="puton">
			     											<% }else{ %>
			     												<button class="getoff" onclick='getoff(event)'>下架</button>
			     												<input type="hidden" name="action"	value="getoff">
			     											<% }; %>
			     											<input type="hidden" name="productid"  value="<%=list1.get(i).getProductid() %>">
			     			
<!-- 			     										</FORM>               				 -->
                                            		</td>
                                                    <td> <%=list1.get(i).getProductprice() %> </td>
                                                    <td>
                                                    	<div>
                                                    	<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/ProductManage" >
                                                        	<input type="submit" value="刪除此項商品" onclick="clicked(event)" class="send">
			     											<input type="hidden" name="productid"  value="<%=list1.get(i).getProductid() %>">
			     											<input type="hidden" name="action" value="delete">
                                                        </FORM>
                                                        </div>
                                                        <div style='margin-top: 5px;'>
                                                        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ProductManage" >
			     											<input type="submit" value="修改/查看詳情"  class="send">
			     											<input type="hidden" name="productid"  value="<%=list1.get(i).getProductid() %>">
			     											<input type="hidden" name="action"	value="getOne_For_Update">
			     										</FORM>
			     										</div>	
                                                    </td>
                                                </tr>      
                                                <% } }%>
<%-- 											</c:forEach> --%>
												<script>          
													function clicked(e)
													{
													    if(!confirm('確定刪除?')) {
													        e.preventDefault();
													    }
													}												
												</script>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div>
            <div class="page-num text-center">
            <ul>
													<% Integer totalpage = (Integer)request.getAttribute("totalpage");
														Integer pageaa = Integer.valueOf((String)request.getAttribute("page"));
														for(int i =1; i<= totalpage; i++){
													%>	
													<li onclick='clickin(event)' <% if(i==pageaa){out.write("class='active'");} %>><a href="<%=request.getContextPath() %>/MVC/ManagePageHandler?page=<%=i %>"><%=i %></a></li>
													
													<% } %>
<!-- 													<li><a href="#">2</a></li> -->
<!-- 													<li><a href="#">3</a></li> -->
<!-- 													<li><a href="#">4</a></li> -->
<!-- 													<li><a href="#"><i class="ion-ios-arrow-right"></i></a></li> -->
												</ul>
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
   <script src="vendors/jquery/jquery-3.6.0.min.js"></script>
   <script>
//      	$(document).on('click', '.getoff', function getoff(e){
//             var productid = $(e.target).next().next().val();
//             console.log(productid);
//      		$.ajax({
//                 url: 'http://localhost:7080/TFA105G1-MVC3/StateChange',
//                 type: 'POST',
//                 data: {productid: $(e.target).next().next().val() ,action:$(e.target).val()},
//                 dataType: "html",
//                 success: function(res){
//                     console.log("成功");
//                     $(e.target).parent().html(res);
            
//                 }
//             });    		
//      	});
     	
     	function getoff(e){
//             var productid = $(e.target).next().next().val();
//             console.log(productid);
     		$.ajax({
                url: '<%=request.getContextPath() %>/StateChange',
                type: 'POST',
                data: {
                	productid: $(e.target).next().next().val(),
                	action: 'down'
                },
                dataType: "html",
                success: function(res){
                    console.log("成功");
                    $(e.target).parent().html(res);
            
                }
            });    		
     	}
     	
//      	$(document).on('click', '.putongo', function putongo(e){
//             var productid = $(e.target).next().next().val();
//             console.log(productid);
//      		$.ajax({
//                 url: 'http://localhost:7080/TFA105G1-MVC3/StateChange',
//                 type: 'POST',
//                 data: {
//                 	productid: $(e.target).next().next().val(),
//                 	action: 'up'
//                 },
//                 dataType: "html",
//                 success: function(res){
//                     console.log("成功");
//                     $(e.target).parent().html(res);
                
//                 }
//             });    		
//      	});
     	
     	function putongo(e){
//             var productid = $(e.target).next().next().val();
//             console.log(productid);
     		$.ajax({
                url: '<%=request.getContextPath() %>/StateChange',
                type: 'POST',
                data: {
                	productid: $(e.target).next().next().val() ,
                	action:'up'
                },
                dataType: "html",
                success: function(res){
                    console.log("成功");
                    $(e.target).parent().html(res);
                
                }
            });    		
     	}

     	
     	
     	function clickin(e){
        	e.stopPropagation();
            var a = $(e.target).find('a').attr('href');
            window.location.href = a;
        }       
   </script>
</body>

</html>
