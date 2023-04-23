<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
	<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="comGoodsList"  value="${orderMap}"  />
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<head>
<%
    session.removeAttribute("side_menu");
%>
<style>
.list_view{
	width: 900px;
   margin-left: 300;
   margin-right: auto;
   padding-top: 10px;
   border-top: 5px solid rgb(255, 215, 0);
}
input[type=button] {
	width: 60px; height: 30px;
   border: 1px solid rgb(248, 248, 248);
   border-radius: 5px;
   background-color: rgb(245, 215, 0);
   color:#fff;
   font-size: 1em;
   font-weight: bold;
   float: right;
}
.order_status {
	margin-left:300px;
	margin-right: auto;
	margin-bottom: 5px;
}

</style>

<script>
function modifyOrderStatus(order_num, index){
	//var order_num = document.getElementsByName("order_num")[index];
	var order_status = document.getElementsByName("order_status1")[index].value;
	$.ajax({
	      type : "post",
	      url : "${contextPath}/company/modifyOrderStatus.do",
	      data : {
	         order_num:order_num,
	         order_status:order_status
	      },
	      
	      success : function(data, textStatus) {
	         //alert(data);
	         if(data.trim()=='modify_success'){
	            alert("상태를 변경했습니다!!");   
	            location.reload();
	         }else{
	            alert("다시 시도해 주세요!!");   
	         }
	         
	      },
	      error : function(data, textStatus) {
	         alert("에러가 발생했습니다."+data);
	      },
	      complete : function(data, textStatus) {
	         //alert("작업을완료 했습니다");
	         
	      }
	   }); //end ajax   
	
}


</script>
</head>
<body>
	<h3 style="font-size:2em;width:900px; height:60px; margin-left:300px;margin-right:auto;">판매 내역</h3>
	<% String status = request.getParameter("order_status"); %>
	<form action="comSaleGoodsInfo.do?" method="get" class="order_status">
		<select name="order_status">
	      <option value="" <%= status == null ? "selected" : "" %>>전체</option>
	      <option value="pay_wait" <%= status != null && status.equals("pay_wait") ? "selected" : "" %>>결제대기</option>
	      <option value="pay_done" <%= status != null && status.equals("pay_done") ? "selected" : "" %>>결제완료</option>
	      <option value="refund_ing" <%= status != null && status.equals("refund_ing") ? "selected" : "" %>>환불중</option>
	      <option value="refund_done" <%= status != null && status.equals("refund_done") ? "selected" : "" %>>환불완료</option>
	      <option value="order_ing" <%= status != null && status.equals("order_ing") ? "selected" : "" %>>진행중</option>
	      <option value="order_done" <%= status != null && status.equals("order_done") ? "selected" : "" %>>최종완료</option>
	   </select>
   <input type="submit" value="검색">
   </form>
   <table class="list_view">
      <tbody align="center">
         <tr>
            <td>주문 번호</td>
            <td>상품명</td>
            <td>상품 이미지</td>
            <td>상태</td>
            <td>옵션 및 수량</td>
            <td>금액</td>
            <td>구매자</td>
            <td>판매 날짜</td>
         </tr>
         <c:choose>
             <c:when test="${comGoodsList == null}">
             <tr>
                <td colspan=8 class="fixed" height="300px;">
                  <strong>판매된 상품이 없습니다.</strong>
                </td>
              </tr>
             </c:when>
	         <c:otherwise>
	         		<c:forEach var="item" items="${comGoodsList}" varStatus="cnt">
	         			<tr>
		               <td><h2 name="order_num">${item.order_num }</h2></td>
		               <td>
		                  <h2><a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }">${item.goods_title }</a></h2>
		               </td>
		               <td class="goods_image">
		                  <a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }">
		                     <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_num=${item.goods_num}&fileName=${item.goods_fileName}"  />
		                  </a>
		               </td>
		               <td><select id="order_status" name="order_status1">
						    <option value="결제대기" ${item.order_status == '결제대기' ? 'selected' : ''}>결제대기</option>
						    <option value="결제완료" ${item.order_status == '결제완료' ? 'selected' : ''}>결제완료</option>
						    <option value="환불중" ${item.order_status == '환불중' ? 'selected' : ''}>환불중</option>
						    <option value="환불완료" ${item.order_status == '환불완료' ? 'selected' : ''}>환불완료</option>
						    <option value="진행중" ${item.order_status == '진행중' ? 'selected' : ''}>진행중</option>
						    <option value="최종완료" ${item.order_status == '최종완료' ? 'selected' : ''}>최종완료</option>
						</select><br><button onclick="modifyOrderStatus(${item.order_num }, ${cnt.count-1});" >변경</button></td>

		               <td ><span>${item.order_goods_option}</span><br><span>${item.order_goods_qty}</span></td>
				  	   <td><h2>${item.order_price}</h2></td>
				  	   <td><h2>${item.orderer_name }</h2></td>
		               <td><h2>${item.order_date }</h2></td>
			         	</tr>
	         		</c:forEach>
	         </c:otherwise>
         </c:choose>
         </tbody>
   </table>
  <table class="list_view" style="margin-bottom:30px; margin-left:300px;"></table>
</body>
</html>