<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div><h2>1:1문의</h2></div>
<form action="/udongca_project/oneToOneInquiry/modifyOneToOneInquiryReply.udc?inquiryNo=${requestScope.oneToOneInquiry.inquiryNo}" method="post">
<table>
	<tr>
		<td>[${requestScope.oneToOneInquiry.inquiryType }]</td>
		<td>${requestScope.oneToOneInquiry.inquiryTitle }</td>
		<td>작성자 : ${requestScope.oneToOneInquiry.memberId }</td>
	</tr>
	<tr>
		<td>${requestScope.oneToOneInquiry.inquiryContent }</td>
	</tr>
	<tr>
		<td><textarea name="inquiryReply" rows="30" cols="50" placeholder="아직 답변이 달리지 않았습니다. 문의에 대한 답변을 남겨주세요..">${requestScope.oneToOneInquiry.inquiryReply }</textarea></td>
	</tr>
</table>
<div align="center">
	<input type="submit" value="답변등록">
	<a href="/udongca_project/oneToOneInquiry/deleteOneToOneInquiry.udc?inquiryNo=${requestScope.oneToOneInquiry.inquiryNo}"><input type="button" value="문의삭제"></a>
	<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc"><input type="button" value="문의목록"></a>
	<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
</div>
</form>