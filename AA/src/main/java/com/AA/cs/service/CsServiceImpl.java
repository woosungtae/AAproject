package com.AA.cs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.AA.adboard.vo.ItemVO;
import com.AA.board.vo.ArticleVO;
import com.AA.cs.dao.CsDAO;
import com.AA.cs.vo.CsItemVO;

@Service("csService")
@Transactional(propagation =  Propagation.REQUIRED)
public class CsServiceImpl implements CsService{
	@Autowired
	CsDAO csDAO;

	@Override
	public List<CsItemVO> listCsItems() throws Exception {
		List<CsItemVO> csItemsList =  csDAO.selectAllCsItemsList();
        return csItemsList;
	}

	@Override
	public int addNewCsItem(Map itemMap) throws Exception {
		return csDAO.insertNewCsItem(itemMap);
	}

	@Override
	public CsItemVO viewCsItem(int cs_num) throws Exception {
		CsItemVO csItemVO = csDAO.selectCsItem(cs_num);
		return csItemVO;
	}

	@Override
	public void removeCsItem(int cs_num) throws Exception {
		csDAO.deleteCsItem(cs_num);
		
	}

	@Override
	public List<CsItemVO> memCsListItems(String id) throws Exception {
		List<CsItemVO> memCsListItems = csDAO.memCsListItems(id);
		return memCsListItems;
	}
}
