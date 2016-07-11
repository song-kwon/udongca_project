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
<div align="left">
	<table id="memberInquiryList">
		<thead>
			<tr>
				<td style="width:50px">No</td>
				<td style="width:200px">문의 제목</td>
				<td style="width:300px">문의 내용</td>
				<td style="width:80px;">처리 결과</td>
			</tr>
		</thead>
		<tbody class="tbody">
		<c:choose>
			<c:when test="${empty requestScope.error }">
			<c:forEach items="${requestScope.list }" var="list">
				<tr class="tr">
					<td id="${list.inquiryNo }">${list.myInquiryNo }</td>
					<td id="td1" class="cursor"><span style="text-align:left; width:100px; text-weight:bold; color:red;">[${list.inquiryType }]</span>&nbsp;${list.inquiryTitle }</td>
					<td id="td2" class="cursor">${list.inquiryContent }</td>
					<td>${empty list.inquiryReply or list.inquiryReply==' '?'처리 중':'답변 완료' }</td>
				</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="4" align="center"><h3 style="color:red;">${requestScope.error }</h3></td>
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
		<ul class="pagination">
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<li><a
					href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${requestScope.pageBean.beginPage-1 }">◀</a></li>
			</c:when>
			<c:otherwise><li><a href="#">◀</a></li></c:otherwise>
		</c:choose>
		<!-- 숫자 -->
		<c:if test="${requestScope.pageBean.endPage == 0 }"><li class="active"><a href="#" >1</a></li></c:if>
		<c:forEach begin="${requestScope.pageBean.beginPage }"
			end="${requestScope.pageBean.endPage }" var="p">
			<c:choose>
				<c:when test="${p != requestScope.pageBean.page }">
					<li><a 
						href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${p }">
						${p } </a></li>
				</c:when>
				<c:otherwise>
			<li class="active"><a href="#" >${p }</a></li>
		</c:otherwise>
			</c:choose>
		</c:forEach>
		<!-- 다음페이지그룹 -->
		<c:choose>
			<c:when test="${requestScope.pageBean.nextPageGroup }">
				<li><a
					href="/udongca_project/member/memberInquiryListPaging.udc?pnum=${requestScope.pageBean.endPage+1 }">▶</a></li>
			</c:when>
			<c:otherwise><li><a href="#">▶</a></li></c:otherwise>
		</c:choose>
		</ul>
	</div>
</div>
