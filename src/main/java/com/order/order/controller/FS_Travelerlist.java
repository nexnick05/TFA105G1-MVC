package com.order.order.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
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

import com.order.travelerlist.model.TravelerlistBean;
import com.order.travelerlist.model.TravelerlistService;

@WebServlet("/traveler.do")
public class FS_Travelerlist extends HttpServlet {

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

		TravelerlistService travelerlistService = context.getBean("travelerlistService", TravelerlistService.class);

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Travelerlist".equals(action)) {
			
			// 明細

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

			try {
				Integer orderdetailno = Integer.valueOf(req.getParameter("orderdetailno"));
				HttpSession session = req.getSession();
				session.setAttribute("orderdetailno", req.getParameter("orderdetailno"));

				Connection connection = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei", "root", "password");
				PreparedStatement ps = connection
						.prepareStatement("select traveler_list_no from traveler_list where order_detail_no = ? ");
				ps.setInt(1, orderdetailno);
				ResultSet rs = ps.executeQuery();

				List<TravelerlistBean> list = new ArrayList<TravelerlistBean>();

				while (rs.next()) {
					TravelerlistBean bean = travelerlistService.getOneTravelerlist(rs.getInt(1));
					list.add(bean);

				}
	
				session.setAttribute("list", list);

				String url = "order/FS-travelerlist.jsp";
				RequestDispatcher sucessView = req.getRequestDispatcher(url);
				sucessView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add("刪除資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/listAllEmp.jsp");
//				failureView.forward(req, res);
				System.out.print("查詢資料失敗traveler");
			}
		}
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer travelerlistno = new Integer(req.getParameter("travelerlistno"));
				System.out.println("test1");

				/*************************** 2.開始查詢資料 ****************************************/

				TravelerlistBean bean = new TravelerlistBean();
//				System.out.println("bean = " + bean);
				bean.setTravelerlistno(travelerlistno);
//				System.out.println("orderdetailno = " + orderdetailno);
				List<TravelerlistBean> list = travelerlistService.select(bean);
//				System.out.println("list = " + list);
				

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/

				HttpSession session = req.getSession();
				session.setAttribute("travelerlistBeanFS", list.get(0));

				String url = "order/FS-update_travelerlist.jsp";
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
			
			HttpSession session = req.getSession();
			List<String> errorMsgs = new LinkedList<String>();
			session.setAttribute("errorMsgsFS", errorMsgs);

			try {
				Integer travelerlistno = Integer.parseInt(req.getParameter("travelerlistno").trim());
				Integer orderdetailno = Integer.parseInt(req.getParameter("orderdetailno").trim());
				
				String firstname = req.getParameter("firstname");
				String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (firstname == null || firstname.trim().length() == 0) {
					errorMsgs.add("名字: 請勿空白");
				} else if (!firstname.trim().matches(fnameReg)) {
					errorMsgs.add("名字: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}
				
				String lastname = req.getParameter("lastname");
				String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (lastname == null || lastname.trim().length() == 0) {
					errorMsgs.add("姓氏: 請勿空白");
				} else if (!lastname.trim().matches(lnameReg)) {
					errorMsgs.add("姓氏: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}
				
				String gender = req.getParameter("gender");
				String genderReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (gender == null || gender.trim().length() == 0) {
					errorMsgs.add("性別: 請勿空白");
				} else if (!gender.trim().matches(genderReg)) {
					errorMsgs.add("名字: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}
				
				Date birthday = Date.valueOf(req.getParameter("birthday").trim());
				if (birthday == null) {
					errorMsgs.add("生日: 請勿空白");
				}
				
				String idno = req.getParameter("idno");
				String idnoReg = "^[a-zA-Z]\\d{9}$";
				if (idno == null || idno.trim().length() == 0) {
					errorMsgs.add("身分證字號: 請勿空白");
				} else if (!idno.trim().matches(idnoReg)) {
					errorMsgs.add("身分證字號: 英文字母、數字 , 且長度必需在10");
				}
				// 以上先拿到參數
				
				/*************************** 2.開始修改資料 ***************************************/

				TravelerlistBean bean = new TravelerlistBean();

				bean.setTravelerlistno(travelerlistno);
				bean.setOrderdetailno(orderdetailno);
				bean.setLastname(lastname);
				bean.setFirstname(firstname);
				bean.setGender(gender);
				bean.setBirthday(birthday);
				bean.setIdno(idno);
				
				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					session.setAttribute("travelerlistBeanFS", bean);

					RequestDispatcher failureView = req.getRequestDispatcher("/order/FS-update_travelerlist.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				
				travelerlistService.update(bean);


				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				List<TravelerlistBean> list = travelerlistService.select(bean); // 秀出指定資料


				session.setAttribute("travelerlistBeanFS", list.get(0));//list裡的第一筆資料

				
				String url = "traveler.do?action=update2";
				RequestDispatcher sucessview = req.getRequestDispatcher(url);
				sucessview.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				e.printStackTrace();
				RequestDispatcher failureView = req
						.getRequestDispatcher("/order/FS-update_travelerlist.jsp");
				failureView.forward(req, res);
				System.out.print("修改資料失敗FS");
			}
		}
		
		if ("update2".equals(action)) { 
			System.out.println(22222);
			HttpSession session = req.getSession();
			String orderdetailno = (String)session.getAttribute("orderdetailno");
			Integer orderdetailnoint = Integer.valueOf(orderdetailno);
			Connection connection;
			List<TravelerlistBean> list = new ArrayList<TravelerlistBean>();
			try {
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei","root","password");
				PreparedStatement ps = connection.prepareStatement("select traveler_list_no from traveler_list where order_detail_no = ? ");
				ps.setInt(1,orderdetailnoint);
				ResultSet rs = ps.executeQuery();
				
				
				while(rs.next()) {
					TravelerlistBean bean = travelerlistService.getOneTravelerlist(rs.getInt(1));
					list.add(bean);
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			session.setAttribute("list", list);
			
			String url = ("order/FS-travelerlist.jsp?orderdetailno=" + orderdetailno );
			RequestDispatcher sucessview = req.getRequestDispatcher(url);
			sucessview.forward(req, res);
		}
	
	}
}
