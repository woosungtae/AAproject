package com.AA.cs.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.AA.adboard.vo.ItemVO;
import com.AA.board.vo.ArticleVO;
import com.AA.company.vo.CompanyVO;
import com.AA.cs.dao.CsDAO;
import com.AA.cs.service.CsService;
import com.AA.cs.vo.CsItemVO;
import com.AA.member.vo.MemberVO;

@Controller("csController")
@RequestMapping(value="/cs")
public class CsControllerImpl implements CsController{
	private static String CS_IMAGE_REPO ="C://cs//image";
	@Autowired
	private CsService csService;
	@Autowired
	private CsItemVO csItemVO;
	@Autowired
	private CsDAO csDAO;
	
	@RequestMapping(value="/csMain.do" ,method = RequestMethod.GET)
	public ModelAndView csMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session.setAttribute("side_menu", "cs");
		return mav;
	}
	
	@RequestMapping(value="/termsOfService.do" ,method = RequestMethod.GET)
	public ModelAndView termsOfService(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session.setAttribute("side_menu", "cs");
		return mav;
	}
	
	@RequestMapping(value="/privacyPolicy.do" ,method = RequestMethod.GET)
	public ModelAndView privacyPolicy(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session.setAttribute("side_menu", "cs");
		return mav;
	}
	
	@Override
	@RequestMapping(value= "/csListItems.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listCsItems(@RequestParam(value = "sidemenu", defaultValue="cs") String sideMenu, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		String sidemenu = sideMenu;
		if(sidemenu.equals("cs")) {
			session.setAttribute("side_menu", "cs"); //side 메뉴 설정한다.
		} else if(sidemenu.equals("mypage")) {
			session.setAttribute("side_menu", "admin_mode");
		}
		String viewName = (String)request.getAttribute("viewName");
		List csItemsList = csService.listCsItems();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("csItemsList", csItemsList);
		
		return mav;
	}
	
	 //한 개 이미지 글쓰기
		@Override
		@RequestMapping(value="/csAddNewItem.do" ,method = RequestMethod.POST)
		@ResponseBody
		public ResponseEntity addNewCsItem(MultipartHttpServletRequest multipartRequest, 
		HttpServletResponse response) throws Exception {
			multipartRequest.setCharacterEncoding("utf-8");
			Map<String,Object> itemMap = new HashMap<String, Object>();
			Enumeration enu=multipartRequest.getParameterNames();
			while(enu.hasMoreElements()){
				String name=(String)enu.nextElement();
				String value=multipartRequest.getParameter(name);
				itemMap.put(name,value);
			}
			
			String imageFileName= upload(multipartRequest);
			HttpSession session = multipartRequest.getSession();
			MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
			if(memberVO != null) {
				String id = memberVO.getId();
				itemMap.put("id", id);
			} else {
				CompanyVO companyVO = (CompanyVO) session.getAttribute("companyInfo");
				String id = companyVO.getId();
				itemMap.put("id", id);
			}
			itemMap.put("imageFileName", imageFileName);
			
			String message;
			ResponseEntity resEnt=null;
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "text/html; charset=utf-8");
			try {
				
				int cs_num = csService.addNewCsItem(itemMap);
			
				
				if(imageFileName!=null && imageFileName.length()!=0) {
					File srcFile = new 
					File(CS_IMAGE_REPO+ "\\" + "temp"+ "\\" + imageFileName);
					File destDir = new File(CS_IMAGE_REPO+"\\"+cs_num);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
		
				message = "<script>";
				message += " alert('새글을 추가했습니다.');";
				message += " location.href='"+multipartRequest.getContextPath()+"/cs/csListItems.do'; ";
				message +=" </script>";
			    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			}catch(Exception e) {
				File srcFile = new File(CS_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
				srcFile.delete();
				
				message = " <script>";
				message +=" alert('오류가 발생했습니다. 다시 시도해 주세요');');";
				message +=" location.href='"+multipartRequest.getContextPath()+"/cs/csItemForm.do'; ";
				message +=" </script>";
				resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
				e.printStackTrace();
			}
			return resEnt;
		}
		
		@Override
		@RequestMapping(value="/csViewItem.do" ,method = {RequestMethod.POST,RequestMethod.GET})
		  public ModelAndView viewCsItem(int cs_num, HttpServletRequest request, HttpServletResponse response) throws Exception {
			HttpSession session=request.getSession();
			session=request.getSession();
			session.setAttribute("side_menu", "cs");
			String viewName = (String) request.getAttribute("viewName");
		    csDAO.updateView(cs_num);
		    // 게시글 조회
		    CsItemVO csItem = csService.viewCsItem(cs_num);
		    // 조회수 증가
		    // ModelAndView 객체 생성 및 반환
		    ModelAndView mav = new ModelAndView();
		    mav.setViewName(viewName);
		    mav.addObject("csItem", csItem);

		    return mav;
		  }
		
		@Override
		  @RequestMapping(value="/removeCsItem.do" ,method = RequestMethod.POST)
		  @ResponseBody
		  public ResponseEntity  removeCsItem(@RequestParam("cs_num") int cs_num,
		                              HttpServletRequest request, HttpServletResponse response) throws Exception{
			response.setContentType("text/html; charset=UTF-8");
			String message;
			ResponseEntity resEnt=null;
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "text/html; charset=utf-8");
			try {
				csService.removeCsItem(cs_num);
				File destDir = new File(CS_IMAGE_REPO+"\\"+cs_num);
				FileUtils.deleteDirectory(destDir);
				
				message = "<script>";
				message += " alert('글을 삭제했습니다.');";
				message += " location.href='"+request.getContextPath()+"/cs/csListItems.do';";
				message +=" </script>";
			    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			       
			}catch(Exception e) {
				message = "<script>";
				message += " alert('작업중 오류가 발생했습니다.다시 시도해 주세요.');";
				message += " location.href='"+request.getContextPath()+"/cs/csListItems.do';";
				message +=" </script>";
			    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			    e.printStackTrace();
			}
			return resEnt;
		  }
		
		@RequestMapping(value = "/*Form.do", method =  RequestMethod.GET)
		private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
			HttpSession session=request.getSession();
			session=request.getSession();
			session.setAttribute("side_menu", "cs");
			String viewName = (String)request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView();
			mav.setViewName(viewName);
			return mav;
		}

		//한개 이미지 업로드하기
		private String upload(MultipartHttpServletRequest multipartRequest) throws Exception{
			String imageFileName= null;
			Iterator<String> fileNames = multipartRequest.getFileNames();
			
			while(fileNames.hasNext()){
				String fileName = fileNames.next();
				MultipartFile mFile = multipartRequest.getFile(fileName);
				imageFileName=mFile.getOriginalFilename();
				File file = new File(CS_IMAGE_REPO +"\\"+"temp"+"\\" + fileName);
				if(mFile.getSize()!=0){ //File Null Check
					if(!file.exists()){ //경로상에 파일이 존재하지 않을 경우
						file.getParentFile().mkdirs();  //경로에 해당하는 디렉토리들을 생성
						mFile.transferTo(new File(CS_IMAGE_REPO +"\\"+"temp"+ "\\"+imageFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
					}
				}
				
			}
			return imageFileName;
		}
		
		//문의 내역
		@RequestMapping(value="/memCsListItems", method= {RequestMethod.GET})
		public ModelAndView memCsListItems(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String viewName=(String)request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);
			
			HttpSession session=request.getSession();
			session=request.getSession();
			MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
			if(memberVO == null) {
				CompanyVO companyVO = (CompanyVO) session.getAttribute("companyInfo");
				session.setAttribute("side_menu", "cs");
				String id = companyVO.getId();
				List<CsItemVO> memCsListItems = csService.memCsListItems(id);
				session.setAttribute("memCsListItems", memCsListItems);
				mav.addObject("memCsListItems", memCsListItems);
			} else {
				session.setAttribute("side_menu", "cs");
				String id = memberVO.getId();
				List<CsItemVO> memCsListItems = csService.memCsListItems(id);
				session.setAttribute("memCsListItems", memCsListItems);
				mav.addObject("memCsListItems", memCsListItems);
			}
			return mav;
		}
}
