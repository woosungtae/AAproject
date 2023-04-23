<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myOrderGoods"  value="${orderMap.myOrderGoods}"  />
<c:set var="orderGoodsCompany"  value="${orderMap.orderGoodsCompany}"  />
<c:set var="orderList"  value="${orderMap.orderList}"  />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>상품 구매하기창</title>
<style>  
body {
font-family: Arial, sans-serif;
background-color: #ffffff;
}
#orderHead {
       font-size: 24px;
    line-height: 1.4;
    margin-left: 215px;
    padding-top: 15px;
} 
.goodsBuyPNG {
  display:inline-block;
    float:right;
        margin-right: 50px;
}  
.goodsBuyForm{     
   width: 1050;
    height: 1000px;
    text-align: left;
    padding: 10px;
    display: inline-block;
    margin-left: 20px;
}  
.goodsBuyForm1{ 
       width: 680px;
    border: 1px solid grey;
    display: inline-block;
    margin-top: 0px;
    margin-left: 20px;
}  
.orderCheck{
   margin:0;
   width:100%;
   border-collapse: collapse;
}
.orderCheck .goods_img{
margin:10px;
   width:80px;
   height:70px;
}
.orderCheck .table_center{
   text-align:center;
}
.orderCheck tr{
   margin-bottom:10px;
   line-height: 2.2;
}
.goodsBuyForm2{ 
   width: 300px;
    height: 350px;
    border: 1px solid grey;
    display: inline-block;
    margin-left: 10px;
    margin-right: 0;
    position: absolute;
}    
.goodsBuyForm3{ 
   width: 680px;
    height: 250px;
    margin-top: 10px;
    line-height: 1.6;
    padding: auto;
    margin-left: 20px;
    flex-direction: row;
    justify-content: center;
}
  .goodsBuyForm3 th {
    width: 400px; 
  }
.goodsBuyForm3 td {
   font-size:1.3em;
   margin-top:5px;
}
.goodsBuyForm4{
   width: 680px;
    height: 150px;
    border: 1px solid grey;
    display: inline-block;
    margin-top: 10px;
    margin-left: 20px;
}
.goodsBuyForm5{
   width: 680px;
    height: 250px;
    border: 1px solid grey;
    display: inline-block;
    margin-top: 10px;
    margin-left: 20px;
}
.upperArrow{
   width:20px;
   height:20px;
   transform: rotate(180deg);
}
.upperArrow:hover{
}
.lowerArrow{
   width:20px;
   height:20px;
   
}
.lowerArrow:hover{
}
</style>
<script>

function modify_goods_qty(goods_num,index, updown){
   var length = document.getElementsByName('order_goods_option').length;
   var _order_goods_qty=0;
   var input = document.getElementsByName("order_goods_qty")[index];
   var input_price = document.getElementsByName("final_resultPrice")[index];
   var goods_option = document.getElementsByName("order_goods_option")[index];
   
   var value = Number(input.value);
   if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
      if(updown == "up"){
         
      if(value < 10){
         value += 1;
      }
      }else if(value > 0){
         value -= 1;
      }
   }else if(updown == "up"){
         
      if(value < 10){
         value += 1;
      }
      }else if(value > 0){
         value -= 1;
      }
   
   $.ajax({
      type: "POST",
      url: "modifyOrderOption.do", // 서버측 코드
      data: { goods_option: goods_option.value, goods_num: goods_num },
      success: function (data) {
        // 서버에서 계산된 가격을 받아와서 가격을 갱신
        var price = data * value;
       input_price.value = price;
        document.getElementById('final_resultPrice_'+ index).textContent = price;
        var totalPrice = 0;
         $('span[id^="final_resultPrice_"]').each(function () {
           totalPrice += Number($(this).text());
         });
         $('#total_resultPrice').text(totalPrice);
      // 최종 결제액 계산 및 갱신
         var use_point = document.getElementsByName("use_point")[0].value;
         var total_price = document.getElementById("total_resultPrice").textContent;
         var final_price = Number(total_price) - Number(use_point);
         document.getElementById("total_finalResultPrice").textContent = final_price;
         document.getElementById("total_finalPrice").value = final_price;
       }
    });
   
   input.value = value;
     document.getElementById('qty_' + index).textContent = value;
}

