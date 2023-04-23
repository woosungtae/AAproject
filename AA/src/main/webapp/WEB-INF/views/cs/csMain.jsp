<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<%
    session.removeAttribute("side_menu");
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.list_view{
	width: 900px;
    margin-left: 300px;
    margin-right: auto;
    padding-top: 10px;
    border-top: 5px solid rgb(255, 215, 0);
}
#cs_qus {
	margin-left: 30px;
	display: inline-block;
}
.cs_qus_jaju {
    display: inline-block;
}
.cs_qus_jaju button{
	font-size: 1.1em;
	text-align: center;
	width: 150px;
    height: 40px;
    margin-left: 10px;
    background-color: rgb(255, 215, 0);
    border: none;
    border-radius: 5px;
    display: inline-block;
	color:white;
	font-family: 'TheJamsil';
}
.cs_qus_agree {
	width: 400px;
    height: 200px;
    margin-top: 10px;
    border-radius: 10px;
    display: inline-block;
}
.cs_qus_ul {
	margin-top: 30px;
	margin-left: 50px;
	line-height: 2em;
}
#cus_button {
	float: right;
	width:150px;  
   	height:40px;
   	background-color: rgb(255, 215, 0);
   	border: 1px solid rgb(255, 215, 0);
   	border-radius: 5px;
   	font-family: 'TheJamsil';
   	font-size: 1.1em;
   	font-weight: bold;
   	color: #fff;
   	font-weight: bold;
   	text-align:center;
   	margin-top: 100px;
}
.cs_modal_content p {
	margin-top: 20px;
}
</style>
<script>
	window.addEventListener("DOMContentLoaded", function() {
		document.getElementById("modal_open_btn").onclick = function() {
		    document.getElementById("cs_modal").style.display = "block";
		}
		
		document.getElementById("modal_close_btn").onclick = function() {
		    document.getElementById("cs_modal").style.display = "none";
		}
	});
	
	window.addEventListener("DOMContentLoaded", function() {
		document.getElementById("modal_open_btn2").onclick = function() {
		    document.getElementById("cs_modal2").style.display = "block";
		}
		
		document.getElementById("modal_close_btn2").onclick = function() {
		    document.getElementById("cs_modal2").style.display = "none";
		}
	});
	
	window.addEventListener("DOMContentLoaded", function() {
		document.getElementById("modal_open_btn3").onclick = function() {
		    document.getElementById("cs_modal3").style.display = "block";
		}
		
		document.getElementById("modal_close_btn3").onclick = function() {
		    document.getElementById("cs_modal3").style.display = "none";
		}
	});
	
	window.addEventListener("DOMContentLoaded", function() {
		document.getElementById("modal_open_btn4").onclick = function() {
		    document.getElementById("cs_modal4").style.display = "block";
		}
		
		document.getElementById("modal_close_btn4").onclick = function() {
		    document.getElementById("cs_modal4").style.display = "none";
		}
	});
	
	window.addEventListener("DOMContentLoaded", function() {
		document.getElementById("modal_open_btn5").onclick = function() {
		    document.getElementById("cs_modal5").style.display = "block";
		}
		
		document.getElementById("modal_close_btn5").onclick = function() {
		    document.getElementById("cs_modal5").style.display = "none";
		}
	});
</script>
<script>
	function fn_itemForm(isLogOn,itemForm,loginForm){
	  if(isLogOn != '' && isLogOn != 'false'){
	    location.href=itemForm;
	  }else{
	    alert("로그인 후 글쓰기가 가능합니다.")
	    location.href=loginForm+'?action=/cs/csItemForm.do';
	  }
	}
