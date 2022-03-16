package com.order.order.controller;

//http://localhost:7080/TFA105G1-MVC/MVC/ProductManageController
import java.io.IOException;
import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

import com.member.model.MemberVO;
import com.order.order.model.OrderBean;
import com.order.order.model.OrderService;
import com.order.order.model.memberupdate.MemberBean;
import com.order.order.model.memberupdate.MemberService;
import com.order.orderdetail.model.OrderdetailBean;
import com.order.orderdetail.model.OrderdetailService;
import com.order.travelerlist.model.TravelerlistBean;
import com.order.travelerlist.model.TravelerlistService;

import redis.clients.jedis.Jedis;

@WebServlet("/order.do")
public class OrderServlet extends HttpServlet implements Serializable {
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

		OrderService orderService = context.getBean("orderService", OrderService.class);
		OrderdetailService orderdetailService = context.getBean("orderdetailService", OrderdetailService.class);
		TravelerlistService travelerlistService = context.getBean("travelerlistService", TravelerlistService.class);
		MemberService memberServiceOrder = context.getBean("memberService", MemberService.class);
		com.member.model.MemberService memberService = new com.member.model.MemberService();

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if (action == null) { // 這是select全部的狀況
			List<OrderBean> list = orderService.select(null);
			List<OrderdetailBean> list123 = orderdetailService.select(null);

			HttpSession session = req.getSession();
			HttpSession session1 = req.getSession();

			session.setAttribute("list", list);
			session1.setAttribute("list123", list123);

			List<MemberVO> allMembers = memberService.getAll();

			HttpSession session3 = req.getSession();
			session3.setAttribute("allMembers", allMembers);

			String url = "order/listAllOrder.jsp";
//			res.sendRedirect(url); 
			RequestDispatcher sucessView = req.getRequestDispatcher(url);
			sucessView.forward(req, res);

		}

//		

