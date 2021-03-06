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

		if (action == null) { // ??????select???????????????
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

		if ("insert".equals(action)) { // ??????add-post.jsp?????????

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

				String[] productids = req.getParameterValues("productid"); // ???????????????bean
				for(int i =0; i < productids.length; i++) {
					System.out.println("productids[i]=" + productids[i]);
				}
				String[] numberoftravelers = req.getParameterValues("numberoftraveler");
				String travelerReg = "^[1-9]*$";
//				for(int i = 0;i<numberoftravelers.length;i++) {
//					System.out.println(numberoftravelers[i]);
//					if (!numberoftravelers[i].matches(travelerReg)) { // ??????????????????(???)?????????(regular-expression)
//						System.out.println("numberoftravelers[i] = " + numberoftravelers[i]);
//						errorMsgs.add("????????????: ?????????????????????");
//					}
//				}
				
				String credit = req.getParameter("credit");
				System.out.println("credit length = " + credit.length());
				String creditReg = "^[(0-9)\\s\\d]{19}$";
				if (credit == null || credit.trim().length() == 0) {
					errorMsgs.add("???????????????: ????????????");
				} else if (!credit.trim().matches(creditReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("???????????????????????????16???");
				}
				
				String expire = req.getParameter("expire");
				String expireReg = "^[(0-9)\\s\\d]{5}$";
				if (expire == null || expire.trim().length() == 0) {
					errorMsgs.add("????????????: ????????????");
				} else if (!expire.trim().matches(expireReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("????????????????????????MM/YY");
				}
				
				String CVC = req.getParameter("CVC");
				String cvcReg = "^[(0-9)]{3}$";
				if (CVC == null || CVC.trim().length() == 0) {
					errorMsgs.add("?????????3???: ????????????");
				} else if (!CVC.trim().matches(cvcReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("?????????3???????????????3");
				}
				
				
//				String language = req.getParameter("language");
//				if (language.equals("?????????") ) {
//					errorMsgs.add("?????????????????????");
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
//					System.out.println("??????");
//					session.setAttribute("travelernumber", bean2);
//					RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				
				int a = 0;
				for (int i = 0; i < productids.length; i++) {
					OrderdetailBean bean2 = new OrderdetailBean();
					bean2.setProductid(Integer.valueOf(productids[i]));
					System.out.println("????????????");
					System.out.println(productids.length);
					bean2.setNumberoftraveler(Integer.valueOf(numberoftravelers[i]));
					bean2.setProductprice(Integer.valueOf(productprices[i]));
					bean2.setOrderrewardpoints(5);
					bean2.setSpecialneeds(specialneeds[i]);
					bean2.setImgid(Integer.valueOf(imgids[i]));

					if (!numberoftravelers[i].matches(travelerReg)) { // ??????????????????(???)?????????(regular-expression)
						System.out.println("numberoftravelers[i] = " + numberoftravelers[i]);
						errorMsgs.add("????????????: ?????????????????????");
					}
					
					finalOrderdetailBeans.add(bean2);
					
//					if (!errorMsgs.isEmpty()) {
//						System.out.println("??????");
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
								errorMsgs.add("?????????: ????????????");
							} else if (!lastnames[a].matches(lnameReg)) { // ??????????????????(???)?????????(regular-expression)
								errorMsgs.add("?????????: ???????????????????????????????????????_ , ??????????????????1???20??????");
							}

						String[] firstnames = req.getParameterValues("firstname");
						String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
						if (firstnames[a] == null || firstnames[a].trim().length() == 0) {
							errorMsgs.add("?????????: ????????????");
						} else if (!firstnames[a].trim().matches(fnameReg)) { // ??????????????????(???)?????????(regular-expression)
							errorMsgs.add("?????????: ???????????????????????????????????????_ , ??????????????????1???20??????");
						}

						String[] genders = req.getParameterValues("gender");
						
						String[] birthdays = req.getParameterValues("birthday");
						if (birthdays[a] == null || birthdays[a].trim().length() == 0) {
							errorMsgs.add("???????????????: ????????????");
						}

						String[] idnos = req.getParameterValues("idno");
							String idnoReg = "^[(a-zA-Z0-9)]{10}$";
							if (idnos[a] == null || idnos[a].trim().length() == 0) {
								errorMsgs.add("???????????????: ????????????");
							} else if (!idnos[a].trim().matches(idnoReg)) { // ??????????????????(???)?????????(regular-expression)
								errorMsgs.add("???????????????: ????????????????????? , ??????????????????10");
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
					System.out.println("?????????");
					session.setAttribute("traveler", finalTravelerlistBeans); // ???????????????????????????empVO??????,?????????req
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
				System.out.print("??????????????????");
			}
		}

		if ("memberUpdate".equals(action)) {

			HttpSession session = req.getSession();
			List<String> errorMsgs = new LinkedList<String>();
			session.setAttribute("errorMsgs", errorMsgs);

			try {

				// ??????????????????
				

				MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
				Integer memberid1 = memberVO.getMemberid();

				Integer memberid = (Integer) session.getAttribute("memberid");

				String memberLastname = req.getParameter("memberLastname");
				String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (memberLastname == null || memberLastname.trim().length() == 0) {
					errorMsgs.add("?????????: ????????????");
				} else if (!memberLastname.trim().matches(lnameReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("?????????: ???????????????????????????????????????_ , ??????????????????1???20??????");
				}

				String memberFirstname = req.getParameter("memberFirstname");
				String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (memberFirstname == null || memberFirstname.trim().length() == 0) {
					errorMsgs.add("?????????: ????????????");
				} else if (!memberFirstname.trim().matches(fnameReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("????????????: ???????????????????????????????????????_ , ??????????????????1???20??????");
				}

				String memberPhone = req.getParameter("memberPhone");
				String phoneReg = "^[(0-9)]{10}$";
				if (memberPhone == null || memberPhone.trim().length() == 0) {
					errorMsgs.add("??????: ????????????");
				} else if (!memberPhone.trim().matches(phoneReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("??????: ?????? , ??????????????????10");
				}

				String memberEmail = req.getParameter("memberEmail");
				String emailReg = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
				if (memberEmail == null || memberEmail.trim().length() == 0) {
					errorMsgs.add("??????: ????????????");
				} else if (!memberEmail.trim().matches(emailReg)) {
					errorMsgs.add("??????: ????????????????????????????????? _ , - ??????@ + ????????????");
				}

				String memberIdno = req.getParameter("memberIdno");
				String idnoReg = "^[(a-zA-Z0-9)]{10}$";
				if (memberIdno == null || memberIdno.trim().length() == 0) {
					errorMsgs.add("???????????????: ????????????");
				} else if (!memberIdno.trim().matches(idnoReg)) { // ??????????????????(???)?????????(regular-expression)
					errorMsgs.add("???????????????: ????????????????????? , ??????????????????10");
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

				// ?????????????????????
				Jedis jedis = new Jedis();

				jedis.del("??????" + memberid);

				/*************************** 3.????????????,????????????(Send the Success view) ***********/

				String url = "order/booking_confirm.jsp";
				res.sendRedirect(url);

				/*************************** ??????????????????????????? **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/order/orderbooking.jsp");
				failureView.forward(req, res);
				System.out.print("??????????????????");
			}
		}
	}

}
