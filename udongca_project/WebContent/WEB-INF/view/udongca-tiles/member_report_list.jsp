<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

a {
	text-decoration: none;
}
</style>
<input type="hidden" value="${requestScope.error }" id="error">
<div id="page" style="width: 700px;">
	<h2>나의 신고 내역</h2>
	<c:choose>
		<c:when test="${empty requestScope.error }">
			<table id="memberReportList" border="1">
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>처리결과</td>
					</tr>
				</thead>
				<tbody class="tbody" id="reportList">
					<c:forEach items="${requestScope.reportList.list }" var="list">
						<tr onclick="memberReportDetail(${list.reportboardNo})">
							<td>${list.reportboardNo }</td>
							<td>[${list.reportType}]${list.reportReason }</td>
							<td>${list.reportResult == '' ? '처리중':'처리됨'}</td>
						<tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 이전페이지그룹 -->
			<div style="text-align: center; margin-top: 6px;">
				<c:choose>
					<c:when
						test="${requestScope.reportList.pageBean.previousPageGroup }">
						<a
							href="/udongca_project/member/memberReportListPaging.udc?pnum=${requestScope.reportList.pageBean.beginPage-1 }">
							◀ </a>
					</c:when>
					<c:otherwise>
		◀ 	
 	</c:otherwise>
				</c:choose>
				<!-- 숫자 -->
				<c:forEach begin="${requestScope.reportList.pageBean.beginPage }"
					end="${requestScope.reportList.pageBean.endPage }" var="p">
					<c:choose>
						<c:when test="${p != requestScope.reportList.pageBean.page }">
							<a
								href="/udongca_project/member/memberReportListPaging.udc?pnum=${p }">
								${p } </a>
						</c:when>
						<c:otherwise>
			[${p }]
		</c:otherwise>
					</c:choose>
				</c:forEach>
				<!-- 다음페이지그룹 -->
				<c:choose>
					<c:when test="${requestScope.reportList.pageBean.nextPageGroup }">
						<a
							href="/udongca_project/member/memberReportListPaging.udc?pnum=${requestScope.reportList.pageBean.endPage+1 }">
							▶ </a>
					</c:when>
					<c:otherwise>
		▶
	</c:otherwise>
				</c:choose>
			</div>
		</c:when>
		<c:otherwise>
			<h3>
				<font style="color: red;">${requestScope.error }</font>
			</h3>
		</c:otherwise>
	</c:choose>
</div>
<div></div>