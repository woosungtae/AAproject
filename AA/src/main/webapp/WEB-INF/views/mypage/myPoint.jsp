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
	margin-left: auto;
	margin-right: auto;
	padding-top: 10px;
	border-top: 5px solid rgb(255, 215, 0);
}
</style>
</head>
<body>
	<h3 style="font-size:2em;width:900px; height:60px; margin-left:300px;margin-right:auto;">My 포인트</h3>
	<div class="listView">
		
	</div>
</body>
</html>