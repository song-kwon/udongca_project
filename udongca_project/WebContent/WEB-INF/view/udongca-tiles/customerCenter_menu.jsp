<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
<a href="/udongca_project/noticeBoard/noticeBoardList.udc">공지사항</a><br>
<c:choose>
	<c:when test="${sessionScope.login.memberId=='udongca' }">
		<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryList.udc">1:1 문의</a><br>
	</c:when>
	<c:otherwise>
		<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryRegisterform.udc">1:1 문의</a><br>
	</c:otherwise>
</c:choose>
</div>