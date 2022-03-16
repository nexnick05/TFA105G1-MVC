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


@WebServlet("/AddShoppingCart")
public class AddShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(session.getAttribute("memberid")==null) {
			out.write("<h5 style='color: red'> 請先登入!</h5>");
			return;
		}
		
		Jedis jedis = new Jedis("localhost", 6379);
		System.out.println(jedis.ping());
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		String memberidstring = String.valueOf(memberid);
		String productid = request.getParameter("productid");
		
		
		boolean exist = false;
		List<String> range2 = jedis.lrange("會員"+memberidstring, 0, -1);
		for (String product : range2) {
			if(product.equals(productid))
			exist=true;
		}
		
		if(!exist) {
			jedis.rpush("會員"+memberidstring, productid);
			jedis.expire("會員"+memberidstring, 60*60*24*30);// 設定一個月後自動清除
			out.write("<h5 style='color: red'> 已新增至購物車</h5>");
		}else {
			out.write("<h5 style='color: red'> 此項目已在購物車中</h5>");
		}
		
		jedis.close();

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
