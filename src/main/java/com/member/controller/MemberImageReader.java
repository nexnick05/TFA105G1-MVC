package com.member.controller;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/member.pic")
public class MemberImageReader extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			/*************************** 1.接收請求參數 *****************************************/
			Integer memberid = Integer.valueOf(req.getParameter("memberid"));
//			Integer memberid = 1;
			/*************************** 2.開始查詢資料 *****************************************/
			MemberService memberSvc = new MemberService();
			MemberVO memberVo =  memberSvc.readPic(memberid);
			/*************************** 3.查詢完成,準備轉交(Send the Success view) **************/
			byte[] buf = memberVo.getAvatar();
			
			out.write(buf);

		} catch (Exception e) {
//			System.out.println(e);
			InputStream in = getServletContext().getResourceAsStream("/images/nopic.jpg");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
	}

}