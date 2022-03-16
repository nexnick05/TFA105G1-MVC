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

import redis.clients.jedis.Jedis;

@WebServlet("/member/member.login")
public class MemberLogin extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		final String indexUrl = "/download/homepage2.jsp";

		if ("login".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
			Map<String, String> errorMsgs = new HashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String email = req.getParameter("email");
				String emailReg = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.put("email", "帳號: 請勿空白");
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
				System.out.println(email + password);
				if (!errorMsgs.isEmpty()) {
					String RejectUrl = "/download/FS-login.jsp";
					req.setAttribute("email", email);
					RequestDispatcher failureView = req.getRequestDispatcher(RejectUrl);
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.memberLogin(email, password);

				if (memberVO == null) {
					errorMsgs.put("result", "帳號 或 密碼 錯誤!");
				}
				System.err.println(errorMsgs);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					String RejectUrl = "/download/FS-login.jsp";
					req.setAttribute("email", email);
					RequestDispatcher failureView = req.getRequestDispatcher(RejectUrl);
					failureView.forward(req, res);
					return;
				}
				Integer memberid = memberVO.getMemberid();
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/

				HttpSession session = req.getSession();
				req.changeSessionId();

				if (session.getAttribute("memberVO") != null || session.getAttribute("memberid") != null) {
					session.removeAttribute("memberVO");
					session.removeAttribute("memberid");
				} else if (session.getAttribute("rtEmail") != null) {
					session.removeAttribute("rtEmail");
				}

				try (Jedis jedis = new Jedis("localhost", 6379);) {
					System.out.println("redis驗證 ping! ~ " + jedis.ping());

					if (jedis.get(email) != null) {
						jedis.del(email);
						System.out.println("redis 清除Email!");
					}

				} catch (Exception e) {
					e.printStackTrace();
				}

				session.setAttribute("memberVO", memberVO);
				session.setAttribute("memberid", memberid);
				System.out.println("儲存memberVO到session! = " + memberVO);

				String sourceURL = (String) session.getAttribute("sourceURL");
				System.out.println("使用者 想去哪? :" + sourceURL);
				String cameFromURL = (String) session.getAttribute("cameFromURL");
				System.out.println("使用者 登入前在哪? :" + cameFromURL);

				if (sourceURL != null) {
					session.removeAttribute("sourceURL");
					res.sendRedirect(sourceURL);
					return;
				} else if (cameFromURL != null) {
					session.removeAttribute("cameFromURL");
					res.sendRedirect(cameFromURL);

				} else {
					res.sendRedirect(req.getContextPath() + indexUrl);
				}

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("result", "無法取得資料:" + e.getMessage());
				String RejectUrl = "/download/FS-login.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(RejectUrl);
				failureView.forward(req, res);
			}
		}

		if ("logout".equals(action)) {
			HttpSession session = req.getSession();
			session.removeAttribute("memberid");
			session.removeAttribute("memberVO");
			session.invalidate();
			System.out.println("session 已清空!");
			res.sendRedirect(req.getContextPath() + indexUrl);
		}

	}

}
