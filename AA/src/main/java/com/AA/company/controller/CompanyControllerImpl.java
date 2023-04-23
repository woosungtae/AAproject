package com.AA.company.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.AA.common.base.BaseController;
import com.AA.company.service.CompanyService;
import com.AA.company.vo.CompanyVO;
import com.AA.goods.vo.GoodsVO;
import com.AA.goods.vo.ImageFileVO;
import com.AA.order.vo.OrderVO;

@Controller("companyController")
@RequestMapping(value="/company")
public class CompanyControllerImpl extends BaseController implements CompanyController{
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	@Autowired
	private CompanyService companyService;
	@Autowired
	private OrderVO orderVO;
	
	@RequestMapping(value="/addNewGoods.do" ,method={RequestMethod.POST})
	public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String imageFileName=null;
		
		Map newGoodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			newGoodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		CompanyVO companyVO = (CompanyVO) session.getAttribute("companyInfo");
		String id = companyVO.getId();
		newGoodsMap.put("id", id);
		String reg_id = companyVO.getId();
		
		
		List<ImageFileVO> imageFileList =upload(multipartRequest);
		if(imageFileList!= null && imageFileList.size()!=0) {
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newGoodsMap.put("imageFileList", imageFileList);
		}
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int goods_num = companyService.addNewGoods(newGoodsMap);
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_num);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			message= "<script>";
			message += " alert('새상품을 추가했습니다.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/company/addNewGoods.do';";
			message +=("</script>");
		}catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			
			message= "<script>";
			message += " alert('오류가 발생했습니다. 다시 시도해 주세요');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/company/addNewGoods.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/addNewGoodsImage.do" ,method={RequestMethod.POST})
	public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		System.out.println("addNewGoodsImage");
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName=null;
		
		Map goodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			goodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		CompanyVO companyVO = (CompanyVO) session.getAttribute("companyInfo");
		String reg_id = companyVO.getId();
		
		List<ImageFileVO> imageFileList=null;
		int goods_num=0;
		try {
			imageFileList =upload(multipartRequest);
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_num = Integer.parseInt((String)goodsMap.get("goods_num"));
					imageFileVO.setGoods_num(goods_num);
					imageFileVO.setReg_id(reg_id);
				}
				
				companyService.addNewGoodsImage(imageFileList);
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_num);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
		}catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/comGoodsInfo", method= {RequestMethod.GET})
	public ModelAndView comGoodsInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "company_page"); //���������� ���̵� �޴��� �����Ѵ�.
		
		CompanyVO companyVO = (CompanyVO) session.getAttribute("companyInfo");
		String id = companyVO.getId();
		
		List<GoodsVO> comGoodsList = companyService.comGoodsList(id);
		session.setAttribute("comGoodsList", comGoodsList);
		mav.addObject("comGoodsList", comGoodsList);
		return mav;
	}
	
	@RequestMapping(value="/removeGoods.do" ,method = RequestMethod.POST)
	public ModelAndView removeGoods(@RequestParam("goods_num") int goods_num,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		companyService.removeGoods(goods_num);
		mav.setViewName("redirect:/company/comGoodsInfo.do");
		return mav;
	}
	
	//�Ǹ� ����
	@RequestMapping(value="/comSaleGoodsInfo", method= {RequestMethod.GET})
	public ModelAndView comSaleGoodsInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//ĳ�� ���� ������ ����
		  response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
		  response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		  response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		  response.setHeader("Pragma", "no-cache");
		//�� �̸��� �޾ƿ�
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session=request.getSession();
		
		//���������� ���̵� �޴��� ����
		session.setAttribute("side_menu", "company_page");
		
		//���ǿ��� ȸ�� ������ �޾ƿͼ� ȸ�� ���̵� ����
		CompanyVO companyVO=(CompanyVO)session.getAttribute("companyInfo");
		String company_name=companyVO.getCompany_name();
		
		//���� ���º� ��ȸ
		String status = request.getParameter("order_status");
		OrderVO paramMap = new OrderVO();
		Map<String, Integer> map = new HashMap();
		map.put("pay_wait", 1);
		map.put("pay_done", 2);
		map.put("refund_ing", 3);
		map.put("refund_done", 4);
		map.put("order_ing", 5);
		map.put("order_done", 6);
		
		
		if(map.get(status)!=null) {
			Integer value = (Integer) map.get(status);
			if(value == null || value == 0) {
				paramMap.setOrder_status(null);
			} else {
				switch (value) {
					case 1:
						paramMap.setOrder_status("결제대기");
						break;
					case 2:
						paramMap.setOrder_status("결제완료");
						break;
					case 3:
						paramMap.setOrder_status("환불중");
						break;
					case 4:
						paramMap.setOrder_status("환불완료");
						break;
					case 5:
						paramMap.setOrder_status("진행중");
						break;
					case 6:
						paramMap.setOrder_status("최종완료");
						break;
				}
			}
		}
		
		//�ֹ� ������ �޾ƿ�
		paramMap.setCompany_name(company_name);
		List<OrderVO> orderMap=companyService.comSaleGoodsInfo(paramMap);
		session.setAttribute("orderMap", orderMap);
		mav.addObject("orderMap", orderMap);
		return mav;
	}
	
	@RequestMapping(value="/modifyOrderStatus.do", method= {RequestMethod.POST})
	public @ResponseBody String modifyOrderStatus(int order_num, String order_status, HttpServletResponse response) throws Exception{
		orderVO.setOrder_num(order_num);
		orderVO.setOrder_status(order_status);
		
	
		
		
boolean result=companyService.modifyOrderStatus(orderVO);
		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
	}
	
}
