<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
table{
	border-collapse: collapse;
	width:700px;
	margin:30px;
	text-align:left;
	font-size:18px;
}

tr#tr{
	border-bottom:1px dotted;
	height:40px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#deleteBtn").on("click",function(){
		var result = confirm("해당 게시물을 삭제하시겠습니까?");		
		if(result==true){
			location.replace("/udongca_project/noticeBoard/deleteNoticeBoard.udc?noticeNo=${requestScope.noticeBoard.noticeNo}");
		}
	});
});
</script>

<div><h1>공지 사항</h1></div>
<table border="1">
	<tr id="tr">
		<td style="width:60px; border-right:1px dotted; font-weight:bold;">[${requestScope.noticeBoard.category }]</td>
		<td style="width:200px; border-right:1px dotted; font-weight:bold;">${requestScope.noticeBoard.noticeTitle }</td>
		<td style="width:30px;">${requestScope.noticeBoard.noticeDate }</td>
	</tr>
	<tr>
		<td colspan="3" style="width:500px; height:300px;">${requestScope.noticeBoard.noticeContent }</td>
	</tr>
</table>
<div align="center">
	<c:if test="${sessionScope.login.memberId=='udongca' }">
		<a href="/udongca_project/noticeBoard/modifyNoticeBoardform.udc?noticeNo=${requestScope.noticeBoard.noticeNo}&codeType=notice_type"><input type="button" value="공지수정"></a>
		<input type="button" id="deleteBtn" value="공지삭제">
	</c:if>
	<a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc"><input type="button" value="공지목록"></a>
	<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
</div>