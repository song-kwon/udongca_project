<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="nonav_bodyDiv" style="width:630px;">
<div id="searchResult" style="width:630px;">
<c:choose>
			<c:when test="${empty requestScope.result.error }">
			<c:forEach items="${requestScope.result.list }" var="result">
				<div style="margin-left:10px;margin-top:20px;padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left; text-align: center;">
					<a href="/udongca_project/prBoard/prView.udc?cafeNo=${result.cafeNo }"><img style="width:200px;height:200px;" src="/udongca_project/images/${result.cafeFakeImage} ">${result.cafeName}</a>
				</div>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="3" align="center"><h3 style="color:red;">${requestScope.result.error }</h3></td>
				</tr>
			</c:otherwise>
		</c:choose>
</div>
<div id="pageNum" style="width:630px;clear:both; padding-top: 30px;" align="center">
	<c:choose>
		<c:when test="${not empty requestScope.result.error }">
		</c:when>
		<c:otherwise>
			<ul class="pagination">
			<c:choose>
				<c:when test="${requestScope.searchType =='address' }">
					<c:choose>
						<c:when test="${requestScope.result.pageBean.previousPageGroup }">
							<li><a href="#" onclick="addressPage('${requestScope.result.cafeAddress}',${requestScope.result.pageBean.beginPage-1}')">◀</a></li>
						</c:when>
						<c:otherwise><li><a>◀</a></li></c:otherwise>
					</c:choose>
					<!-- 숫자 -->
					<c:if test="${requestScope.result.pageBean.endPage == 0 }"><li>1</li></c:if>
					<c:forEach begin="${requestScope.result.pageBean.beginPage }"
						end="${requestScope.result.pageBean.endPage }" var="p">
						<c:choose>
							<c:when test="${p != requestScope.result.pageBean.page }">
								<li><a href="#" onclick="addressPage('${requestScope.result.cafeAddress}',${p })">
									${p } </a></li>
							</c:when>
							<c:otherwise>
							<li class="active"><a>${p }</a></li>
						</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- 다음페이지그룹 -->
						<c:choose>
								<c:when test="${requestScope.result.pageBean.nextPageGroup }">
									<li><a href="#" onclick="addressPage('${requestScope.result.cafeAddress}',${requestScope.result.pageBean.endPage+1})">▶</a></li>
								</c:when>
							<c:otherwise><li><a>▶</a></li></c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
					<c:choose>
						<c:when test="${requestScope.result.pageBean.previousPageGroup }">
							<li><a href="#" onclick="themePage(${requestScope.result.pageBean.beginPage-1})">◀</a></li>
						</c:when>
						<c:otherwise><li><a>◀</a></li></c:otherwise>
					</c:choose>
					<!-- 숫자 -->
					<c:if test="${requestScope.result.pageBean.endPage == 0 }"><li>1</li></c:if>
					<c:forEach begin="${requestScope.result.pageBean.beginPage }"
						end="${requestScope.result.pageBean.endPage }" var="p">
						<c:choose>
							<c:when test="${p != requestScope.result.pageBean.page }">
								<li><a href="#" onclick="themePage(${p })">
									${p } </a></li>
							</c:when>
							<c:otherwise>
							<li class="active"><a>${p }</a></li>
						</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- 다음페이지그룹 -->
						<c:choose>
								<c:when test="${requestScope.result.pageBean.nextPageGroup }">
									<li><a href="#" onclick="themePage(${requestScope.result.pageBean.endPage+1})">▶</a></li>
								</c:when>
							<c:otherwise><li><a>▶</a></li></c:otherwise>
						</c:choose>
						
					</c:otherwise>
				</c:choose>
			</ul>
		</c:otherwise>
	</c:choose>
	</div>
</div>
