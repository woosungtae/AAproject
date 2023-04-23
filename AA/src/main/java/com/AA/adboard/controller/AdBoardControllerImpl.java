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
		session.setAttribute("side_menu", "ad_board"); //side �޴� �����Ѵ�.
		
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
		session.setAttribute("side_menu", "ad_board"); //side �޴� �����Ѵ�.
		
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
		session.setAttribute("side_menu", "ad_board"); //side �޴� �����Ѵ�.
		
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
		session.setAttribute("side_menu", "ad_board"); //side �޴� �����Ѵ�.
		
		String viewName = (String)request.getAttribute("viewName");
		List itemsList = adboardService.listItems();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("itemsList", itemsList);
		
		return mav;
		
	}
	
	 //�� �� �̹��� �۾���
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
			message += " alert('������ �߰��߽��ϴ�.');";
			message += " location.href='"+multipartRequest.getContextPath()+"/adboard/listItems.do'; ";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}catch(Exception e) {
			File srcFile = new File(ADBOARD_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
			srcFile.delete();
			
			message = " <script>";
			message +=" alert('������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');');";
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
	    // �Խñ� ��ȸ
	    ItemVO item = adboardService.viewItem(adboard_num);
	    // ��ȸ�� ����
	    // ModelAndView ��ü ���� �� ��ȯ
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName(viewName);
	    mav.addObject("item", item);

	    return mav;
	  }

	
	/*
	//���� �̹��� �����ֱ�
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
	

	
  //�� �� �̹��� ���� ���
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
	   message += " alert('���� �����߽��ϴ�.');";
	   message += " location.href='"+multipartRequest.getContextPath()+"/board/viewArticle.do?adboard_num="+adboard_num+"';";
	   message +=" </script>";
       resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
    }catch(Exception e) {
      File srcFile = new File(ADBOARD_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
      srcFile.delete();
      message = "<script>";
	  message += " alert('������ �߻��߽��ϴ�.�ٽ� �������ּ���');";
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
		message += " alert('���� �����߽��ϴ�.');";
		message += " location.href='"+request.getContextPath()+"/adboard/listItems.do';";
		message +=" </script>";
	    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	       
	}catch(Exception e) {
		message = "<script>";
		message += " alert('�۾��� ������ �߻��߽��ϴ�.�ٽ� �õ��� �ּ���.');";
		message += " location.href='"+request.getContextPath()+"/adboard/listItems.do';";
		message +=" </script>";
	    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	    e.printStackTrace();
	}
	return resEnt;
  }  
  
/*
  //���� �̹��� �� �߰��ϱ�
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
	
	//�α��� �� ���ǿ� ����� ȸ�� �������� �۾��� ���̵� ���ͼ� Map�� �����մϴ�.
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
		message += " alert('������ �߰��߽��ϴ�.');";
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
		message +=" alert('������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');');";
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

	//�Ѱ� �̹��� ���ε��ϱ�
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		String imageFileName= null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName=mFile.getOriginalFilename();
			File file = new File(ADBOARD_IMAGE_REPO +"\\"+"temp"+"\\" + fileName);
			if(mFile.getSize()!=0){ //File Null Check
				if(!file.exists()){ //��λ� ������ �������� ���� ���
					file.getParentFile().mkdirs();  //��ο� �ش��ϴ� ���丮���� ����
					mFile.transferTo(new File(ADBOARD_IMAGE_REPO +"\\"+"temp"+ "\\"+imageFileName)); //�ӽ÷� ����� multipartFile�� ���� ���Ϸ� ����
				}
			}
			
		}
		return imageFileName;
	}
	
	/*
	//���� �̹��� ���ε��ϱ�
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
				if(!file.exists()){ //��λ� ������ �������� ���� ���
					file.getParentFile().mkdirs();  //��ο� �ش��ϴ� ���丮���� ����
					mFile.transferTo(new File(ARTICLE_IMAGE_REPO +"\\"+"temp"+ "\\"+originalFileName)); //�ӽ÷� ����� multipartFile�� ���� ���Ϸ� ����
				}
			}
		}
		return fileList;
	}
	*/
}
