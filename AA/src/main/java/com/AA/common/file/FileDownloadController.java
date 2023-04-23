package com.AA.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;


@Controller
public class FileDownloadController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	private static String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
    private static String ADBOARD_IMAGE_REPO ="C:\\adboard\\image";
    private static String CS_IMAGE_REPO ="C:\\cs\\image";
	
	
	@RequestMapping("/download")
	protected void download(@RequestParam("fileName") String fileName,
		                 	@RequestParam("goods_num") String goods_num,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_num+"\\"+fileName;
		File image=new File(filePath);

		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer); //버퍼에 읽어들인 문자개수
			if(count==-1)  //버퍼의 마지막에 도달했는지 체크
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	@RequestMapping("/download1")
	protected void download1(@RequestParam("imageFileName") String imageFileName,
			@RequestParam("board_num") String board_num,
			HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=ARTICLE_IMAGE_REPO+"\\"+board_num+"\\"+imageFileName;
		File image=new File(filePath);
		
		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+imageFileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer); //버퍼에 읽어들인 문자개수
			if(count==-1)  //버퍼의 마지막에 도달했는지 체크
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	@RequestMapping("/download2")
	protected void download2(@RequestParam("imageFileName") String imageFileName,
			@RequestParam("adboard_num") String adboard_num,
			HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=ADBOARD_IMAGE_REPO+"\\"+adboard_num+"\\"+imageFileName;
		File image=new File(filePath);
		
		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+imageFileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer); //버퍼에 읽어들인 문자개수
			if(count==-1)  //버퍼의 마지막에 도달했는지 체크
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	
	@RequestMapping("/download3")
	protected void download3(@RequestParam("imageFileName") String imageFileName,
			@RequestParam("cs_num") String cs_num,
			HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CS_IMAGE_REPO+"\\"+cs_num+"\\"+imageFileName;
		File image=new File(filePath);
		
		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+imageFileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer); //버퍼에 읽어들인 문자개수
			if(count==-1)  //버퍼의 마지막에 도달했는지 체크
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	
	
	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("fileName") String fileName,
                            	@RequestParam("goods_num") String goods_num,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_num+"\\"+fileName;
		File image=new File(filePath);
		
		if (image.exists()) { 
			Thumbnails.of(image).size(121,154).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}
