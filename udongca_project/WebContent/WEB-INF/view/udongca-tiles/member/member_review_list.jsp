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
	overflow:hidden;white-space:nowrap;text-overflow:ellipsis;
	text-align:left;
	margin:30px;
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<div>
	<h1>나의 리뷰 리스트</h1><br>
	<c:choose>
		<c:when test="${empty requestScope.error }">
			<table>
				<thead>
					<tr>
						<td id="no">No</td>
						<td id="title">리뷰 제목</td>
						<td id="content">리뷰 내용</td>
						<col width="30px"><col width="200px"><col width="300px">
					</tr>
				</thead>

				<tbody id="myRevieList" class="tbody">
					<c:forEach items="${requestScope.reviewList.list }"
						var="reviewList">
						<tr id="tr" onclick="reviewPageGo(${reviewList.cafeNo})">
							<td>${reviewList.myReviewNo }</td>
							<td id="td1" class="cursor">${reviewList.reviewTitle }</td>
							<td id="td2" class="cursor">${reviewList.reviewContent }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div align="center">
				<!-- 이전페이지그룹 -->
				<ul class="pagination">
				<c:choose>
					<c:when
						test="${requestScope.reviewList.pageBean.previousPageGroup }">
						<li><a
							href="/udongca_project/member/memberReviewListPaging.udc?pnum=${requestScope.reviewList.pageBean.beginPage-1 }">
							◀ </a></li>
					</c:when>
					<c:otherwise>
		<li><a href="#">◀</a></li> 	
 	</c:otherwise>
				</c:choose>
				<!-- 숫자 -->
				<c:forEach begin="${requestScope.reviewList.pageBean.beginPage }"
					end="${requestScope.reviewList.pageBean.endPage }" var="p">
					<c:choose>
						<c:when test="${p != requestScope.reviewList.pageBean.page }">
							<li><a 
								href="/udongca_project/member/memberReviewListPaging.udc?pnum=${p }">
								${p } </a></li>
						</c:when>
						<c:otherwise>
			<li class="active"><a href="#">${p }</a></li>
		</c:otherwise>
					</c:choose>
				</c:forEach>
				<!-- 다음페이지그룹 -->
				<c:choose>
					<c:when test="${requestScope.reviewList.pageBean.nextPageGroup }">
						<li><a
							href="/udongca_project/member/memberReviewListPaging.udc?pnum=${requestScope.reviewList.pageBean.endPage+1 }">
							▶ </a></li>
					</c:when>
					<c:otherwise>
		<li><a href="#">▶</a></li>
	</c:otherwise>
				</c:choose>
				</ul>
			</div>
		</c:when>
			<c:otherwise>
				<h3>
					<font style="color: red;">${requestScope.error }</font>
				</h3>
			</c:otherwise>
	</c:choose>
</div>