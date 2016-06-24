<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
table, td, th{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width: 700px;
}
td,th{
	padding: 5px;
}
a{
	text-decoration: none;
}
</style>
<input type="hidden" value="${requestScope.error }" id="error">
<div id="page" style="width:700px;">
<h2>나의 1:1 문의 내역</h2> 
<table id = "memberInquiryList" border="1" >
	<thead>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>처리결과</td>
		</tr>
	</thead>
	<tbody class="tbody">
	<c:forEach items="${requestScope.list }" var="list">
		<tr>
			<td>${list.inquiryNo }</td>
			<td>[${list.inquiryType}]${list.inquiryTitle }</td>
			<td>${list.inquiryReply == '' ? '처리중':'처리됨'}</td>
		<tr>
	</c:forEach>
	</tbody>
</table>
<!-- 이전페이지그룹 -->
<div style="float: right;margin-top: 5px;"><input type="button" value="문의 등록"></div>
<div style="text-align: center; margin-top: 6px;">
<c:choose>
 	<c:when test="${requestScope.pageBean.previousPageGroup }">
 		<a href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${requestScope.pageBean.beginPage-1 }">
 			◀
 		</a>	
 	</c:when>
 	<c:otherwise>
		◀ 	
 	</c:otherwise>
 </c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.pageBean.beginPage }" end="${requestScope.pageBean.endPage }"
			   var="p">
	<c:choose>
		<c:when test="${p != requestScope.pageBean.page }">
			<a href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${p }">
				${p }
			</a>
			&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			[${p }]&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>
</c:forEach>	
<!-- 다음페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.pageBean.nextPageGroup }">
		<a href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${requestScope.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>
</div>
</div>