package com.AA.cs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.AA.board.vo.ArticleVO;
import com.AA.cs.vo.CsItemVO;

@Repository("csDAO")
public class CsDAOImpl implements CsDAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CsItemVO> selectAllCsItemsList() throws DataAccessException {
		List<CsItemVO> csItemsList = sqlSession.selectList("mapper.cs.selectAllCsItemsList");
		return csItemsList;
	}

	@Override
	public int insertNewCsItem(Map itemMap) throws DataAccessException {
		int cs_num = selectNewCs_num();
		itemMap.put("cs_num", cs_num);
		sqlSession.insert("mapper.cs.insertNewCsItem",itemMap);
		return cs_num;
	}

	@Override
	public CsItemVO selectCsItem(int cs_num) throws DataAccessException {
		return sqlSession.selectOne("mapper.cs.selectCsItem", cs_num);
	}

	@Override
	public void deleteCsItem(int cs_num) throws DataAccessException {
		sqlSession.delete("mapper.cs.deleteCsItem", cs_num);
		
	}

	@Override
	public void updateView(int cs_num) throws DataAccessException {
		sqlSession.update("mapper.cs.updateView", cs_num);
		
	}
	
	private int selectNewCs_num() throws DataAccessException {
		return sqlSession.selectOne("mapper.cs.selectNewCsItemNO");
	}

	@Override
	public List<CsItemVO> memCsListItems(String id) throws DataAccessException {
		List<CsItemVO> memCsListItems = sqlSession.selectList("mapper.cs.memCsListItems", id);
		return memCsListItems;
	}
	
	
}
