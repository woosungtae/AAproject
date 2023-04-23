package com.AA.admin.company.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.AA.company.vo.CompanyVO;

@Repository("adminCompanyDao")
public class AdminCompanyDAOImpl  implements AdminCompanyDAO{
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<CompanyVO> listCompany(Map condMap) throws DataAccessException{
		List<CompanyVO>  companyList=(List)sqlSession.selectList("mapper.admin.company.listCompany",condMap);
		return companyList;
	}
	
	
	  public CompanyVO companyDetail(String id) throws DataAccessException { 
	  
	   CompanyVO companyBean=(CompanyVO)sqlSession.selectOne("mapper.admin.company.companyDetail", id); 
	  return companyBean; 
	  }
	  
	/*
	 * public void modifyMemberInfo(HashMap memberMap) throws DataAccessException{
	 * sqlSession.update("mapper.admin.member.modifyMemberInfo",memberMap); }
	 */
	 
	

}
