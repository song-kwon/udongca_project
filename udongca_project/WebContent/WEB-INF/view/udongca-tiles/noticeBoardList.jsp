<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function() {
		$("#tbody").on("click","tr",function() {
			location.replace("/udongca_project/noticeBoard/noticeBoard.udc?noticeNo="+ $(this).find(":first").text());
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
	table-layout:fixed;
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
	overflow:hidden;white-space:nowrap;text-overflow:ellipsis; 
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<div><h1>공지 사항</h1></div>
<c:if test="${sessionScope.login.memberId=='udongca' }">
	<div align="right">
		<a href="/udongca_project/noticeBoard/noticeBoardRegisterform.udc"><input
			type="button" value="공지사항 등록"></a>
	</div>
</c:if>
<table>
	<thead id="thead">
		<tr>
			<td>No</td>
			<td>유형</td>
			<td>공지 제목</td>
			<td>공지 내용</td>
			<td>작성일자</td>
			<col width="30px"><col width="60px"><col width="200px"><col width="300px"><col width="100px">
		</tr>
	</thead>
	<tbody id="tbody">
		<c:forEach items="${requestScope.map.noticeBoardList }" var="list">
			<tr id="tr">
				<td>${list.noticeNo }</td>
				<td>${list.category }</td>
				<td id="td1" class="cursor">${list.noticeTitle }</td>
				<td id="td2" class="cursor">${list.noticeContent }</td>
				<td>${list.noticeDate }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div align="center">
<!-- 이전페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.map.pageBean.previousPageGroup }">
		<a
			href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${requestScope.map.pageBean.beginPage-1 }">
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
				href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${p }">
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
			href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${requestScope.map.pageBean.endPage+1 }">
			▶ </a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>
</div>
