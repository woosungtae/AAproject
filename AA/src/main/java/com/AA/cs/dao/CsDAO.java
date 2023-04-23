package com.AA.cs.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.AA.cs.vo.CsItemVO;

public interface CsDAO {
	public List<CsItemVO> selectAllCsItemsList() throws DataAccessException;
	public int insertNewCsItem(Map itemMap) throws DataAccessException;
	public CsItemVO selectCsItem(int cs_num) throws DataAccessException;
	public void deleteCsItem(int cs_num) throws DataAccessException;
	public void updateView(int cs_num) throws DataAccessException;
	public List<CsItemVO> memCsListItems(String id) throws DataAccessException;

}
