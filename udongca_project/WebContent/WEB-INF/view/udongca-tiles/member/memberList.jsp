<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <script type="text/javascript">
$(document).ready(function(){
	$("#list").on("click",function(){
		var id = $("#id").text()
			$.post("/udongca_project/member/memberInfoMaster.udc",{"id" : id});
		
	});
});


</script> -->
<style type="text/css">
table, td, th {
	border: 1px solid gray;
}

table {
	border-collapse: collapse;
	width: 700px;
}

td, th {
	padding: 5px;
}
</style>
<div id="page">
	<h3>회원리스트</h3>
	<table id="table" border="1">
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>이메일</td>
			<td>페널티</td>
		</tr>
		<c:forEach items="${requestScope.list }" var="list">
			<tr id="list"
				onclick='location.href="/udongca_project/member/memberInfoMaster.udc?id=${list.memberId}&page=${requestScope.page }"'
				style="cursor: hand;">
				<td id="id">${list.memberId }</td>
				<td>${list.memberName }</td>
				<td>${list.memberEmail }</td>
				<td>${list.memberPenalty }</td>
			<tr>
		</c:forEach>
	</table>
	<!-- 이전페이지그룹 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }">
			<a
				href="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.pageBean.beginPage-1 }">
				◀ </a>
		</c:when>
		<c:otherwise>
		◀ 	
 	</c:otherwise>
	</c:choose>
	<!-- 숫자 -->
	<c:forEach begin="${requestScope.pageBean.beginPage }"
		end="${requestScope.pageBean.endPage }" var="p">
		<c:choose>
			<c:when test="${p != requestScope.pageBean.page }">
				<a href="/udongca_project/member/memberListPaging.udc?pnum=${p }">
					${p } </a>
			</c:when>
			<c:otherwise>
			[${p }]
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<!-- 다음페이지그룹 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup }">
			<a
				href="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.pageBean.endPage+1 }">
				▶ </a>
		</c:when>
		<c:otherwise>
		▶
	</c:otherwise>
	</c:choose>

</div>