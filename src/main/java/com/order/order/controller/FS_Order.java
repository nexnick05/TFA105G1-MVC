package com.order.order.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;

import com.member.model.MemberVO;
import com.order.orderdetail.model.OrderdetailBean;
import com.order.orderdetail.model.OrderdetailService;
import com.product.product.model.ProductBean;
import com.product.product.model.ProductService;



	@WebServlet("/fsorder.do")
	public class FS_Order extends HttpServlet {
		private static final long serialVersionUID = 1L;

		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			// TODO Auto-generated method stub
			doGet(request, response);
		}

		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

			ServletContext applicationContext = this.getServletContext();
			ApplicationContext context = (ApplicationContext) applicationContext
					.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);

			OrderdetailService orderdetailService = context.getBean("orderdetailService",OrderdetailService.class);
			ProductService productService = context.getBean("productService",ProductService.class);

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
			HttpSession session2 = req.getSession();
			MemberVO memberVO = (MemberVO)session2.getAttribute("memberVO");
			if(memberVO==null) {
				String url = req.getRequestURI();
				session2.setAttribute("sourceURL", url);
				res.sendRedirect(req.getContextPath() +"/download/FS-login.jsp");
			}

			if ("getOne_For_Orderdetail".equals(action)) {

				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				try {
					Integer orderid = Integer.valueOf(req.getParameter("orderid"));
					HttpSession session = req.getSession();
					session.setAttribute("orderid", req.getParameter("orderid"));

					Connection connection = DriverManager.getConnection(
							"jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei", "root", "password");
					PreparedStatement ps = connection
							.prepareStatement("select order_detail_no from order_detail where order_id = ? ");
					ps.setInt(1, orderid);
					ResultSet rs = ps.executeQuery();

					List<OrderdetailBean> list = new ArrayList<OrderdetailBean>();
					while (rs.next()) {
						OrderdetailBean bean = orderdetailService.getOneOrderdetail(rs.getInt(1));
						list.add(bean);
					}

					session.setAttribute("list", list);

					List<ProductBean> products = productService.select(null);
					HttpSession session3 = req.getSession();
					session3.setAttribute("allProducts", products);
					
					
					List<ProductBean> productBeans = new ArrayList<ProductBean>();
					for (int i = 0; i < list.size(); i++) {
						ProductBean bean = new ProductBean();
						bean.setProductid(orderid);
					}	
//					String[] productids = req.getParameterValues("productid");
//					List<ProductBean> productBeans = new ArrayList<ProductBean>();
//					for (int i = 0; i < productids.length; i++) {
//						ProductBean bean = new ProductBean();
//						bean.setProductid(Integer.valueOf(productids[i]));
//						productService.select(bean);
//						productBeans.add(productService.select(bean).get(0));
//
//					}
//					    session.setAttribute("products", productBeans);
					
					
					//找出此頁該顯示的圖片們
					List<Integer> imgids = new ArrayList<Integer>();
					try {
						connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei",
								"root", "password");

						for (int i = 0; i < products.size(); i++) {
							if (products.get(i) != null) {
								 ps = connection
										.prepareStatement("SELECT * FROM PRODUCT_IMG where PRODUCT_ID = ? limit 1");
								ps.setInt(1, products.get(i).getProductid());
								ResultSet rSet = ps.executeQuery();

								while (rSet.next()) {
									imgids.add(rSet.getInt(1));
								}
							}
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					System.out.println(imgids);
					HttpSession session5 = req.getSession();
					session5.setAttribute("imgids", imgids);

					String url = "order/FS-orderdetail.jsp";
//					res.sendRedirect(url);
					RequestDispatcher sucessView = req.getRequestDispatcher(url);
					sucessView.forward(req, res);

					/*************************** 其他可能的錯誤處理 *************************************/
				} catch (Exception e) {
					e.printStackTrace();
//					errorMsgs.add("刪除資料失敗:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/emp/listAllEmp.jsp");
//					failureView.forward(req, res);
					System.out.print("查詢資料失敗detail");
				}
			}
		}
	}

