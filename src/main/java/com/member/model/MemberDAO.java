package com.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO implements MemberDAO_interface {

	private static DataSource ds = null;

	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/tfa105g1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String FIND_FOR_LOGIN_STMT = "SELECT \r\n"
			+ "	MEMBER_ID, EMAIL, `PASSWORD`, FIRST_NAME, LAST_NAME, GENDER, ID_NO, DATE_OF_BIRTH, COUNTRY, PHONE, POINTS, NICKNAME, SELF_INTRO\r\n"
			+ "FROM MEMBER\r\n" + "WHERE EMAIL = ? AND `PASSWORD` = ?";

	@Override
	public MemberVO login(String email, String password) {

		MemberVO memberVO = null;
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(FIND_FOR_LOGIN_STMT)) {

			pstmt.setString(1, email);
			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMemberid(rs.getInt("MEMBER_ID"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setPassword(rs.getString("PASSWORD"));
				memberVO.setFirstname(rs.getString("FIRST_NAME"));
				memberVO.setLastname(rs.getString("LAST_NAME"));
				memberVO.setIdno(rs.getString("ID_NO"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setDateofbirth(rs.getDate("DATE_OF_BIRTH"));
				memberVO.setCountry(rs.getString("COUNTRY"));
				memberVO.setPhone(rs.getString("PHONE"));
				memberVO.setPoints(rs.getInt("POINTS"));
				memberVO.setNickname(rs.getString("NICKNAME"));
				memberVO.setSelfintro(rs.getString("SELF_INTRO"));

			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
		return memberVO;
	}

	private static final String INSERT_STMT = "insert into MEMBER\r\n"
			+ "	(EMAIL, `PASSWORD`, FIRST_NAME, LAST_NAME, GENDER, ID_NO, DATE_OF_BIRTH, COUNTRY, PHONE, NICKNAME, SELF_INTRO)\r\n"
			+ "value\r\n" + "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	@Override
	public void insert(MemberVO memberVO) {

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(INSERT_STMT)) {

			pstmt.setString(1, memberVO.getEmail());
			pstmt.setString(2, memberVO.getPassword());
			pstmt.setString(3, memberVO.getFirstname());
			pstmt.setString(4, memberVO.getLastname());
			pstmt.setString(5, memberVO.getGender());
			pstmt.setString(6, memberVO.getIdno());
			pstmt.setDate(7, memberVO.getDateofbirth());
			pstmt.setString(8, memberVO.getCountry());
			pstmt.setString(9, memberVO.getPhone());
			pstmt.setString(10, memberVO.getNickname());
			pstmt.setString(11, memberVO.getSelfintro());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
	}

	private static final String UPDATE = "UPDATE MEMBER\r\n" + "SET\r\n"
			+ " EMAIL = ?, `PASSWORD` = ?, FIRST_NAME = ?, LAST_NAME = ?, ID_NO = ?, GENDER = ?, DATE_OF_BIRTH = ?, COUNTRY = ?, NICKNAME = ?, PHONE = ?\r\n"
			+ "WHERE MEMBER_ID = ?";
	private static final String UPDATEBS = "UPDATE MEMBER\r\n" + "SET\r\n"
			+ " EMAIL = ?, FIRST_NAME = ?, LAST_NAME = ?, ID_NO = ?, GENDER = ?, DATE_OF_BIRTH = ?, COUNTRY = ?, NICKNAME = ?, PHONE = ?\r\n"
			+ "WHERE MEMBER_ID = ?";

	@Override
	public void update(MemberVO memberVO) {

		try (Connection con = ds.getConnection();) {
			if (memberVO.getPassword() != null) {
				try (PreparedStatement pstmt = con.prepareStatement(UPDATE);) {
					pstmt.setString(1, memberVO.getEmail());
					pstmt.setString(2, memberVO.getPassword());
					pstmt.setString(3, memberVO.getFirstname());
					pstmt.setString(4, memberVO.getLastname());
					pstmt.setString(5, memberVO.getIdno());
					pstmt.setString(6, memberVO.getGender());
					pstmt.setDate(7, memberVO.getDateofbirth());
					pstmt.setString(8, memberVO.getCountry());
					pstmt.setString(9, memberVO.getNickname());
					pstmt.setString(10, memberVO.getPhone());
					pstmt.setInt(11, memberVO.getMemberid());

					pstmt.executeUpdate();
				}
			} else {
				try (PreparedStatement pstmt = con.prepareStatement(UPDATEBS);) {
					pstmt.setString(1, memberVO.getEmail());
					pstmt.setString(2, memberVO.getFirstname());
					pstmt.setString(3, memberVO.getLastname());
					pstmt.setString(4, memberVO.getIdno());
					pstmt.setString(5, memberVO.getGender());
					pstmt.setDate(6, memberVO.getDateofbirth());
					pstmt.setString(7, memberVO.getCountry());
					pstmt.setString(8, memberVO.getNickname());
					pstmt.setString(9, memberVO.getPhone());
					pstmt.setInt(10, memberVO.getMemberid());

					pstmt.executeUpdate();
				}
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
	}

	private static final String DELETE = "DELETE FROM MEMBER where MEMBER_ID = ?";

	@Override
	public void delete(Integer memberid) {

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(DELETE)) {

			pstmt.setInt(1, memberid);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		}
	}

	private static final String GET_ONE_STMT = "SELECT\r\n"
			+ "	MEMBER_ID, EMAIL, `PASSWORD`, FIRST_NAME, LAST_NAME, GENDER, ID_NO, DATE_OF_BIRTH, COUNTRY, PHONE, POINTS, NICKNAME, AVATAR, SELF_INTRO\r\n"
			+ "FROM MEMBER\r\n" + "WHERE MEMBER_ID = ?";

	@Override
	public MemberVO findByPrimaryKey(Integer memberid) {
		MemberVO memberVO = null;

		ResultSet rs = null;

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(GET_ONE_STMT)) {

			pstmt.setInt(1, memberid);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMemberid(rs.getInt("MEMBER_ID"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setPassword(rs.getString("PASSWORD"));
				memberVO.setFirstname(rs.getString("FIRST_NAME"));
				memberVO.setLastname(rs.getString("LAST_NAME"));
				memberVO.setIdno(rs.getString("ID_NO"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setDateofbirth(rs.getDate("DATE_OF_BIRTH"));
				memberVO.setCountry(rs.getString("COUNTRY"));
				memberVO.setPhone(rs.getString("PHONE"));
				memberVO.setNickname(rs.getString("NICKNAME"));
				memberVO.setSelfintro(rs.getString("SELF_INTRO"));
				memberVO.setAvatar(rs.getBytes("AVATAR"));
			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
		return memberVO;
	}

	private static final String GET_ALL_STMT = "SELECT\r\n"
			+ "	MEMBER_ID, EMAIL, `PASSWORD`, FIRST_NAME, LAST_NAME, GENDER, ID_NO, DATE_OF_BIRTH, COUNTRY, PHONE, POINTS, NICKNAME, SELF_INTRO\r\n"
			+ "FROM MEMBER\r\n" + "order by MEMBER_ID";

	@Override
	public List<MemberVO> getAll() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(GET_ALL_STMT)) {

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMemberid(rs.getInt("MEMBER_ID"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setPassword(rs.getString("PASSWORD"));
				memberVO.setFirstname(rs.getString("FIRST_NAME"));
				memberVO.setLastname(rs.getString("LAST_NAME"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setIdno(rs.getString("ID_NO"));
				memberVO.setDateofbirth(rs.getDate("DATE_OF_BIRTH"));
				memberVO.setCountry(rs.getString("COUNTRY"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setPoints(rs.getInt("PHONE"));
				memberVO.setNickname(rs.getString("NICKNAME"));
				memberVO.setSelfintro(rs.getString("SELF_INTRO"));

				list.add(memberVO);
			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		}
		return list;
	}

	private static final String UPLOADPIC = "UPDATE MEMBER \r\n" + "SET \r\n" + "	AVATAR = ?\r\n"
			+ "WHERE MEMBER_ID = ?";

	@Override
	public void uploadPic(MemberVO memberVO) {

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(UPLOADPIC)) {

			pstmt.setBytes(1, memberVO.getAvatar());
			pstmt.setInt(2, memberVO.getMemberid());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
	}

	private static final String changePWD = "UPDATE MEMBER SET password = ? WHERE MEMBER_ID = ?";

	@Override
	public void changePWD(Integer memberid, String password) {
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(changePWD)) {

			pstmt.setString(1, password);
			pstmt.setInt(2, memberid);

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
	}

	private static final String checkEmail = "SELECT MEMBER_ID FROM MEMBER WHERE EMAIL = ?";

	@Override
	public Integer checkEmail(String email) {
		Integer memberid = null;
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(checkEmail)) {
			pstmt.setString(1, email);

			ResultSet rs = pstmt.executeQuery();
			rs.next();
			memberid = rs.getInt("MEMBER_ID");

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}
		return memberid;
	}

}