package com.order.orderdetail.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.order.orderdetail.model.OrderdetailBean;
import com.order.orderdetail.model.OrderdetailService;
import com.order.travelerlist.model.TravelerlistBean;
import com.order.travelerlist.model.TravelerlistService;
import com.product.product.model.ProductBean;
import com.product.product.model.ProductService;

@WebServlet("/orderdetail.do")
public class OrderdetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		ServletContext applicationContext = this.getServletContext();
		ApplicationContext context = (ApplicationContext)applicationContext.getAttribute(
				WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		
		OrderdetailService orderdetailService = context.getBean("orderdetailService",OrderdetailService.class);
		ProductService productService = context.getBean("productService",ProductService.class);

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		

		if ("getOne_For_Orderdetail".equals(action)) {

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

			try {
				Integer orderid = Integer.valueOf(req.getParameter("orderid"));
				
				if(orderid!=null) {
			
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

				
				String url = "order/listOneOrderdetail.jsp";
				RequestDispatcher sucessView = req.getRequestDispatcher(url);
				sucessView.forward(req, res);
				}

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				String url = req.getRequestURI();
				res.sendRedirect(req.getContextPath() +"/order.do");
				System.out.print("查詢資料失敗detail");
			}
		}
		

		if ("delete".equals(action)) {

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer orderdetailno = Integer.parseInt(req.getParameter("orderdetailno").trim());

				/*************************** 2.開始刪除資料 ***************************************/

				OrderdetailBean bean = new OrderdetailBean();
				bean.setOrderdetailno(orderdetailno);
				orderdetailService.delete(bean);
				System.out.println("test1");

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				List<OrderdetailBean> list = orderdetailService.select(null); // 刪除完成後，秀出剩餘訂單

				HttpSession session = req.getSession();
				session.setAttribute("list", list);
				System.out.println("test2");

				String url = "orderdetail.do?action=delete2";
				RequestDispatcher sucessview = req.getRequestDispatcher(url);
				sucessview.forward(req, res);
//				res.sendRedirect(url);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add("刪除資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/listAllEmp.jsp");
//				failureView.forward(req, res);
				System.out.print("刪除資料失敗");
			}

		}
		
		if ("delete2".equals(action)) {
			HttpSession session = req.getSession();
			String orderid = (String) session.getAttribute("orderid");
			Integer orderidint = Integer.valueOf(orderid);
			Connection connection;
			List<OrderdetailBean> list = new ArrayList<OrderdetailBean>();
			try {
				connection = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei", "root", "password");
				PreparedStatement ps = connection
						.prepareStatement("select order_detail_no from order_detail where order_id = ? ");
				ps.setInt(1, orderidint);
				ResultSet rs = ps.executeQuery();

				while (rs.next()) {
					OrderdetailBean bean = orderdetailService.getOneOrderdetail(rs.getInt(1));
					list.add(bean);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			session.setAttribute("list", list);
			String url = ("order/listOneOrderdetail.jsp?orderid=" + orderid);
			RequestDispatcher sucessview = req.getRequestDispatcher(url);
			sucessview.forward(req, res);
//			res.sendRedirect(url);
		}


		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer orderdetailno = new Integer(req.getParameter("orderdetailno"));

				/*************************** 2.開始查詢資料 ****************************************/

				OrderdetailBean bean = new OrderdetailBean();
				bean.setOrderdetailno(orderdetailno);
				List<OrderdetailBean> list = orderdetailService.select(bean);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/

				HttpSession session = req.getSession();
				session.setAttribute("orderdetailBean", list.get(0));
				System.out.println("test3");

				String url = "order/update_orderdetail_input.jsp";
				res.sendRedirect(url);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/listAllEmp.jsp");
//				failureView.forward(req, res);
				System.out.println("尋找單一目標失敗");
			}
		}

		if ("update".equals(action)) { // 來自add-post.jsp的請求

			try {
				Integer orderid = Integer.parseInt(req.getParameter("orderid").trim());
				Integer productid = Integer.parseInt(req.getParameter("productid").trim());
				Integer numberoftraveler = Integer.parseInt(req.getParameter("numberoftraveler").trim());
				Integer productprice = Integer.parseInt(req.getParameter("productprice").trim());
				Integer orderrewardpoints = Integer.parseInt(req.getParameter("orderrewardpoints").trim());
				String specialneeds = req.getParameter("specialneeds");
				// 以上先拿到參數

				/*************************** 2.開始修改資料 ***************************************/

				OrderdetailBean bean = new OrderdetailBean();
				HttpSession session = req.getSession();
				Integer orderdetailno = Integer.parseInt(req.getParameter("orderdetailno").trim());

				bean.setOrderdetailno(orderdetailno);
				bean.setOrderid(orderid);
				bean.setProductid(productid);
				bean.setOrderrewardpoints(orderrewardpoints);
				bean.setSpecialneeds(specialneeds);
				bean.setNumberoftraveler(numberoftraveler);
				bean.setProductprice(productprice);

				orderdetailService.update(bean);

//				System.out.println(bean);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				List<OrderdetailBean> list = orderdetailService.select(bean); // 秀出指定資料

//				System.out.println(list);

				session.setAttribute("orderdetailBean", list.get(0));

//				String url = "/TFA105G1-MVC/orderdetail.do?action=update2";
//				res.sendRedirect(url);
				
				String url = ("orderdetail.do?action=update2");
				RequestDispatcher sucessview = req.getRequestDispatcher(url);
				sucessview.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/addEmp.jsp");
//				failureView.forward(req, res);
				System.out.print("修改資料失敗");
			}
		}

		if ("update2".equals(action)) {
			System.out.println(22222);
			HttpSession session = req.getSession();
			String orderid = (String) session.getAttribute("orderid");
			Integer orderidint = Integer.valueOf(orderid);
			Connection connection;
			List<OrderdetailBean> list = new ArrayList<OrderdetailBean>();
			try {
				connection = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei", "root", "password");
				PreparedStatement ps = connection
						.prepareStatement("select order_detail_no from order_detail where order_id = ? ");
				ps.setInt(1, orderidint);
				ResultSet rs = ps.executeQuery();

				while (rs.next()) {
					OrderdetailBean bean = orderdetailService.getOneOrderdetail(rs.getInt(1));
					list.add(bean);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			session.setAttribute("list", list);
			String url = ("order/listOneOrderdetail.jsp?orderid=" + orderid);
			RequestDispatcher sucessview = req.getRequestDispatcher(url);
			sucessview.forward(req, res);
//			res.sendRedirect(url);
		}

	}
	
//	if ("getOne_For_Display".equals(action)) { 
//
//		try {
//			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//			Integer orderdetailno = new Integer(req.getParameter("orderdetailno"));
//
//			/*************************** 2.開始查詢資料 *****************************************/
//
//			OrderdetailService svc = new OrderdetailService(orderdetailDAO);
//			OrderdetailBean bean = orderdetailService.getOneOrderdetail(orderdetailno);
//			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//
//			HttpSession session = req.getSession();
//			session.setAttribute("orderdetailBean", bean);
//			
//			String url = "order/listOneOrderdetail.jsp";
//			res.sendRedirect(url);
//			
//			/*************************** 其他可能的錯誤處理 *************************************/
//		} catch (Exception e) {
//			e.printStackTrace();
////			errorMsgs.add("刪除資料失敗:"+e.getMessage());
////			RequestDispatcher failureView = req
////					.getRequestDispatcher("/emp/listAllEmp.jsp");
////			failureView.forward(req, res);
//			System.out.print("查詢資料失敗");
//		}
//	}

//	if(action==null) {  //這是select全部的狀況
//	List<OrderdetailBean> list = orderdetailService.select(null);
//
//	HttpSession session = req.getSession();
//	session.setAttribute("list", list.get(0));
//	
//	String url = "order/listAllOrder.jsp";
//	res.sendRedirect(url); 
//}
	
//	if ("insert".equals(action)) { // 來自add-post.jsp的請求
//
//		try {
//
//			Integer orderid = Integer.parseInt(req.getParameter("orderid").trim());
////			System.out.println(orderid);
//			Integer productid = Integer.parseInt(req.getParameter("productid").trim());
////			System.out.println(productid);
//			Integer numberoftraveler = Integer.parseInt(req.getParameter("numberoftraveler").trim());
////			System.out.println(numberoftraveler);
//			Integer productprice = Integer.parseInt(req.getParameter("productprice").trim());
//			Integer orderrewardpoints = Integer.parseInt(req.getParameter("orderrewardpoints").trim());
//			String specialneeds = req.getParameter("specialneeds");
//
//			/*************************** 2.開始新增資料 ***************************************/
//
//			OrderdetailBean bean = new OrderdetailBean();
//			bean.setOrderid(orderid);
//			bean.setProductid(productid);
//			bean.setOrderrewardpoints(orderrewardpoints);
//			bean.setSpecialneeds(specialneeds);
//			bean.setNumberoftraveler(numberoftraveler);
//			bean.setProductprice(productprice);
//
//			orderdetailService.insert(bean);
//
//			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
//			List<OrderdetailBean> list = orderdetailService.select(bean);// 新增完成後，秀出剩餘訂單
//
//			HttpSession session = req.getSession();
//			session.setAttribute("OrderdetailBean", list.get(0));// why新增用list.get(0)，但刪除用list就好?
//
//			String url = "order/listAllOrderdetail.jsp";
//			res.sendRedirect(url);
//
//			/*************************** 其他可能的錯誤處理 **********************************/
//		} catch (Exception e) {
//			e.printStackTrace();
////			errorMsgs.add(e.getMessage());
////			RequestDispatcher failureView = req
////					.getRequestDispatcher("/emp/addEmp.jsp");
////			failureView.forward(req, res);
//			System.out.print("新增資料失敗");
//		}
//	}

}
