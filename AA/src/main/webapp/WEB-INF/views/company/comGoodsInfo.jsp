<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
   margin-left: auto;
   margin-right: auto;
   padding-top: 10px;
   border-top: 5px solid rgb(255, 215, 0);
}
.bt1{
 width: 70px;
    height: 30px;
    border-radius: 5px;
    margin:3px;
    border: 0px;
 text-align: center;
 background-color:rgb(255, 215, 0);
 font-family: 'TheJamsil';
 color: #fff;
 
 }
 .bt2{
  width: 70px;
    height: 30px;
    border-radius: 5px;
    border: 0px;
 text-align: center;
 background-color:lightgray;
 font-family: 'TheJamsil';
 }
 .bt3 {
 	width: 100px;
 	height: 40px;
 	border-radius: 5px;
    border: 0px;
    background-color:rgb(255, 215, 0);
    text-align: center;
    font-family: 'TheJamsil';
    font-size: 1.1em;
    font-weight: bold;
    float: right;
    color: #fff;
 }
</style>
<script type="text/javascript">
	var formObj = $("form[role='form']");
	
	$("#modify_btn").click(function(){
	 formObj.attr("action", "${contextPath}/company/modifyGoodsInfo");
	 formObj.attr("method", "get")
	 formObj.submit();
	});

function delete_goods(goods_num){
	if(confirm("상품을 삭제하시겠습니까?")) {
	   var goods_num=Number(goods_num);
	   var formObj1=document.createElement("form");
	   var i_goods = document.createElement("input");
	   i_goods.name="goods_num";
	   i_goods.value=goods_num;
	   
	   formObj1.appendChild(i_goods);
	    document.body.appendChild(formObj1); 
	    formObj1.method="post";
	    formObj1.action="${contextPath}/company/removeGoods.do";
	    formObj1.submit();
	} else {
		alert("취소합니다.");
	}
}
</script>
</head>
<body>
	<h3 style="font-size:2em;width:900px; height:60px; margin-left:300px;margin-right:auto;">My 상품 조회</h3>
   <table class="list_view">
      <tbody align=center >
         <tr>
            <td>선택</td>
            <td>상품 번호</td>
            <td>상품명</td>
            <td>상품 이미지</td>
            <td>금액</td>
            <td>등록 날짜</td>
            <td></td>
         </tr>
         <c:choose>
             <c:when test="${empty comGoodsList }">
             <tr>
                <td colspan=8 class="fixed" height="300px;">
                  <strong>등록한 상품이 없습니다.</strong>
                </td>
              </tr>
             </c:when>
	         <c:otherwise>
	         		<c:forEach var="item" items="${comGoodsList}">
	         			<tr>
	         		   <td><input type="checkbox" name="checked_goods" checked></td>
		               <td><h2>${item.goods_num }</h2></td>
		               <td>
		                  <h2><a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }">${item.goods_title }</a></h2>
		               </td>
		               <td class="goods_image">
		                  <a href="${contextPath}/goods/goodsDetail.do?goods_num=${item.goods_num }">
		                     <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_num=${item.goods_num}&fileName=${item.goods_fileName}"  />
		                  </a>
		               </td>
				  	   <td><h2>${item.goods_standardPrice}원</h2></td>
		               <td><h2>${item.goods_credate }</h2></td>
		               <td>
		               	<input type="button" class="bt1" value="수정"><br>
		               	<input type="button" class="bt2" value="삭제" onclick="delete_goods('${item.goods_num}'); return false;"/>
		               </td>
			         	</tr>
	         		</c:forEach>
	         </c:otherwise>
         </c:choose> 
         </tbody>
   </table>
  <table class="list_view" style="margin-bottom:30px; margin-left:300px;">
	  <tr>
		  <td>
		  	<a href="${contextPath}/company/addNewGoods.do"><input type="button" class="bt3" value="상품 등록" ></a>
		  </td>
	  </tr>
  </table>
</body>
</html>