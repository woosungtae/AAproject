package com.AA.cs.service;

import java.util.List;
import java.util.Map;

import com.AA.adboard.vo.ItemVO;
import com.AA.board.vo.ArticleVO;
import com.AA.cs.vo.CsItemVO;

public interface CsService {
	public List<CsItemVO> listCsItems() throws Exception;
	public int addNewCsItem(Map itemMap) throws Exception;
	public CsItemVO viewCsItem(int cs_num) throws Exception;
	public void removeCsItem(int cs_num) throws Exception;
	public List<CsItemVO> memCsListItems(String id) throws Exception;

}
