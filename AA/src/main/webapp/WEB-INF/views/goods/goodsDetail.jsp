<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"    isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goodsVO}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />
 <%
     //치환 변수 선언합니다.
      //pageContext.setAttribute("crcn", "\r\n"); //개행문자
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>  
<html>
<head>
<style>
.Detail_left a{
   color:rgb(255, 215, 0);
}
.Detail_left a:hover{
   color: rgb(255, 102, 0); text-decoration: none;
}
.Detail_left h3 {
   color:rgb(255, 215, 0);
   margin-bottom:10px;
}
#layer {
   z-index: 2;
   position: absolute;
   top: 0px;
   left: 0px;
   width: 100%;
}
#popup {
    z-index: 3;
    position: fixed;
    text-align: center;
    padding-left: 30px;
    left: 50%;
    top: 45%;
    width: 300px;
    height: 150px;
    background-color: #fff;
    border: 3px solid rgb(245,215,0);
    border-radius: 5px;
}
#popup input[type=submit]{
   width: 120px;
   height: 30px;
   border: 0px;
   border-radius: 3px;
   text-align: center;
   color: #fff;
   font-size: 1em;
   background-color: rgb(245, 215, 0);
   margin-top: 20px;
}
#close {
    z-index: 4;
    float: right;
    padding: 5px;
    width: 15px;
    height: 15px;
}
</style>
<script type="text/javascript">
   function add_cart(goods_num, cart_goods_qty_id, goods_option) {
      var _isLogOn=document.getElementById("isLogOn");
      var isLogOn=_isLogOn.value;
      
       if(isLogOn=="false" || isLogOn=='' ){
         alert("로그인 후 주문이 가능합니다!!!");
      } else{
      
      $.ajax({
         type : "post",
         async : false, //false인 경우 동기식으로 처리한다.
         url : "${contextPath}/cart/addGoodsInCart.do",
         data : {
            goods_num:goods_num,
            cart_goods_qty: $('#' + cart_goods_qty_id).val(),
            goods_option:goods_option
         },
         success : function(data, textStatus) {
            //alert(data);
         //   $('#message').append(data);
            if(data.trim()=='add_success'){
               imagePopup('open', '.layer01');   
            }else if(data.trim()=='already_existed'){
               alert("이미 카트에 등록된 상품입니다.");   
            }
            
         },
         error : function(data, textStatus) {
            alert("에러가 발생했습니다."+data);
         },
         complete : function(data, textStatus) {
             /* alert("장바구니 추가완료 했습니다"); */
          }
      }); //end ajax   
      }
   }

   function imagePopup(type) {
      if (type == 'open') {
         // 팝업창을 연다.
         jQuery('#layer').attr('style', 'visibility:visible');

         // 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
         jQuery('#layer').height(jQuery(document).height());
      }

      else if (type == 'close') {

         // 팝업창을 닫는다.
         jQuery('#layer').attr('style', 'visibility:hidden');
      }
   }
   
   function fn_order_each_goods(goods_num,goods_option,qty, goods_title,fileName){
   var _isLogOn=document.getElementById("isLogOn");
   var isLogOn=_isLogOn.value;
   
    if(isLogOn=="false" || isLogOn=='' ){
      alert("로그인 후 주문이 가능합니다!!!");
   } 
   
   
   
   var formObj=document.createElement("form");
   var i_goods_num = document.createElement("input"); 
    var i_order_goods_qty=document.createElement("input");
    var i_order_goods_option=document.createElement("input");
    var i_goods_title = document.createElement("input");
    var i_fileName=document.createElement("input");
    
    i_goods_num.name="goods_num";
    i_order_goods_qty.name="order_goods_qty";
    i_order_goods_option.name="order_goods_option";
    i_goods_title.name="goods_title";
    i_fileName.name="goods_fileName";
    
    i_goods_num.value=goods_num;
    i_order_goods_qty.value=qty;
    i_order_goods_option.value=goods_option;
    i_goods_title.value=goods_title;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_num);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);
    formObj.appendChild(i_order_goods_option);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}
