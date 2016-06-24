<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
table, td, th{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width: 700px;
}
td,th{
	padding: 5px;
}
a{
	text-decoration: none;
}
#no{
	width:100px;
}

#title{
	width:150px;
}

#content{
	width:200px;
}
</style>
<div>
<h2>나의 리뷰 리스트</h2>
	<table border="1">
		<thead>
			<tr>
				<td id="no">번호
				<td id="title">제목
				<td id="content">내용
		</thead>
		
		<tbody id="myRevieList" class="tbody">
			<c:forEach items="${requestScope.reviewList.list }" var="reviewList">
				<tr>
					<td>${reviewList.reviewNo }
					<td>${reviewList.reviewTitle }
					<td>${reviewList.reviewContent }
			</c:forEach>
		</tbody>
	</table>
<div align="center">
<!-- 이전페이지그룹 -->
<c:choose>
 	<c:when test="${requestScope.reviewList.pageBean.previousPageGroup }">
 		<a href="/udongca_project/member/memberReviewListPaging.udc?pnum=${requestScope.reviewList.pageBean.beginPage-1 }">
 			◀
 		</a>	
 	</c:when>
 	<c:otherwise>
		◀ 	
 	</c:otherwise>
 </c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.reviewList.pageBean.beginPage }" end="${requestScope.reviewList.pageBean.endPage }"
			   var="p">
	<c:choose>
		<c:when test="${p != requestScope.reviewList.pageBean.page }">
			<a href="/udongca_project/member/memberReviewListPaging.udc?pnum=${p }">
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
	<c:when test="${requestScope.reviewList.pageBean.nextPageGroup }">
		<a href="/udongca_project/member/memberReviewListPaging.udc?pnum=${requestScope.reviewList.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>
</div>
</div>