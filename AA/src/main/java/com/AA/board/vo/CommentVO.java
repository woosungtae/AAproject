package com.AA.board.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("commentVO")
public class CommentVO {
	private String id;
	private int cmt_number;
	private String cmt_content;
	private int cmt_mom_num;
	private Date cmt_date;
	private int board_num;
	private int depth;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCmt_number() {
		return cmt_number;
	}
	public void setCmt_number(int cmt_number) {
		this.cmt_number = cmt_number;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public int getCmt_mom_num() {
		return cmt_mom_num;
	}
	public void setCmt_mom_num(int cmt_mom_num) {
		this.cmt_mom_num = cmt_mom_num;
	}
	public Date getCmt_date() {
		return cmt_date;
	}
	public void setCmt_date(Date cmt_date) {
		this.cmt_date = cmt_date;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	
}
