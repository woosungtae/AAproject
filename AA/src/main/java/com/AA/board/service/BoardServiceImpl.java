package com.AA.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.AA.board.dao.BoardDAO;
import com.AA.board.vo.ArticleVO;
import com.AA.board.vo.CommentVO;

@Service("boardService")
@Transactional(propagation =  Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	public List<ArticleVO> listArticles() throws Exception{
		List<ArticleVO> articlesList =  boardDAO.selectAllArticlesList();
        return articlesList;
	}

	
	//���� �̹��� �߰��ϱ�
	@Override
	public int addNewArticle(Map articleMap) throws Exception{
		return boardDAO.insertNewArticle(articleMap);
	}
	
	 //���� �̹��� �߰��ϱ�
	/*
	@Override
	public int addNewArticle(Map articleMap) throws Exception{
		int articleNO = boardDAO.insertNewArticle(articleMap);
		articleMap.put("articleNO", articleNO);
		boardDAO.insertNewImage(articleMap);
		return articleNO;
	}
	*/
	/*
	//���� ���� ���̱�
	@Override
	public Map viewArticle(int articleNO) throws Exception {
		Map articleMap = new HashMap();
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		List<ImageVO> imageFileList = boardDAO.selectImageFileList(articleNO);
		articleMap.put("article", articleVO);
		articleMap.put("imageFileList", imageFileList);
		return articleMap;
	}
   */
	
	
	 //���� ���� ���̱�
	@Override
	public ArticleVO viewArticle(int board_num) throws Exception {
		ArticleVO articleVO = boardDAO.selectArticle(board_num);
		return articleVO;
	}
	
	
	@Override
	public void modArticle(Map articleMap) throws Exception {
		boardDAO.updateArticle(articleMap);
	}
	
	@Override
	public void removeArticle(int board_num) throws Exception {
		boardDAO.deleteArticle(board_num);
	}
	@Override
	public void addComment(CommentVO commentVO) throws Exception {
		boardDAO.addComment(commentVO);
	}


	@Override
	public List<CommentVO> selectBoardCommentByCode(ArticleVO articleVO) throws Exception {
		List<CommentVO> comment = boardDAO.selectBoardCommentByCode(articleVO);
		return comment;
	}

	
}
