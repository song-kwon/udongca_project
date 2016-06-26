<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function() {
		$("#tbody").on("click","tr",function() {
				location.replace("/udongca_project/oneToOneInquiry/oneToOneInquiry.udc?inquiryNo="
						+ $(this).find(":first").text());
		});
});
</script>

<div>
	<h2>1:1문의</h2>
</div>
<table>
	<thead>
		<tr>
			<td>No</td>
			<td>작성자</td>
			<td>문의 유형</td>
			<td>문의 제목</td>
			<td>문의 내용</td>
		</tr>
	</thead>
	<tbody id="tbody">
		<c:forEach items="${requestScope.map.oneToOneInquiryList}" var="list">
			<tr>
				<td>${list.inquiryNo}</td>
				<td>${list.memberId }</td>
				<td>${list.inquiryType }</td>
				<td>${list.inquiryTitle }</td>
				<td>${list.inquiryContent }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 이전페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.map.pageBean.previousPageGroup }">
		<a
			href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc?pnum=${requestScope.map.pageBean.beginPage-1 }">
			◀ </a>
	</c:when>
	<c:otherwise>
		◀ 	
 	</c:otherwise>
</c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.map.pageBean.beginPage }"
	end="${requestScope.map.pageBean.endPage }" var="p">
	<c:choose>
		<c:when test="${p != requestScope.map.pageBean.page }">
			<a
				href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc?pnum=${p }">
				${p } </a>
		</c:when>
		<c:otherwise>
			[${p }]
		</c:otherwise>
	</c:choose>
</c:forEach>
<!-- 다음페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.map.pageBean.nextPageGroup }">
		<a
			href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc?pnum=${requestScope.map.pageBean.endPage+1 }">
			▶ </a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>

<form
	action="/udongca_project/oneToOneInquiry/registerOneToOneInquiry.udc"
	method="post">
	<c:if test="${sessionScope.login.memberId=='udongca' }">
		<div align="right">
			<input type="submit" value="답글달기">
		</div>
	</c:if>
</form>
