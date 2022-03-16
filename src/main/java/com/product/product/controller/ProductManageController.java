package com.product.product.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.product.product.model.ProductBean;
import com.product.product.model.ProductService;

@Controller
public class ProductManageController {
	@Autowired
	private ProductService productService;
	
//	@InitBinder
//	public void initMethod(WebDataBinder binder) {
//		binder.registerCustomEditor(java.sql.Date.class, 
//				new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
//		
//		binder.registerCustomEditor(Integer.class, new CustomNumberEditor(Integer.class, true));
//		
//		binder.registerCustomEditor(Double.class, new CustomNumberEditor(Double.class, true));
//	}

	@RequestMapping("/ProductManageController")
	public String name(String action, HttpSession session, ProductBean bean, 
			Model model, String productid, String state) {
		
		session.removeAttribute("ProductBean");
		
		if(productid!=null && productid!="") {
			
			ProductBean bean2 = new ProductBean();
			bean2.setProductid(Integer.valueOf(productid));
			List<ProductBean> list = productService.select(bean2);
			model.addAttribute("list", list);
			model.addAttribute("totalpage", 1);
			model.addAttribute("page", "1");
			return "backstage/product/productmanage1";	
		}else if(action==null) {  //這是select全部的狀況	
			List<ProductBean> list = productService.select(null);
			if(state!=null) {
			
				if(state.equals("1")) {
					for(int i =0; i< list.size(); i++) {
						if(list.get(i).getState()!=1) {
							list.remove(list.get(i));
							i--;
						}
					}
				}
				
				if(state.equals("0")) {
					for(int i =0; i< list.size(); i++) {
						if(list.get(i).getState()!=0) {
							list.remove(list.get(i));
							i--;
						}
					}
				}
			}
			session.setAttribute("list", list);
			return "redirect:/MVC/ManagePageHandler";
		}
		
		return "";
	}
	
	@RequestMapping("/ManagePageHandler")
	public String pageHandler(HttpSession session, String page, Model model) {
		
		List<ProductBean> list = (List<ProductBean>) session.getAttribute("list");
		
		if(list==null) {
			list = productService.select(null);
		}
		

//		找出總共該有幾頁
		int totalpage = 0;
		if (list.size() % 10 == 0) {
			totalpage = list.size() / 10;
		} else {
			totalpage = (list.size() / 10) + 1;
		}
		model.addAttribute("totalpage", totalpage);

//		找出此頁該顯示哪幾筆商品
		if (list == null) {
			list = productService.select(null);
		}
		if (page == null) {
			page = "1";
		}
		int pageindex = Integer.valueOf(page);
		List<ProductBean> list2 = new ArrayList();

		for (int i = (pageindex - 1) * 10; i <= ((pageindex * 10) - 1); i++) {
			if ((i + 1) <= list.size()) {
				list2.add(list.get(i));
			}
		}
		
		model.addAttribute("totalpage", totalpage);
		model.addAttribute("page", page);
		model.addAttribute("list", list2);
		return "backstage/product/productmanage1";
	}
	
	
	@RequestMapping("/PutonGetoff")
	public String name2(String action, HttpSession session, String productid, Model model) {

	
		if(action.equals("puton")) {
			ProductBean bean = new ProductBean();
			bean.setProductid(Integer.valueOf(productid));
			ProductBean bean2 = productService.select(bean).get(0);
			bean2.setState(1);
			productService.update(bean2);
			return "redirect:/MVC/ProductManageController ";
//			return "productmanage1";
		}else {
			ProductBean bean = new ProductBean();
			bean.setProductid(Integer.valueOf(productid));
			ProductBean bean2 = (ProductBean) productService.select(bean).get(0);
			bean2.setState(0);
			productService.update(bean2);
			return "redirect:/MVC/ProductManageController ";
//			return "productmanage1";
		}
		
	}
	
	
	@RequestMapping("/AddProduct")
	public String addProduct(HttpSession session) {
		
		return "backstage/product/add-product1";
	}
	
	
	@RequestMapping("/UpdateProduct")
	public String updateProduct() {	
		return "backstage/product/update-product";
	}
	
	
	
}
