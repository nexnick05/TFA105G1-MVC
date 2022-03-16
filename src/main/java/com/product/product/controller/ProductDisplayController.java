package com.product.product.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.engine.query.spi.sql.NativeSQLQueryCollectionReturn;
import org.hibernate.query.NativeQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.order.orderdetail.model.OrderdetailBean;
import com.product.city.model.CityBean;
import com.product.product.model.ProductBean;
import com.product.product.model.ProductDAOHibernate;
import com.product.product.model.ProductService;
import com.product.productcomment.model.ProductCommentBean;
import com.product.productcomment.model.ProductCommentService;
import com.product.productimg.model.ProductImgBean;

import redis.clients.jedis.Jedis;

@Controller
public class ProductDisplayController {

	@Autowired
	private ProductService productService;

	@Autowired
	private ProductCommentService productCommentService;

	@PersistenceContext
	private Session session;

//	@InitBinder
//	public void initMethod(WebDataBinder binder, HttpServletRequest req) throws UnsupportedEncodingException {
//		
//		req.setCharacterEncoding("UTF-8");

//		binder.registerCustomEditor(java.sql.Date.class, 
//				new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
//		
//		binder.registerCustomEditor(Integer.class, new CustomNumberEditor(Integer.class, true));
//		
//		binder.registerCustomEditor(Double.class, new CustomNumberEditor(Double.class, true));
//	}

	@RequestMapping("/ProductDisplayController")
	public String displayAll(HttpSession session, String page, Model model, String keyword, String price, String type,
			String[] city, String[] time) {

		session.removeAttribute("keyword");
		session.removeAttribute("type");
		session.removeAttribute("price");

		// 搜尋關鍵字過濾 類別過濾
		List<ProductBean> list = null;
//		System.out.println(type);
		if (type != null && !"產品分類".equals(type) && keyword != null && keyword != "") {
			String keyword2 = keyword.trim();
			NativeQuery query = this.session.createSQLQuery("select * from product where product_name like '%"
					+ keyword2 + "%' and " + "product_type = '" + type + "' ");
			query.addEntity(ProductBean.class);
			list = (List<ProductBean>) query.list();
			session.setAttribute("keyword", keyword);
			session.setAttribute("type", type);

		} else if (keyword != null && keyword != "") {
			String keyword2 = keyword.trim();
			NativeQuery query = this.session
					.createSQLQuery("select * from product where product_name like '%" + keyword2 + "%'");
			query.addEntity(ProductBean.class);
			list = (List<ProductBean>) query.list();
			session.setAttribute("keyword", keyword);
		} else if (type != null && !"產品分類".equals(type)) {
			NativeQuery query = this.session
					.createSQLQuery("select * from product where product_type = '" + type + "' ");
			query.addEntity(ProductBean.class);
			list = (List<ProductBean>) query.list();
			session.setAttribute("type", type);

		} else {
			list = productService.select(null);
		}

		// 價錢過濾
		Integer price1 = 0;
		if (price != null) {
			price1 = Integer.parseInt(price);
		}
		if (price1 != 0) {
			session.setAttribute("price", price);
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getProductprice() > price1) {
					list.remove(list.get(i));
					i--;
				}
			}
		}

		//上架過濾
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getState() == 0) {
				list.remove(list.get(i));
				i--;
			}
		}

		// 縣市過濾
		if (city != null && city.length != 0) {
			for (int i = 0; i < list.size(); i++) {
				NativeQuery query = this.session
						.createSQLQuery("SELECT c.CITY_ID, c.CITY, c.AREA \r\n" + "FROM PRODUCT p \r\n"
								+ "	join PRODUCT_LOC pl\r\n" + "		on p.PRODUCT_ID = pl.PRODUCT_ID\r\n"
								+ "         join City c \r\n" + "			on c.CITY_ID = pl.CITY_ID\r\n"
								+ "where p.PRODUCT_ID = " + list.get(i).getProductid());
				query.addEntity(CityBean.class);
				CityBean bean = ((List<CityBean>) query.list()).get(0);
				String cityString = bean.getCity();
				boolean a = false;
				for (int j = 0; j < city.length; j++) {
					if (cityString.equals(city[j])) {
						a = true;
					}
				}

				if (a != true) {
					list.remove(list.get(i));
					i--;
				}

			}
		}

		if (time != null && time.length != 0) {
			int total = list.size();
			List<ProductBean> newlist = new ArrayList<ProductBean>();
			for (int i = 0; i < total; i++) {
				if (Arrays.asList(time).contains("a") && list.get(i).getTraveltime() < 4) {
					newlist.add(list.get(i));
				}
				if (Arrays.asList(time).contains("b") && list.get(i).getTraveltime() >= 4
						&& list.get(i).getTraveltime() < 24) {
					newlist.add(list.get(i));
				}
				if (Arrays.asList(time).contains("c") && list.get(i).getTraveltime() >= 24
						&& list.get(i).getTraveltime() < 48) {
					newlist.add(list.get(i));
				}
				if (Arrays.asList(time).contains("d") && list.get(i).getTraveltime() >= 48) {
					newlist.add(list.get(i));
				}
			}

			session.setAttribute("list", newlist);

		} else {
			session.setAttribute("list", list);
		}

		session.setAttribute("totalproduct", list.size());
