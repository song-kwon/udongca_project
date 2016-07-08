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
	text-align:left;
	margin:30px;
	cursor:pointer;
	overflow:hidden;white-space:nowrap;text-overflow:ellipsis;
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<div><h1>나의 1:1 문의 내역</h1></div>
<br>
	<table id="memberInquiryList">
		<thead>
			<tr>
				<td>No</td>
				<td>문의 제목</td>
				<td>문의 내용</td>
				<td>처리 결과</td>
				<col width="50px"><col width="200px"><col width="300px"><col width="80px">
			</tr>
		</thead>
		<tbody class="tbody">
		<c:choose>
			<c:when test="${empty requestScope.error }">
			<c:forEach items="${requestScope.list }" var="list">
				<tr id="tr">
					<td>${list.inquiryNo }</td>
					<td id="td1" class="cursor"><span style="text-align:left; width:100px; text-weight:bold; color:red;">[${list.inquiryType }]</span>&nbsp;${list.inquiryTitle }</td>
					<td id="td2" class="cursor">${list.inquiryContent }</td>
					<td>${empty list.inquiryReply or list.inquiryReply==' '?'처리 중':'답변 완료' }</td>
				</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="3" align="center"><h3 style="color:red;">${requestScope.error }</td>
				</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
	<!-- 이전페이지그룹 -->
	<div align="right" style="margin:30px;">
		<a
			href="/udongca_project/oneToOneInquiry/registerOneToOneInquiryform.udc?codeType=inquiry_type"><input
			type="button" value="문의 등록"></a>
	</div>
	<div align="center">
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<a
					href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${requestScope.pageBean.beginPage-1 }">◀</a>
			</c:when>
			<c:otherwise>◀</c:otherwise>
		</c:choose>
		<!-- 숫자 -->
		<c:if test="${requestScope.pageBean.endPage == 0 }">[1]</c:if>
		<c:forEach begin="${requestScope.pageBean.beginPage }"
			end="${requestScope.pageBean.endPage }" var="p">
			<c:choose>
				<c:when test="${p != requestScope.pageBean.page }">
					<a
						href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${p }">
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
					href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${requestScope.pageBean.endPage+1 }">▶</a>
			</c:when>
			<c:otherwise>▶</c:otherwise>
		</c:choose>
	</div>