<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div><h2>1:1문의</h2></div>
<table>
	<tr>
		<td>[${requestScope.map.oneToOneInquiry.inquiryType }]&nbsp;${requestScope.map.oneToOneInquiry.inquiryTitle }</td>
	</tr>
	<tr>
		<td>${requestScope.map.oneToOneInquiry.inquiryContent }</td>
	</tr>
	<c:choose>
		<c:when test="${! empty requestScope.map.oneToOneInquiry.inquiryReply }">
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
	<c:if test="${sessionScope.login.memberId == requestScope.memberId}">
		<a href="/udongca_project/noticeBoard/modifyNoticeBoardform.udc?noticeNo=${requestScope.map.oneToOneInquiry.inquiryNo}"><input type="button" value="문의수정"></a>
	</c:if>
	<a href="/udongca_project/noticeBoard/deleteNoticeBoard.udc?noticeNo=${requestScope.map.oneToOneInquiry.inquiryNo}"><input type="button" value="문의삭제"></a>
	<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
</div>