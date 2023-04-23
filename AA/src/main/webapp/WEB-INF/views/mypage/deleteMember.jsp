<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<style>
.list_view{
	width: 900px;
	margin-left: 300px;
	margin-right: auto;
	padding-top: 10px;
	border-top: 5px solid rgb(255, 215, 0);
}
.reason {
	margin-top: 10px;
	margin-left: 30px;
	line-height: 2em;
}
.reason input[type=text]{
	width: 300px;
	height: 30px;
	padding: 10px;
}
.info {
	margin-top: 10px;
	margin-left: 30px;
	background: rgb(230,230,230);
}
.deleteInfo {
	margin-top: 10px;
	margin-left: 30px;
	font-size: 0.9em;
	padding: 20px 0px;
}
.reason input[type=button]:disabled{
	float: right;
	width:100px;  
   	height:40px;
   	background: rgb(230,230,230);
   	border: none;
   	border-radius: 5px;
   	font-family: 'TheJamsil';
   	color: #ccc;
   	font-size: 1.1em;
   	font-weight: bold;
   	text-align:center;
}
.reason input[type=button]{
	float: right;
	width:100px;  
   	height:40px;
   	background: rgb(230,230,230);
   	border: none;
   	border-radius: 5px;
   	font-family: 'TheJamsil';
   	color: #000;
   	font-size: 1.1em;
   	font-weight: bold;
   	text-align:center;
}
</style>
<script>
function agreeCheck(frm){
   if (frm.checkButton.disabled==true)
    frm.checkButton.disabled=false
   else
    frm.checkButton.disabled=true
}
function deletemember(_login_id){
	if(confirm("회원 정보는 30일간 저장 됩니다. 정말로 탈퇴 하시겠습니까?")){

		var formObj = document.createElement("form");
		var i_login_id = document.createElement("input");
		i_login_id.name = "login_id";
		i_login_id.value = _login_id;
		
		formObj.appendChild(i_login_id);
		document.body.appendChild(formObj);
		formObj.method="post";
		formObj.action="${contextPath}/mypage/deleteMember.do";
		formObj.submit();
		} else {
			alert("취소합니다.");
		}	
}
function deleteComMember(_login_id){
	if(confirm("회원 정보는 30일간 저장 됩니다. 정말로 탈퇴 하시겠습니까?")){

	var formObj = document.createElement("form");
	var i_login_id = document.createElement("input");
	i_login_id.name = "login_id";
	i_login_id.value = _login_id;
	
	formObj.appendChild(i_login_id);
	document.body.appendChild(formObj);
	formObj.method="post";
	formObj.action="${contextPath}/mypage/deleteComMember.do";
	formObj.submit();		
	} else {
		alert("취소합니다.");
	}
}
$(function(){
    $("input:radio[name=reason]").attr("checked", false);
    $(".non_etc").click(function(){
        $("#etc_view").css("display","none");
    });
    $("#etc").click(function(){
        $("#etc_view").css("display","block");
    });
});
</script>
</head>
<body>
	<h3 style="font-size:2em;width:900px; height:60px; margin-left:300px;margin-right:auto;">회원탈퇴</h3>
	<div class="list_View">
		<h3 style="margin-top:30px; margin-left: 30px; font-size:1.5em;">탈퇴 사유를 선택해주세요.</h3>
		<div class="reason">
			<input type="radio" class="non_etc" name="reason" value="이용하고 싶은 서비스가 없어요">&nbsp;&nbsp;이용하고 싶은 서비스가 없어요<br>
			<input type="radio" class="non_etc" name="reason" value="서비스 퀄리티가 낮아요">&nbsp;&nbsp;서비스 퀄리티가 낮아요<br>
			<input type="radio" class="non_etc" name="reason" value="비매너 회원을 만났어요">&nbsp;&nbsp;비매너 회원을 만났어요<br>
			<input type="radio" class="non_etc" name="reason" value="잦은 오류가 발생해요">&nbsp;&nbsp;잦은 오류가 발생해요<br>
			<input type="radio" class="non_etc" name="reason" value="대체할 만한 서비스를 찾았어요">&nbsp;&nbsp;대체할 만한 서비스를 찾았어요<br>
			<input type="radio" class="non_etc" name="reason" value="헤택이 적어요">&nbsp;&nbsp;헤택이 적어요<br>
			<input type="radio" id="etc" name="reason" value="기타" onchange="etc_view()">&nbsp;&nbsp;기타
			<div id="etc_view" style="display: none;">
				<input type="text" style="width: 400px;" placeholder="기타 사유를 입력해주세요">
			</div>
		</div>
		<div class="reason">
			<label for="deleteEmail"><strong>계정 확인&nbsp;&nbsp;</strong></label>
			<input type="text" placeholder="가입하신 이메일을 입력해주세요." id="deleteEmail">
		</div>
		<div class="info">
			<ul class="deleteInfo">
				<li>현재 사용중인 계정 정보는 회원 탈퇴 후 복구가 불가능합니다.</li>
				<li>진행 중인 거래건이 있거나 페널티 조치 중인 경우 탈퇴 신청이 불가합니다.</li>
				<li>탈퇴 후 회원님의 정보는 전자상거래 소비자보호법에 의거한 AA 개인정보처리방침에 따라 관리됩니다.</li>
				<li>무상으로 지급된 포인트는 탈퇴와 함께 자동 소멸됩니다. 탈퇴 후 재가입하더라도 이미 소멸되었기 때문에 양도되지 않습니다.</li>
				<li>구매후기 및 답글은 탈퇴 시 자동 삭제되지 않습니다. 탈퇴 후에는 계정 정보가 삭제되어 본인 확인이 불가하므로, <br>탈퇴 신청 전에 게시글 삭제를 요청해 주시기 바랍니다.</li>
				<li>환불 받지 못한 금액이 있을 경우, 환불 정산이 완료된 이후 탈퇴를 신청하셔야 합니다.</li>
				<li>탈퇴 완료 30일 경과 후 개인정보가 모두 삭제됩니다.</li>
			</ul>
		</div>
		<form name="form">
			<div class="reason">
				<input type="checkbox" name="agree" onClick="agreeCheck(this.form)">&nbsp;&nbsp;<strong>주의 사항을 모두 확인하였습니다.</strong>
			</div>
			<div class="reason">
				<input type="button" name="checkButton" value="회원 탈퇴" onclick="javascript:deletemember('${login_id}')" disabled>
			</div>
		</form>
	</div>
</body>
</html>