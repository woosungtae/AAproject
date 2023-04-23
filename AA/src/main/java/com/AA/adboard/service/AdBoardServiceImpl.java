package com.AA.adboard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.AA.adboard.dao.AdBoardDAO;
import com.AA.adboard.vo.ItemVO;

@Service("adboardService")
@Transactional(propagation =  Propagation.REQUIRED)
public class AdBoardServiceImpl implements AdBoardService {
	@Autowired
	AdBoardDAO adboardDAO;
	
	
	public List<ItemVO> listItems() throws Exception{
		List<ItemVO> itemsList =  adboardDAO.selectAllItemsList();
        return itemsList;
	}
	
	public List<ItemVO> listEvent() throws Exception{
		List<ItemVO> itemsList =  adboardDAO.selectAllItemsList();
		return itemsList;
	}
	
	public List<ItemVO> listSite() throws Exception{
		List<ItemVO> itemsList =  adboardDAO.selectAllItemsList();
		return itemsList;
	}
	
	public List<ItemVO> listNotice() throws Exception{
		List<ItemVO> itemsList =  adboardDAO.selectAllItemsList();
		return itemsList;
	}

	
	//단일 이미지 추가하기
	@Override
	public int addNewItem(Map itemMap) throws Exception{
		return adboardDAO.insertNewItem(itemMap);
	}
	
	 //다중 이미지 추가하기
	/*
	@Override
	public int addNewArticle(Map itemMap) throws Exception{
		int articleNO = boardDAO.insertNewArticle(itemMap);
		itemMap.put("articleNO", articleNO);
		boardDAO.insertNewImage(itemMap);
		return articleNO;
	}
	*/
	/*
	//다중 파일 보이기
	@Override
	public Map viewArticle(int articleNO) throws Exception {
		Map itemMap = new HashMap();
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		List<ImageVO> imageFileList = boardDAO.selectImageFileList(articleNO);
		itemMap.put("article", articleVO);
		itemMap.put("imageFileList", imageFileList);
		return itemMap;
	}
   */
	
	
	 //단일 파일 보이기
	@Override
	public ItemVO viewItem(int adboard_num) throws Exception {
		ItemVO itemVO = adboardDAO.selectItem(adboard_num);
		return itemVO;
	}
	
	
	@Override
	public void modItem(Map itemMap) throws Exception {
		adboardDAO.updateItem(itemMap);
	}
	
	@Override
	public void removeItem(int adboard_num) throws Exception {
		adboardDAO.deleteItem(adboard_num);
	}

	

	
}
