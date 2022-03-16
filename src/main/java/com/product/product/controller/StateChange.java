package com.product.product.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;

import com.product.product.model.ProductBean;
import com.product.product.model.ProductService;


@WebServlet("/StateChange")
public class StateChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		
		ServletContext applicationContext = this.getServletContext();
		ApplicationContext context = (ApplicationContext) applicationContext.getAttribute
				(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		ProductService productService = context.getBean("productService", ProductService.class);
		
		String productid = req.getParameter("productid");
		String action = req.getParameter("action");
		
		System.out.println(productid);
		System.out.println(action);
		
		if("up".equals(action)) {
			ProductBean bean = new ProductBean();
			bean.setProductid(Integer.valueOf(productid));
			ProductBean bean2 = productService.select(bean).get(0);
			bean2.setState(1);
			productService.update(bean2);
			
			out.write("<span>上架中</span>\r\n"
					+ "<button class=\"getoff\" onclick='getoff(event)'>下架</button>\r\n"
					+ "<input type=\"hidden\" name=\"action\"	value=\"getoff\">\r\n"
					+ "<input type=\"hidden\" name=\"productid\"  value=\"" +  productid  + "\">");
			
			
		}else if("down".equals(action)) {
			ProductBean bean = new ProductBean();
			bean.setProductid(Integer.valueOf(productid));
			ProductBean bean2 = (ProductBean) productService.select(bean).get(0);
			bean2.setState(0);
			productService.update(bean2);
			
			out.write("<span>下架中</span>\r\n"
					+ "<button class=\"puton\" onclick='putongo(event)'>上架</button>\r\n"
					+ "<input type=\"hidden\" name=\"action\"	value=\"puton\">\r\n"
					+ "<input type=\"hidden\" name=\"productid\"  value=\"" +  productid  + "\">");
			
			
		}
		
		
		
		
		
		
//		System.out.println(req.getParameter("productid"));
//		System.out.println(req.getParameter("action"));

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
