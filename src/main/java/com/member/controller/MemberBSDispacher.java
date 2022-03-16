package com.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@Controller
@RequestMapping("/MemberDispacher")
public class MemberBSDispacher {

	@RequestMapping("/MemberManage")
	public String memberManage(Model model, MemberService memberSvc) {
		List<MemberVO> list = memberSvc.getAll();
		model.addAttribute("memberList", list);
		return "backstage/member/BS-member_manage";
	}
	
	@RequestMapping("/AddMember")
	public String AddMember() {
		return "backstage/member/BS-add-member";
	}
	
	@RequestMapping("/EditMember")
	public String EditMember(@RequestAttribute("memberVO") MemberVO memberVO, Model model) {
		model.addAttribute("memberVO", memberVO);
		return "backstage/member/BS-edit-member";
	}
	
	@RequestMapping("/ListOneMember")
	public String ListOneMember() {
		return "backstage/member/BS-listOneMember";
	}
	
//	@RequestMapping(value = "/MemberUpdatePic", method=RequestMethod.GET)
	@GetMapping("/MemberUpdatePic")
	public String MemberUpdatePic(HttpServletRequest req , Model model, String action, String memberid) {
		Integer id = Integer.valueOf(memberid);
		model.addAttribute("action", action);
		model.addAttribute("memberid", id);
		
		return "backstage/member/BS-update-image";
	}
	
}
