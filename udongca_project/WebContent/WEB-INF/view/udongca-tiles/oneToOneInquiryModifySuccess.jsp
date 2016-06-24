<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${sessionScope.login.memberId=='udongca' }">
		<div align="center"><h3>1:1문의에 대한 답변이 등록되었습니다!</h3></div>
			<div align="center">
				<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc"><input type="button" value="문의목록"></a>
				<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
			</div>
	</c:when>
	<c:otherwise>
		<c:if test="${! empty sessionScope.login.memberId }">
			<div align="center"><h3>1:1문의가 성공적으로 수정되었습니다!</h3></div>
			<div align="center">
				<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryRegisterform.udc"><input type="button" value="1:1문의하기"></a>
				<a href="/udongca_project/member/memberInquiryListPaging.udc"><input type="button" value="내 문의 내역"></a>
				<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>
