package com.AA.board.service;

import java.util.List;
import java.util.Map;

import com.AA.board.vo.ArticleVO;
import com.AA.board.vo.CommentVO;

public interface BoardService {
	public List<ArticleVO> listArticles() throws Exception;
	public int addNewArticle(Map articleMap) throws Exception;
	public ArticleVO viewArticle(int board_num) throws Exception;
	//public Map viewArticle(Map articleNO) throws Exceprion;
	public void modArticle(Map articleMap) throws Exception;
	public void removeArticle(int articleNO) throws Exception;
	public void addComment(CommentVO commentVO) throws Exception;
	public List<CommentVO> selectBoardCommentByCode(ArticleVO articleVO) throws Exception;
}
