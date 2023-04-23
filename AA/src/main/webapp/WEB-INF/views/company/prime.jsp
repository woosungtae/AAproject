<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#primediv {
    display: inline-block;
    width: 1295px;
    height: auto;
    background-color: #000;
    padding: 0px;
    text-align: center;
    margin-right: 0;
    color: #fff;
}
#prime_center {
	position: relative;
    width: 1290px;
    margin: auto;
    padding-left: -20px;
    height: 300px;
    display: block;
}
#prime_text {
	float: left;
    width: 500px;
    height: 400px;
    vertical-align: middle;
    text-align: left;
    margin-left: 70px;
}
#prime_image img{
	float: left;
    width: 700px;
    height: 400px;
}
#prime_categorylist {
    width: 1200px;
    height: 420px;
    display: inline-block;
    margin-left: 40px;
    overflow: visible;
    border-radius: 10px;
}
.prime_h2 {
    font-size: 2em;
    font-weight: bold;
    margin-top: 350px;
    margin-bottom: 0px;
}
#prime_com {
	width: 1295px;
	display: inline-block;
	margin-top: 50px;
	margin-bottom: 100px;
}
.prime_com_info {
	width: 350px;
    height: 315px;
    margin-left: 30px;
    background-color: #5F5F5F;
    border: 1px soild #5F5F5F;
    border-radius: 10px;
    display: inline-block;
}
.prime_com_info img {
	width: 330px;
    height: 200px;
    margin-top: 10px;
    border-radius: 10px;
}
.prime_com_info strong {
	float: left;
	margin: 10px;
	font-size: 1.2em;
}
.prime_com_info p {
	float: left;
	margin: 0px 10px;
	text-align: left;
}
.prime_com_step {
	width: 180px;
    height: 130px;
    margin-left: 30px;
    background-color: #5F5F5F;
    border: 1px soild #5F5F5F;
    border-radius: 10px;
    display: inline-block;
    font-size: 1.2em;
}
.prime_com_step_image {
	display: inline-block;
	margin-left: 30px;
}
.prime_com_step h3 {
	font-size: 1.1em;
	padding-top: 40px;
}
</style>
</head>
<body>
	<div id="primediv">
		<div id="prime_center">
			<div id="prime_text">
				<h3 style="margin-top:130px; font-size:2em;">Ability Assemble이 엄선한<br> 상위 2% 전문가 서비스!</h3>
				<h3 style="margin-top:30px; font-size:1em;">Prime은 거래량과 고객평가를 통해 엄선된 전문가 서비스로 보다<br> 차별화된 결과를 만들어 낼 수 있습니다.</h3>
			</div>
			<div id="prime_image">
				<img src="${contextPath}/resources/image/prime.jpg" alt="prime">
			</div>
		</div>
		<div id="prime_categorylist">
			<h3 style="margin-top:30px; margin-left: 90px; font-size:1.7em; text-align: left;">AA가 엄선한 Prime 서비스<br> </h3>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=디자인">
			<img src="${contextPath}/resources/image/design_01.png" width=100px; height=100px;><br><span style="color:#fff;">디자인</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=IT/프로그래밍">
			<img src="${contextPath}/resources/image/it_01.png" width=120px; height=100px;><br><span style="color:#fff;">IT, 프로그래밍</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=영상/사진/음향">
			<img src="${contextPath}/resources/image/picture_01.png" width=100px; height=100px;><br><span style="color:#fff;">영상, 사진, 음향</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=마케팅">
			<img src="${contextPath}/resources/image/ma2.png" width=100px; height=100px;><br><span style="color:#fff;">마케팅</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=문서/번역">
			<img src="${contextPath}/resources/image/report_01.png" width=100px; height=100px;><br><span style="color:#fff;">문서, 번역</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=경영자문/운영지원">
			<img src="${contextPath}/resources/image/ques.png" width=100px; height=100px;><br><span style="color:#fff;">경영자문, 운영지원</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=주문제작">
			<img src="${contextPath}/resources/image/gift_01.png" width=100px; height=100px;><br><span style="color:#fff;">주문제작</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=비즈니스&goods_middle_category=세무/법무/노무">
			<img src="${contextPath}/resources/image/law_01.png" width=100px; height=100px;><br><span style="color:#fff;">세무, 법무, 노무</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=N잡/커리어&goods_middle_category=취업/입시/노하우/직무역량">
			<img src="${contextPath}/resources/image/job_01.png" width=100px; height=100px;><br><span style="color:#fff;">취업, 입시, <br>노하우, 직무역량</span></a></div>
			<div class="main_category"><a href="${contextPath}/goods/goodsListByCategory.do?goods_main_category=취미/생활&goods_middle_category=취미/생활">
			<img src="${contextPath}/resources/image/hobby_01.png" width=100px; height=100px;><br><span style="color:#fff;">취미, 생활</span></a></div>
		</div>
		<div>
			<h3 style="margin-top:140px; font-size:2em;">한번의 거래도 믿고 맡길 수 있어야 하기에<br> Prime 전문가는 달라야 합니다</h3>
			<h3 style="margin-top:30px; font-size:1em;">10만 건의 AA 거래 분석과 인터뷰, 레퍼런스 체크를 통해 선별한 300여명의 전문가</h3>
		</div>
		<div id="prime_com">
			<div class="prime_com_info">
				<img src="${contextPath}/resources/image/logogo.jpg" alt="로고고디자인"><br>
				<strong>로고고디자인</strong><br>
				<p>디자인전공,미술전공,포토그래퍼  각 예술분야의 전문가들이 모여 오직 로고만을 감각있고 트렌디하게 만들어 드립니다</p>
			</div>
			<div class="prime_com_info">
				<img src="${contextPath}/resources/image/it_com.jpg" alt="MJdevteam">
				<strong>MJdevteam</strong><br>
				<p>2명의 기획자, 3명의 디자이너, 2명의 프론트 엔드, 그리고 2명의 백엔드 개발자가 한 팀이 되어 최고의 서비스를 구현해 드리겠습니다!</p>
			</div>
			<div class="prime_com_info">
				<img src="${contextPath}/resources/image/law_com.jpg" alt="첨단법률사무소">
				<strong>첨단법률사무소</strong><br>
				<p>현직 변호사가 의뢰인을 위하여 신속하고 정확하게 고소장을 작성해 드립니다.</p>
			</div>
		</div>
		<div>
			<h3 style="margin-top:140px; font-size:2em;">TOP 2% Prime 전문가 서비스는<br> 이렇게 선별됩니다</h3>
		</div>
		<div id="prime_com">
			<div class="prime_com_step">
				<h3>10만건 이상의<br> 거래내역</h3>
			</div>
			<div class="prime_com_step_image">
				<img src="${contextPath}/resources/image/right01.png" width="20" height="30" alt="prime"><br>
			</div>
			<div class="prime_com_step">
				<h3>고객 평점<br> 4.5 이상</h3>
			</div>
			<div class="prime_com_step_image">
				<img src="${contextPath}/resources/image/right01.png" width="20" height="30" alt="prime"><br>
			</div>
			<div class="prime_com_step">
				<h3 style="padding-top: 50px;">전문가 인터뷰</h3>
			</div>
			<div class="prime_com_step_image">
				<img src="${contextPath}/resources/image/right01.png" width="20" height="30" alt="prime"><br>
			</div>
			<div class="prime_com_step" style="background: rgb(245, 215, 0);">
				<h3 style="padding-top: 50px;">Prime 등록</h3>
			</div>	
		</div>
	</div>
	<div class="clear"></div>
</body>
</html>