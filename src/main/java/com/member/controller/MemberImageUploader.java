package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/member.upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
//當數據量大於fileSizeThreshold值時，內容將被寫入磁碟
//上傳過程中無論是單個文件超過maxFileSize值，或者上傳的總量大於maxRequestSize 值都會拋出IllegalStateException 異常
public class MemberImageUploader extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	String saveDirectory = "/images_uploaded"; // 上傳檔案的目的地目錄;
	// 將由底下的第26~30行用 java.io.File 於 ContextPath 之下, 自動建立目地目錄

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");

		String action = req.getParameter("action");
		Integer memberid = Integer.valueOf(req.getParameter("memberid"));
		Collection<Part> parts = req.getParts();
		

			for (Part part : parts) {
				String filename = getFileNameFromPart(part);
				if (filename != null && part.getContentType() != null) {

					// 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
					InputStream in = part.getInputStream();
					byte[] buf = new byte[in.available()];
					in.read(buf);
					in.close();

					MemberVO memberVO = new MemberVO();
					memberVO.setMemberid(memberid);
					memberVO.setAvatar(buf);

					MemberService memberSvc = new MemberService();
					memberSvc.uploadPic(memberid, buf);

//				String url = "/download/BS-member_manage.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);

			}
		}
			if ("上傳".equals(action)) {
				String url = "/MVC/MemberDispacher/MemberManage";
				res.sendRedirect(req.getContextPath() + url);					
			} else if ("確認".equals(action)) {
				String url = "/download/FS-my-profile.jsp";
				res.sendRedirect(req.getContextPath() + url);	
			}
	}

	// 取出上傳的檔案名稱 (因為API未提供method,所以必須自行撰寫)
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
//		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
//		System.out.println("filename=" + filename); // 測試用
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
}