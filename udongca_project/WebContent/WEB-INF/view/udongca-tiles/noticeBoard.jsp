<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div><h2>공지 사항</h2></div>
<table>
	<tr>
		<td>[${requestScope.noticeBoard.category }]&nbsp;${requestScope.noticeBoard.noticeTitle }</td>
	</tr>
	<tr>
		<td>${requestScope.noticeBoard.noticeContent }</td>
	</tr>
</table>
<div align="center">
	<c:if test="${sessionScope.login.memberId=='udongca' }">
		<a href="/udongca_project/noticeBoard/modifyNoticeBoardform.udc?noticeNo=${requestScope.noticeBoard.noticeNo}"><input type="button" value="공지수정"></a>
		<a href="/udongca_project/noticeBoard/deleteNoticeBoard.udc?noticeNo=${requestScope.noticeBoard.noticeNo}"><input type="button" value="공지삭제"></a>
	</c:if>
	<a href="/udongca_project/noticeBoard/noticeBoardList.udc"><input type="button" value="공지목록"></a>
	<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
</div>