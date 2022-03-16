package com.filters;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.model.AdminVO;
import com.member.model.MemberVO;

@WebFilter(filterName = "BSFilter", urlPatterns = {
	    "/MVC/adminManagement/AdminManage", 
	    "/MVC/MemberDispacher/*"	    
})
public class BSFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		response.setContentType("text/html; charset=UTF-8");

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		HttpSession session = req.getSession();
		System.out.println("BSFilter work!!!!!!!!");

		AdminVO adminVO = (AdminVO) session.getAttribute("adminVO");
		if (adminVO == null) {
			System.out.println("adminVO is null");			
			
			res.sendRedirect(req.getContextPath() + "/download/BS-login.jsp");
			return;
		}

		chain.doFilter(request, response);
	}
}
