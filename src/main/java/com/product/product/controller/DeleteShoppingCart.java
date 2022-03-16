package com.product.product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import redis.clients.jedis.Jedis;


@WebServlet("/DeleteShoppingCart")
public class DeleteShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Jedis jedis = new Jedis("localhost", 6379);
		HttpSession session = request.getSession();
		String productid = request.getParameter("productid");
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		String memberidstring = String.valueOf(memberid);
		jedis.lrem("會員"+memberidstring, 0, productid);	
		
		jedis.close();
		

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
