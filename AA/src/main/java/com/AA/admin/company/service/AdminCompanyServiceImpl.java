package com.AA.admin.company.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.AA.admin.company.dao.AdminCompanyDAO;
import com.AA.company.vo.CompanyVO;


@Service("adminCompanyService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminCompanyServiceImpl implements AdminCompanyService {
	@Autowired
	private AdminCompanyDAO adminCompanyDAO;
	
	public List<CompanyVO> listCompany(Map condMap) throws Exception{
		return adminCompanyDAO.listCompany(condMap);
	}

	
	  public CompanyVO companyDetail(String id) throws Exception{ 
		 return adminCompanyDAO.companyDetail(id); 
	  }
	  /*
	 * public void modifyMemberInfo(HashMap memberMap) throws Exception{ String
	 * id=(String)memberMap.get("id"); adminMemberDAO.modifyMemberInfo(memberMap); }
	 */
}
