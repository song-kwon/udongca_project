<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<input type="hidden" value="${requestScope.error }" id="error">
<div id="page" style="width: 700px;">
	<h1>나의 신고 내역</h1>
	<c:choose>
		<c:when test="${empty requestScope.error }">
			<table id="memberReportList" border="1">
				<thead>
					<tr>
						<td>No</td>
						<td>신고내역</td>
						<td>처리결과</td>
						<col width="30px;"><col width="300px;"><col width="60px;">
					</tr>
				</thead>
				<tbody class="tbody" id="reportList">
					<c:forEach items="${requestScope.reportList.list }" var="list">
						<tr id="tr" onclick="memberReportDetail(${list.reportboardNo})">
							<td class="cursor">${list.reportboardNo }</td>
							<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="cursor">[${list.reportType}]${list.reportReason }</td>
							<td class="cursor">${list.reportResult == '' ? '처리중':'처리됨'}</td>
						</tr>
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
								${p } </a>&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
			[${p }]&nbsp;&nbsp;
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