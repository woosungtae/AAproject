package com.AA.adboard.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.AA.adboard.vo.ItemVO;


public interface AdBoardDAO {
	public List selectAllItemsList() throws DataAccessException;
	public int insertNewItem(Map itemMap) throws DataAccessException;
	//public void insertNewImage(Map itemMap) throws DataAccessException;
	public  void updateView(int adboard_num) throws Exception;

	public ItemVO selectItem(int adboard_num) throws DataAccessException;
	public void updateItem(Map itemMap) throws DataAccessException;
	public void deleteItem(int adboard_num) throws DataAccessException;
	public List selectImageFileList(int adboard_num) throws DataAccessException;
	
}
