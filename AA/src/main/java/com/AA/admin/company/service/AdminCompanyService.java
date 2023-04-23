package com.AA.admin.company.service;

import java.util.List;
import java.util.Map;

import com.AA.company.vo.CompanyVO;

public interface AdminCompanyService {
	public List<CompanyVO> listCompany(Map condMap) throws Exception;
	
	 public CompanyVO companyDetail(String id) throws Exception; 
		/* public void modifyMemberInfo(HashMap memberMap) throws Exception; */
	 
}