function modify_goods_option(goods_num, index, updown) {
     var length = document.getElementsByName('order_goods_option').length;
     var goods_option = "standard";
    var qty = document.getElementsByName("order_goods_qty")[index];
     var input = document.getElementsByName("order_goods_option")[index];
    var input_price = document.getElementsByName("final_resultPrice")[index];
     if (length > 1) {
       if (input.value == "standard") {
         if (updown == "up") {
           goods_option = "deluxe";
         } else {
           goods_option = "standard";
         }
       } else if (input.value == "deluxe") {
         if (updown == "up") {
           goods_option = "premium";
         } else {
           goods_option = "standard";
         }
       } else if (input.value == "premium") {
         if (updown == "up") {
           goods_option = "deluxe";
         } else {
           goods_option = "standard";
         }
       }
     } else {
       if (input.value == "standard") {
         if (updown == "up") {
           goods_option = "deluxe";
         } else {
           goods_option = "standard";
         }
       } else if (input.value == "deluxe") {
         if (updown == "up") {
           goods_option = "premium";
         } else {
           goods_option = "standard";
         }
       } else if (input.value == "premium") {
         if (updown == "up") {
           goods_option = "premium";
         } else {
           goods_option = "deluxe";
         }
       }
     }

     input.value = goods_option;
     document.getElementById('option_' + index).textContent = input.value;
     
  // setter 호출
     $.ajax({
          type: "POST",
          url: "modifyOrderOption.do", // 서버측 코드
          data: { goods_option: goods_option, goods_num: goods_num },
          success: function (data) {
            // 서버에서 계산된 가격을 받아와서 가격을 갱신
            var price = data * qty.value;
           input_price.value = price;
            document.getElementById('final_resultPrice_'+ index).textContent = price;
            var totalPrice = 0;
             $('span[id^="final_resultPrice_"]').each(function () {
               totalPrice += Number($(this).text());
             });
             $('#total_resultPrice').text(totalPrice);
          // 최종 결제액 계산 및 갱신
             var use_point = document.getElementsByName("use_point")[0].value;
             var total_price = document.getElementById("total_resultPrice").textContent;
             var final_price = Number(total_price) - Number(use_point);
             document.getElementById("total_finalResultPrice").textContent = final_price;
             document.getElementById("total_finalPrice").value = final_price;
           }
        });

     
     
   }


</script>
<script>
var goods_num;
var goods_title;
var goods_fileName;
var order_goods_qty;
var total_order_goods_qty;
var orderer_name;
var orderer_tel; 
var orderer_email; 

var pay_method; 
var card_com_name; 
var card_pay_month; 


