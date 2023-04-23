package com.AA.admin.company.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.AA.company.vo.CompanyVO;

public interface AdminCompanyDAO {
	public List<CompanyVO> listCompany(Map condMap) throws DataAccessException;
	
	  public CompanyVO companyDetail(String id) throws DataAccessException; 
	  /*
	 * public
	 * void modifyMemberInfo(HashMap memberMap) throws DataAccessException;
	 */
}
