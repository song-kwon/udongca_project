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
	text-align:left;
	margin:50px;
	cursor:pointer;
	overflow:hidden;white-space:nowrap;text-overflow:ellipsis;
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<div><h1>공지 사항</h1></div>
<c:if test="${sessionScope.login.memberId=='udongca' }">
	<div align="right">
		<a href="/udongca_project/noticeBoard/registerNoticeBoardform.udc?codeType=notice_type"><input type="button" value="공지사항 등록"></a>
	</div>
</c:if>
<table>
	<thead id="thead">
		<tr>
			<td>No</td>
			<td>공지 제목</td>
			<td>공지 내용</td>
			<td>작성일자</td>
			<col width="30px"><col width="300px"><col width="300px"><col width="100px">
		</tr>
	</thead>
	<tbody id="tbody">
		<c:forEach items="${requestScope.map.noticeBoardList }" var="list">
			<tr id="tr">
				<td>${list.noticeNo }</td>
				<td id="td1" class="cursor" nowrap="nowrap"><span style="text-align:left; width:100px; text-weight:bold; color:red;">[${list.category }]</span>&nbsp;${list.noticeTitle }</td>
				<td id="td2" class="cursor" nowrap="nowrap">${list.noticeContent }</td>
				<td>${list.noticeDate }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div align="center">
<!-- 이전페이지그룹 -->
<ul class='pagination'>
<c:choose>
	<c:when test="${requestScope.map.pageBean.previousPageGroup }">
		<li><a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${requestScope.map.pageBean.beginPage-1 }">
			◀ </a></li>
	</c:when>
	<c:otherwise>
	<li><a>◀ </a></li>
 	</c:otherwise>
</c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.map.pageBean.beginPage }"
	end="${requestScope.map.pageBean.endPage }" var="p">
	<c:choose>
		<c:when test="${p != requestScope.map.pageBean.page }">
			<li><a
				href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${p }">
				${p } </a></li>
		</c:when>
		<c:otherwise>
			<li id='pnum' class='active'><a>${p }</a></li>
		</c:otherwise>
	</c:choose>
</c:forEach>
<!-- 다음페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.map.pageBean.nextPageGroup }">
		<li><a
			href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${requestScope.map.pageBean.endPage+1 }">
			▶ </a></li>
	</c:when>
	<c:otherwise>
		<li><a>▶</a></li>
	</c:otherwise>
</c:choose>
</ul>
</div>