function fn_process_pay_order() {
      alert("최종 결제하기");
      
      // form 요소 생성
      var formObj = document.createElement("form");
      
      // input 요소 생성
      var orderer_name = document.createElement("input");
      var orderer_id = document.createElement("input"); // 변수명 수정
      var orderer_tel = document.createElement("input");
      var orderer_email = document.createElement("input");
      var pay_method = document.createElement("input");
      var card_com_name = document.createElement("input");
      var card_pay_month = document.createElement("input");
      var order_price = document.createElement("input");
      var order_goods_qty = document.createElement("input");
      var order_goods_option = document.createElement("input");
      
      pay_method1 = document.getElementsByName("pay_method");
      var selected_pay_method;
      for (var i = 0; i < pay_method1.length; i++) {
         if (pay_method1[i].checked) {
           selected_pay_method = pay_method1[i].value;
           break;
         }
       }
      
      
      // input 요소의 name 속성값 설정
      orderer_name.name = "orderer_name";
      orderer_id.name = "orderer_id"; // 변수명 수정
      orderer_tel.name = "orderer_tel";
      orderer_email.name = "orderer_email";
      pay_method.name = "pay_method";
      card_com_name.name = "card_com_name";
      card_pay_month.name = "card_pay_month";
      order_price.name = "order_price";
      order_goods_qty.name = "order_goods_qty";
      order_goods_option.name="order_goods_option";
    
      // input 요소의 value 속성값 설정
      orderer_name.value = document.getElementsByName("ordererName").value; // 값을 할당할 변수명을 지정해주어야 합니다.
      orderer_id.value = document.getElementsByName("ordererId").value; // 변수값을 할당할 변수명을 지정해주어야 합니다.
      orderer_tel.value = document.getElementsByName("ordererTel").value;
      orderer_email.value = document.getElementsByName("ordererEmail").value;
      pay_method.value = selected_pay_method;
      card_com_name.value = document.getElementById("card_com_name").value;
      card_pay_month.value = document.getElementById("card_pay_month").value;
      order_price.value = document.getElementById("total_finalPrice").value;
      order_goods_qty.value = document.getElementsByName("order_goods_qty")[0].value;
      order_goods_option.value = document.getElementsByName("order_goods_option")[0].value;

      
      // 생성한 input 요소를 form 요소에 추가
      formObj.appendChild(orderer_name);
      formObj.appendChild(orderer_id);
      formObj.appendChild(orderer_tel);
      formObj.appendChild(orderer_email);
      formObj.appendChild(pay_method);
      formObj.appendChild(card_com_name);
      formObj.appendChild(card_pay_month);
      formObj.appendChild(order_price);
      formObj.appendChild(order_goods_qty);
      formObj.appendChild(order_goods_option);

      
      // form 요소를 body에 추가하고, method와 action 속성값 설정 후 submit
      document.body.appendChild(formObj);
      formObj.method = "post";
      formObj.action = "${contextPath}/order/payToOrderGoods.do";
      formObj.submit();
      
   }
function backToList(obj){
    obj.action="${contextPath}/goods/goodsListByCategory.do";
    obj.submit();
 }

</script>



