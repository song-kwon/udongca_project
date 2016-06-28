<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header_div">
<script type="text/javascript">
$(document).ready(function(){
	//major category
	$.ajax({
		"url":"/udongca_project/search/selectAllMajorAddress.udc",
		"type":"GET",
		"data":"",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				$("#address1").append("<option value=" + json[i].majorCategoryNo + ">" + json[i].addressName + "</option>");
			}
		}
	});
	
	//theme category
	$.ajax({
		"url":"/udongca_project/search/selectThemeCategory.udc",
		"type":"GET",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				$("#theme").append("<option value=" + json[i].codeId + ">" + json[i].codeName + "</option>");
			}
		}
	});
});
</script>
<c:choose>
	<c:when test="${sessionScope.login != null}">
		<c:choose>
			<c:when test="${sessionScope.login.memberType =='master'}" >
				<div style="text-align:right;height:65px;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/member/logout.udc">로그아웃</a>|<a href="/udongca_project/member/master_page.udc">관리자페이지</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/customerCenter_header_menu.jsp"/></div>
			</c:when>
			<c:otherwise>
				<div style="text-align:right;height:65px;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/member/logout.udc">로그아웃</a>|<a href="/udongca_project/member/member_myPage.udc">마이페이지</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/customerCenter_header_menu.jsp"/></div>
			</c:otherwise>
		</c:choose>
	</c:when>
	
	<c:otherwise>
		<div style="text-align:right;height:65px;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/joinSelect.udc">회원가입</a>|<a href="/udongca_project/loginPage.udc">로그인</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/customerCenter_header_menu.jsp"/></div>
	</c:otherwise>
</c:choose>

<div style="font-size: x-large;"><a href="/udongca_project/main.udc">우 동 카</a></div>
<br>
<div>지역선택&nbsp;<select id="address1"><option value=0>시/도</option></select>&nbsp;<select id="address2"><option value=0>시/도 먼저 선택</option></select>&nbsp;<button id="searchAddress">검색</button>&nbsp;&nbsp;테마검색&nbsp;<select id="theme"><option value=0>테마 선택</option></select>&nbsp;<button id="searchTheme">검색</button></div>
</div>