</script>
<script>

   function reviewList() {
      var goods_num = ${goods.goods_num};
      $.getJSON("${contextPath}/goods/reviewList.do" + "?goods_num=" + goods_num, function(data){
       var str = "";
       
       $(data).each(function(){
        
        console.log(data);
        
        var repDate = new Date(this.repDate);
        creDate = creDate.toLocaleDateString("ko-US")
        
        str += "<li data-goods_num='" + this.goods_num + "'>"
          + "<div class='memberInfo'>"
          + "<span class='id'>" + this.id + " "
          + "<span class='date'>" + creDate + " "
          + "</div>"
          + "<div class='goods_content'>" + this.goods_content + "</div>"
          + "</li>";             
       });
       
       $("#tab_content.reviewList ol").html(str);
      });
   }

   $(function(){
      $('#thumbnail li').click(function(){
        var thisIndex = $(this).index()
        if(thisIndex < $('#thumbnail li.active').index()){
          prevImage(thisIndex, $(this).parents("#thumbnail").prev("#image-slider"));
        }else if(thisIndex > $('#thumbnail li.active').index()){
          nextImage(thisIndex, $(this).parents("#thumbnail").prev("#image-slider"));
        }
        $('#thumbnail li.active').removeClass('active');
        $(this).addClass('active');
      });

      var width = $('#image-slider').width();

      function nextImage(newIndex, parent){
         parent.find('li').eq(newIndex).addClass('next-img').css('left', width).animate({left: 0},600);
         parent.find('li.active-img').removeClass('active-img').css('left', '0').animate({left: -width},600);
         parent.find('li.next-img').attr('class', 'img');
         parent.find('li').eq(newIndex).attr('class', 'active-img');
      }

      function prevImage(newIndex, parent){
         parent.find('li').eq(newIndex).addClass('next-img').css('left', -width).animate({left: 0},600);
         parent.find('li.active-img').removeClass('active-img').css('left', '0').animate({left: width},600);
         parent.find('li.next-img').attr('class', 'img');
         parent.find('li').eq(newIndex).attr('class', 'active-img');
      }
    });
   
   
