package com.AA.cart.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.AA.cart.service.CartService;
import com.AA.cart.vo.CartVO;
import com.AA.common.base.BaseController;
import com.AA.company.vo.CompanyVO;
import com.AA.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private CompanyVO companyVO;
	
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(@RequestParam(value="sidemenu", required = false) String sidemenu, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
	      response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	      response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
	      response.setHeader("Pragma", "no-cache");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		String result = sidemenu;
		if(session.getAttribute("memberInfo") != null) {
			if(result !=null) {
				session.setAttribute("side_menu", "my_page");
			}
			MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
			String id=memberVO.getId();
			cartVO.setId(id);
			
		}else if(session.getAttribute("companyInfo") !=null) {
			if(result !=null) {
				session.setAttribute("side_menu", "company_page");
			}
			CompanyVO companyVO = (CompanyVO)session.getAttribute("companyInfo");
			String id=companyVO.getId();
			cartVO.setId(id);
		}else {
			mav.setViewName("redirect:/member/loginForm.do");
		}
		
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap);//��ٱ��� ��� ȭ�鿡�� ��ǰ �ֹ� �� ����ϱ� ���ؼ� ��ٱ��� ����� ���ǿ� �����Ѵ�.
		mav.addObject("cartMap", cartMap);
		return mav;
	}
	@RequestMapping(value="/addGoodsInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public  @ResponseBody String addGoodsInCart(@RequestParam("goods_num") int goods_num,@RequestParam("cart_goods_qty") int cart_goods_qty,@RequestParam("goods_option") String goods_option,
			                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		if(session.getAttribute("memberInfo") != null) {
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String id=memberVO.getId();
		cartVO.setId(id);
		}else if(session.getAttribute("companyInfo") !=null) {
			companyVO = (CompanyVO)session.getAttribute("companyInfo");
			String id=companyVO.getId();
			cartVO.setId(id);
		}
		cartVO.setGoods_num(goods_num);
		cartVO.setCart_goods_qty(cart_goods_qty);
		boolean isAreadyExisted=cartService.findCartGoods(cartVO);
		System.out.println("isAreadyExisted:"+isAreadyExisted);
		if(isAreadyExisted==true){
			return "already_existed";
		}else{
			cartVO.setGoods_option(goods_option);
			cartService.addGoodsInCart(cartVO);
			return "add_success";
		}
	}
	
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartQty(@RequestParam("goods_num") int goods_num,
			                                   @RequestParam("cart_goods_qty") int cart_goods_qty,
			                                   @RequestParam("goods_option") String goods_option,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		if(session.getAttribute("memberInfo") != null) {
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String id=memberVO.getId();
		cartVO.setId(id);
		}else if(session.getAttribute("companyInfo") != null) {
			CompanyVO companyVO = (CompanyVO) session.getAttribute("companyInfo");
			String id = companyVO.getId();
			cartVO.setId(id);
		}
		cartVO.setGoods_num(goods_num);
		
		cartVO.setCart_goods_qty(cart_goods_qty);
		cartVO.setGoods_option(goods_option);
		boolean result=cartService.modifyCartQty(cartVO);
		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
		
	}
	
	@RequestMapping(value="/removeCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartGoods(@RequestParam("cart_num") int cart_num,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartGoods(cart_num);
		mav.setViewName("redirect:/cart/myCartList.do");
		return mav;
	}
}
