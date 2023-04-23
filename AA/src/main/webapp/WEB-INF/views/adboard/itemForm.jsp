<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
<meta charset="UTF-8">
<title>글쓰기창</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
      if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function (e) {
           $('#preview').attr('src', e.target.result);
           $('#preview').attr('style', 'display:block;');
          }
         reader.readAsDataURL(input.files[0]);
      }
  }  
  function backToList(obj){
    obj.action="${contextPath}/adboard/listItems.do";
    obj.submit();
  }
  
  var cnt=1;
  function fn_addFile(){
     $("#d_file").append("<br>"+"<input type='file' name='file"+cnt+"' />");
     cnt++;
  }  

</script>
<style>
.list_view{
    width: 725px;
    margin-left: auto;
    margin-right: auto;
    padding-top: 25px;
    border-top: 5px solid rgb(255, 215, 0);
}
textarea {
    font-family: 'TheJamsil';
    padding: 5px;
}
input[type=text] {
	font-family: 'TheJamsil';
    padding: 5px;
}
</style>
 <title>글쓰기창</title>
</head> 
<body>
<h3 style="font-size:2em;width:900px; height:60px; margin-left:300px; margin-right:auto;">공지사항 글 작성</h3>
<table  width=900px;   class="list_view" style=" margin-left:280px;"> 
</table>
  <form name="itemForm" method="post"   action="${contextPath}/adboard/addNewItem.do"   enctype="multipart/form-data" style="margin-left:200px;">
    <table border="0" align="center" style="margin-left:100px;">
      <tr>
         <td align="center">작성자: </td>
         <c:choose>
            <c:when test="${companyInfo.id != null}">
                  <td colspan=2 align="left"><input type="text" size="30" maxlength="200" style="height:30px;" value="${companyInfo.id}" readonly/></td>
                </c:when>
                <c:when test="${memberInfo.id != null}">
                  <td colspan=2 align="left"><input type="text" size="30" maxlength="200" style="height:30px;" value="${memberInfo.id}" readonly/></td>
                </c:when>
            </c:choose>
     </tr>
               <tr>
            <td align="center">글 유형: </td>
            <td colspan="2"><select name="adboard_category">
                                <option value="공지사항">공지사항</option>
                         <option value="이벤트">이벤트</option>
                          <option value="사이트사용법">사이트사용법</option>
</select></td>
        <tr>
            <td align="center">글 제목: </td>
            <td colspan="2"><input type="text" size="72.8"  maxlength="500" style="height:30px;" name="adboard_title" /></td>
       </tr> 
        
          <tr>  
            <td align="center" valign="top"><br>글 내용: </td>
              <td colspan=2><textarea name="adboard_content" style="width:540px;" rows="10" cols="65" maxlength="4000"></textarea> </td>
           </tr>
           
           <tr>
           <td align="center">이미지파일 첨부:  </td>
           <td> <input type="file" name="imageFileName" style="margin-left:10px;" onchange="readURL(this);" /></td>
           <td><img  id="preview" src="#"   width=200 height=200 style="margin-left:40px; display: none;"/></td>
          </tr>
          <tr>
           <td align="center">이미지파일 첨부:</td>
            <td align="left"> <input type="button" value="파일 추가" style="margin-left:10px;" onClick="fn_addFile()"/></td>
        </tr>
      <tr>
         <td colspan="4"><div id="d_file"></div></td>
      </tr>  
   
       <tr style="height:100px;"> 
         <td align="center"></td> 
         <td colspan="2">
          <input type="submit" value="글쓰기" style="width: 120px; height: 40px; font-size: 0.9em; font-weight: bold; background: rgb(245, 215, 0); border-radius: 5px; border: 0px; color: #fff; margin-left:70px;"  />
          <input type=button value="목록보기"onClick="backToList(this.form)" style="width: 120px; height: 40px; font-size: 0.9em; font-weight: bold; background: rgb(245, 215, 0); border-radius: 5px; border: 0px; color: #fff;" /><input type="hidden" name="viewCnt" value="0" />
           
         </td>
     </tr>
    </table>
  </form>
  <table  width=900px;   class="list_view" style=" margin-left:280px; margin-top:15px;"> 
</table>
</body>
</html>