<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%-- 
<c:set var="item"  value="${itemMap.item}"  />
<c:set var="imageFileList"  value="${itemMap.imageFileList}"  />

 --%>
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
   <meta charset="UTF-8">
   <title>공지사항 글 상세</title>
   <style>
     #tr_file_upload{
       display:none;
     }
     #tr_btn_modify{ 
       display:none;
     }
   .one_form {
   margin-left:280px;
   }
   input[type=text] {
 border:none;
 background:white;
}
.list_view{ 
      width: 762px;
    margin-left: auto;
    margin-right: auto;
    border-bottom: 5px solid rgb(255, 215, 0);

   }

   #tr_btn input[type=text]{
     background:rgb(255, 215, 0);
   }
.listback_btn{
      width: 160px;
       height: 40px;
       font-size: 0.9em;
       font-weight: bold;
       background: rgb(245, 215, 0);
       border-radius: 5px;
       border: 0px;
       color: #fff;
}
   .cmt {
      width: 900px;
      font-size: 1.5em;
      margin: 10px 0px;
      padding: 10px 0px;
      border-bottom: 1px solid #ccc;
   }
   .cmt_btn {
      width: 80px;
       height: 40px;
       font-size: 1.2em;
       font-weight: bold;
       background: rgb(245, 215, 0);
       border-radius: 5px;
       border: 0px;
       color: #fff;
   }
   .cmt_date {
      margin-left: 10px;
      font-weight: normal;
      font-size: 0.8em;
   }
   .nonono {
      width: 900px;
      text-align: center;
      font-size: 2em;
      margin: 10px 0px;
   }
   textarea {
      font-family: 'TheJamsil';
      padding: 5px;
   }

   </style>
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   <script type="text/javascript" >
     function backToList(obj){
       obj.action="${contextPath}/adboard/listItems.do";
       obj.submit();
     }
 
    function fn_enable(obj){
       document.getElementById("i_title").disabled=false;
       document.getElementById("i_content").disabled=false;
       document.getElementById("i_imageFileName").disabled=false;
       document.getElementById("tr_btn_modify").style.display="block";
       document.getElementById("tr_file_upload").style.display="block";
       document.getElementById("tr_btn").style.display="none";
    }
    
    function fn_modify_item(obj){
       obj.action="${contextPath}/adboard/modItem.do";
       obj.submit();
    }
    
    function fn_remove_item(url,adboard_num){
          var form = document.createElement("form");
          form.setAttribute("method", "post");
          form.setAttribute("action", url);
           var adboard_numInput = document.createElement("input");
          adboard_numInput.setAttribute("type","hidden");
           adboard_numInput.setAttribute("name","adboard_num");
           adboard_numInput.setAttribute("value", adboard_num);
          
           form.appendChild(adboard_numInput);
           document.body.appendChild(form);
           form.submit();
       }
    
    
    function fn_reply_form(url, ){
       var form = document.createElement("form");
       form.setAttribute("method", "post");
       form.setAttribute("action", url);
        var Input = document.createElement("input");
        Input.setAttribute("type","hidden");
        Input.setAttribute("name","");
        Input.setAttribute("value", );
       
        form.appendChild(Input);
        document.body.appendChild(form);
       form.submit();
    }
    
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }  
 </script>
</head>
<body>
 <h3 style="font-size:2em;width:1000px; height:57px; margin-left:300px; margin-right:auto;">공지사항 상세창</h3>
<table  width=1000px;   class="list_view" style=" margin-left:280px;">
</table> 
  <form name="frmItem" method="post"  action="${contextPath}"  enctype="multipart/form-data" class="one_form">
  <table  border=0  align="center">
      
  <tr>
   <td  colspan="2" align="left" style="padding-left:50px;"> 
    <input type=text value="${item.adboard_title }"  name="board_title"  id="i_title" style=" width:460px; height:49; font-size:1.2em; font-family:'TheJamsil'; "disabled />
   </td> 
      <td><input type="text" style="width:200; height:20; text-align:center;" value="${item.adboard_category }" disabled/>
   </td>    
  </tr>  
   <tr>
   <td colspan="3" style="height:0.3; border-top:0.5px solid rgb(245, 215, 0);"></td>
   </tr>
      <tr>  
   <td style="width:30px;"></td>
   <td style=" padding-left:50px; text-align:left; width:460; height:20; padding:15px;font-size:0.7em;">
      ${item.id}
   </td>
   
   <td style="text-align:center; width:170; height:20; padding:15px;font-size:0.7em;">
      조회수:${item.viewCnt}&nbsp;&nbsp; 
   </td> 
  </tr>
  
   
  <c:choose> 
     <c:when test="${not empty item.imageFileName && item.imageFileName!='null' }">
         <tr> 
         <td style="text-align:center; width:660;  max-width:660px; height:500; border-top:0.5px solid rgb(245, 215, 0);" colspan="3">
           <input  type= "hidden"   name="originalFileName" value="${item.imageFileName }" />
          <img src="${contextPath}/download2.do?adboard_num=${item.adboard_num}&imageFileName=${item.imageFileName}" id="preview"  /><br>
         </td>   
        </tr>   
           <td colspan="3" style="text-align:left; width:660; height:auto; max-width:660px; padding:10; padding-left:50px; word-break:break-all;">
              ${item.adboard_content }
             </td>   
       </c:when>          
       <c:otherwise>
          <td colspan="3" style="text-align:left; max-height:1000px; width:660; max-width:660px; height:100px; padding:10; padding-left:50px; padding-right:50px; word-break:break-all; border-top:0.5px solid rgb(245, 215, 0);">
              ${item.adboard_content  }
             </td>
       </c:otherwise> 
    </c:choose>

  <tr   id="tr_btn_modify"  align="center"  >
      <td colspan="3"   > 
          <input type=button value="수정반영하기"   onClick="fn_modify_article(frmArticle)"  >
           <input type=button value="취소"  onClick="backToList(frmArticle)">
      </td>   
  </tr>
    
  <tr  id="tr_btn">
  <c:choose>
         <c:when test="${isLogOn == true and memberInfo.status =='관리자'}">
   <td colspan="3" align="center" style="padding-top:20px; border-top:0.5px solid rgb(245, 215, 0);">
         <input type=button value="수정하기" class="listback_btn" onClick="fn_modify_item(this.form)">
         <input type=button value="삭제하기" class="listback_btn" onClick="fn_remove_item('${contextPath}/adboard/removeItem.do', ${item.adboard_num})">
       <input type=button value="리스트로 돌아가기" class="listback_btn" onClick="backToList(this.form)">
   </td>   </c:when>
   <c:otherwise>
      <td colspan="3" align="center" style="padding-top:20px; border-top:0.5px solid rgb(245, 215, 0);">
          <input type=button value="리스트로 돌아가기" class="listback_btn" onClick="backToList(this.form)">
          </td>
   </c:otherwise>

   </c:choose>
  </tr>
 </table> 
 </form>  
</body>
</html>