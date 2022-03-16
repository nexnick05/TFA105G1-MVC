package com.admin.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;

	public AdminService(AdminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}

	public boolean addAdmin(AdminVO adminVO) {		
		try {
			if (adminVO != null) {
				adminDAO.insert(adminVO);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}

	public AdminVO updateAdmin(AdminVO admin) {
		AdminVO result = null;
		if (admin != null && admin.getEmpno() != null) {
			result = adminDAO.update(admin);
		}
		return result;
	}

	public boolean deleteAdmin(Integer empno) {
		boolean result = false;
		if (empno != null) {
			result = adminDAO.delete(empno);
		}
		return result;
	}

	public List<AdminVO> select(AdminVO admin) {
		List<AdminVO> result = null;
		if (admin != null && admin.getEmpno() != null && !admin.getEmpno().equals(0)) {
			AdminVO temp = adminDAO.select(admin.getEmpno());
			if (temp != null) {
				result = new ArrayList<AdminVO>();
				result.add(temp);
			}
		}
		return result;
	}

	public AdminVO loginAdmin(AdminVO admin) {
		AdminVO result = null;
		if (admin != null && admin.getAccount() != null) {
			result = adminDAO.selectAccount(admin);
			if (result != null) {
				return result;
			}
		}
		return result;
	}

	public List<AdminVO> selectAll() {
		List<AdminVO> results = adminDAO.select();
		return results;

	}

//	public static void main(String[] args) {
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//
//		// insert
//		// 測試序號:
////		String no = "1";
////		AdminVO insertSimple = new AdminVO();
////		insertSimple.setEname("吳" + no + "號");
////		insertSimple.setAccount("100" + no);
////		insertSimple.setPassword("00" + no);
////		session.save(insertSimple);
//		// save()：執行Insert指令，執行成功則回傳Primary Key
//
//		// delete
//		// #1
////		AdminVO delete = session.get(AdminVO.class, 4);
////		session.delete(delete);
//		// #2
////		AdminVO delete = new AdminVO();
////		delete.setEmpno(4);
////		session.delete(delete);
//
//		// update
//		// 測試序號:
////		int no = 1;
////		String updateNo = "1";
////		
////		AdminVO updateAdmin = session.get(AdminVO.class, no);
////		// close...
////		// Open...
////		updateAdmin.setEname("吳" + no + "號");
////		updateAdmin.setAccount("100" + no);
////		updateAdmin.setPassword("00" + no);
//
//		// select
//		// 抓1筆資料：不知道table有沒有id=100的資料，如果沒有則回傳null
////		AdminVO select = (AdminVO) session.get(AdminVO.class, 8);
////		if (select != null) {
////			System.out.println("select=" + select);
////		} else {
////			System.out.println("沒資料");
////		}
//		// 抓1筆資料：確信table有id=10的資料，如果沒有則Exception
////		try {
////			MemberBean select = (MemberBean) session.load(MemberBean.class, 1);
////			System.out.println("select=" + select);
////		} catch (Exception e) {			
////			e.printStackTrace();
////			System.out.println("沒資料");
////		}
//
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
//	}

}
