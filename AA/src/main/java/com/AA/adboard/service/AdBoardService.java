package com.AA.adboard.service;

import java.util.List;
import java.util.Map;

import com.AA.adboard.vo.ItemVO;

public interface AdBoardService {
	public List<ItemVO> listItems() throws Exception;
	public List<ItemVO> listEvent() throws Exception;
	public List<ItemVO> listNotice() throws Exception;
	public List<ItemVO> listSite() throws Exception;
	public int addNewItem(Map itemMap) throws Exception;
	public ItemVO viewItem(int adboard_num) throws Exception;
	//public Map viewArticle(Map articleNO) throws Exceprion;
	public void modItem(Map itemMap) throws Exception;
	public void removeItem(int adboard_num) throws Exception;
}
