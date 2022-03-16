package com.member.model;

import java.util.List;

public class MemberService {

	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberDAO();
	}

	public MemberVO memberLogin(String email, String password) {
		return dao.login(email, password);
	}

	public void changePWD(Integer memberid, String password) {
		dao.changePWD(memberid, password);
	}

	public Integer checkEmail(String email) {
		return dao.checkEmail(email);
	}

	public MemberVO addMember(MemberVO memberVO) {

		MemberVO memberVO1 = new MemberVO();

		memberVO1.setEmail(memberVO.getEmail());
		memberVO1.setPassword(memberVO.getPassword());
		memberVO1.setFirstname(memberVO.getFirstname());
		memberVO1.setLastname(memberVO.getLastname());
		memberVO1.setIdno(memberVO.getIdno());
		memberVO1.setGender(memberVO.getGender());
		memberVO1.setDateofbirth(memberVO.getDateofbirth());
		memberVO1.setCountry(memberVO.getCountry());
		memberVO1.setPhone(memberVO.getPhone());
		memberVO1.setNickname(memberVO.getNickname());
		memberVO1.setSelfintro(memberVO.getSelfintro());
		dao.insert(memberVO1);
		Integer newId = dao.checkEmail(memberVO.getEmail());
		memberVO1.setMemberid(newId);
		return memberVO1;
	}

	public MemberVO updateMember(MemberVO memberVO) {
		dao.update(memberVO);
		Integer memberid = memberVO.getMemberid();
		MemberVO newMemberVO = dao.findByPrimaryKey(memberid);
		return newMemberVO;
	}

	public void uploadPic(Integer memberid, byte[] buf) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberid(memberid);
		memberVO.setAvatar(buf);
		dao.uploadPic(memberVO);
	}

	public void deleteMember(Integer memberid) {
		dao.delete(memberid);
	}

	public MemberVO getOneMember(Integer memberid) {
		return dao.findByPrimaryKey(memberid);
	}

	public List<MemberVO> getAll() {
		return dao.getAll();
	}

	public MemberVO readPic(Integer memberid) {
		return dao.findByPrimaryKey(memberid);
	}
}
