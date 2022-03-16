package com.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/member.register")
public class MemberRegister extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("register".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String email = req.getParameter("email");
				String emailReg = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.put("email", "請勿空白");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.put("email", "請輸入英文字母、數字和 _ , - 且含@ + 信箱網域");
				}

				String password = req.getParameter("password");
				String pwdReg = "^([A-Za-z0-9]){1,20}$";
				if (password == null || password.trim().length() == 0) {
					errorMsgs.put("password", "請勿空白");
				} else if (!password.trim().matches(pwdReg)) {
					errorMsgs.put("password", "請輸入英文字母、數字 且1~20個字");
				}

				String confirmPWD = req.getParameter("confirm-password");
				if (!password.equals(confirmPWD)) {
					errorMsgs.put("confirmPWD","密碼不一致，請重新輸入!");
				}

				String agreement = req.getParameter("agreement");
				if (agreement == null) {
					errorMsgs.put("agreement","尚有條款未確認!");
				}
				MemberVO memberVO = new MemberVO();
				memberVO.setEmail(email);
				memberVO.setPassword(password);

				System.err.println(errorMsgs);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					String RejectUrl = "/download/FS-register.jsp";
					req.setAttribute("email", email);
					RequestDispatcher failureView = req.getRequestDispatcher(RejectUrl);
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				MemberService memberSvc = new MemberService();
				MemberVO newMember = memberSvc.addMember(memberVO);
				
				Integer memberid = memberSvc.checkEmail(email);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				HttpSession session = req.getSession();
				session.setAttribute("memberVO", newMember);
				session.setAttribute("memberid", memberid);
				System.out.println("儲存\"新\"memberVO到session! = " + newMember);
				System.out.println("newMember memberid !!!= " + newMember.getMemberid());
				System.out.println("new memberid !!!= " + memberid);

				String sourceURL = (String) session.getAttribute("sourceURL");
				System.out.println("使用者 想去哪? :" + sourceURL);
				String cameFromURL = (String) session.getAttribute("cameFromURL");
				System.out.println("使用者 登入前哪? :" + cameFromURL);

				if (sourceURL != null) {
					session.removeAttribute("sourceURL");
					res.sendRedirect(sourceURL);
					return;
				} else if (cameFromURL != null) {
					session.removeAttribute("cameFromURL");
					res.sendRedirect(cameFromURL);
				} else {
					String indexUrl = "/download/homepage2.jsp";
					res.sendRedirect(req.getContextPath() + indexUrl);
				}

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("exception", "註冊異常，輸入的email已存在!");
				System.out.println(e.getMessage());
				String RejectUrl = "/download/FS-register.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(RejectUrl);
				failureView.forward(req, res);
			}
		}
	}

}
