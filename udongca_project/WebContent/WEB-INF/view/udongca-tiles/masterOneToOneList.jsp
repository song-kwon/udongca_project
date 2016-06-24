<%@ page contentType = "text/html;charset=utf-8"%>
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
</style>
<div id="page">
<h3>1:1문의관리</h3> 
<table id = "table" border="1" >
	<tr>
		<td>NO</td>
		<td>제목</td>
		<td>문의유형</td>
		<td>id</td>
	</tr>
	<c:forEach items="${requestScope.list }" var="list">
	<tr onclick='location.href="/udongca_project/oneToOneInquiry/master/oneInfo.udc?page=${requestScope.pageBean.page}&inquiryNo=${list.inquiryNo }"'>
		<td>${list.inquiryNo }</td>
		<td>${list.inquiryTitle }</td>
		<td>${list.inquiryType }</td>
		<td>${list.memberId }</td>
		
	<tr>
	</c:forEach>
</table>
<!-- 이전페이지그룹 -->
<c:choose>
 	<c:when test="${requestScope.pageBean.previousPageGroup }">
 		<a href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?page=${requestScope.pageBean.beginPage-1 }">
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
			<a href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?page=${p }">
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
		<a href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?page=${requestScope.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>

</div>