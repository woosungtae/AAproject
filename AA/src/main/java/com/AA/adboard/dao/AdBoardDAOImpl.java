package com.AA.adboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.AA.adboard.vo.ItemVO;
import com.AA.board.vo.ImageVO;


@Repository("adboardDAO")
public class AdBoardDAOImpl implements AdBoardDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllItemsList() throws DataAccessException {
		List<ItemVO> itemsList = itemsList = sqlSession.selectList("mapper.adboard.selectAllItemsList");
		return itemsList;
	}

	
	@Override
	public int insertNewItem(Map itemMap) throws DataAccessException {
		int adboard_num = selectNewboard_num();
		itemMap.put("adboard_num", adboard_num);
		sqlSession.insert("mapper.adboard.insertNewItem",itemMap);
		return adboard_num;
	}
    
	//다중 파일 업로드
	/*
	@Override
	public void insertNewImage(Map itemMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)itemMap.get("imageFileList");
		int board_num = (Integer)itemMap.get("board_num");
		int imageFileNO = selectNewImageFileNO();
		for(ImageVO imageVO : imageFileList){
			imageVO.setImageFileNO(++imageFileNO);
			imageVO.setboard_num(board_num);
		}
		sqlSession.insert("mapper.board.insertNewImage",imageFileList);
	}
	
   */
	
	@Override
	public ItemVO selectItem(int adboard_num) throws DataAccessException {
		return sqlSession.selectOne("mapper.adboard.selectItem", adboard_num);
	}

	@Override
	public void updateItem(Map itemMap) throws DataAccessException {
		sqlSession.update("mapper.adboard.updateItem", itemMap);
	}

	@Override
	public void deleteItem(int adboard_num) throws DataAccessException {
		sqlSession.delete("mapper.adboard.deleteItem", adboard_num);
		
	}
	 @Override
	  public void updateView(int itemMap) throws Exception {
	    sqlSession.update("mapper.adboard.updateView", itemMap);
	  }
	@Override
	public List selectImageFileList(int adboard_num) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.adboard.selectImageFileList",adboard_num);
		return imageFileList;
	}
	
	private int selectNewboard_num() throws DataAccessException {
		return sqlSession.selectOne("mapper.adboard.selectNewItemNO");
	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.adboard.selectNewImageFileNO");
	}

}