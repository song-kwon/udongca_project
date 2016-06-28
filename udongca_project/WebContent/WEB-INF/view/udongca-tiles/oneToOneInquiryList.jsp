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

<style type="text/css">
table{
	border-collapse: collapse;
	border-top:2px solid;
	border-bottom:2px solid;
	width:800px;
	margin:30px;
	text-align:center;
}

thead{
	text-align:center;
	width:400px;
	height:40px;
	margin:20px;
	font-size:13pt;
	font-weight:bold;
	cursor:default;
	border-bottom:1.5px solid;
}


table, tbody{
	height:30px;
	font-size:12pt;
}

tr#tr, td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<div>
	<h1>1:1 문의 내역</h1>
</div>
<table>
	<thead id="thead">
		<tr>
			<td>No</td>
			<td>유형</td>
			<td>문의 제목</td>
			<td>문의 내용</td>
			<td>작성자</td>
		</tr>
	</thead>
	<tbody id="tbody">
		<c:forEach items="${requestScope.map.oneToOneInquiryList}" var="list">
			<tr id="tr">
				<td style="width:30px;">${list.inquiryNo}</td>
				<td style="width:60px;">${list.inquiryType }</td>
				<td style="width:200px;" id="td1" class="cursor">${list.inquiryTitle }</td>
				<td style="width:300px;" id="td2" class="cursor">${list.inquiryContent }</td>
				<td style="width:60px;">${list.memberId }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div align="center">
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
				${p } </a>&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			[${p }]&nbsp;&nbsp;
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
</div>