</script>
</head>
<body>
<div class="goods_Detail">
  <div class="Detail_left">   
   <h3><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=${goods.goods_main_category}">${goods.goods_main_category}</a> > <a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=${goods.goods_main_category}&goods_middle_category=${goods.goods_middle_category}"> ${goods.goods_middle_category} </a> > <a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=${goods.goods_main_category}&goods_middle_category=${goods.goods_middle_category}&goods_sub_category=${goods.goods_sub_category}"> ${goods.goods_sub_category} </a></h3> 
      <div id="slider-wrapper">
     <div id="image-slider">
       <ul>
         <li class="active-img">
           <img src="${contextPath}/thumbnails.do?goods_num=${goods.goods_num}&fileName=${goods.goods_fileName}">
         </li>
           <c:forEach var="image" items="${imageList}">
         <li><img src="${contextPath}/download.do?goods_num=${goods.goods_num}&fileName=${image.fileName}"></li>
           </c:forEach>
       </ul>
     </div>
     <div id="thumbnail">
       <ul>
         <li class="active"><img src="${contextPath}/thumbnails.do?goods_num=${goods.goods_num}&fileName=${goods.goods_fileName}"></li>
         <c:forEach var="image" items="${imageList}">
           <li><img src="${contextPath}/download.do?goods_num=${goods.goods_num}&fileName=${image.fileName}"></li>
         </c:forEach>
       </ul>
     </div>
   </div>
         <div class="clear"></div>
         <!-- 내용 들어 가는 곳 -->
      <div id="goods_container">
         <ul class="tabs">
            <li><a href="#tab1">상품 설명</a></li>
            <li><a href="#tab2">가격 정보</a></li>
            <li><a href="#tab3">수정·재진행</a></li>
            <li><a href="#tab4">취소·환불</a></li>
            <li><a href="#tab5">리뷰</a></li>
         </ul>
         <div class="tab_container">
            <div class="tab_content" id="tab1">
               <h4>상품 설명</h4>
               <p>${goods.goods_content}</p>
               <c:forEach var="image" items="${imageList }">
                  <img 
                     src="${contextPath}/download.do?goods_num=${goods.goods_num}&fileName=${image.fileName}">
               </c:forEach>
            </div>
            <div class="tab_content" id="tab2">
               <h4>가격 정보</h4>
               <p>
               <div class="price">
                  <table>
                  <tbody>
                     <tr class="tr_1">
                        <td class="td_1"></td>
                        <td>
                           <span class="tr_2">STANDARD</span><br>
                           <span class="tr_2_price">
                                <fmt:formatNumber  value="${goods.goods_standardPrice}" type="number" var="goods_standardPrice" />
                                 ${goods_standardPrice}원
                           </span>
                        </td>
                        <td>
                           <span class="tr_2">DELUXE</span><br>
                           <span class="tr_2_price">
                                <fmt:formatNumber  value="${goods.goods_deluxePrice}" type="number" var="goods_deluxePrice" />
                                 ${goods_deluxePrice}원
                           </span>
                        </td>
                        <td>
                           <span class="tr_2">PREMIUM</span><br>
                           <span class="tr_2_price">
                                <fmt:formatNumber  value="${goods.goods_premiumPrice}" type="number" var="goods_premiumPrice" />
                                 ${goods_premiumPrice}원
                           </span>
                        </td>
                     </tr>
                     <tr>
                        <td class="td_1">패키지 설명</td>
                        <td><span class="tr_2">${goods.goods_standardContent}</span><br>
                        </td>
                        <td><span class="tr_2">${goods.goods_deluxeContent}</span><br>
                        </td>
                        <td><span class="tr_2">${goods.goods_premiumContent}</span><br>
                        </td>
                     </tr>
                     <tr>
                        <td class="td_1">원본파일 제공</td>
                        <td>○</td>
                        <td>○</td>
                        <td>○</td>
                     </tr>
                     <tr>
                        <td class="td_1">고해상도 파일 제공</td>
                        <td>○</td>
                        <td>○</td>
                        <td>○</td>
                     </tr>
                     <tr>
                        <td class="td_1">상표등록 가능여부</td>
                        <td>○</td>
                        <td>○</td>
                        <td>○</td>
                     </tr>
                     <tr>
                        <td class="td_1">상업적 이용 가능</td>
                        <td>○</td>
                        <td>○</td>
                        <td>○</td>
                     </tr>
                     <tr>
                        <td class="td_1">응용 디자인</td>
                        <td>○</td>
                        <td>○</td>
                        <td>○</td>
                     </tr>
                     <tr>
                        <td class="td_1">시안개수</td>
                        <td>1개</td>
                        <td>3개</td>
                        <td>5개</td>
                     </tr>
                     <tr>
                        <td class="td_1">작업일</td>
                        <td>7일</td>
                        <td>7일</td>
                        <td>14일</td>
                     </tr>
                     <tr>
                        <td class="td_1">수정 횟수</td>
                        <td>2회</td>
                        <td>4회</td>
                        <td>8회</td>
                     </tr>
                     <tr>
                        <td class="td_1"></td>
                        <td><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_num }','standard','1','${goods.goods_title }','${goods.goods_fileName }');"><input type="button" value="구매하기"></a></td>
                        <td><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_num }','deluxe','1','${goods.goods_title }','${goods.goods_fileName }');"><input type="button" value="구매하기"></a></td>
                        <td><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_num }','premium','1','${goods.goods_title }','${goods.goods_fileName }');"><input type="button" value="구매하기"></a></td>
                     </tr>
                  </tbody>
                  </table>
               </div> 
            </div>
            <div class="tab_content" id="tab3">
               <h4>수정 및 재진행</h4>
               <p>01. 전문가와 의뢰인 간의 상호 협의 후 청약철회가 가능합니다. <br><br>

02. 전문가의 귀책사유로 디자인작업을 시작하지 않았거나 혹은 이에 준하는 보편적인 관점에서 심각하게 잘못 이행한 경우 결제 금액 전체 환불이 가능합니다. <br><br>

03. 전문가가 작업 기간 동안 지정된 서비스를 제공하지 못할 것이 확실한 경우 지급받은 서비스 비용을 일할 계산하여 작업물 개수와 작업 기간 일수만큼 공제하고 잔여 금액을 환불합니다. <br><br>

04. 서비스 받은 항목을 공제하여 환불하며, 공제 비용은 정가 처리됩니다.
가. 소비자 피해 보상 규정에 의거하여 작업물 원본의 멸실 및 작업 기간 미이행 및 이에 상응하는 전문가 책임으로 인한 피해 발생 시, 전액 환불 <br><br>
나. 시안 작업 진행된 상품 차감 환불<br>
ⓐ. '디자인'에 대한 금액이 서비스 내 별도 기재가 되지 않았거나, 디자인 상품 패키지 내 수정 횟수가 1회(1회 포함) 이상인 서비스 상품의 시안 or 샘플이 제공된 경우<br>
→ 구매금액의 10% 환불(디자인 비용이 별도 기재되어 있는 경우, 해당금액 차감 후 환불)<br>
※ 시안 제공 및 수정이 추가로 이뤄진 경우 환불 금액내 수정 횟수에 따라 분할하여 환불. <br><br>

