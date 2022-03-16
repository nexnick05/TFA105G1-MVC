package com.product.product.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import redis.clients.jedis.Jedis;


@WebServlet("/AddLikes")
public class AddLikes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(session.getAttribute("memberid")==null) {		
//			RequestDispatcher failureView = request
//					.getRequestDispatcher("/WEB-INF/views/frontstage/member/FS-login.jsp");
//			failureView.forward(request, response);
			out.write("login");
			return;
		}
		
		Jedis jedis = new Jedis("localhost", 6379);
		System.out.println(jedis.ping());
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		String memberidstring = String.valueOf(memberid);
		String productid = request.getParameter("productid");
		
		
		boolean exist = false;
		List<String> range2 = jedis.lrange("會員收藏"+memberidstring, 0, -1);
		for (String product : range2) {
			if(product.equals(productid))
			exist=true;
		}
		
		if(!exist) {
			jedis.rpush("會員收藏"+memberidstring, productid);	
			out.write("<i onclick='clickout(event)' id='aaaa' class=\"ion-heart\"></i>");
		}else {
			jedis.lrem("會員收藏"+memberidstring, 0, productid);
			out.write("<i onclick='clickout(event)' id='aaaa' class=\"ion-ios-heart-outline\"></i>");
		}
		
		jedis.close();

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
