package com.AA.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.AA.cart.vo.CartVO;
import com.AA.goods.vo.GoodsVO;

public interface CartDAO {
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList) throws DataAccessException;
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException;
	public void deleteCartGoods(int cart_num) throws DataAccessException;
	
	

}