package com.AA.adboard.controller;

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

import com.AA.adboard.dao.AdBoardDAO;
import com.AA.adboard.service.AdBoardService;
import com.AA.adboard.vo.ItemVO;
import com.AA.member.vo.MemberVO;


@Controller("adboardController")
public class AdBoardControllerImpl  implements AdBoardController{
    private static String ADBOARD_IMAGE_REPO ="C://adboard//image";
	@Autowired
	private AdBoardService adboardService;
	@Autowired
	private ItemVO itemVO;
	@Autowired
	private AdBoardDAO adboardDAO;
	
	@Override
	@RequestMapping(value= "/adboard/listItems.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listItems(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "ad_board"); //side 메뉴 설정한다.
		
		String viewName = (String)request.getAttribute("viewName");
		List itemsList = adboardService.listItems();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("itemsList", itemsList);
		
		return mav;
		
	}
	@Override
	@RequestMapping(value= "/adboard/listNotice.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "ad_board"); //side 메뉴 설정한다.
		
		String viewName = (String)request.getAttribute("viewName");
		List itemsList = adboardService.listItems();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("itemsList", itemsList);
		
		return mav;
		
	}
	@Override
	@RequestMapping(value= "/adboard/listEvent.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listEvent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "ad_board"); //side 메뉴 설정한다.
		
		String viewName = (String)request.getAttribute("viewName");
		List itemsList = adboardService.listItems();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("itemsList", itemsList);
		
		return mav;
		
	}
	@Override
	@RequestMapping(value= "/adboard/listSite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView listSite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "ad_board"); //side 메뉴 설정한다.
		
		String viewName = (String)request.getAttribute("viewName");
		List itemsList = adboardService.listItems();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("itemsList", itemsList);
		
		return mav;
		
	}
	
