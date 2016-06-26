<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
<input type="hidden" value="${sessionScope.login.memberId }" id="loginId">
<c:choose>
	<c:when test="${sessionScope.login.memberType == 'licenseemember' }">
		내 홍보글<br>
		신고내역<br>
		1:1문의<br>
		<a href="/udongca_project/member/member_modify_form.udc">정보수정</a><br>
		회원탈퇴<br>
	</c:when>
	<c:otherwise>
		<div class="menuLink">
			<a id="book" href="/udongca_project/member/memberBookmarkListPaging.udc">즐겨찾기</a><br>
			<a href="/udongca_project/member/member_preferLocation_form.udc">선호지역</a><br>
			<a href="/udongca_project/member/memberReviewListPaging.udc">내가쓴리뷰</a><br>
			<a href="/udongca_project/member/memberReportListPaging.udc">신고내역</a><br>
			<a href="/udongca_project/member/memberInquiryListPaging.udc">내 1:1문의 내역</a><br>
			<a href="/udongca_project/member/member_verify.udc">정보수정</a><br>
			<a href="/udongca_project/member/member_drop.udc">회원탈퇴</a><br>
		</div>
	</c:otherwise>
</c:choose>
</div>