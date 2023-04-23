package com.AA.adboard.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("itemVO")
public class ItemVO {
	private int  level;
	private int adboard_num;
	private String adboard_title;
	private String adboard_content;
	private String adboard_category;
	private String imageFileName;
	private String id;
	private String status;
	private Date  writeDate;
	private int viewCnt;
	
	



	public ItemVO() {
		System.out.println("item VO »ý¼º");
	}

	

	public String getImageFileName() {
		try {
			if (imageFileName != null && imageFileName.length() != 0) {
				imageFileName = URLDecoder.decode(imageFileName, "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		try {
			if(imageFileName!= null && imageFileName.length()!=0) {
				this.imageFileName = URLEncoder.encode(imageFileName,"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}



	public int getLevel() {
		return level;
	}



	public void setLevel(int level) {
		this.level = level;
	}



	public int getAdboard_num() {
		return adboard_num;
	}



	public void setAdboard_num(int adboard_num) {
		this.adboard_num = adboard_num;
	}



	public String getAdboard_title() {
		return adboard_title;
	}



	public void setAdboard_title(String adboard_title) {
		this.adboard_title = adboard_title;
	}



	public String getAdboard_content() {
		return adboard_content;
	}



	public void setAdboard_content(String adboard_content) {
		this.adboard_content = adboard_content;
	}



	public String getAdboard_category() {
		return adboard_category;
	}



	public void setAdboard_category(String adboard_category) {
		this.adboard_category = adboard_category;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public Date getWriteDate() {
		return writeDate;
	}



	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}



	public int getViewCnt() {
		return viewCnt;
	}



	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}
	
	


	
	
}