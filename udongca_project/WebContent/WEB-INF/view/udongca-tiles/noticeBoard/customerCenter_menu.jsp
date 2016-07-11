<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.nav-pills > li.active > a,
.nav-pills > li.active > a:hover,
 .nav-pills > li.active > a:focus{
	background-color:#6b4004;
}
.nav>li>a{
	font-size:15pt;
}
.nav > li > a:hover,
.nav > li > a:focus{
	font-weight:bold;
	background-color:#faebd7;
}
</style>
<div style="width:180px;">
<ul class="nav nav-pills nav-stacked">
<li class="li member"><a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc">공지사항</a></li>
<c:choose>
	<c:when test="${sessionScope.login.memberId=='udongca' }">
		<li class="li member"><a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc">1:1문의관리</a></li>
	</c:when>
	<c:when test="${!empty sessionScope.login.memberId }">
		<li class="li member"><a href="/udongca_project/oneToOneInquiry/registerOneToOneInquiryform.udc?codeType=inquiry_type">1:1문의하기</a></li>
	</c:when>
	<c:otherwise>
		<li class="li member"><a href="/udongca_project/loginPage.udc">1:1문의</a></li>
	</c:otherwise>
</c:choose>
</ul>
</div>