<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
<a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc">공지사항</a><br>
<c:choose>
	<c:when test="${sessionScope.login.memberId=='udongca' }">
		<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc">1:1문의관리</a>
	</c:when>
	<c:when test="${!empty sessionScope.login.memberId }">
		<a href="/udongca_project/oneToOneInquiry/registerOneToOneInquiryform.udc?codeType=inquiry_type">1:1문의하기</a>
	</c:when>
	<c:otherwise>
		<a href="/udongca_project/loginPage.udc">1:1문의</a>
	</c:otherwise>
</c:choose>
</div>