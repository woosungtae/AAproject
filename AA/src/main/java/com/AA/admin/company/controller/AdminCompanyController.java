package com.AA.admin.company.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.AA.member.vo.MemberVO;

public interface AdminCompanyController {
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	  public ModelAndView companyDetail(HttpServletRequest request, HttpServletResponse response) throws Exception; 
		/*
		 * public void modifyMemberInfo(HttpServletRequest request, HttpServletResponse
		 * response) throws Exception; public ModelAndView
		 * deleteMember(HttpServletRequest request, HttpServletResponse response) throws
		 * Exception;
		 */
	 
}
