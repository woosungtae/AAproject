package com.AA.company.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.AA.cart.vo.CartVO;
import com.AA.goods.vo.GoodsVO;
import com.AA.order.vo.OrderVO;

public interface CompanyDAO {
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
	public void insertGoodsImageFile(List fileList)  throws DataAccessException;
	public List<GoodsVO> comGoodsList(String id) throws DataAccessException;
	public List<OrderVO> comSaleGoodsInfo(OrderVO paramMap) throws DataAccessException;
	public void deleteGoods(int goods_num) throws DataAccessException;
	public void updateOrderStatus(OrderVO orderVO) throws DataAccessException;
}
