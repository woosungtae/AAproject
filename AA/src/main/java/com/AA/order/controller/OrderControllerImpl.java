package com.AA.order.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.AA.common.base.BaseController;
import com.AA.company.vo.CompanyVO;
import com.AA.goods.vo.GoodsVO;
import com.AA.member.vo.MemberVO;
import com.AA.order.service.OrderService;
import com.AA.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
   @Autowired
   private OrderService orderService;
   @Autowired
   private OrderVO orderVO;
   
   @RequestMapping(value="/orderEachGoods.do" ,method = RequestMethod.POST)
   public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,
                                HttpServletRequest request, HttpServletResponse response)  throws Exception{
      
      request.setCharacterEncoding("utf-8");
      HttpSession session=request.getSession();
      
      Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
      String action=(String)session.getAttribute("action");
      //로그인 여부 체크
      //이전에 로그인 상태인 경우는 주문과정 진행
      //로그아웃 상태인 경우 로그인 화면으로 이동
      if(isLogOn==null || isLogOn==false){
         session.setAttribute("orderInfo", _orderVO);
         session.setAttribute("action", "/order/orderEachGoods.do");
         return new ModelAndView("redirect:/member/loginForm.do");
      }else{
          if(action!=null && action.equals("/order/orderEachGoods.do")){
            orderVO=(OrderVO)session.getAttribute("orderInfo");
            session.removeAttribute("action");
          }else {
             orderVO=_orderVO;
          }
       }
      
      String viewName=(String)request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      Map<String,List> orderMap = orderService.myBuyInfo(orderVO);
      
      
      
      if(session.getAttribute("memberInfo") != null) { //memberInfo가 null이 아니면
         MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
         session.setAttribute("orderer", memberInfo);
         }else if(session.getAttribute("companyInfo") !=null) { //companyInfo가 null이 아니면
            CompanyVO memberInfo = (CompanyVO)session.getAttribute("companyInfo");
            session.setAttribute("orderer", memberInfo);
         }
      
      session.setAttribute("orderMap", orderMap);
      
      
      return mav;
   }
   
   @RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
   public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
      String viewName=(String)request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      HttpSession session=request.getSession();
      Map cartMap=(Map)session.getAttribute("cartMap");
      List myOrderList=new ArrayList<OrderVO>();
      
      List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList");
      
      if(session.getAttribute("memberInfo") != null) { //memberInfo가 null이 아니면
         MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
         session.setAttribute("orderer", memberInfo);
         }else if(session.getAttribute("companyInfo") !=null) { //companyInfo가 null이 아니면
            CompanyVO memberInfo = (CompanyVO)session.getAttribute("companyInfo");
            session.setAttribute("orderer", memberInfo);
         }
      
      
      for(int i=0; i<cart_goods_qty.length;i++){
         String[] cart_goods=cart_goods_qty[i].split(":");
         for(int j = 0; j< myGoodsList.size();j++) {
            GoodsVO goodsVO = myGoodsList.get(j);
            int goods_num = goodsVO.getGoods_num();
            if(goods_num==Integer.parseInt(cart_goods[0])) {
               OrderVO _orderVO=new OrderVO();
               String goods_title=goodsVO.getGoods_title();
               int goods_sales_price=goodsVO.getGoods_standardPrice();
               String goods_fileName=goodsVO.getGoods_fileName();
               _orderVO.setGoods_num(goods_num);
               _orderVO.setGoods_title(goods_title);
               _orderVO.setGoods_sales_price(goods_sales_price);
               _orderVO.setGoods_fileName(goods_fileName);
               _orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));
               myOrderList.add(_orderVO);
               break;
            }
         }
      }
      
      session.setAttribute("myGoodsList", myGoodsList);
      session.setAttribute("myOrderList", myOrderList);
      return mav;
   }   
   
   @RequestMapping(value="/modifyOrderOption.do", method=RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
   public @ResponseBody String modifyOrderOption(@RequestParam("goods_option") String goods_option, @RequestParam("goods_num") int goods_num,
                                HttpServletRequest request, HttpServletResponse response)  throws Exception{
      int price = 0;
      
      GoodsVO goodsVO = orderService.findGoodsByNum(goods_num);
      
      if(goods_option.equals("standard") && goods_option != null){
         price = goodsVO.getGoods_standardPrice();
   
      }else if(goods_option.equals("deluxe") && goods_option != null) {
         price = goodsVO.getGoods_deluxePrice();
      }else if(goods_option.equals("premium") && goods_option != null) {
         price = goodsVO.getGoods_premiumPrice();
      }else {
         price = 0;
      }
      
      
      return String.valueOf(price);
   }
      
   @RequestMapping(value="/payToOrderGoods.do" ,method = RequestMethod.POST)
   public String payToOrderGoods(@RequestParam Map<String, String> receiverMap,
                                HttpServletRequest request, HttpServletResponse response)  throws Exception{
      
      HttpSession session=request.getSession();
      
      if(session.getAttribute("memberInfo") != null) {
         MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
         String id=memberVO.getId();
         String orderer_name=memberVO.getName();
         
         Map orderMap = (Map)session.getAttribute("orderMap");
         List<OrderVO> myOrderList=(List<OrderVO>)orderMap.get("orderList");
         List<CompanyVO> orderCompanyList = (List<CompanyVO>)orderMap.get("orderGoodsCompany");
         for(int i=0; i<myOrderList.size();i++){
            OrderVO orderVO=(OrderVO)myOrderList.get(i);
            orderVO.setId(id);
            orderVO.setOrderer_name(orderer_name);
            int order_price = orderVO.getFinal_resultPrice();
            orderVO.setCompany_name(myOrderList.get(i).getCompany_name());
            orderVO.setOrder_price(order_price);
            orderVO.setCompany_name(orderCompanyList.get(i).getCompany_name());
            orderVO.setPay_method(receiverMap.get("pay_method"));
            orderVO.setCard_com_name(receiverMap.get("card_com_name"));
            orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
            orderVO.setOrder_price(Integer.parseInt(receiverMap.get("order_price")));
            orderVO.setOrder_goods_qty(Integer.parseInt(receiverMap.get("order_goods_qty")));
            orderVO.setOrder_goods_option(receiverMap.get("order_goods_option"));
            myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
         }//end for
         
         orderService.addNewOrder(myOrderList);
         session.setAttribute("myOrderInfo",receiverMap);
         session.setAttribute("myOrderList", myOrderList);
         
         }else if(session.getAttribute("companyInfo") != null) {
            CompanyVO memberVO = (CompanyVO) session.getAttribute("orderer");
            String id=memberVO.getId();
            String orderer_name=memberVO.getCompany_name();
            
            Map orderMap = (Map)session.getAttribute("orderMap");
            List<OrderVO> myOrderList=(List<OrderVO>)orderMap.get("orderList");
            List<CompanyVO> orderCompanyList = (List<CompanyVO>)orderMap.get("orderGoodsCompany");
            for(int i=0; i<myOrderList.size();i++){
               OrderVO orderVO=(OrderVO)myOrderList.get(i);
               orderVO.setId(id);
               orderVO.setOrderer_name(orderer_name);
               int order_price = orderVO.getFinal_resultPrice();
               orderVO.setOrder_price(order_price);
               orderVO.setCompany_name(orderCompanyList.get(i).getCompany_name());
               orderVO.setPay_method(receiverMap.get("pay_method"));
               orderVO.setCard_com_name(receiverMap.get("card_com_name"));
               orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
               orderVO.setOrder_price(Integer.parseInt(receiverMap.get("order_price")));
               orderVO.setOrder_goods_qty(Integer.parseInt(receiverMap.get("order_goods_qty")));
               orderVO.setOrder_goods_option(receiverMap.get("order_goods_option"));
               myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
            }//end for
            
            orderService.addNewOrder(myOrderList);
            session.setAttribute("myOrderInfo",receiverMap);
            session.setAttribute("myOrderList", myOrderList);
            
         }
      
      
      return "redirect:/order/orderResult.do";
      
      
   }
   
   @RequestMapping(value="/orderResult.do")
   public ModelAndView orderResult(HttpServletRequest request, HttpServletResponse response)  throws Exception{
      String viewName=(String)request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      HttpSession session=request.getSession();
      
      Map receiverMap = (Map)session.getAttribute("myOrderInfo");
      List myOrderList = (List)session.getAttribute("myOrderList");
      mav.addObject("myOrderInfo",receiverMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
      mav.addObject("myOrderList", myOrderList);
      return mav;
   }
}