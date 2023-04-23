<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
    
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%-- 
<c:set var="article"  value="${articleMap.article}"  />
<c:set var="imageFileList"  value="${articleMap.imageFileList}"  />

 --%>


<%
  request.setCharacterEncoding("UTF-8");
%> 
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta charset="UTF-8">
   <title>자유게시판 글 상세</title>
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
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <script type="text/javascript" >
   

     function backToList(obj){
       obj.action="${contextPath}/board/listArticles.do";
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
    
    function fn_modify_article(obj){
       obj.action="${contextPath}/board/modArticle.do";
       obj.submit();
    }
    
    function fn_remove_article(url,board_num){
          var form = document.createElement("form");
          form.setAttribute("method", "post");
          form.setAttribute("action", url);
           var board_numInput = document.createElement("input");
           board_numInput.setAttribute("type","hidden");
           board_numInput.setAttribute("name","board_num");
           board_numInput.setAttribute("value", board_num);
          
           form.appendChild(board_numInput);
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

    /*
     * 댓글 등록하기(Ajax)
     */
    function fn_comment(code){
       var cmt_content = $("#cmt_content").val();
        if(cmt_content === null || cmt_content.trim() === "") {
           alert("댓글 내용을 입력해주세요.");
        } else {
           $.ajax({
               type:'POST',
               url : "<c:url value='/board/addComment.do'/>", 
               data:$("#commentForm").serialize(),
               success : function(data){
                   if(data=="success") {
                      alert("댓글을 등록했습니다.");
                   }
                       getCommentList();
                       $("#cmt_content").val("");
               },
               error:function(request,status,error){
                   //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
               
           });
        }
    }

    /**
     * 초기 페이지 로딩시 댓글 불러오기
     */
    $(function(){
        getCommentList();
    });
     
    /**
     * 댓글 불러오기(Ajax)
     */
    function getCommentList(){
        
        $.ajax({
            type:'GET',
            url : "<c:url value='/board/commentList.do'/>", 
            dataType : "json",
            data:$("#commentForm").serialize(),
            contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
            success : function(data){
                
                var html = "";
                var cCnt = data.length;
                
                if(data.length > 0){
                    for(i=0; i<data.length; i++){
                        html += "<div>";
                        html += "<div class='cmt'><table id='memId'><h2 style='margin-bottom: 10px;'><strong>"+ data[i].id + "<span class='cmt_date'>" + data[i].cmt_date + "</span>" + "</strong></h2>";
                        html += data[i].cmt_content  + "<tr><td></td></tr>";
                        html += "</table></div>";
                        html += "</div>";
                    }
                } else {
                    html += "<div>"; 
                    html += "<div class='nonono'><table><h6  style='padding-right:140px;'><strong>등록된 댓글이 없습니다.</strong></h6>";
                    html += "</table></div>";
                    html += "</div>";
                }
                
                $("#cCnt").html(cCnt);
                $("#commentList").html(html); 
                
            },
            error:function(request,status,error){
                
           }
            
        });
    }
     
    </script>

 
</head> 
<body>
<h3 style="font-size:2em;width:1000px; height:57px; margin-left:300px; margin-right:auto;">자유게시판</h3>
<table  width=1000px;   class="list_view" style=" margin-left:280px;">
</table> 
  <form name="frmArticle" method="post"  action="${contextPath}"  enctype="multipart/form-data" class="one_form">
  <table  border=0  align="center">
      
  <tr>
   <td  colspan="2" align="left" style="padding-left:50px;"> 
    <input type=text value="${article.board_title }"  name="board_title"  id="i_title" style=" width:460px; height:49; font-size:1.2em; font-family:'TheJamsil'; "disabled />
   </td> 
      <td><input type="text" style="width:170; height:20; text-align:center;" value="${article.writeDate}" disabled/>
   </td>    
  </tr>  
   <tr>
   <td colspan="3" style="height:0.3; border-top:0.5px solid rgb(245, 215, 0);"></td>
   </tr>
      <tr>  
   <td style="width:30px;"></td>
   <td style=" padding-left:50px; text-align:left; width:460; height:20; padding:15px;font-size:0.7em;">
      ${article.id}(${article.status})
   </td>
   
   <td style="text-align:center; width:170; height:20; padding:15px;font-size:0.7em;">
      조회수:${article.viewCnt}&nbsp;&nbsp; 댓글수:<span id="cCnt"></span>
   </td> 
  </tr>
  
   
  <c:choose> 
     <c:when test="${not empty article.imageFileName && article.imageFileName!='null' }">
         <tr> 
         <td style="text-align:center; width:660;  max-width:660px; height:500; border-top:0.5px solid rgb(245, 215, 0);" colspan="3">
           <input  type= "hidden"   name="originalFileName" value="${article.imageFileName }" />
          <img src="${contextPath}/download1.do?board_num=${article.board_num}&imageFileName=${article.imageFileName}" id="preview"  /><br>
         </td>   
        </tr>   
           <td colspan="3" style="text-align:left; width:660px; height:auto; max-width:660px; padding:10px; padding-left:50px; word-break:break-all;">
              ${article.board_content }
             </td>   
       </c:when>          
       <c:otherwise>
          <td colspan="3" style="text-align:left; max-height:1000px; width:660px; max-width:660px; height:200px; padding:10px; padding-left:50px; padding-right:50px; word-break:break-all; border-top:0.5px solid rgb(245, 215, 0);">
              ${article.board_content }
             </td>
       </c:otherwise> 
    </c:choose>
 <%-- 
 <c:if test="${not empty imageFileList && imageFileList!='null' }">
     <c:forEach var="item" items="${imageFileList}" varStatus="status" >
          <tr>
             <td width="150" align="center" bgcolor="#FF9933"  rowspan="2">
               이미지${status.count }
            </td>
            <td>
              <input  type= "hidden"   name="originalFileName" value="${item.imageFileName }" />
             <img src="${contextPath}/download.do?board_num=${article.board_num}&imageFileName=${item.imageFileName}" id="preview"  /><br>
            </td>   
           </tr>  
           <tr>
             <td>
                <input  type="file"  name="imageFileName " id="i_imageFileName"   disabled   onchange="readURL(this);"   />
             </td>
          </tr>
      </c:forEach>
 </c:if>
     --%>   
     
 <%--  추천 버튼 --%>
<%--  <tr> 
       <td colspan="3">
         <c:choose> 
            <c:when test="${isLogOn == true and not empty memberInfo  || isLogOn == true and not empty companyInfo }">
              <button style="margin-left:345px;" id="recoButton" onclick="updateReco()"><img width="50px" height="50px" alt="추천하기"  src="${contextPath}/resources/image/roco.jpg"></button>
            
            <c:otherwise>
            <td>추천기능은 로그인후 사용 가능합니다.</td>
            </c:otherwise>
            </c:when> 
        </c:choose>
      </td>
      </tr>
--%>


  <tr   id="tr_btn_modify"  align="center"  >
      <td colspan="3"   >
          <input type=button value="수정반영하기"   onClick="fn_modify_article(frmArticle)"  >
           <input type=button value="취소"  onClick="backToList(frmArticle)">
      </td>   
  </tr>
    
  <tr  id="tr_btn">
   <td colspan="3" align="center" style="padding-top:20px; border-top:0.5px solid rgb(245, 215, 0);">
       <c:if test="${memberInfo.id == article.id || companyInfo.id == article.id }">
         <input type=button value="수정하기" class="listback_btn" onClick="fn_enable(this.form)">
         <input type=button value="삭제하기" class="listback_btn" onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.board_num})">
       </c:if>
       <input type=button value="리스트로 돌아가기" class="listback_btn" onClick="backToList(this.form)">
   </td> 
  </tr>
 </table> 
 </form>  
 <!-- 댓글 -->    
<div class="board_coment">  
    <form id="commentForm" name="commentForm" method="post" style="margin-left:270px;">
    <br><br>
        <div>
            <div style="margin-bottom: 10px;">
                <span><strong>댓글</strong></span><span id="cCnt"></span>
            </div>
            <div>
                <table class="table">                    
                    <tr>
                        <td>
                            <textarea style="width: 750px; height: 80px;" rows="5" cols="10" id="cmt_content" name="cmt_content" placeholder="댓글을 입력하세요"></textarea>
                            <a href='#' onClick="fn_comment('${article.board_num }')"><input type="button" value="등록" class="cmt_btn"></a>
                        </td>
                    </tr>
                </table>
            </div>
        </div> 
        <input type="hidden" id="board_num" name="board_num" value="${article.board_num }" />        
    </form> 
    <form id="commentListForm" name="commentListForm" method="post" style="margin-left:270px;">
        <div id="commentList" >
        </div>
    </form>
</div>
</body>
</html>