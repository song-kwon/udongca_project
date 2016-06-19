<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${sessionScope.id != null}">
		<div style="text-align:right;"><a href="main.udc">메인</a>|<a href="member/logout.udc">로그아웃</a></div>
	</c:when>
	
	<c:otherwise>
		<div style="text-align:right;"><a href="main.udc">메인</a>|<a href="login.udc">로그인</a></div>
	</c:otherwise>
</c:choose>
<div><a href="main.udc">헤더</a></div>