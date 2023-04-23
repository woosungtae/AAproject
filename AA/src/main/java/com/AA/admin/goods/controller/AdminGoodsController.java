package com.AA.admin.goods.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface AdminGoodsController {
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception;
	public ResponseEntity modifyGoodsInfo( @RequestParam("goods_num") String goods_num,
                                 @RequestParam("mod_type") String mod_type,
                                 @RequestParam("value") String value,
			                     HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public void  removeGoodsImage(@RequestParam("goods_num") int goods_num,
            @RequestParam("image_id") int image_id,
            @RequestParam("imageFileName") String imageFileName,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public void  addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception;
	public void modifyGoodsImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception;
}
