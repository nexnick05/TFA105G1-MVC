package com.product.product.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.NativeQuery;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;


import com.product.product.model.ProductBean;
import com.product.product.model.ProductService;
import com.product.productimg.model.ProductImgBean;
import com.product.productimg.model.ProductImgService;
import com.product.productloc.model.ProductLocBean;
import com.product.productloc.model.ProductLocService;

//QQQQQ
@WebServlet("/ProductManage")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		ServletContext applicationContext = this.getServletContext();
		ApplicationContext context = (ApplicationContext) applicationContext.getAttribute
				(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		ProductService productService = context.getBean("productService", ProductService.class);
		ProductLocService productLocService = context.getBean("productLocService", ProductLocService.class);
		ProductImgService productImgService = context.getBean("productImgService", ProductImgService.class);
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
			
		

		if("insert".equals(action)) {
			
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			HttpSession session = req.getSession();
			session.setAttribute("errorMsgsadd", errorMsgs);
		
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String productname = req.getParameter("productname");
				if (productname == null || productname.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				} 
				
				Integer productprice = null;
				try {
					productprice = new Integer(req.getParameter("productprice").trim());
				} catch (NumberFormatException e) {
					productprice = 0;
					errorMsgs.add("商品價格請填整數");
				}
				
				Integer memberrequired = null;
				try {
					memberrequired = new Integer(req.getParameter("memberrequired").trim());
				} catch (NumberFormatException e) {
					memberrequired = 0;
					errorMsgs.add("最少成團人數請填整數");
				}
				
				
				String productintro = req.getParameter("productintro").trim();
//				productintro = productintro.replaceAll("\n", "<br>");
				if (productintro == null || productintro.trim().length() == 0) {
					errorMsgs.add("商品說明請勿空白");
				}
				
				if (productintro.length() < 50) {
					errorMsgs.add("商品說明至少50字");
				}
				
				
				String attention = req.getParameter("attention").trim();
				if (attention == null || attention.trim().length() == 0) {
					errorMsgs.add("注意事項請勿空白");
				}
				
				java.sql.Date startdate = null;
				try {
					
					String a = req.getParameter("startdate").trim().replaceAll("/", "-");
					startdate = java.sql.Date.valueOf(a);
				} catch (IllegalArgumentException e) {
					startdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入開始日");
				}
				
				java.sql.Date enddate = null;
				try {
					String a = req.getParameter("enddate").trim().replaceAll("/", "-");
					enddate = java.sql.Date.valueOf(a);
				} catch (IllegalArgumentException e) {
					enddate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入結束日");
				}
				
				
				Double traveltime = null;
				try {
					traveltime = new Double(req.getParameter("traveltime").trim());
				} catch (NumberFormatException e) {
					traveltime = 0.0;
					errorMsgs.add("旅行時數請填數字");
				}
				
				String producttype = req.getParameter("producttype");
				

				ProductBean bean = new ProductBean();
				bean.setProductname(productname);
				bean.setProducttype(producttype);
				bean.setProductprice(productprice);
				bean.setMemberrequired(memberrequired);
				bean.setProductintro(productintro);
				bean.setAttention(attention);
				bean.setStartdate(startdate);
				bean.setEnddate(enddate);
				bean.setTraveltime(traveltime);
				bean.setState(0);			
				
				String[] cityid = req.getParameterValues("cityid");
				
				//判斷使用者有無上傳圖片
				Collection<Part> parts = req.getParts();
				boolean haspic = false;
				for (Part part : parts) {	
					if (part.getContentType()!=null && part.getContentType().equals("image/jpeg")) {
						haspic = true;
					}
				}
				
				if(!haspic) {
					errorMsgs.add("請至少上傳一張照片");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					session.setAttribute("cityid", cityid);
					session.setAttribute("ProductBean", bean); // 含有輸入格式錯誤的empVO物件,也存入req
					System.out.println(errorMsgs);
					res.sendRedirect(req.getContextPath()+"/MVC/AddProduct");
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				productService.insert(bean); // 商品資料z
				session.removeAttribute("ProductBean");
				
				/***************************3.開始新增地區資料***************************************/
				
				Integer productid = bean.getProductid();
//				String[] cityid = req.getParameterValues("cityid");			
				
				if(cityid!=null) {
					for(int i = 0; i < cityid.length; i++) {
						ProductLocBean bean2 = new ProductLocBean();
						bean2.setProductid(productid);
						bean2.setCityid(Integer.valueOf(cityid[i]) );
						productLocService.insert(bean2);				
					}
				}
				
				/***************************4.開始新增圖片資料***************************************/
				
//				Collection<Part> parts = req.getParts(); // Servlet3.0新增了Part介面，讓我們方便的進行檔案上傳處理
				
				if(parts!=null && parts.size()!=0) {
				
					for (Part part : parts) {
						String filename = getFileNameFromPart(part);
						if (filename!= null && part.getContentType()!=null) {
							
							long size = part.getSize();
		
//							 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
							InputStream in = part.getInputStream();
							byte[] buf = new byte[in.available()];
							in.read(buf);
							in.close();
							
							ProductImgBean img = new ProductImgBean();
							img.setProductid(productid);
							img.setImgname(filename);
							img.setProductimg(buf);
							productImgService.insert(img);
							
						}
					}
				
				}
				
				
				/***************************5.新增完成 準備導向別的頁面***************************************/
				
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				return;
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add(e.getMessage());
				res.sendRedirect(req.getContextPath()+"/MVC/AddProduct");
			}
		}
		
		
		
		if("update".equals(action)) {
			
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			HttpSession session = req.getSession();
			session.setAttribute("errorMsgsupdate", errorMsgs);
		
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String productname = req.getParameter("productname");
				if (productname == null || productname.trim().length() == 0) {
					errorMsgs.add("商品名稱請勿空白");
				} 
				
				Integer productprice = null;
				try {
					productprice = new Integer(req.getParameter("productprice").trim());
				} catch (NumberFormatException e) {
					productprice = 0;
					errorMsgs.add("商品價格請填整數");
				}
				
				Integer memberrequired = null;
				try {
					memberrequired = new Integer(req.getParameter("memberrequired").trim());
				} catch (NumberFormatException e) {
					memberrequired = 0;
					errorMsgs.add("最少成團人數請填整數");
				}
				
				
				String productintro = req.getParameter("productintro").trim();
				if (productintro == null || productintro.trim().length() == 0) {
					errorMsgs.add("商品說明請勿空白");
				}
				
				if (productintro.length() < 50) {
					errorMsgs.add("商品說明至少50字");
				}
				
				
				String attention = req.getParameter("attention").trim();
				if (attention == null || attention.trim().length() == 0) {
					errorMsgs.add("注意事項請勿空白");
				}
				
				java.sql.Date startdate = null;
				try {
					startdate = java.sql.Date.valueOf(req.getParameter("startdate").trim());
				} catch (IllegalArgumentException e) {
					startdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入開始日");
				}
				
				java.sql.Date enddate = null;
				try {
					enddate = java.sql.Date.valueOf(req.getParameter("enddate").trim());
				} catch (IllegalArgumentException e) {
					enddate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入結束日");
				}
				
				
				Double traveltime = null;
				try {
					traveltime = new Double(req.getParameter("traveltime").trim());
				} catch (NumberFormatException e) {
					traveltime = 0.0;
					errorMsgs.add("旅行時數請填數字");
				}
				
				String producttype = req.getParameter("producttype");
				
				ProductBean bean1 = (ProductBean) session.getAttribute("ProductBean");
				Integer productid = bean1.getProductid();
				
				ProductBean bean = new ProductBean();
				bean.setProductid(productid);
				bean.setProductname(productname);
				bean.setProducttype(producttype);
				bean.setProductprice(productprice);
				bean.setMemberrequired(memberrequired);
				bean.setProductintro(productintro);
				bean.setAttention(attention);
				bean.setStartdate(startdate);
				bean.setEnddate(enddate);
				bean.setTraveltime(traveltime);
				bean.setState(0);
				
				String[] cityid = req.getParameterValues("cityid");
				
				//判斷使用者有無上傳圖片
				Collection<Part> parts = req.getParts();
				boolean haspic = false;
				for (Part part : parts) {	
					if (part.getContentType()!=null && part.getContentType().equals("image/jpeg")) {
						haspic = true;
					}
				}
				
				if(!haspic) {
					errorMsgs.add("請至少上傳一張照片");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					session.setAttribute("ProductBean", bean); // 含有輸入格式錯誤的empVO物件,也存入req
					if(cityid!=null) {
						session.setAttribute("cityid", cityid);
					}
					res.sendRedirect(req.getContextPath()+"/MVC/UpdateProduct");
					return;
				}
				
				/***************************2.開始修改資料***************************************/
				productService.update(bean); // 商品資料
				session.removeAttribute("ProductBean");
				cityid = req.getParameterValues("cityid");
		
				
				Connection connection;
				PreparedStatement preparedStatement;

				
				try {
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei", "root", "password");
					preparedStatement = connection.prepareStatement("delete from PRODUCT_LOC where PRODUCT_ID = ?");
					preparedStatement.setInt(1, productid);
					preparedStatement.execute();
					preparedStatement = connection.prepareStatement("delete from PRODUCT_IMG where PRODUCT_ID = ?");
					preparedStatement.setInt(1, productid);
					preparedStatement.execute();
					
					
									
				}catch (Exception e) {
					errorMsgs.add(e.getMessage());
					res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				}
				
				/*************************以下上傳圖片******************************************/
				
				
//				Collection<Part> parts = req.getParts();
				
				if(parts!=null) {
				
					for (Part part : parts) {
						String filename = getFileNameFromPart(part);
						if (filename!= null && part.getContentType()!=null) {
							
							long size = part.getSize();
		
//							 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
							InputStream in = part.getInputStream();
							byte[] buf = new byte[in.available()];
							in.read(buf);
							in.close();
							
							ProductImgBean img = new ProductImgBean();
							img.setProductid(productid);
							img.setImgname(filename);
							img.setProductimg(buf);
							productImgService.insert(img);
							
						}
					}
				
				}
				
				
				/*************************以下新增商品地點***************************************/
				
				if(cityid!=null) {
					for(int i = 0; i < cityid.length; i++) {
						ProductLocBean bean2 = new ProductLocBean();
						bean2.setProductid(productid);
						bean2.setCityid(Integer.valueOf(cityid[i]) );
						productLocService.insert(bean2);				
					}
				}
				
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				return;
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
//				res.sendRedirect(req.getContextPath()+"/MVC/UpdateProduct");
			}
		}
		
		
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			HttpSession session = req.getSession();
			session.removeAttribute("errorMsgsdelete");
			session.setAttribute("errorMsgsdelete", errorMsgs);
			
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer productid = new Integer(req.getParameter("productid"));
				
				/***************************2.開始刪除資料***************************************/
				ProductBean bean = new ProductBean();
				bean.setProductid(productid);
				productService.delete(bean);
				
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
//				System.out.println("安 安");
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = req.getSession();
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer productid = new Integer(req.getParameter("productid"));
				
				/***************************2.開始查詢資料****************************************/
				ProductBean bean = new ProductBean();
				bean.setProductid(productid);
				List<ProductBean> list = (List<ProductBean>)productService.select(bean);
				ProductBean bean2 = list.get(0);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				session.setAttribute("ProductBean", bean2);         // 資料庫取出的empVO物件,存入req
				
				//找出商品相關地區
				try {
					Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei", "root", "password");
					PreparedStatement preparedStatement = connection.prepareStatement("select CITY_ID from PRODUCT_LOC where PRODUCT_ID = ?");
					preparedStatement.setInt(1, productid);					
					ResultSet rSet = preparedStatement.executeQuery();
					List cityids = new ArrayList();
						
					while (rSet.next()) {
						cityids.add(rSet.getInt(1));					
					}
					
					session.setAttribute("cityids", cityids);
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
		
				res.sendRedirect(req.getContextPath()+"/MVC/UpdateProduct");
				return;

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	// 取出上傳的檔案名稱 (因為API未提供method,所以必須自行撰寫)
		public String getFileNameFromPart(Part part) {
			String header = part.getHeader("content-disposition");
			System.out.println("header=" + header); // 測試用
			String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
			System.out.println("filename=" + filename); // 測試用
			if (filename.length() == 0) {
				return null;
			}
			return filename;
		}

}