	 //한 개 이미지 글쓰기
	@Override
	@RequestMapping(value="/adboard/addNewItem.do" ,method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addNewItem(MultipartHttpServletRequest multipartRequest, 
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
		String id = memberVO.getId();
		itemMap.put("id", id);
		itemMap.put("imageFileName", imageFileName);
		
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			
			int adboard_num = adboardService.addNewItem(itemMap);
		
			
			if(imageFileName!=null && imageFileName.length()!=0) {
				File srcFile = new 
				File(ADBOARD_IMAGE_REPO+ "\\" + "temp"+ "\\" + imageFileName);
				File destDir = new File(ADBOARD_IMAGE_REPO+"\\"+adboard_num);
				FileUtils.moveFileToDirectory(srcFile, destDir,true);
			}
	
			message = "<script>";
			message += " alert('새글을 추가했습니다.');";
			message += " location.href='"+multipartRequest.getContextPath()+"/adboard/listItems.do'; ";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}catch(Exception e) {
			File srcFile = new File(ADBOARD_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
			srcFile.delete();
			
			message = " <script>";
			message +=" alert('오류가 발생했습니다. 다시 시도해 주세요');');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/adboard/itemForm.do'; ";
			message +=" </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	
	  @Override
	@RequestMapping(value="/adboard/viewItem.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	  public ModelAndView viewItem(int adboard_num, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
	    session.setAttribute("side_menu", "ad_board"); 
		String viewName = (String) request.getAttribute("viewName");
	    adboardDAO.updateView(adboard_num);
	    // 게시글 조회
	    ItemVO item = adboardService.viewItem(adboard_num);
	    // 조회수 증가
	    // ModelAndView 객체 생성 및 반환
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName(viewName);
	    mav.addObject("item", item);

	    return mav;
	  }

	
	/*
	//다중 이미지 보여주기
	@RequestMapping(value="/board/viewArticle.do" ,method = RequestMethod.GET)
	public ModelAndView viewArticle(@RequestParam("adboard_num") int adboard_num,
			  HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		Map itemMap=boardService.viewArticle(adboard_num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("itemMap", itemMap);
		return mav;
	}
   */
	

	
  //한 개 이미지 수정 기능
  @RequestMapping(value="/adboard/modAItem.do" ,method = RequestMethod.POST)
  @ResponseBody
  public ResponseEntity modItem(MultipartHttpServletRequest multipartRequest,  
    HttpServletResponse response) throws Exception{
    multipartRequest.setCharacterEncoding("utf-8");
	Map<String,Object> itemMap = new HashMap<String, Object>();
	Enumeration enu=multipartRequest.getParameterNames();
	while(enu.hasMoreElements()){
		String name=(String)enu.nextElement();
		String value=multipartRequest.getParameter(name);
		itemMap.put(name,value);
	}
	
	String imageFileName= upload(multipartRequest);
	itemMap.put("imageFileName", imageFileName);
	
	String adboard_num=(String)itemMap.get("adboard_num");
	String message;
	ResponseEntity resEnt=null;
	HttpHeaders responseHeaders = new HttpHeaders();
	responseHeaders.add("Content-Type", "text/html; charset=utf-8");
    try {
       adboardService.modItem(itemMap);
       if(imageFileName!=null && imageFileName.length()!=0) {
         File srcFile = new File(ADBOARD_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
         File destDir = new File(ADBOARD_IMAGE_REPO+"\\"+adboard_num);
         FileUtils.moveFileToDirectory(srcFile, destDir, true);
         
         String originalFileName = (String)itemMap.get("originalFileName");
         File oldFile = new File(ADBOARD_IMAGE_REPO+"\\"+adboard_num+"\\"+originalFileName);
         oldFile.delete();
       }	
       message = "<script>";
	   message += " alert('글을 수정했습니다.');";
	   message += " location.href='"+multipartRequest.getContextPath()+"/board/viewArticle.do?adboard_num="+adboard_num+"';";
	   message +=" </script>";
       resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
    }catch(Exception e) {
      File srcFile = new File(ADBOARD_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
      srcFile.delete();
      message = "<script>";
	  message += " alert('오류가 발생했습니다.다시 수정해주세요');";
	  message += " location.href='"+multipartRequest.getContextPath()+"/board/viewArticle.do?adboard_num="+adboard_num+"';";
	  message +=" </script>";
      resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
    }
    return resEnt;
  }
  
  @Override
  @RequestMapping(value="/adboard/removeItem.do" ,method = RequestMethod.POST)
  @ResponseBody
  public ResponseEntity  removeItem(@RequestParam("adboard_num") int adboard_num,
                              HttpServletRequest request, HttpServletResponse response) throws Exception{
	response.setContentType("text/html; charset=UTF-8");
	String message;
	ResponseEntity resEnt=null;
	HttpHeaders responseHeaders = new HttpHeaders();
	responseHeaders.add("Content-Type", "text/html; charset=utf-8");
	try {
		adboardService.removeItem(adboard_num);
		File destDir = new File(ADBOARD_IMAGE_REPO+"\\"+adboard_num);
		FileUtils.deleteDirectory(destDir);
		
		message = "<script>";
		message += " alert('글을 삭제했습니다.');";
		message += " location.href='"+request.getContextPath()+"/adboard/listItems.do';";
		message +=" </script>";
	    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	       
	}catch(Exception e) {
		message = "<script>";
		message += " alert('작업중 오류가 발생했습니다.다시 시도해 주세요.');";
		message += " location.href='"+request.getContextPath()+"/adboard/listItems.do';";
		message +=" </script>";
	    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	    e.printStackTrace();
	}
	return resEnt;
  }  
  
/*
  //다중 이미지 글 추가하기
  @Override
  @RequestMapping(value="/board/addNewArticle.do" ,method = RequestMethod.POST)
  @ResponseBody
  public ResponseEntity  addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
	multipartRequest.setCharacterEncoding("utf-8");
	String imageFileName=null;
	
	Map itemMap = new HashMap();
	Enumeration enu=multipartRequest.getParameterNames();
	while(enu.hasMoreElements()){
		String name=(String)enu.nextElement();
		String value=multipartRequest.getParameter(name);
		itemMap.put(name,value);
	}
	
	//로그인 시 세션에 저장된 회원 정보에서 글쓴이 아이디를 얻어와서 Map에 저장합니다.
	HttpSession session = multipartRequest.getSession();
	MemberVO memberVO = (MemberVO) session.getAttribute("member");
	String id = memberVO.getId();
	itemMap.put("id",id);
	itemMap.put("parentNO", 0);
	
	List<String> fileList =upload(multipartRequest);
	List<ImageVO> imageFileList = new ArrayList<ImageVO>();
	if(fileList!= null && fileList.size()!=0) {
		for(String fileName : fileList) {
			ImageVO imageVO = new ImageVO();
			imageVO.setImageFileName(fileName);
			imageFileList.add(imageVO);
		}
		itemMap.put("imageFileList", imageFileList);
	}
	String message;
	ResponseEntity resEnt=null;
	HttpHeaders responseHeaders = new HttpHeaders();
    responseHeaders.add("Content-Type", "text/html; charset=utf-8");
	try {
		int adboard_num = boardService.addNewArticle(itemMap);
		if(imageFileList!=null && imageFileList.size()!=0) {
			for(ImageVO  imageVO:imageFileList) {
				imageFileName = imageVO.getImageFileName();
				File srcFile = new File(ARTICLE_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
				File destDir = new File(ARTICLE_IMAGE_REPO+"\\"+adboard_num);
				//destDir.mkdirs();
				FileUtils.moveFileToDirectory(srcFile, destDir,true);
			}
		}
		    
		message = "<script>";
		message += " alert('새글을 추가했습니다.');";
		message += " location.href='"+multipartRequest.getContextPath()+"/board/listArticles.do'; ";
		message +=" </script>";
	    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	    
		 
	}catch(Exception e) {
		if(imageFileList!=null && imageFileList.size()!=0) {
		  for(ImageVO  imageVO:imageFileList) {
		  	imageFileName = imageVO.getImageFileName();
			File srcFile = new File(ARTICLE_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
		 	srcFile.delete();
		  }
		}

		
		message = " <script>";
		message +=" alert('오류가 발생했습니다. 다시 시도해 주세요');');";
		message +=" location.href='"+multipartRequest.getContextPath()+"/board/articleForm.do'; ";
		message +=" </script>";
		resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		e.printStackTrace();
	}
	return resEnt;
  }
	
*/

	

	@RequestMapping(value = "/adboard/*Form.do", method =  RequestMethod.GET)
	private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			File file = new File(ADBOARD_IMAGE_REPO +"\\"+"temp"+"\\" + fileName);
			if(mFile.getSize()!=0){ //File Null Check
				if(!file.exists()){ //경로상에 파일이 존재하지 않을 경우
					file.getParentFile().mkdirs();  //경로에 해당하는 디렉토리들을 생성
					mFile.transferTo(new File(ADBOARD_IMAGE_REPO +"\\"+"temp"+ "\\"+imageFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
				}
			}
			
		}
		return imageFileName;
	}
	
	/*
	//다중 이미지 업로드하기
	private List<String> upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		List<String> fileList= new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName=mFile.getOriginalFilename();
			fileList.add(originalFileName);
			File file = new File(ARTICLE_IMAGE_REPO +"\\"+"temp"+"\\" + fileName);
			if(mFile.getSize()!=0){ //File Null Check
				if(!file.exists()){ //경로상에 파일이 존재하지 않을 경우
					file.getParentFile().mkdirs();  //경로에 해당하는 디렉토리들을 생성
					mFile.transferTo(new File(ARTICLE_IMAGE_REPO +"\\"+"temp"+ "\\"+originalFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
				}
			}
		}
		return fileList;
	}
	*/
}
