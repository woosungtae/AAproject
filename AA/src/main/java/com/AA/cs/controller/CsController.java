package com.AA.cs.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface CsController {
	public ModelAndView listCsItems(@RequestParam("sidemenu") String sideMenu,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity addNewCsItem(MultipartHttpServletRequest multipartRequest,HttpServletResponse response) throws Exception;
	public ModelAndView viewCsItem(@RequestParam("cs_num") int cs_num,
			                        HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest,  HttpServletResponse response) throws Exception;
	public ResponseEntity  removeCsItem(@RequestParam("cs_num") int cs_num,
                              HttpServletRequest request, HttpServletResponse response) throws Exception;
}