</script> 
</head>
<body>
	<h3 style="font-size:2em;width:900px; height:60px; margin-left:300px;margin-right:auto;">고객센터</h3>
	<div class="list_view">
		<h3 style="margin-top:30px; margin-left: 30px; font-size:1.5em; margin-bottom: 15px;">자주 묻는 질문</h3>
		<div id="cs_qus">
			<div id="root" class="cs_qus_jaju">
				<button type="button" id="modal_open_btn">주문안내</button>
			</div>
			<div id="cs_modal">
				<div class="cs_modal_content">
					<h3>주문안내</h3>
					<p>주문은 상품 상세페이지에서 가능합니다.</p>
					<button type="button" id="modal_close_btn">닫기</button>
				</div>
				<div class="cs_modal_layer"></div>
			</div>
			<div id="root2" class="cs_qus_jaju">
				<button type="button" id="modal_open_btn2">결제안내</button>
			</div>
			<div id="cs_modal2">
				<div class="cs_modal_content">
					<h3>결제안내</h3>
					<p>결제는 상품 수령 후 전문가에게 결제대금이 전달됩니다.</p>
					<button type="button" id="modal_close_btn2">닫기</button>
				</div>
				<div class="cs_modal_layer"></div>
			</div>
			<div id="root3" class="cs_qus_jaju">
				<button type="button" id="modal_open_btn3">취소/환불안내</button>
			</div>
			<div id="cs_modal3">
				<div class="cs_modal_content">
					<h3>취소/환불안내</h3>
					<p>취소/환불 기준은 전문가마다 상이하니 구매전 확인 부탁드립니다.</p>
					<button type="button" id="modal_close_btn3">닫기</button>
				</div>
				<div class="cs_modal_layer"></div>
			</div>
			<div id="root4" class="cs_qus_jaju">
				<button type="button" id="modal_open_btn4">포인트</button>
			</div>
			<div id="cs_modal4">
				<div class="cs_modal_content">
					<h3>포인트</h3>
					<p>포인트는 구매건당 구매금액의 10%가 포인트로 지급됩니다.</p>
					<button type="button" id="modal_close_btn4">닫기</button>
				</div>
				<div class="cs_modal_layer"></div>
			</div>
			<div id="root5" class="cs_qus_jaju">
				<button type="button" id="modal_open_btn5">사업체 등록</button>
			</div>
			<div id="cs_modal5">
				<div class="cs_modal_content">
					<h3>사업체 등록</h3>
					<p>개인 회원이 사업체 등록을 원하시면 이메일 중복이 되지 않으니 회원가입시 사업체로 회원가입을 하셔서 같은 이메일을 사용하시면됩니다.</p>
					<button type="button" id="modal_close_btn5">닫기</button>
				</div>
				<div class="cs_modal_layer"></div>
			</div>
		</div>
		<div id="cs_qus">
			<div class="cs_qus_agree">
			<h3 style="margin-top:30px; font-size:1.5em;">이용 약관</h3>
				<ul class="cs_qus_ul">
					<li>AA 이용약관 개정 안내</li>
					<li>AA 사이트 이용약관 상세</li>
				</ul>
			</div>
			<div class="cs_qus_agree">
			<h3 style="margin-top:30px; font-size:1.5em;">1:1 문의</h3>
			<a href="#" style="float:right; font-size:0.9em; color: #5F5F5F;">더보기</a>
				<ul class="cs_qus_ul">
					<li>배송문의</li>
					<li>환불문의</li>
				</ul>
			</div>
			<div class="cs_qus_agree">
			<h3 style="margin-top:30px; font-size:1.5em;">개인정보처리방침</h3>
				<ul class="cs_qus_ul">
					<li>개인정보처리방침 개정 안내</li>
					<li>개인정보처리방침 상세</li>
				</ul>
			</div>
			<div class="cs_qus_agree">
				<a href="javascript:fn_itemForm('${isLogOn}','${contextPath}/cs/csItemForm.do', 
                                                   '${contextPath}/member/loginForm.do')"><input type="button" value="문의하기" id="cus_button"></a>
			</div>
		</div>
	</div>
</body>
</html>