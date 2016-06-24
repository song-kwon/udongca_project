<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="nav_bodyDiv" style="width:400px;">
	<div id="bookmarkDiv">
		<input type="hidden" value="${requestScope.error }" id="error">
		<h2>즐겨찾기</h2>
		<table id="memberBookmark" border="1" style="width:400px;">
			<thead>
				<tr>
					<td>번호</td>
					<td>카페명</td>
					<td>
				</tr>
			</thead>
			<tbody class="tbody">
				<c:forEach items="${requestScope.bookmarkList.list }" var="list">
					<tr onclick="bookmarkDelete(${list.cafeNo});">
						<td id="${list.cafeNo }">${list.no }</td>
						<td>${list.cafeName }</td>
						<td><button>버튼</button></td>
						<tr>
					
				</c:forEach>
				</tbody>
			</table>
			<!-- 이전페이지그룹 -->
			<div style="float: right; margin-top: 5px;">
				<input type="button" value="문의 등록">
			</div>
			<div style="text-align: center; margin-top: 6px;">
				<c:choose>
					<c:when test="${requestScope.bookmarkList.pageBean.previousPageGroup }">
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
								${p }
			</a> &nbsp;&nbsp;
						</c:when>
						<c:otherwise>
			[${p }]&nbsp;&nbsp;
		</c:otherwise>
					</c:choose>
				
					</c:forEach>
				<!-- 다음페이지그룹 -->
				<c:choose>
					<c:when test="${requestScope.bookmarkList.pageBean.nextPageGroup }">
						<a
						href="/udongca_project/member/memberBookmarkListPaging.udc?no=${requestScope.bookmarkList.pageBean.endPage+1 }">
							▶ </a>
					</c:when>
					<c:otherwise>
		▶
	</c:otherwise>
				</c:choose>
		</div>
	</div>
</div>