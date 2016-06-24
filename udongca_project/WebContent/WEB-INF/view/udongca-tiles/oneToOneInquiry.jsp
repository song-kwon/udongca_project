<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div><h2>1:1문의</h2></div>
<table>
	<tr>
		<td>[${requestScope.map.oneToOneInquiry.inquiryType }]</td>
		<td>${requestScope.map.oneToOneInquiry.inquiryTitle }</td>
		<td>작성자 : ${requestScope.map.oneToOneInquiry.memberId }</td>
	</tr>
	<tr>
		<td>${requestScope.map.oneToOneInquiry.inquiryContent }</td>
	</tr>
	<c:choose>
		<c:when test="${! empty requestScope.map.oneToOneInquiry.inquiryReply and requestScope.map.oneToOneInquiry.inquiryReply!=' '}">
			<tr>
				<td>${requestScope.map.oneToOneInquiry.inquiryReply }</td>
			</tr>
		</c:when>
		
		<c:otherwise>
			<tr>
				<td>아직 답변이 달리지 않았습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<div align="center">
	<c:if test="${sessionScope.login.memberId == requestScope.map.oneToOneInquiry.memberId}">
		<a href="/udongca_project/oneToOneInquiry/modifyOneToOneInquiryform.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo}"><input type="button" value="문의수정"></a>
		<a href="/udongca_project/oneToOneInquiry/deleteOneToOneInquiry.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo}"><input type="button" value="문의삭제"></a>
	</c:if>
	<c:if test="${sessionScope.login.memberId == 'udongca' }">
		<a href="/udongca_project/oneToOneInquiry/modifyOneToOneInquiryReplyform.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo }"><input type="button" value="답변등록"></a>
		<a href="/udongca_project/oneToOneInquiry/deleteOneToOneInquiry.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo}"><input type="button" value="문의삭제"></a>
		<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc"><input type="button" value="문의목록"></a>
	</c:if>
	<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
</div>