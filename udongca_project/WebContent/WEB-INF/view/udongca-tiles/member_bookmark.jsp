<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
table {
	border-collapse: collapse;
}
</style>
<div id="nav_bodyDiv" style="width: 400px;">
	<div id="bookmarkDiv">
		<div><h1>즐겨찾는 카페</h1></div>
		<br><br>
		<c:choose>
			<c:when test="${empty requestScope.error }">
				<table id="memberBookmark" style="width: 350px; text-align:center;">
					<!-- 			<thead>
				<tr>
					<td>번호</td>
					<td>카페명</td>
				</tr>
			</thead> -->
					<tbody class="tbody">
						<c:forEach items="${requestScope.bookmarkList.list }" var="list">
							<tr>
								<td style="font-size:20px;"><a href="/udongca_project/prBoard/prView.udc?cafeNo=${list.cafeNo }">${list.cafeName }</a></td>
								<td id="${list.cafeNo }"
									style="width: 100px; text-align: center;"><button
										class="deleteBookmark">즐겨찾기 해제</button></td>
							<tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 이전페이지그룹 -->
				<div style="text-align: center; margin-top: 50px;">
					<c:choose>
						<c:when
							test="${requestScope.bookmarkList.pageBean.previousPageGroup }">
							<a
								href="/udongca_project/member/memberBookmarkListPaging.udc?no=${requestScope.bookmarkList.pageBean.beginPage-1 }">
								◀ </a>
						</c:when>
						<c:otherwise>
		◀ 	
 	</c:otherwise>
					</c:choose>

					<!-- 숫자 -->
					<c:forEach begin="${requestScope.bookmarkList.pageBean.beginPage }"
						end="${requestScope.bookmarkList.pageBean.endPage }" var="p">
						<c:choose>
							<c:when test="${p != requestScope.bookmarkList.pageBean.page }">
								<a
									href="/udongca_project/member/memberBookmarkListPaging.udc?no=${p }">
									${p } </a>
							</c:when>
							<c:otherwise>
			[${p }]
		</c:otherwise>
						</c:choose>

					</c:forEach>
					<!-- 다음페이지그룹 -->
					<c:choose>
						<c:when
							test="${requestScope.bookmarkList.pageBean.nextPageGroup }">
							<a
								href="/udongca_project/member/memberBookmarkListPaging.udc?no=${requestScope.bookmarkList.pageBean.endPage+1 }">
								▶ </a>
						</c:when>
						<c:otherwise>
		▶
	</c:otherwise>
					</c:choose>
				</div>
			</c:when>
			<c:otherwise>
				<h3><font style="color : red;">${requestScope.error }</font></h3>
			</c:otherwise>
		</c:choose>
	</div>
</div>