05. 주문 제작 상품 등 서비스 받은 항목이 없으며, 결제 후 1일 이내 작업이 진행되기 전 시점은 전액 환불 가능. <br><br>

06. 다만, 환불이 불가능한 서비스에 대한 사실을 표시사항에 포함한 경우에는 의뢰인의 환불요청이 제한될 수 있습니다. <br><br>
가. 고객의 요청에 따라 개별적으로 주문 제작되는 재판매가 불가능한 경우(인쇄, 이니셜 각인, 사이즈 맞춤 등) <br>
ⓐ. 주문 제작 상품 특성상 제작(인쇄 등) 진행된 경우. <br>
ⓑ. 인쇄 색상의 차이 : 모니터의 종류에 따라 색상의 차이가 발생하며,인쇄 시마다 합판 인쇄 방법의 특성상 색상 표현의 오차가 발생함. <br>
ⓒ. 디자인 서비스이며 수정 횟수가 존재하지 않았던 상품일 경우 시안 수령 후 환불 불가</p>
            </div>
            <div class="tab_content" id="tab4">
               <h4>취소 및 환불 규정</h4>
               <p>01. 전문가와 의뢰인 간의 상호 협의 후 청약철회가 가능합니다. <br><br>

02. 전문가의 귀책사유로 디자인작업을 시작하지 않았거나 혹은 이에 준하는 보편적인 관점에서 심각하게 잘못 이행한 경우 결제 금액 전체 환불이 가능합니다. <br><br>

03. 전문가가 작업 기간 동안 지정된 서비스를 제공하지 못할 것이 확실한 경우 지급받은 서비스 비용을 일할 계산하여 작업물 개수와 작업 기간 일수만큼 공제하고 잔여 금액을 환불합니다. <br><br>

04. 서비스 받은 항목을 공제하여 환불하며, 공제 비용은 정가 처리됩니다.<br><br>
가. 소비자 피해 보상 규정에 의거하여 작업물 원본의 멸실 및 작업 기간 미이행 및 이에 상응하는 전문가 책임으로 인한 피해 발생 시, 전액 환불 <br><br>
나. 시안 작업 진행된 상품 차감 환불<br>
ⓐ. '디자인'에 대한 금액이 서비스 내 별도 기재가 되지 않았거나, 디자인 상품 패키지 내 수정 횟수가 1회(1회 포함) 이상인 서비스 상품의 시안 or 샘플이 제공된 경우<br>
→ 구매금액의 10% 환불(디자인 비용이 별도 기재되어 있는 경우, 해당금액 차감 후 환불)<br>
※ 시안 제공 및 수정이 추가로 이뤄진 경우 환불 금액내 수정 횟수에 따라 분할하여 환불. <br><br>

05. 주문 제작 상품 등 서비스 받은 항목이 없으며, 결제 후 1일 이내 작업이 진행되기 전 시점은 전액 환불 가능. <br><br>

