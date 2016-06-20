<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${sessionScope.login != null}">
		<c:choose>
			<c:when test="${sessionScope.login.memberType =='master'}" >
				<div style="text-align:right;"><a href="main.udc">메인</a>|<a href="member/logout.udc">로그아웃</a>|<a href="member/myPage.udc">관리페이지</a>|<a href="member/customerCenter.udc">고객센터</a></div>
			</c:when>
			<c:otherwise>
				<div style="text-align:right;"><a href="main.udc">메인</a>|<a href="member/logout.udc">로그아웃</a>|<a href="member/myPage.udc">마이페이지</a>|<a href="member/customerCenter.udc">고객센터</a></div>
			</c:otherwise>
		</c:choose>
	</c:when>
	
	<c:otherwise>
		<div style="text-align:right;"><a href="main.udc">메인</a>|<a href="loginPage.udc">로그인</a>|<a href="member/customerCenter.udc">고객센터</a></div>
	</c:otherwise>
</c:choose>
<div><a href="main.udc">헤더</a></div>