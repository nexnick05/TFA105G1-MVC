package com.product.product.controller;

import java.io.*;
import java.sql.*;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;

import com.product.productimg.model.ProductImgBean;
import com.product.productimg.model.ProductImgService;


@WebServlet("/ProductImageReader")
public class ProductImageReader extends HttpServlet {


	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		ServletContext applicationContext = this.getServletContext();
		ApplicationContext context = (ApplicationContext) applicationContext.getAttribute
				(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		ProductImgService productImgService = context.getBean("productImgService", ProductImgService.class);
		
		req.setCharacterEncoding("UTF-8");
		String imgid = req.getParameter("imgid");
		ProductImgBean bean = new ProductImgBean();
		bean.setImgid(Integer.parseInt(imgid));
		List<ProductImgBean> list = productImgService.select(bean);
		ProductImgBean bean2 = list.get(0);
		
		byte[] pic = bean2.getProductimg();
		out.write(pic);
	}
		

}