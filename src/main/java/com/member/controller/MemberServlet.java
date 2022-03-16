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

@WebServlet("/member/member.do")
public class MemberServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		// BS
		final String MemberManage = "/MVC/MemberDispacher/MemberManage";
		final String AddMember = "/MVC/MemberDispacher/AddMember";
		final String EditMember = "/MVC/MemberDispacher/EditMember";
		final String ListOneMember = "/MVC/MemberDispacher/ListOneMember";
		// FS
		final String UserProfile = "/download/FS-my-profile.jsp";
		final String FSEditMember = "/download/FS-edit-profile.jsp";

		if ("getOne_For_Update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer memberid = Integer.valueOf(req.getParameter("memberid").trim());

				/*************************** 2.開始查詢資料 ****************************************/
				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(memberid);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("memberVO", memberVO);
				RequestDispatcher successView = req.getRequestDispatcher(EditMember);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(MemberManage);
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) {

			Map<String, String> errorMsgs = new HashMap<String, String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				// 回傳 memberid(隱藏),lastname, firstname, idno, gender, dateofbirth, 沒有Email

				Integer memberid = Integer.valueOf(req.getParameter("memberid").trim());

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

				String lastname = req.getParameter("lastname");
				String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (lastname == null || lastname.trim().length() == 0) {
					errorMsgs.put("lastname", "請勿空白");
				} else if (!lastname.trim().matches(lnameReg)) {
					errorMsgs.put("lastname", "只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String firstname = req.getParameter("firstname");
				String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (firstname == null || firstname.trim().length() == 0) {
					errorMsgs.put("firstname", "請勿空白");
				} else if (!firstname.trim().matches(fnameReg)) {
					errorMsgs.put("firstname", "只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String idno = req.getParameter("idno");
				String idnoReg = "^[a-zA-Z]\\d{9}$";
				if (idno == null || idno.trim().length() == 0) {
					errorMsgs.put("idno", "請勿空白");
				} else if (!idno.trim().matches(idnoReg)) {
					errorMsgs.put("idno", "英文字母、數字 , 且長度必需在10");

				}

				String gender = req.getParameter("gender").trim();

				java.sql.Date dateofbirth = null;
				try {
					dateofbirth = java.sql.Date.valueOf(req.getParameter("dateofbirth").trim());
				} catch (IllegalArgumentException e) {

					dateofbirth = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("dateofbirth", "請輸入日期!");
				}

				String country = req.getParameter("country").trim();

				String phone = req.getParameter("phone").trim();
				String phoneReg = "^09[0-9]{8}$";
				if (phone == null || phone.trim().length() == 0) {
					errorMsgs.put("phone", "請勿空白");
				} else if (!phone.trim().matches(phoneReg)) {
					errorMsgs.put("phone", "需數字,且長度必需在10");
				}
				
				String nickname = req.getParameter("nickname").trim();
				String nicknameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (nickname == null || nickname.trim().length() == 0) {
					errorMsgs.put("nickname", "請勿空白");
				} else if (!nickname.trim().matches(nicknameReg)) {
					errorMsgs.put("nickname", "只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}
				
				MemberVO memberVO = new MemberVO();
				memberVO.setMemberid(memberid);
				memberVO.setEmail(email);
				memberVO.setPassword(password);
				memberVO.setLastname(lastname);
				memberVO.setFirstname(firstname);
				memberVO.setIdno(idno);
				memberVO.setGender(gender);
				memberVO.setDateofbirth(dateofbirth);
				memberVO.setCountry(country);
				memberVO.setPhone(phone);
				memberVO.setNickname(nickname);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					req.setAttribute("memberVO", memberVO);

					RequestDispatcher failureView = req.getRequestDispatcher(FSEditMember);
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemberService memberSvc = new MemberService();
				memberSvc.updateMember(memberVO);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				HttpSession session = req.getSession();
				MemberVO currentVO = (MemberVO) session.getAttribute("memberVO");
				if (currentVO != null) {
					session.removeAttribute("memberVO");
					session.setAttribute("memberVO", memberVO);
				}
				res.sendRedirect(req.getContextPath() + UserProfile);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.put("exception", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(FSEditMember);
				failureView.forward(req, res);
			}
		}

		if ("updateBS".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer memberid = Integer.valueOf(req.getParameter("memberid").trim());

				String email = req.getParameter("email");
				String emailReg = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("帳號: 請勿空白");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.add("帳號: 請輸入英文字母、數字和 _ , - 且含@ + 信箱網域");
				}

				String lastname = req.getParameter("lastname");
				String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (lastname == null || lastname.trim().length() == 0) {
					errorMsgs.add("姓氏: 請勿空白");
				} else if (!lastname.trim().matches(lnameReg)) {
					errorMsgs.add("姓氏: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String firstname = req.getParameter("firstname");
				String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (firstname == null || firstname.trim().length() == 0) {
					errorMsgs.add("名字: 請勿空白");
				} else if (!firstname.trim().matches(fnameReg)) {
					errorMsgs.add("名字: 只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String idno = req.getParameter("idno");
				String idnoReg = "^[a-zA-Z]\\d{9}$";
				if (idno == null || idno.trim().length() == 0) {
					errorMsgs.add("身分證字號: 請勿空白");
				} else if (!idno.trim().matches(idnoReg)) {
					errorMsgs.add("身分證字號: 英文字母、數字 , 且長度必需在10");
				}

				String gender = req.getParameter("gender").trim();

				java.sql.Date dateofbirth = null;
				try {
					dateofbirth = java.sql.Date.valueOf(req.getParameter("dateofbirth").trim());
				} catch (IllegalArgumentException e) {

					dateofbirth = new java.sql.Date(System.currentTimeMillis());

					errorMsgs.add("請輸入日期!");
				}
				String country = req.getParameter("country").trim();

				String phone = req.getParameter("phone").trim();
				String phoneReg = "^09[0-9]{8}$";
				if (phone == null || phone.trim().length() == 0) {
					errorMsgs.add("手機: 請勿空白");
				} else if (!phone.trim().matches(phoneReg)) {
					errorMsgs.add("手機: 輸入開頭09 + 8碼數字");
				}

				MemberVO memberVO = new MemberVO();
				memberVO.setMemberid(memberid);
				memberVO.setEmail(email);
				memberVO.setLastname(lastname);
				memberVO.setFirstname(firstname);
				memberVO.setIdno(idno);
				memberVO.setGender(gender);
				memberVO.setDateofbirth(dateofbirth);
				memberVO.setCountry(country);
				memberVO.setPhone(phone);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					req.setAttribute("memberVO", memberVO);
					RequestDispatcher failureView = req.getRequestDispatcher(EditMember);
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemberService memberSvc = new MemberService();
				memberSvc.updateMember(memberVO);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memberVO", memberVO);
				RequestDispatcher successView = req.getRequestDispatcher(ListOneMember);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(EditMember);
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) {

			Map<String, String> errorMsgs = new HashMap<String, String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String email = req.getParameter("email").trim();
				String emailReg = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.put("email", "請勿空白");
				} else if (!email.trim().matches(emailReg)) {
					errorMsgs.put("email", "請輸入英文字母、數字和 _ , - 且含@ + 信箱網域");
				}

				String password = req.getParameter("password").trim();
				String pwdReg = "^([A-Za-z0-9]){1,20}$";
				if (password == null || password.trim().length() == 0) {
					errorMsgs.put("password", "請勿空白");
				} else if (!password.trim().matches(pwdReg)) {
					errorMsgs.put("password", "請輸入英文字母、數字 且1~20個字");
				}

				String lastname = req.getParameter("lastname");
				String lnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (lastname == null || lastname.trim().length() == 0) {
					errorMsgs.put("lastname", "請勿空白");
				} else if (!lastname.trim().matches(lnameReg)) {
					errorMsgs.put("lastname", "只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String firstname = req.getParameter("firstname");
				String fnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (firstname == null || firstname.trim().length() == 0) {
					errorMsgs.put("firstname", "請勿空白");
				} else if (!firstname.trim().matches(fnameReg)) {
					errorMsgs.put("firstname", "只能是中、英文字母、數字和_ , 且長度必需在1到20之間");
				}

				String idno = req.getParameter("idno");
				String idnoReg = "^[(a-zA-Z0-9)]{10}$";
				if (idno == null || idno.trim().length() == 0) {
					errorMsgs.put("idno", "請勿空白");
				} else if (!idno.trim().matches(idnoReg)) {
					errorMsgs.put("idno", "英文字母、數字 , 且長度必需在10");
				}

				String gender = req.getParameter("gender").trim();

				java.sql.Date dateofbirth = null;
				try {
					dateofbirth = java.sql.Date.valueOf(req.getParameter("dateofbirth").trim());
				} catch (IllegalArgumentException e) {

					dateofbirth = new java.sql.Date(System.currentTimeMillis());

					errorMsgs.put("dateofbirth", "請輸入日期!");
				}

				String country = req.getParameter("country").trim();

				String phone = req.getParameter("phone").trim();
				String phoneReg = "^[(0-9)]{10}$";
				if (idno == null || idno.trim().length() == 0) {
					errorMsgs.put("phone", "請勿空白");
				} else if (!phone.trim().matches(phoneReg)) {
					errorMsgs.put("phone", "需數字,且長度必需在10");
				}

				String nickname = req.getParameter("nickname").trim();

				String selfintro = req.getParameter("selfintro").trim();

				// Pack into memberVO
				MemberVO memberVO = new MemberVO();
				memberVO.setEmail(email);
				memberVO.setPassword(password);
				memberVO.setFirstname(firstname);
				memberVO.setLastname(lastname);
				memberVO.setIdno(idno);
				memberVO.setGender(gender);
				memberVO.setDateofbirth(dateofbirth);
				memberVO.setCountry(country);
				memberVO.setPhone(phone);
				memberVO.setNickname(nickname);
				memberVO.setSelfintro(selfintro);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					req.setAttribute("memberVO", memberVO);
					RequestDispatcher failureView = req.getRequestDispatcher(AddMember);
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemberService memberSvc = new MemberService();
				memberSvc.addMember(memberVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				res.sendRedirect(req.getContextPath() + MemberManage);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.put("exception", "無法新增，輸入的email已存在!");
				System.out.println(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(AddMember);
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer memberid = Integer.valueOf(req.getParameter("memberid").trim());

				/*************************** 2.開始刪除資料 ***************************************/
				MemberService memberSvc = new MemberService();
				memberSvc.deleteMember(memberid);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				RequestDispatcher successView = req.getRequestDispatcher(MemberManage);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(MemberManage);
				failureView.forward(req, res);
			}
		}
	}
}
