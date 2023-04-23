package com.AA.company.service;

import java.util.List;
import java.util.Map;

import com.AA.goods.vo.GoodsVO;
import com.AA.order.vo.OrderVO;

public interface CompanyService {
	public int  addNewGoods(Map newGoodsMap) throws Exception;
	public void addNewGoodsImage(List imageFileList) throws Exception;
	public List<GoodsVO> comGoodsList(String id) throws Exception;
	public List<OrderVO> comSaleGoodsInfo(OrderVO paramMap) throws Exception;
	public void removeGoods(int goods_num) throws Exception;
	public boolean modifyOrderStatus(OrderVO orderVO) throws Exception;
}