06. 다만, 환불이 불가능한 서비스에 대한 사실을 표시사항에 포함한 경우에는 의뢰인의 환불요청이 제한될 수 있습니다. <br>
가. 고객의 요청에 따라 개별적으로 주문 제작되는 재판매가 불가능한 경우(인쇄, 이니셜 각인, 사이즈 맞춤 등) <br>
ⓐ. 주문 제작 상품 특성상 제작(인쇄 등) 진행된 경우. <br>
ⓑ. 인쇄 색상의 차이 : 모니터의 종류에 따라 색상의 차이가 발생하며,인쇄 시마다 합판 인쇄 방법의 특성상 색상 표현의 오차가 발생함. <br>
ⓒ. 디자인 서비스이며 수정 횟수가 존재하지 않았던 상품일 경우 시안 수령 후 환불 불가</p><br>
            </div>
            <div class="tab_content" id="tab5">
               <h4>리뷰</h4>
               <div id="reviewList">
                  <section>
                     <ol>
                        <c:forEach items="${review }" var="review">
                        <li>
                           <div class="memberInfo">
                              <span class="id">${review.nickname }</span>
                              <span>${review.status }&nbsp;|</span>
                              <span>${review.goods_grade }/5.0&nbsp;|</span>
                              <span class="date"><fmt:formatDate value="${review.creDate}" pattern="yyyy-MM-dd"/></span>
                           </div>
                           <div class="goods_content">${review.goods_content}</div>
                        </li>
                        </c:forEach>
                     </ol>
                  </section>
               </div>
               <c:if test="${isLogOn == true and not empty memberInfo || isLogOn == true and not empty companyInfo}">
            <h4>리뷰 등록</h4>
                  <form name="myform" id="myform" method="post" action="${contextPath}/goods/addReview.do">
                  <input type="hidden" name="goods_num" value="${goods.goods_num }">
               <fieldset>
                  <span class="text-bold"></span>
                  <input type="radio" name="goods_grade" value="5.0" id="rate1"><label
                     for="rate1">★</label>
                  <input type="radio" name="goods_grade" value="4.0" id="rate2"><label
                     for="rate2">★</label>
                  <input type="radio" name="goods_grade" value="3.0" id="rate3"><label
                     for="rate3">★</label>
                  <input type="radio" name="goods_grade" value="2.0" id="rate4"><label
                     for="rate4">★</label>
                  <input type="radio" name="goods_grade" value="1.0" id="rate5"><label
                     for="rate5">★</label>
               </fieldset>
               <div class="middle">
                  <textarea type="text" id="reviewContents" name="goods_content"
                          placeholder="리뷰를 작성해주세요."></textarea>
                  <input type="submit" value="등록하기" class="btn_review">
               </div>
            </form>
            </c:if>
             </div>
      </div>
   </div>
   <div class="clear"></div>
   <div id="layer" style="visibility: hidden">
      <!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
      <div id="popup">
         <!-- 팝업창 닫기 버튼 -->
         <a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');"> <img
            src="${contextPath}/resources/image/close.png" id="close" />
         </a> <br /> <font size="5em;" id="contents">장바구니에 담았습니다.</font><br>
         <form action='${contextPath}/cart/myCartList.do'  >            
            <input  type="submit" value="장바구니 보기">
         </form>
      </div>
   </div>
  </div>
  <div class="Detail_right">
   <!-- 내용 들어 가는 곳 -->
   <h1>${goods.goods_title }</h1>
   <div class="tabmenu out-tabmenu">
   <ul>
    <li id="tab1" class="btnCon"> 
      <input type="radio" checked name="tabmenu" id="tabmenu1">
      <label for="tabmenu1">STANDARD</label>
      <div class="tabCon" >
      <h1>
      <fmt:formatNumber  value="${goods.goods_standardPrice}" type="number" var="goods_standardPrice"/>
           ${goods_standardPrice}원 <small>(VAT 포함가)</small></h1>
         <b>${goods.goods_intro}</b>
             <table>
                <tr>
                   <td>원본파일 제공</td>
                   <td style="float: right;">○</td>
                </tr>
                <tr>
                   <td>고해상도 파일 제공</td>
                   <td style="float: right;">○</td>
                </tr>
                <tr>
                   <td>상표등록 가능여부</td>
                   <td style="float: right;">○</td>
                </tr>
                <tr>
                   <td>상업적 이용 가능</td>
                   <td style="float: right;">○</td>
                </tr>
                <tr>
                   <td>시안개수</td>
                   <td style="float: right;">1개</td>
                </tr>
                <tr>
                   <td>작업일</td>
                   <td style="float: right;">7일</td>
                </tr>
                <tr>
                   <td>수정 횟수</td>
                   <td style="float: right;">2회</td>
                </tr>
                <tr>
                   <td>수량</td>
                   <td style="float: right;">
                    <select id="cart_goods_qty1" name="cart_goods_qty1" class="form-select">
                           <option value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                        </select>
                     </td>
                </tr>
                <tr>
                <td><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_num }','standard',document.getElementById('cart_goods_qty1').value,'${goods.goods_title }','${goods.goods_fileName }');"><input type="button" value="구매하기"></a></td>
                  <td><a class="cart" href="javascript:add_cart('${goods.goods_num }','cart_goods_qty1','standardPrice')"><input type="button" value="장바구니"></a></td>
               </tr>
             </table>
      </div>
    </li>
    <li id="tab2" class="btnCon"><input type="radio" name="tabmenu" id="tabmenu2">
      <label for="tabmenu2">DELUXE</label>
      <div class="tabCon" >
      <h1>
         <fmt:formatNumber  value="${goods.goods_deluxePrice}" type="number" var="goods_deluxePrice"/>
            ${goods_deluxePrice}원 <small>(VAT 포함가)</small></h1>
         <b>${goods.goods_intro}</b>
              <table>
                 <tr>
                    <td>원본파일 제공</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>고해상도 파일 제공</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>상표등록 가능여부</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>상업적 이용 가능</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>시안개수</td>
                    <td style="float: right;">3개</td>
                 </tr>
                 <tr>
                    <td>작업일</td>
                    <td style="float: right;">7일</td>
                 </tr>
                 <tr>
                    <td>수정 횟수</td>
                    <td style="float: right;">4회</td>
                 </tr>
                 <tr>
                    <td>수량</td>
                    <td style="float: right;">
                       <select id="cart_goods_qty2" name="cart_goods_qty2" class="form-select">
                           <option value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                        </select>
                     </td>
                 </tr>
                 <tr>
                 <td><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_num }','deluxe',document.getElementById('cart_goods_qty2').value,'${goods.goods_title }','${goods.goods_fileName }');"><input type="button" value="구매하기"></a></td>
                   <td><a class="cart" href="javascript:add_cart('${goods.goods_num }','cart_goods_qty2','deluxePrice')"><input type="button" value="장바구니"></a></td>
                </tr>
              </table>
   </div>
    </li>    
    <li id="tab3" class="btnCon"><input type="radio" name="tabmenu" id="tabmenu3">
      <label for="tabmenu3">PREMIUM</label>
      <div class="tabCon" >
         <h1>
            <fmt:formatNumber  value="${goods.goods_premiumPrice}" type="number" var="goods_premiumPrice"/>
               ${goods_premiumPrice}원 <small>(VAT 포함가)</small></h1>
            <b>${goods.goods_intro}</b>
              <table>
                 <tr>
                    <td>원본파일 제공</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>고해상도 파일 제공</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>상표등록 가능여부</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>상업적 이용 가능</td>
                    <td style="float: right;">○</td>
                 </tr>
                 <tr>
                    <td>시안개수</td>
                    <td style="float: right;">5개</td>
                 </tr>
                 <tr>
                    <td>작업일</td>
                    <td style="float: right;">14일</td>
                 </tr>
                 <tr>
                    <td>수정 횟수</td>
                    <td style="float: right;">8회</td>
                 </tr>
                 <tr>
                    <td>수량</td>
                    <td style="float: right;">
                       <select id="cart_goods_qty3" name="cart_goods_qty3" class="form-select">
                           <option value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                        </select>
                     </td>
                 </tr>
                 <tr>
                 <td><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_num }','premium',document.getElementById('cart_goods_qty3').value,'${goods.goods_title }','${goods.goods_fileName }');"><input type="button" value="구매하기"></a></td>
                   <td><a class="cart" href="javascript:add_cart('${goods.goods_num }','cart_goods_qty3','premiumPrice')"><input type="button" value="장바구니"></a></td>
              </tr>
            </table>
      </div>
    </li>
  </ul>
