<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script  type="text/javascript">
$(document).ready(function(){
		$("#tbody").on("click","tr",function(){
			location.replace("/udongca_project/noticeBoard/noticeBoard.udc?noticeNo="+$(this).find(":first").text());
		});
});

</script>

<div><h2>공지 사항</h2></div>
<c:if test="${sessionScope.login.memberId=='udongca' }">
<div align="right"><a href="/udongca_project/noticeBoard/noticeBoardRegisterform.udc"><input type="button" value="공지사항 등록"></a></div>
</c:if>
<table>
	<thead>
		<tr>
			<td>No</td>
			<td>공지 유형</td>
			<td>공지 제목</td>
			<td>공지 내용</td>
			<td>작성일자</td>
		</tr>
	</thead>
	<tbody id="tbody">
		<c:forEach items="${requestScope.map.noticeBoardList }" var="list">
		<tr>
			<td>${list.noticeNo }</td>
			<td>${list.category }</td>
			<td>${list.noticeTitle }</td>
			<td>${list.noticeContent }</td>
			<td>${list.noticeDate }</td>
		</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 이전페이지그룹 -->
<c:choose>
 	<c:when test="${requestScope.map.pageBean.previousPageGroup }">
 		<a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${requestScope.map.pageBean.beginPage-1 }">
 			◀
 		</a>	
 	</c:when>
 	<c:otherwise>
		◀ 	
 	</c:otherwise>
 </c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.map.pageBean.beginPage }" end="${requestScope.map.pageBean.endPage }" var="p">
	<c:choose>
		<c:when test="${p != requestScope.map.pageBean.page }"> 
			<a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${p }">
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
	<c:when test="${requestScope.map.pageBean.nextPageGroup }">
		<a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc?pnum=${requestScope.map.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>
