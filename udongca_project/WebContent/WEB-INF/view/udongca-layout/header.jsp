<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${sessionScope.login != null}">
		<c:choose>
			<c:when test="${sessionScope.login.memberType =='master'}" >
				<div style="text-align:right;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/member/logout.udc">로그아웃</a>|<a href="/udongca_project/member/master_page.udc">관리페이지</a>|<a href="/udongca_project/member/customerCenter.udc">고객센터</a></div>
			</c:when>
			<c:otherwise>
				<div style="text-align:right;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/member/logout.udc">로그아웃</a>|<a href="/udongca_project/member/member_myPage.udc">마이페이지</a>|<a href="/udongca_project/member/customerCenter.udc">고객센터</a></div>
			</c:otherwise>
		</c:choose>
	</c:when>
	
	<c:otherwise>
		<div style="text-align:right;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/memberJoin.udc">회원가입</a>|<a href="/udongca_project/loginPage.udc">로그인</a>|<a href="/udongca_project/member/customerCenter.udc">고객센터</a></div>
	</c:otherwise>
</c:choose>
<div><a href="/udongca_project/main.udc">헤더</a></div>