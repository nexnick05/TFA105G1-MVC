package com.order.order.controller;

import java.io.IOException;

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

import com.order.order.model.memberupdate.MemberBean;
import com.order.order.model.memberupdate.MemberService;

@WebServlet("/memberUpdate.do")
public class MemberUpdate extends HttpServlet {
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

		MemberService memberService = context.getBean("memberService", MemberService.class);

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		HttpSession session = req.getSession();

		if ("update".equals(action)) {

			try {
				Integer memberid = (Integer) session.getAttribute("memberid");
				String lastname = req.getParameter("lastname");
				String firstname = req.getParameter("firstname");
				String phone = req.getParameter("phone");
				String email = req.getParameter("email");
				String idno = req.getParameter("idno");
				System.out.println("lastname = " + lastname);
				System.out.println("firstname = " + firstname);
				System.out.println("phone = " + phone);
				System.out.println("email = " + email);
				System.out.println("idno = " + idno);
				

				MemberBean bean = new MemberBean();
				bean.setMemberid(memberid);
				bean.setEmail(email);
				bean.setFirstname(firstname);
				bean.setLastname(lastname);
				bean.setPhone(phone);
				bean.setIdno(idno);
				
				memberService.update(bean);
				
				String url = "order/orderbooking.jsp";
				RequestDispatcher sucessview = req.getRequestDispatcher(url);
				sucessview.forward(req, res);
				
			} catch (Exception e) {
				System.out.println("會員更新失敗");
			}

		}

	}

}
