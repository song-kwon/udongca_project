<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.major_category{
	width:120px;
}
.middle_category{
	min-width:100px;
	text-align: center;
}
</style>
<div id="nav_bodyDiv">
<div><h1>선호 지역</h1></div><br><br>
<div class="form-inline" align="left" style="font-size:18px;">
	선호지역 1 : <select class="form-control major_category" id="first_category">
		<option value="0">시/도 선택</option>
		<c:forEach items="${requestScope.category.majorList }" var="majorList" varStatus="status">
			<option value="${majorList.majorCategoryNo }"
				${requestScope.category.myLocationList[0].majorCategoryNo == majorList.majorCategoryNo ? 'selected':'' }>${majorList.addressName }</option>
		</c:forEach>
	</select>&nbsp;&nbsp; 
	<select class="form-control middle_category" name="first_category">
		<c:choose>
			<c:when test="${empty requestScope.category.myLocationList[0]}">
				<option value="0">시/도 먼저 선택</option>
			</c:when>

			<c:otherwise>
				<option value="0">군/구 선택</option>
				<c:forEach items="${requestScope.category.middleList[0] }" var="middleCategory">
					<option value="${middleCategory.middleCategoryNo }" ${requestScope.category.myLocationList[0].middleCategoryNo == middleCategory.middleCategoryNo? 'selected':''}>${middleCategory.addressName }</option>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</select>
	<p>
	<p>
		선호지역 2 : <select  class="form-control major_category" id="second_category">
			<option value="0">시/도 선택</option>
			<c:forEach items="${requestScope.category.majorList }" var="majorList">
				<option value="${majorList.majorCategoryNo }"
					${requestScope.category.myLocationList[1].majorCategoryNo == majorList.majorCategoryNo ? 'selected':'' }>${majorList.addressName }</option>
			</c:forEach>
		</select>&nbsp;&nbsp; 
		<select class="form-control middle_category" name="second_category">
			<c:choose>
				<c:when test="${empty requestScope.category.myLocationList[1]}">
					<option value="0">시/도 먼저 선택</option>
				</c:when>

				<c:otherwise>
					<c:forEach items="${requestScope.category.middleList[1] }" var="middleCategory">
						<option value="${middleCategory.middleCategoryNo }" ${requestScope.category.myLocationList[1].middleCategoryNo == middleCategory.middleCategoryNo? 'selected':''}>${middleCategory.addressName }</option>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</select>
	<p>
	<p>
		선호지역 3 : <select class="form-control major_category" id="third_category">
			<option value="0">시/도 선택</option>
			<c:forEach items="${requestScope.category.majorList }" var="majorList">
				<option value="${majorList.majorCategoryNo }"
					${requestScope.category.myLocationList[2].majorCategoryNo == majorList.majorCategoryNo ? 'selected':'' }>${majorList.addressName }</option>
			</c:forEach>
		</select>&nbsp;&nbsp; 
		<select class="form-control middle_category" name="third_category">
			<c:choose>
				<c:when test="${empty requestScope.category.myLocationList[2]}">
					<option value="0">시/도 먼저 선택</option>
				</c:when>

				<c:otherwise>
					<c:forEach items="${requestScope.category.middleList[2] }" var="middleCategory">
						<option value="${middleCategory.middleCategoryNo }" ${requestScope.category.myLocationList[2].middleCategoryNo == middleCategory.middleCategoryNo? 'selected':''}>${middleCategory.addressName }</option>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</select>
	<p>
</div><br>
<div style="margin-left:20%"><button class="btn btn-default" id="preferLocation_modiftBtn">선호지역 수정</button></div>
</div>