</div>
   <div class="comInfo">
      <h3>${goodsCompanyInfo.company_name }</h3>
      <ul>
         <li>연락 가능 시간: 언제나 가능</li>
         <li>평균 응답 시간: 30분 이내</li>
      </ul>
      <table>
         <tr>
            <td><span class="comWork">${goodsCompanyInfo.totalWork }건</span><br>
            총 작업 개수</td>
            <td><span class="comWork">${goodsCompanyInfo.company_grade }/5.0</span><br>
            평점</td>
            <td><span class="comWork">${goodsCompanyInfo.status }</span><br>
            회원 구분</td>
         </tr>
      </table>
      <c:if test="${!isLogOn == true and empty memberInfo || !isLogOn == true and empty companyInfo}">
         <a href="${contextPath}/member/loginForm.do"><input type="button" value="로그인 후 문의 가능"></a><br>
      </c:if>
      <c:if test="${isLogOn == true and not empty memberInfo || isLogOn == true and not empty companyInfo}">
         <a href="#"><input type="button" value="문의 하기"></a><br>
      </c:if>
      <b>소개</b>
      <p>${goodsCompanyInfo.company_intro }</p>
   </div>
   <div class="clear"></div>
   <div id="layer" style="visibility: hidden">
      <!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
      <div id="popup">
         <!-- 팝업창 닫기 버튼 -->
         <a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');"> <img
            src="${contextPath}/resources/image/close.png" id="close" />
         </a> <br /> <font size="1em;" id="contents">장바구니에 담았습니다.</font><br>
      <form   action='${contextPath}/cart/myCartList.do'  >            
            <input  type="submit" value="장바구니 보기">
      </form>
      </div>
   </div>
</div>   
</div> 
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>