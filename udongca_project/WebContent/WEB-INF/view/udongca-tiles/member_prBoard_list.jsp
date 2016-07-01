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
	<h1>나의 홍보글</h1>
	<c:choose>
		<c:when test="${empty requestScope.error }">
			<table id="memberReportList" border="1">
				<thead>
					<tr>
						<td>No</td>
						<td>카페명</td>
					</tr>
				</thead>
				<tbody class="tbody" id="prBoardtList">
					<c:forEach items="${requestScope.list }" var="list">
						<tr id="tr" onclick="location.href='/udongca_project/prBoard/prView.udc?cafeNo=${list.cafeNo}'">
							<td class="cursor">${list.cafeNo }</td>
							<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="cursor">${list.cafeName }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 이전페이지그룹 -->
			<div style="text-align: center; margin-top: 6px;">
				<c:choose>
					<c:when
						test="${requestScope.pageBean.previousPageGroup }">
						<a
							href="/udongca_project/member/member_prBoard_list.udc?pnum=${requestScope.pageBean.beginPage-1 }">
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
							<a
								href="/udongca_project/member/member_prBoard_list.udc?pnum=${p }">
								${p } </a>&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
			[${p }]&nbsp;&nbsp;
		</c:otherwise>
					</c:choose>
				</c:forEach>
				<!-- 다음페이지그룹 -->
				<c:choose>
					<c:when test="${requestScope.pageBean.nextPageGroup }">
						<a
							href="/udongca_project/member/member_prBoard_list.udc?pnum=${requestScope.pageBean.endPage+1 }">
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