//		session.setAttribute("list", list);
		return "redirect:/MVC/PageHandler";

	}

	@RequestMapping("/PageHandler")
	public String pageHandler(HttpSession session, String page, Model model) {

		List<ProductBean> list = (List<ProductBean>) session.getAttribute("list");
		
		if(list==null) {
			list = productService.select(null);
		}
		

//		找出總共該有幾頁
		int totalpage = 0;
		if (list.size() % 4 == 0) {
			totalpage = list.size() / 4;
		} else {
			totalpage = (list.size() / 4) + 1;
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

		for (int i = (pageindex - 1) * 4; i <= ((pageindex * 4) - 1); i++) {
			if ((i + 1) <= list.size()) {
				list2.add(list.get(i));
			}
		}
		

//		找出此頁該顯示的圖片們 商品的訂購數量
		List imgids = new ArrayList();
		List<Integer> commentcount = new ArrayList<Integer>();
		List<Double> avg = new ArrayList<Double>();
		List<String> cities = new ArrayList<String>();
		List<Integer> orders = new ArrayList<Integer>();
		Connection connection;
		try {
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei",
					"root", "password");

			for (int i = 0; i < list2.size(); i++) {
				if (list2.get(i) != null) {
					PreparedStatement ps = connection
							.prepareStatement("SELECT * FROM PRODUCT_IMG where PRODUCT_ID = ? limit 1");
					ps.setInt(1, list2.get(i).getProductid());
					ResultSet rSet = ps.executeQuery();

					while (rSet.next()) {
						imgids.add(rSet.getInt(1));
					}

					// 以下找出有幾則評論
					ps = connection.prepareStatement("SELECT COUNT(*) FROM PRODUCT_COMMENT WHERE PRODUCT_ID = ?");
					ps.setInt(1, list2.get(i).getProductid());
					rSet = ps.executeQuery();

					while (rSet.next()) {
						commentcount.add(rSet.getInt(1));
					}

					// 以下找出平均分數

					ps = connection.prepareStatement("SELECT AVG(SCORE) FROM PRODUCT_COMMENT WHERE PRODUCT_ID = ?");
					ps.setInt(1, list2.get(i).getProductid());
					rSet = ps.executeQuery();

					while (rSet.next()) {
						DecimalFormat df = new DecimalFormat("#.#");
						avg.add(Double.valueOf(df.format(rSet.getDouble(1))));
					}

					// 以下找出所在城市
					ps = connection
							.prepareStatement("SELECT c.CITY\r\n" + "FROM PRODUCT p \r\n" + "	join PRODUCT_LOC pl\r\n"
									+ "		on p.PRODUCT_ID = pl.PRODUCT_ID\r\n" + "         join City c \r\n"
									+ "			on c.CITY_ID = pl.CITY_ID\r\n" + "where p.PRODUCT_ID = ?");
					ps.setInt(1, list2.get(i).getProductid());
					rSet = ps.executeQuery();

					while (rSet.next()) {
						cities.add(rSet.getString(1));
					}
					
					//以下找出訂購數量
					ps = connection
							.prepareStatement("select COUNT(1) from order_detail where PRODUCT_ID = ?");
					ps.setInt(1, list2.get(i).getProductid());
					rSet = ps.executeQuery();

					while (rSet.next()) {
						orders.add(rSet.getInt(1));
					}
					
					
					

					rSet.close();
					ps.close();
				}
			}

			connection.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 顯示哪幾筆介紹
		List<String> introStrings = new ArrayList<String>();
		for (int i = 0; i < list2.size(); i++) {
			String string = list2.get(i).getProductintro();
//			String[] strs = string.split("<br>");
//			String a = strs[0]+strs[1];
//			String a = string.substring(0, 50);
			String a = string.replaceAll("<br>", " ");
			a = a.substring(0, 50);

			introStrings.add(a);
		}
		
		//是否收藏
		Jedis jedis = new Jedis("localhost", 6379);
		List<Boolean> exists = new ArrayList<Boolean>();
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		if(memberid!=null) {
			String memberidstring = String.valueOf(memberid);
			List<String> range2 = jedis.lrange("會員收藏"+memberidstring, 0, -1);
			for(int i =0; i < list2.size(); i++) {
				boolean a = false;
				for (String product : range2) {
					if(Integer.valueOf(product) ==list2.get(i).getProductid()){
						exists.add(true);
						a = true;
					}
				}
				
				if(!a)
				exists.add(false);
			}
			
		}

		model.addAttribute("exists", exists);
		model.addAttribute("orders", orders);
		model.addAttribute("cities", cities);
		model.addAttribute("avg", avg);
		model.addAttribute("commentcount", commentcount);
		model.addAttribute("introStrings", introStrings);
		model.addAttribute("keyword", session.getAttribute("keyword"));
//		session.removeAttribute("keyword");
		model.addAttribute("type", session.getAttribute("type"));
//		session.removeAttribute("type");
		model.addAttribute("price", session.getAttribute("price"));
//		session.removeAttribute("price");
		model.addAttribute("page", page);
		model.addAttribute("list2", list2);
		model.addAttribute("imgids", imgids);

		return "frontstage/product/product-display";
	}

	@RequestMapping("/ProductDetail")
	public String productDetail(String productid, Model model, HttpSession session) {

//		session.setAttribute("memberid", 2);//先假裝有會員登入

		ProductBean bean = new ProductBean();
		Integer productidint = Integer.valueOf(productid);
		bean.setProductid(productidint);
		List list = (List) productService.select(bean);
		ProductBean bean2 = (ProductBean) list.get(0);
		model.addAttribute("ProductBean", bean2);

		Connection connection;
		List imgids = new ArrayList<Integer>();
		List<ProductCommentBean> comments = new ArrayList<ProductCommentBean>();

		try {
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei",
					"root", "password");

			PreparedStatement ps = connection.prepareStatement("SELECT * FROM PRODUCT_IMG where PRODUCT_ID = ? ");
			ps.setInt(1, productidint);
			ResultSet rSet = ps.executeQuery();

			while (rSet.next()) {
				imgids.add(rSet.getInt(1));
			}

			ps = connection.prepareStatement("SELECT * FROM PRODUCT_COMMENT where PRODUCT_ID = ? ");
			ps.setInt(1, productidint);
			ResultSet rSet2 = ps.executeQuery();

			while (rSet2.next()) {
				ProductCommentBean productcomment = new ProductCommentBean();
				productcomment.setCommentid(rSet2.getInt(1));
				comments.add(productCommentService.select(productcomment).get(0));
			}

			rSet2.close();
			rSet.close();
			ps.close();
			connection.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 以下抓縣市資料
		NativeQuery query = this.session
				.createSQLQuery("SELECT * FROM CITY\r\n" + "where CITY_ID = (SELECT CITY_ID \r\n"
						+ "FROM  PRODUCT_LOC \r\n" + "where PRODUCT_ID = " + productid + ")");
		query.addEntity(CityBean.class);
		List<CityBean> listcity = (List<CityBean>) query.list();
		model.addAttribute("cities", listcity);

		// 以下抓評分等級 (平均幾分)

		Double ttlScore = 0.0;
		if (comments != null && comments.size() != 0) {
			for (int i = 0; i < comments.size(); i++) {
				ttlScore = ttlScore + comments.get(i).getScore();
			}

			Double avgScore = ttlScore / comments.size();
			DecimalFormat df = new DecimalFormat("#.#");

			avgScore = Double.valueOf(df.format(avgScore));
			model.addAttribute("avgScore", avgScore);

		}

		// 以下判斷是否有評論資格
		if (session.getAttribute("memberid") != null) {
			Integer memberid = (Integer) session.getAttribute("memberid");

			NativeQuery query2 = this.session.createSQLQuery("select * \r\n" + "from ordertest ot\r\n"
					+ "	join order_detail od\r\n" + "    on ot.order_id = od.order_id\r\n" + "where member_id = "
					+ memberid + " and product_id = " + productid);
			query2.addEntity(OrderdetailBean.class);
			List<OrderdetailBean> listorderdetail = (List<OrderdetailBean>) query2.list();
			
			NativeQuery query3 = this.session.createSQLQuery("SELECT * FROM PRODUCT_COMMENT "
					+ "where MEMBER_ID = " + memberid +" and product_id = " + productid);
			query3.addEntity(ProductCommentBean.class);
			List<ProductCommentBean> listcomment = (List<ProductCommentBean>) query3.list();
			
			
			if (listorderdetail.size() != 0 && listcomment.size()==0) {
				model.addAttribute("commemtok", true);
			} else {
				model.addAttribute("commemtok", false);
			}

		}
		
		
		Jedis jedis = new Jedis("localhost", 6379);
		boolean exist = false;
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		if(memberid!=null) {
			String memberidstring = String.valueOf(memberid);
			List<String> range2 = jedis.lrange("會員收藏"+memberidstring, 0, -1);
			for (String product : range2) {
				if(product.equals(productid))
				exist=true;
			}
			
		}
		

		MemberService memberService = new MemberService();
		List<MemberVO> members = memberService.getAll();
		model.addAttribute("members", members);

		model.addAttribute("imgids", imgids);
		model.addAttribute("exist", exist);
		
		model.addAttribute("comments", comments);

		return "frontstage/product/product-detail";
	}

	@RequestMapping("/ShoppingCart")
	public String shoppingCart(Model model, HttpSession session) {
		
//		session.setAttribute("memberid", 3);
		
		if(session.getAttribute("memberid")==null) {	
			return "frontstage/member/FS-login";
		};

		
		Jedis jedis = new Jedis("localhost", 6379);
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		String memberidstring = String.valueOf(memberid);
		List<Integer> productids = new ArrayList<Integer>();
		List<ProductBean> list = new ArrayList<ProductBean>();
		
		List<String> range2 = jedis.lrange("會員"+memberidstring, 0, -1);
		
		if(range2!=null && range2.size()!=0) {
			for (String product : range2) {
				productids.add(Integer.valueOf(product));
			}			
		}
		
		jedis.close();

		Integer totalprice = 0;
		
		List<Integer> imgids = new ArrayList<Integer>();
		
		for (Integer productid : productids) {
			//以下找出哪些商品
			ProductBean bean = new ProductBean();
			bean.setProductid(productid);
			list.add(productService.select(bean).get(0));
			totalprice = totalprice + productService.select(bean).get(0).getProductprice();
			
			//以下找出哪些圖片
			NativeQuery query = this.session.createSQLQuery(
					"select * from PRODUCT_IMG where PRODUCT_ID = "+ productid +" limit 1"
				);
				query.addEntity(ProductImgBean.class);
				List<ProductImgBean> imgs = (List<ProductImgBean>) query.list();
				imgids.add(imgs.get(0).getImgid());
			
			
		}
		
		//以下找城市跟平均分數
		List<Double> avg = new ArrayList<Double>();
		List<String> cities = new ArrayList<String>();
		Connection connection;
				try {
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei",
							"root", "password");

					for (int i = 0; i < list.size(); i++) {
						if (list.get(i) != null) {
	
							//以下找出平均分數
							
							PreparedStatement ps = connection
									.prepareStatement("SELECT AVG(SCORE) FROM PRODUCT_COMMENT WHERE PRODUCT_ID = ?");
							ps.setInt(1, list.get(i).getProductid());
							ResultSet rSet = ps.executeQuery();

							while (rSet.next()) {
								DecimalFormat df = new DecimalFormat("#.#");
								avg.add(Double.valueOf(df.format(rSet.getDouble(1))));
							}
							
							
							//以下找出所在城市
							ps = connection
									.prepareStatement("SELECT c.CITY\r\n"
											+ "FROM PRODUCT p \r\n"
											+ "	join PRODUCT_LOC pl\r\n"
											+ "		on p.PRODUCT_ID = pl.PRODUCT_ID\r\n"
											+ "         join City c \r\n"
											+ "			on c.CITY_ID = pl.CITY_ID\r\n"
											+ "where p.PRODUCT_ID = ?");
							ps.setInt(1, list.get(i).getProductid());
							rSet = ps.executeQuery();

							while (rSet.next()) {
								cities.add(rSet.getString(1));
							}
						}
					}
						}catch (Exception e) {
							e.printStackTrace();
						}
		
		model.addAttribute("avg", avg);
		model.addAttribute("cities", cities);	
		model.addAttribute("imgids", imgids);
		model.addAttribute("list", list);
		model.addAttribute("totalprice", totalprice);
	
	
		return "frontstage/product/shopping-cart";
	}

	//以下寄信給網址用
	@RequestMapping("/AddComment")
	public String addComment(HttpSession session, String memberid, String productid) {

		// 網址 /MVC/AddComment?productid=x&memberid=y
		session.setAttribute("memberid", Integer.valueOf(memberid));

		return "redirect:/MVC/ProductDetail?productid=" + productid;
	}

	@RequestMapping(value = "/AddRealComment", produces = "application/html; charset=utf-8")
	public @ResponseBody String addRealComment(HttpSession session, String productid, String commentcontext,
			String score, HttpServletRequest req) {

		ProductCommentBean bean = new ProductCommentBean();
		Integer memberid = (Integer) session.getAttribute("memberid");
		Integer score1 = Integer.valueOf(score);

		bean.setMemberid(memberid);
		bean.setProductid(Integer.valueOf(productid));
		bean.setCommentcontext(commentcontext);
		bean.setScore(score1);
		bean.setCommentrewardpoints(10);
		bean.setCommenttime(new Timestamp(System.currentTimeMillis()));

		productCommentService.insert(bean);

		MemberService memberService = new MemberService();
		MemberVO bean2 = memberService.getOneMember(memberid);
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		df.format(new Timestamp(System.currentTimeMillis()));
		String nickname = bean2.getNickname();
		if (nickname == null) {
			nickname = bean2.getFirstname();
		}

		return "<div class=\"review-box\">\r\n" + "  <ul class=\"review_wrap\">\r\n" + "    <li>\r\n"
				+ "      <div class=\"customer-review_wrap\">\r\n" + "        <div class=\"reviewer-img\">\r\n"
				+ "          <img src=\"" + req.getContextPath() + "/member/member.pic?memberid=" + memberid + "\">\r\n"
				+ "          <p>" + nickname + " </p>\r\n" + "        </div>\r\n"
				+ "        <div class=\"customer-content-wrap\">\r\n" + "          <div class=\"customer-content\">\r\n"
				+ "            <div class=\"customer-review\">\r\n" + "              <h6>" + commentcontext
				+ "</h6>\r\n" + "              <p>於&nbsp" + df.format(new Timestamp(System.currentTimeMillis()))
				+ "&nbsp評論</p>\r\n" + "            </div>\r\n" + "            <div class=\"customer-rating\">" + score1
				+ " </div>\r\n" + "          </div>\r\n" 
				//以下新增部分 編輯 修改
				+"<div class=\"like-btn mar-top-40\">\r\n"
				+ "                                                    	<form method=\"post\" action=\""+ req.getContextPath()+"/MVC/DeleteComment\">\r\n"
				+ "<!--                                                         <a href=\"#\" class=\"rate-review float-left\"><i class=\"icofont-thumbs-up\"></i><span>2</span></a> -->\r\n"
				+ "                                                        <input type=\"submit\" value=\"刪除\" class=\"rate-review float-right\">\r\n"
				+ "                                                        <input type=\"button\" value=\"修改\" class=\"rate-review float-right updatecomment\" onclick=\"update(event)\">\r\n"
				+ "                                                        <input type=\"hidden\" name=\"commentid\" value=\""+ bean.getCommentid()+"\">\r\n"
				+ "                                                        <input type=\"hidden\" name=\"productid\" value=\""+ productid +"\">\r\n"
				+ "                                                        \r\n"
				+ "                                                        </form>\r\n"
				+ "                                                    </div>"
				//以上新增部分 編輯 修改
				+"        </div>\r\n" + "      </div>\r\n" + "</div>";
	}

	
	
	
	@RequestMapping("/DeleteComment")
	public String deleteComment(HttpSession session, String commentid, String productid) {
		
		ProductCommentBean bean = new ProductCommentBean();
		bean.setCommentid(Integer.valueOf(commentid));
		productCommentService.delete(bean);
		
		
		return "redirect:/MVC/ProductDetail?productid=" + productid + "#reviews";
	}
	
	
	
	@RequestMapping("/UpdateComment")
	public String updateComment(HttpSession session, String commentid, String productid, String commentcontext,
			String score) {
		
		
		ProductCommentBean bean = new ProductCommentBean();
		
		Integer memberid = (Integer) session.getAttribute("memberid");
		Integer score1 = 0 ;
		if(score!="" && score!=null) {
			score1 = Integer.valueOf(score);
		}
		
		System.out.println("有跑這段");

		bean.setCommentid(Integer.valueOf(commentid));
		bean.setMemberid(memberid);
		bean.setProductid(Integer.valueOf(productid));
		bean.setCommentcontext(commentcontext);
		bean.setScore(score1);
		bean.setCommentrewardpoints(10);
		bean.setCommenttime(new Timestamp(System.currentTimeMillis()));
		
		productCommentService.update(bean);
		
		
		return "redirect:/MVC/ProductDetail?productid=" + productid + "#reviews";
	}
	
	
	
	
	@RequestMapping("/Mylikes")
	public String myLikes(Model model, HttpSession session) {
		
//		session.setAttribute("memberid", 3);
		
		if(session.getAttribute("memberid")==null) {	
			return "frontstage/member/FS-login";
		};

		
		Jedis jedis = new Jedis("localhost", 6379);
		
		Integer memberid = (Integer)session.getAttribute("memberid");
		String memberidstring = String.valueOf(memberid);
		List<Integer> productids = new ArrayList<Integer>();
		List<ProductBean> list = new ArrayList<ProductBean>();
		
		List<String> range2 = jedis.lrange("會員收藏"+memberidstring, 0, -1);
		
		if(range2!=null && range2.size()!=0) {
			for (String product : range2) {
				productids.add(Integer.valueOf(product));
			}			
		}
		
		jedis.close();

		Integer totalprice = 0;
		
		List<Integer> imgids = new ArrayList<Integer>();
		
		for (Integer productid : productids) {
			//以下找出哪些商品
			ProductBean bean = new ProductBean();
			bean.setProductid(productid);
			list.add(productService.select(bean).get(0));
			totalprice = totalprice + productService.select(bean).get(0).getProductprice();
			
			//以下找出哪些圖片
			NativeQuery query = this.session.createSQLQuery(
					"select * from PRODUCT_IMG where PRODUCT_ID = "+ productid +" limit 1"
				);
				query.addEntity(ProductImgBean.class);
				List<ProductImgBean> imgs = (List<ProductImgBean>) query.list();
				imgids.add(imgs.get(0).getImgid());
			
			
		}
		
		//以下找城市跟平均分數
		List<Double> avg = new ArrayList<Double>();
		List<String> cities = new ArrayList<String>();
		Connection connection;
				try {
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFA105G1?serverTimezone=Asia/Taipei",
							"root", "password");

					for (int i = 0; i < list.size(); i++) {
						if (list.get(i) != null) {
	
							//以下找出平均分數
							
							PreparedStatement ps = connection
									.prepareStatement("SELECT AVG(SCORE) FROM PRODUCT_COMMENT WHERE PRODUCT_ID = ?");
							ps.setInt(1, list.get(i).getProductid());
							ResultSet rSet = ps.executeQuery();

							while (rSet.next()) {
								DecimalFormat df = new DecimalFormat("#.#");
								avg.add(Double.valueOf(df.format(rSet.getDouble(1))));
							}
							
							
							//以下找出所在城市
							ps = connection
									.prepareStatement("SELECT c.CITY\r\n"
											+ "FROM PRODUCT p \r\n"
											+ "	join PRODUCT_LOC pl\r\n"
											+ "		on p.PRODUCT_ID = pl.PRODUCT_ID\r\n"
											+ "         join City c \r\n"
											+ "			on c.CITY_ID = pl.CITY_ID\r\n"
											+ "where p.PRODUCT_ID = ?");
							ps.setInt(1, list.get(i).getProductid());
							rSet = ps.executeQuery();

							while (rSet.next()) {
								cities.add(rSet.getString(1));
							}
						}
					}
						}catch (Exception e) {
							e.printStackTrace();
						}
		
		model.addAttribute("avg", avg);
		model.addAttribute("cities", cities);	
		model.addAttribute("imgids", imgids);
		model.addAttribute("list", list);

	
	
		return "frontstage/product/mylikes";
	}
	
	
	
	
}
