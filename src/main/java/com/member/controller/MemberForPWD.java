package com.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.Util.AESUtil;
import com.Util.GenerateAlphaNumericString;
import com.Util.MailService;
import com.member.model.MemberService;
import com.member.model.MemberVO;

import redis.clients.jedis.Jedis;

@Controller
@RequestMapping("/MemberInfo")
public class MemberForPWD {

	@PostMapping("/PwdForget")
	public String PwdForget(String FGaction, String FGemail, GenerateAlphaNumericString AlphaNumericString,
			MemberService memberService, MailService mailService, HttpServletRequest req, HttpSession session,
			AESUtil aes) {
		String email = FGemail.trim();
		if ("forgotPWD".equals(FGaction)) {
			Map<String, String> errorCheck = new HashMap<String, String>();
			session.setAttribute("errorCheck", errorCheck);

			int expireTime = 1;

			// check email exit
			Integer memberid = null;
			try {
				memberid = memberService.checkEmail(email);
			} catch (Exception e1) {
				e1.printStackTrace();
				System.out.println("查無此email");
				errorCheck.put("checkEmail", "alert(\'查無此email 請重新輸入');");
			}

			if (errorCheck != null && !errorCheck.isEmpty()) {
				System.out.println(errorCheck);
				return "forward:/download/FS-login.jsp";
			}

			System.out.println("memberid : " + memberid);

			// Generate temp PWD
			String temPWD = AlphaNumericString.getRandomString(10);

			// Redis connection
			try (Jedis jedis = new Jedis("localhost", 6379);) {
				System.out.println("redis ping! ~ " + jedis.ping());

				jedis.setex(email, expireTime * 86400, temPWD);

			} catch (Exception e) {
				e.printStackTrace();
			}
			// Email
			String messageText = "Hello! " + email + "\n" + " (請注意 !!)" + "\n" + "請在" + expireTime
					+ "天內點擊連結變更密碼，時間超過驗證碼自動失效! " + "\n";
			// prefixUrl
			String prefixUrl = "/TFA105G1-MVC/MVC/MemberInfo/return?";
			// suffixUrl
			String suffixUrl = "reAction=forgotPWD&mail=" + email + "&No=" + memberid + "&temPWD=" + temPWD;
			// suffixUrl 加密
			String pwd = "tfa105g1";
			String suffixUrlAES = aes.encode(suffixUrl, pwd);

			String wholeUrl = prefixUrl + suffixUrlAES;

			StringBuffer SBUrl = new StringBuffer(wholeUrl);
			SBUrl.insert(0, req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort());

			String Url = SBUrl.toString();

			mailService.sendMail(FGemail, "忘記密碼通知", messageText + Url);
			System.out.println("驗證信已寄出!");
			return "redirect:/download/FS-login.jsp";
		}
		return "";
	}

	@GetMapping("/return")
	public String returnURL(HttpServletRequest req, AESUtil aes) {

		String pwd = "tfa105g1";
		// QueryString 解密
		String QueryString = aes.decode(req.getQueryString(), pwd);

		return "redirect:/MVC/MemberInfo/changePWD?" + QueryString;
	}

	@GetMapping("/changePWD")
	public String changePWD(String reAction, String No, String temPWD, String mail, HttpSession session, Model model) {

		if ("forgotPWD".equals(reAction)) {
			System.out.println("驗證連結接收!");
			System.out.println("memberid :" + No);
			System.out.println("驗證碼 :" + temPWD);
			String receivePWD = temPWD.trim();
			String userTempPWD = null;

			// 取redis 驗證碼
			try (Jedis jedis = new Jedis("localhost", 6379);) {
				System.out.println("redis驗證 ping! ~ " + jedis.ping());

				userTempPWD = jedis.get(mail);

				if (userTempPWD == null) {
					System.out.println("使用者驗證碼已過期");
					model.addAttribute("verificationFailed", "驗證碼已失效!");
					return "forward:/download/FS-login.jsp";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 驗證 驗證碼
			if (receivePWD.equals(userTempPWD)) {
				System.out.println("驗證碼正確!");

				// 更新舊密碼為新密碼

//				memberService.changePWD(memberid, temPWD);

				System.out.println("rtEmail = " + mail);
				session.setAttribute("no", No);
				session.setAttribute("rtEmail", mail);
				return "redirect:/download/FS-changePWD.jsp";
			}
		}
		model.addAttribute("verificationFailed", "驗證失敗，請重新點擊連結!");
		return "forward:/download/FS-login.jsp";
	}

	@PostMapping("/checkPWD")
	public String checkPWD(String newPWD, String confirm_password, String id, String action,
			MemberService memberService, HttpServletRequest req, HttpSession session) {
		if ("checkPWD".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);

			// 確認來源 或 原來在哪
			System.out.println("改密碼! 有進來");

			String confirmPWD = confirm_password.trim();
			String password = newPWD.trim();
			if (password == null || password.length() == 0) {
				errorMsgs.put("password", "請勿空白");
			}
			if (confirmPWD == null || confirmPWD.length() == 0) {
				errorMsgs.put("confirmPWD", "請勿空白");
			}

			if (!password.equals(confirmPWD)) {
				errorMsgs.put("confirmPWD", "密碼不一致，請重新輸入!");
			}
			// 待測
			if (!errorMsgs.isEmpty()) {
//				req.setAttribute("email", email);  // 看看需不需要回傳mail
				return "forward:/download/FS-changePWD.jsp";
			}

			Integer memberid = Integer.valueOf(id);
			try {
				memberService.changePWD(memberid, newPWD);
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("result", "密碼更新異常! 請重新輸入");
			}
			MemberVO memberVO = memberService.getOneMember(memberid);
			

			String rtEmail = (String) session.getAttribute("rtEmail");
			if (rtEmail != null) {
				session.removeAttribute("rtEmail");
			}

			try (Jedis jedis = new Jedis("localhost", 6379);) {
				System.out.println("redis驗證 ping! ~ " + jedis.ping());

				if (jedis.get(rtEmail) != null) {
					jedis.del(rtEmail);
					System.out.println("redis 清除Email!");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			if (session.getAttribute("memberVO") != null || session.getAttribute("memberid") != null) {
				session.removeAttribute("memberVO");
				session.removeAttribute("memberid");
			}
			req.changeSessionId();
			session.setAttribute("memberVO", memberVO);
			session.setAttribute("memberid", memberid);

			System.out.println("儲存memberVO到session! = " + memberVO);

			String sourceURL = (String) session.getAttribute("sourceURL");
			System.out.println("使用者 想去哪? :" + sourceURL);
			String cameFromURL = (String) session.getAttribute("cameFromURL");
			System.out.println("使用者 登入前在哪? :" + cameFromURL);

			if (sourceURL != null) {
				session.removeAttribute("sourceURL");
//				return "redirect:" + sourceURL;
				return "redirect:" + req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + sourceURL;
			} else if (cameFromURL != null) {
				session.removeAttribute("cameFromURL");
				return "redirect:" + cameFromURL;
			} else {
				return "redirect:/download/homepage2.jsp";
			}

		}
		return "";
	}

}