</head> 
<body>  
   <img class="goodsBuyPNG" alt="결제창"  src="${contextPath}/resources/image/goodsHead.png">
   <h3 id="orderHead">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;상품 구매하기</h3> 
   
   <form class="goodsBuyForm">
    
   <div class="goodsBuyForm1" style="border:none;">  
   <table class="orderCheck" style="border:3px inset #adb5bd;"> 
      <tr style="border-bottom:2px solid #adb5bd">
         <td colspan="2"><h2 style="font-size:20px; margin-left:20px; font-weight: bolder;">주문내역</h2></td>
         <td style="font-size:12px;">상품 옵션</td>
         <td style="font-size:12px;">주문 수량</td>
         <td style="font-size:12px;" align="center">결제 금액</td> 
      </tr> 
      <form name="frm_order_all_cart">
      <c:forEach var="item" items="${orderList }" varStatus="cnt">
      <c:set var="company_name" value="${orderGoodsCompany[cnt.count-1].company_name}" />
    <c:set var="goods_title" value="${myOrderGoods[cnt.count-1].goods_title}" />
      <tr style="height:100px;">
         <td align="center"><a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }">
                     <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_num=${item.goods_num}&fileName=${item.goods_fileName}"  />
                  </a></td>
         <td><a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }">${goods_title }</a> <br><a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }"><h2>${company_name}</h2></a> </td>
         <td class="table_center"><img class="upperArrow" src="${contextPath}/resources/image/arrow1.png" onclick="javascript:modify_goods_option('${item.goods_num}','${cnt.count-1}','up');"><br><input name="order_goods_option" type="hidden" value="${item.order_goods_option}" /><span id="option_${cnt.count-1}">${item.order_goods_option }</span><br><img class="lowerArrow" src="${contextPath}/resources/image/arrow1.png" onclick="javascript:modify_goods_option('${item.goods_num}','${cnt.count-1}','down');">
         </td>
         <td class="table_center"><img class="upperArrow" src="${contextPath}/resources/image/arrow1.png" onclick="javascript:modify_goods_qty('${item.goods_num}','${cnt.count-1}','up');"><br><input name="order_goods_qty" type="hidden" value="${item.order_goods_qty}" /><span id="qty_${cnt.count-1}">${item.order_goods_qty}</span><br><img class="lowerArrow" src="${contextPath}/resources/image/arrow1.png" onclick="javascript:modify_goods_qty('${item.goods_num}','${cnt.count-1}','down');">
         </td>
         <td class="table_center"> <input name="final_resultPrice" type="hidden" value="${item.final_resultPrice * item.order_goods_qty}" /><span id="final_resultPrice_${cnt.count-1}">${item.final_resultPrice * item.order_goods_qty} </span>원</td>
      </tr>
      <c:set var="totalPrice" value="${totalPrice += item.final_resultPrice * item.order_goods_qty}" />
      </c:forEach>
   </table>
   </div> 
   <table class="goodsBuyForm2" style="border:3px inset #adb5bd; border-collapse: collapse;" >  
      <tr style="border-bottom:2px solid #adb5bd; height:70px;" >
         <td align="center" style="width:70px;">서비스 금액</td> 
         <td align="center" style="width:175px;"><span id="total_resultPrice">${totalPrice}</span>원</td>
      </tr>
      <tr style="border-bottom:2px solid #adb5bd; height:70px;">
         <td align="center">포인트 할인</td> 
         <td align="center"><input type="hidden" name="use_point" value="${use_point}" /></td>
      </tr>
      <tr style="border-bottom:2px solid  #adb5bd; height:70px;">
         <td align="center">최종 결제액</td>
         <td align="center"><input type="hidden" id="total_finalPrice" name="total_finalResultPrice" value="${totalPrice - use_point}" /><span id="total_finalResultPrice">${totalPrice - use_point}</span>원</td>
      </tr>
      <tr>
      <td style="width:180px;"><button onClick="backToList(this.form)" style="width: 80px; height: 40px; font-size: 0.9em; font-weight: bold; background: rgb(245, 215, 0); border-radius: 5px; border: 0px; color: #fff; margin-left:30px; margin-top:50px;">취소하기</button></td>
      <td colspan=2 align=center>
      <input name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" style="width: 100px; height: 40px; font-size: 0.9em; font-weight: bold; background: rgb(245, 215, 0); border-radius: 5px; border: 0px; color: #fff; margin-left:30px; margin-top:50px;" value="최종결제하기"></td>
      </tr>
   
   </table>
   <table class="goodsBuyForm3" style="border:inset 3px #adb5bd; border-collapse: collapse;" > 
    <tr align ="center" style="border-bottom:solid 2px #adb5bd">  
   <th colspan = "2" style="font-size:2em;">구매자 정보</th>
    </tr>
    
    <tr align = "center" style="border-bottom:solid 2px #adb5bd; height:50px;">
   <td style="width:200px; text-align:right;">회원 이름</td>
   <td>${orderer.name }<input type="hidden" name="ordererName" value="${orderer.name}" /></td>
    </tr>
    
    <tr align = "center" style="border-bottom:solid 2px #adb5bd; height:50px;">
   <td style="width:200px; text-align:right;">회원 ID</td>
   <td>${orderer.id }<input type="hidden" name="ordererId" value="${orderer.id}" /></td>
    </tr>
    
    <tr align = "center" style="border-bottom:solid 2px #adb5bd; height:50px;">
   <td style="width:200px; text-align:right;">회원 휴대폰 번호</td>
   <td>${orderer.tel }<input type="hidden" name="ordererTel" value="${orderer.tel}" /></td>
    </tr>
    
    <tr align = "center" style="border-bottom:solid 2px #adb5bd; height:50px;">
   <td style="width:200px; text-align:right;">회원 주소</td>
   <td>${orderer.roadAdd } ${orderer.jibunAdd} ${orderer.namujiAdd}<input type="hidden" name="ordererRoadAdd" value="${orderer.roadAdd}" /><input type="hidden" name="ordererJibunAdd" value="${orderer.jibunAdd}" /><input type="hidden" name="ordererNamujiAdd" value="${orderer.namujiAdd}" /></td>
    </tr>
    
    <tr align = "center" style="border-bottom:solid 2px #adb5bd; height:50px;" >
   <td style="width:200px; text-align:right;">회원 e-mail</td>
   <td>${orderer.email }<input type="hidden" name="ordererEmail" value="${orderer.email}" /></td>
    </tr>
    
