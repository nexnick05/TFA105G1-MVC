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
				/***********************1.?????????????????? - ???????????????????????????*************************/
				String productname = req.getParameter("productname");
				if (productname == null || productname.trim().length() == 0) {
					errorMsgs.add("????????????????????????");
				} 
				
				Integer productprice = null;
				try {
					productprice = new Integer(req.getParameter("productprice").trim());
				} catch (NumberFormatException e) {
					productprice = 0;
					errorMsgs.add("????????????????????????");
				}
				
				Integer memberrequired = null;
				try {
					memberrequired = new Integer(req.getParameter("memberrequired").trim());
				} catch (NumberFormatException e) {
					memberrequired = 0;
					errorMsgs.add("??????????????????????????????");
				}
				
				
				String productintro = req.getParameter("productintro").trim();
//				productintro = productintro.replaceAll("\n", "<br>");
				if (productintro == null || productintro.trim().length() == 0) {
					errorMsgs.add("????????????????????????");
				}
				
				if (productintro.length() < 50) {
					errorMsgs.add("??????????????????50???");
				}
				
				
				String attention = req.getParameter("attention").trim();
				if (attention == null || attention.trim().length() == 0) {
					errorMsgs.add("????????????????????????");
				}
				
				java.sql.Date startdate = null;
				try {
					
					String a = req.getParameter("startdate").trim().replaceAll("/", "-");
					startdate = java.sql.Date.valueOf(a);
				} catch (IllegalArgumentException e) {
					startdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("??????????????????");
				}
				
				java.sql.Date enddate = null;
				try {
					String a = req.getParameter("enddate").trim().replaceAll("/", "-");
					enddate = java.sql.Date.valueOf(a);
				} catch (IllegalArgumentException e) {
					enddate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("??????????????????");
				}
				
				
				Double traveltime = null;
				try {
					traveltime = new Double(req.getParameter("traveltime").trim());
				} catch (NumberFormatException e) {
					traveltime = 0.0;
					errorMsgs.add("????????????????????????");
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
				
				//?????????????????????????????????
				Collection<Part> parts = req.getParts();
				boolean haspic = false;
				for (Part part : parts) {	
					if (part.getContentType()!=null && part.getContentType().equals("image/jpeg")) {
						haspic = true;
					}
				}
				
				if(!haspic) {
					errorMsgs.add("???????????????????????????");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					session.setAttribute("cityid", cityid);
					session.setAttribute("ProductBean", bean); // ???????????????????????????empVO??????,?????????req
					System.out.println(errorMsgs);
					res.sendRedirect(req.getContextPath()+"/MVC/AddProduct");
					return;
				}
				
				/***************************2.??????????????????***************************************/
				productService.insert(bean); // ????????????z
				session.removeAttribute("ProductBean");
				
				/***************************3.????????????????????????***************************************/
				
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
				
				/***************************4.????????????????????????***************************************/
				
//				Collection<Part> parts = req.getParts(); // Servlet3.0?????????Part???????????????????????????????????????????????????
				
				if(parts!=null && parts.size()!=0) {
				
					for (Part part : parts) {
						String filename = getFileNameFromPart(part);
						if (filename!= null && part.getContentType()!=null) {
							
							long size = part.getSize();
		
//							 ???????????? InputStream ??? byte[] (?????????model???VO????????????)
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
				
				
				/***************************5.???????????? ????????????????????????***************************************/
				
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				return;
				
				/***************************???????????????????????????**********************************/
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
				/***********************1.?????????????????? - ???????????????????????????*************************/
				String productname = req.getParameter("productname");
				if (productname == null || productname.trim().length() == 0) {
					errorMsgs.add("????????????????????????");
				} 
				
				Integer productprice = null;
				try {
					productprice = new Integer(req.getParameter("productprice").trim());
				} catch (NumberFormatException e) {
					productprice = 0;
					errorMsgs.add("????????????????????????");
				}
				
				Integer memberrequired = null;
				try {
					memberrequired = new Integer(req.getParameter("memberrequired").trim());
				} catch (NumberFormatException e) {
					memberrequired = 0;
					errorMsgs.add("??????????????????????????????");
				}
				
				
				String productintro = req.getParameter("productintro").trim();
				if (productintro == null || productintro.trim().length() == 0) {
					errorMsgs.add("????????????????????????");
				}
				
				if (productintro.length() < 50) {
					errorMsgs.add("??????????????????50???");
				}
				
				
				String attention = req.getParameter("attention").trim();
				if (attention == null || attention.trim().length() == 0) {
					errorMsgs.add("????????????????????????");
				}
				
				java.sql.Date startdate = null;
				try {
					startdate = java.sql.Date.valueOf(req.getParameter("startdate").trim());
				} catch (IllegalArgumentException e) {
					startdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("??????????????????");
				}
				
				java.sql.Date enddate = null;
				try {
					enddate = java.sql.Date.valueOf(req.getParameter("enddate").trim());
				} catch (IllegalArgumentException e) {
					enddate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("??????????????????");
				}
				
				
				Double traveltime = null;
				try {
					traveltime = new Double(req.getParameter("traveltime").trim());
				} catch (NumberFormatException e) {
					traveltime = 0.0;
					errorMsgs.add("????????????????????????");
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
				
				//?????????????????????????????????
				Collection<Part> parts = req.getParts();
				boolean haspic = false;
				for (Part part : parts) {	
					if (part.getContentType()!=null && part.getContentType().equals("image/jpeg")) {
						haspic = true;
					}
				}
				
				if(!haspic) {
					errorMsgs.add("???????????????????????????");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					session.setAttribute("ProductBean", bean); // ???????????????????????????empVO??????,?????????req
					if(cityid!=null) {
						session.setAttribute("cityid", cityid);
					}
					res.sendRedirect(req.getContextPath()+"/MVC/UpdateProduct");
					return;
				}
				
				/***************************2.??????????????????***************************************/
				productService.update(bean); // ????????????
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
				
				/*************************??????????????????******************************************/
				
				
//				Collection<Part> parts = req.getParts();
				
				if(parts!=null) {
				
					for (Part part : parts) {
						String filename = getFileNameFromPart(part);
						if (filename!= null && part.getContentType()!=null) {
							
							long size = part.getSize();
		
//							 ???????????? InputStream ??? byte[] (?????????model???VO????????????)
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
				
				
				/*************************????????????????????????***************************************/
				
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
				/***************************???????????????????????????**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
//				res.sendRedirect(req.getContextPath()+"/MVC/UpdateProduct");
			}
		}
		
		
		
		
		if ("delete".equals(action)) { // ??????listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			HttpSession session = req.getSession();
			session.removeAttribute("errorMsgsdelete");
			session.setAttribute("errorMsgsdelete", errorMsgs);
			
	
			try {
				/***************************1.??????????????????***************************************/
				Integer productid = new Integer(req.getParameter("productid"));
				
				/***************************2.??????????????????***************************************/
				ProductBean bean = new ProductBean();
				bean.setProductid(productid);
				productService.delete(bean);
				
				
				/***************************3.????????????,????????????(Send the Success view)***********/								
				
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				
				/***************************???????????????????????????**********************************/
			} catch (Exception e) {
//				System.out.println("??? ???");
				errorMsgs.add("??????????????????:"+e.getMessage());
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
				
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // ??????listAllEmp.jsp?????????

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = req.getSession();
			
			try {
				/***************************1.??????????????????****************************************/
				Integer productid = new Integer(req.getParameter("productid"));
				
				/***************************2.??????????????????****************************************/
				ProductBean bean = new ProductBean();
				bean.setProductid(productid);
				List<ProductBean> list = (List<ProductBean>)productService.select(bean);
				ProductBean bean2 = list.get(0);
								
				/***************************3.????????????,????????????(Send the Success view)************/
				session.setAttribute("ProductBean", bean2);         // ??????????????????empVO??????,??????req
				
				//????????????????????????
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

				/***************************???????????????????????????**********************************/
			} catch (Exception e) {
				errorMsgs.add("??????????????????????????????:" + e.getMessage());
				res.sendRedirect(req.getContextPath()+"/MVC/ProductManageController");
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	// ??????????????????????????? (??????API?????????method,????????????????????????)
		public String getFileNameFromPart(Part part) {
			String header = part.getHeader("content-disposition");
			System.out.println("header=" + header); // ?????????
			String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
			System.out.println("filename=" + filename); // ?????????
			if (filename.length() == 0) {
				return null;
			}
			return filename;
		}

}
