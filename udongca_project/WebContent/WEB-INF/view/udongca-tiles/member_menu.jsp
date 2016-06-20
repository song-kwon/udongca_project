<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${sessionScope.login.memberType == 'licensee' }">
		내 홍보글<br>
		신고내역<br>
		1:1문의<br>
		정보수정<br>
		회원탈퇴<br>
	</c:when>
	<c:otherwise>
		즐겨찾기<br>
		선호지역<br>
		내가쓴리뷰<br>
		신고내역<br>
		1:1문의<br>
		<a href="/udongca_project/member/member_modify_form.udc">정보수정</a><br>
		회원탈퇴<br>
	</c:otherwise>
</c:choose>