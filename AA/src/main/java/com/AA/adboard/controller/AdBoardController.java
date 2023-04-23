package com.AA.adboard.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface AdBoardController {
	
	public ModelAndView listItems(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView listNotice(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView listEvent(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView listSite(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity addNewItem(MultipartHttpServletRequest multipartRequest,HttpServletResponse response) throws Exception;
	public ModelAndView viewItem(@RequestParam("adboard_num") int adboard_num,
			                        HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest,  HttpServletResponse response) throws Exception;
	public ResponseEntity  removeItem(@RequestParam("adboard_num") int adboard_num,
                              HttpServletRequest request, HttpServletResponse response) throws Exception;

}