</table>

   <table class="goodsBuyForm4" style="border:inset 3px #adb5bd; ">  <!-- 포인트 사용 -->
      <tr >
         <td colspan="2" align="center" style="width:550px; font-size:2em; font-weight: bolder; ">포인트 사용</td> 
      </tr> 
      <tr> 
         <td align="center" style="width:100px; height:40px; " >현재 포인트</td>
         <td style="width:350px; padding-left:55px;">${orderer.point}원</td>
      </tr>
      <tr>
  <td align="center" style="width:300px; height:40px;"><input type="text" id="point-input" /></td>
  <td><button id="apply-btn" style="width: 80px; height: 40px; font-size: 0.9em; font-weight: bold; background: rgb(245, 215, 0); border-radius: 5px; border: 0px; color: #fff;margin-left:20px;">적용</button></td>
</tr>
   </table>
   <table class="goodsBuyForm5" style="border:inset 3px #adb5bd; border-collapse: collapse;" >  <!-- 결제 방법 -->
   <tbody>
               <tr >
                  <td style="width:700px; height:50px; padding-left:20px;"><input type="radio" name="pay_method"
                     value="신용카드" onClick="fn_pay_card()" checked>신용카드
                     &nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
                     name="pay_method" value="제휴 신용카드">제휴 신용카드
                     &nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
                     name="pay_method" value="실시간 계좌이체">실시간 계좌이체
                     &nbsp;&nbsp;&nbsp; </td> 
               </tr>
               <tr> 
                  <td style="width:700px; height:50px; padding-left:20px;"><input type="radio" name="pay_method"
                     value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제
                     &nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
                     name="pay_method" value="카카오페이(간편결제)">카카오페이(간편결제)
                     &nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
                     name="pay_method" value="페이나우(간편결제)">페이나우(간편결제)
                     &nbsp;&nbsp;&nbsp; <input type="radio" id="pay_method"
                     name="pay_method" value="페이코(간편결제)">페이코(간편결제)
                     &nbsp;&nbsp;&nbsp;</td>
               </tr>
               <tr style="border-top:2px solid #adb5bd; border-bottom:2px solid #adb5bd;">
                  <td style="width:700px; height:50px; padding-left:20px;"><input type="radio" name="pay_method"
                     value="직접입금">직접입금&nbsp;&nbsp;&nbsp;</td>
               </tr> 
               <tr id="tr_pay_card">
                  <td style="height:100px; padding-left:20px;"><strong>카드 선택<strong>:&nbsp;&nbsp;&nbsp;
                           <select id="card_com_name" name="card_com_name">
                              <option value="삼성" selected>삼성</option>
                              <option value="하나SK">하나SK</option>
                              <option value="현대">현대</option>
                              <option value="KB">KB</option>
                              <option value="신한">신한</option>
                              <option value="롯데">롯데</option>
                              <option value="BC">BC</option>
                              <option value="시티">시티</option>
                              <option value="NH농협">NH농협</option>
                        </select> <br>
                        <Br> <strong>할부 기간:<strong>
                                 &nbsp;&nbsp;&nbsp; <select id="card_pay_month"
                                 name="card_pay_month">
                                    <option value="일시불" selected>일시불</option>
                                    <option value="2개월">2개월</option>
                                    <option value="3개월">3개월</option>
                                    <option value="4개월">4개월</option>
                                    <option value="5개월">5개월</option>
                                    <option value="6개월">6개월</option>
                              </select></td>
               </tr>
            </tbody>
   </table>
   </form>
</body>
</html> 