		if ("insert".equals(action)) { // 來自add-post.jsp的請求

			HttpSession session = req.getSession();
			List<String> errorMsgs = new LinkedList<String>();
			session.setAttribute("errorMsgs", errorMsgs);
			
			OrderBean finalOrderBean = new OrderBean();
			List<OrderdetailBean> finalOrderdetailBeans = new ArrayList<OrderdetailBean>();
			List<TravelerlistBean> finalTravelerlistBeans = new ArrayList<TravelerlistBean>();

			try {
				// order
				
				MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
				Integer memberid1 = memberVO.getMemberid();
				Integer orderpriceamount = Integer.parseInt(req.getParameter("orderpriceamount").trim());
//				Integer usedfunpoints = Integer.parseInt(req.getParameter("usedfunpoints").trim());

				LocalDateTime orderdate = LocalDateTime.now();
				DateTimeFormatter dtf4 = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
				String formatDateTime = orderdate.format(dtf4);
//				String orderdate = dtf4.format(LocalDateTime.now());

				OrderBean bean = new OrderBean();
				bean.setMemberid(memberid1);
				bean.setOrderdate(formatDateTime);
				bean.setOrderpriceamount(orderpriceamount);
				System.out.println("orderpriceamount = " + orderpriceamount);
				bean.setUsedfunpoints(50);

//				orderService.insert(bean);
				finalOrderBean = bean;

				/// orderdetail

				String[] productids = req.getParameterValues("productid"); // 跑迴圈裝進bean
				for(int i =0; i < productids.length; i++) {
					System.out.println("productids[i]=" + productids[i]);
				}
				String[] numberoftravelers = req.getParameterValues("numberoftraveler");
				String travelerReg = "^[1-9]*$";
//				for(int i = 0;i<numberoftravelers.length;i++) {
//					System.out.println(numberoftravelers[i]);
//					if (!numberoftravelers[i].matches(travelerReg)) { // 以下練習正則(規)表示式(regular-expression)
//						System.out.println("numberoftravelers[i] = " + numberoftravelers[i]);
//						errorMsgs.add("團員人數: 請選擇團員人數");
//					}
//				}
				
				String credit = req.getParameter("credit");
				System.out.println("credit length = " + credit.length());
				String creditReg = "^[(0-9)\\s\\d]{19}$";
				if (credit == null || credit.trim().length() == 0) {
					errorMsgs.add("信用卡卡號: 請勿空白");
				} else if (!credit.trim().matches(creditReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("信用卡卡號長度不為16碼");
				}
				
				String expire = req.getParameter("expire");
				String expireReg = "^[(0-9)\\s\\d]{5}$";
				if (expire == null || expire.trim().length() == 0) {
					errorMsgs.add("有效期限: 請勿空白");
				} else if (!expire.trim().matches(expireReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("有效期限長度不為MM/YY");
				}
				
				String CVC = req.getParameter("CVC");
				String cvcReg = "^[(0-9)]{3}$";
				if (CVC == null || CVC.trim().length() == 0) {
					errorMsgs.add("背面末3碼: 請勿空白");
				} else if (!CVC.trim().matches(cvcReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("背面末3碼長度不為3");
				}
				
				
//				String language = req.getParameter("language");
//				if (language.equals("請選擇") ) {
//					errorMsgs.add("請選擇導覽語言");
//				}
//				
				String[] productprices = req.getParameterValues("productprice");
				//String[] orderrewardpoints = req.getParameterValues("orderrewardpoints");
				String[] specialneeds = req.getParameterValues("specialneeds");
				String[] imgids = req.getParameterValues("imgid");

//				OrderdetailBean bean2 = new OrderdetailBean();
//				bean2.setOrderid(bean.getOrderid());
//				TravelerlistBean bean3 = new TravelerlistBean();
				
//				if (!errorMsgs.isEmpty()) {
//					System.out.println("驗證");
//					session.setAttribute("travelernumber", bean2);
//					RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				
				int a = 0;
				for (int i = 0; i < productids.length; i++) {
					OrderdetailBean bean2 = new OrderdetailBean();
					bean2.setProductid(Integer.valueOf(productids[i]));
					System.out.println("安安安安");
					System.out.println(productids.length);
					bean2.setNumberoftraveler(Integer.valueOf(numberoftravelers[i]));
					bean2.setProductprice(Integer.valueOf(productprices[i]));
					bean2.setOrderrewardpoints(5);
					bean2.setSpecialneeds(specialneeds[i]);
					bean2.setImgid(Integer.valueOf(imgids[i]));

					if (!numberoftravelers[i].matches(travelerReg)) { // 以下練習正則(規)表示式(regular-expression)
						System.out.println("numberoftravelers[i] = " + numberoftravelers[i]);
						errorMsgs.add("團員人數: 請選擇團員人數");
					}
					
					finalOrderdetailBeans.add(bean2);
					
//					if (!errorMsgs.isEmpty()) {
//						System.out.println("驗證");
//						session.setAttribute("travelernumber", bean2);
//						RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
//						failureView.forward(req, res);
//						return;
//					}
					
					
					
				
					
					for (int j = 0; j < Integer.valueOf(numberoftravelers[i]); j++) {
						TravelerlistBean bean3 = new TravelerlistBean();
						System.out.println("numberoftravelers[i] = " + Integer.valueOf(numberoftravelers[i]));
						
						
						String[] lastnames = req.getParameterValues("lastname");
							String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
							if (lastnames[a] == null || lastnames[a].trim().length() == 0) {
								errorMsgs.add("旅客姓: 請勿空白");
							} else if (!lastnames[a].matches(lnameReg)) { // 以下練習正則(規)表示式(regular-expression)
								errorMsgs.add("旅客姓: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
							}

						String[] firstnames = req.getParameterValues("firstname");
						String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
						if (firstnames[a] == null || firstnames[a].trim().length() == 0) {
							errorMsgs.add("旅客名: 請勿空白");
						} else if (!firstnames[a].trim().matches(fnameReg)) { // 以下練習正則(規)表示式(regular-expression)
							errorMsgs.add("旅客名: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
						}

						String[] genders = req.getParameterValues("gender");
						
						String[] birthdays = req.getParameterValues("birthday");
						if (birthdays[a] == null || birthdays[a].trim().length() == 0) {
							errorMsgs.add("身分證字號: 請勿空白");
						}

						String[] idnos = req.getParameterValues("idno");
							String idnoReg = "^[(a-zA-Z0-9)]{10}$";
							if (idnos[a] == null || idnos[a].trim().length() == 0) {
								errorMsgs.add("身分證字號: 請勿空白");
							} else if (!idnos[a].trim().matches(idnoReg)) { // 以下練習正則(規)表示式(regular-expression)
								errorMsgs.add("身分證字號: 英文字母、數字 , 且長度必需在10");
							}

						bean3.setOrderdetailno(bean2.getOrderdetailno());
						bean3.setLastname(lastnames[a]);
						bean3.setFirstname(firstnames[a]);
						bean3.setGender(genders[a]);
						bean3.setBirthday(Date.valueOf(birthdays[a]));
						bean3.setIdno(idnos[a]);
						
//						// Send the use back to the form, if there were errors
						
						
//						orderdetailService.insert(bean2);
//						travelerlistService.insert(bean3);
						finalTravelerlistBeans.add(bean3);
						
						System.out.println("a = " + a);
						System.out.println(lastnames[a]);
						a++;
					}
				}
				
				
				if (!errorMsgs.isEmpty()) {
					System.out.println("我在這");
					session.setAttribute("traveler", finalTravelerlistBeans); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
					failureView.forward(req, res);
					return;
				}
				
				orderService.insert(bean);
				for(int i = 0; i<finalOrderdetailBeans.size();i++) {
					finalOrderdetailBeans.get(i).setOrderid(bean.getOrderid()) ;
					orderdetailService.insert(finalOrderdetailBeans.get(i));
				}
				
					int b = 0;
					for(int j = 0; j < finalOrderdetailBeans.size(); j++) {
						for(int k = 0; k < finalOrderdetailBeans.get(j).getNumberoftraveler();k++) {
							
								finalTravelerlistBeans.get(b).setOrderdetailno(finalOrderdetailBeans.get(j).getOrderdetailno())    ;
								travelerlistService.insert(finalTravelerlistBeans.get(b));
								b++;
							
						}					
					}	
				
				
				String url = ("order.do?action=memberUpdate");
				RequestDispatcher sucessview = req.getRequestDispatcher(url);
				sucessview.forward(req, res);

			} 
			catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
				failureView.forward(req, res);
				System.out.print("新增資料失敗");
			}
		}

		if ("memberUpdate".equals(action)) {

			HttpSession session = req.getSession();
			List<String> errorMsgs = new LinkedList<String>();
			session.setAttribute("errorMsgs", errorMsgs);

			try {

				// 更新會員資料
				

				MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
				Integer memberid1 = memberVO.getMemberid();

				Integer memberid = (Integer) session.getAttribute("memberid");

				String memberLastname = req.getParameter("memberLastname");
				String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (memberLastname == null || memberLastname.trim().length() == 0) {
					errorMsgs.add("會員姓: 請勿空白");
				} else if (!memberLastname.trim().matches(lnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String memberFirstname = req.getParameter("memberFirstname");
				String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (memberFirstname == null || memberFirstname.trim().length() == 0) {
					errorMsgs.add("會員名: 請勿空白");
				} else if (!memberFirstname.trim().matches(fnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員姓名: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String memberPhone = req.getParameter("memberPhone");
				String phoneReg = "^[(0-9)]{10}$";
				if (memberPhone == null || memberPhone.trim().length() == 0) {
					errorMsgs.add("手機: 請勿空白");
				} else if (!memberPhone.trim().matches(phoneReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("手機: 數字 , 且長度必需在10");
				}

				String memberEmail = req.getParameter("memberEmail");
				String emailReg = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
				if (memberEmail == null || memberEmail.trim().length() == 0) {
					errorMsgs.add("帳號: 請勿空白");
				} else if (!memberEmail.trim().matches(emailReg)) {
					errorMsgs.add("帳號: 請輸入英文字母、數字和 _ , - 且含@ + 信箱網域");
				}

				String memberIdno = req.getParameter("memberIdno");
				String idnoReg = "^[(a-zA-Z0-9)]{10}$";
				if (memberIdno == null || memberIdno.trim().length() == 0) {
					errorMsgs.add("身分證字號: 請勿空白");
				} else if (!memberIdno.trim().matches(idnoReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("身分證字號: 英文字母、數字 , 且長度必需在10");
				}

//				System.out.println("memberid = " + memberid);
//				System.out.println("memberLastname = " + memberLastname);
//				System.out.println("memberFirstname = " + memberFirstname);
//				System.out.println("memberPhone = " + memberPhone);
//				System.out.println("memberEmail = " + memberEmail);
//				System.out.println("memberIdno = " + memberIdno);

				MemberBean bean1 = new MemberBean();
				bean1.setMemberid(memberid1);
				bean1.setEmail(memberEmail);
				bean1.setFirstname(memberFirstname);
				bean1.setLastname(memberLastname);
				bean1.setPhone(memberPhone);
				bean1.setIdno(memberIdno);

				memberServiceOrder.update(bean1);

				// 購物車項目刪除
				Jedis jedis = new Jedis();

				jedis.del("會員" + memberid);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/

				String url = "order/booking_confirm.jsp";
				res.sendRedirect(url);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
				failureView.forward(req, res);
				System.out.print("會員更新失敗");
			}
		}
	}

}
