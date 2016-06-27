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
	
	$("#address1").on("change", function(){
		var es = this;
		$("#address2").empty().append("<option>군/구</option>");
		if ($(this).val() == "시/도"){
			alert("올바른 시/도를 선택하세요");
			$("#address1").focus();
			return false;
		}
		else{
			$.ajax({
				"url":"/udongca_project/search/selectMiddleAddressByMajorCategoryNo.udc",
				"type":"GET",
				"data":"majorCategoryNo=" + $(es).val(),
				"dataType":"json",
				"success":function(json){
					for(var i = 0; i < json.length; i++){
						$("#address2").append("<option value=" + json[i].middleCategoryNo + ">" + json[i].addressName + "</option>");
					}
				}
			});
		}
	});
	
	$("#searchAddress").on("click", function(){
		if ($("#address1").val() == "시/도" || $("#address2").val() == "군/구"){
			alert("올바른 지역을 선택하세요");
			($("#address1").val() == "시/도") ? $("#address1").focus() : $("#address2").focus();
			return false;
		}
		else{
			var submitString = $("#address1 option:selected").text() + " " + $("#address2 option:selected").text();
			if (submitString == "세종특별자치시 세종시"){
				submitString = "세종특별자치시";
			}
			$("#searchResult").empty();
			$.ajax({
				"url":"/udongca_project/search/locationSearchResult.udc",
				"type":"POST",
				"data":"cafeAddress=" + submitString + "&page=" + 1 + "&itemsPerPage=" + 10,
				"dataType":"json",
				"success":function(json){
					alert(json.length);
					$("#searchResult").empty();
					if (json == null || json.length == 0){
						$("#searchResult").append("검색 결과 없음");
					}
					else{
						for(var i = 0; i < json.length; i++){
							$("#searchResult").append("<img src='" + json[i].cafeFakeImage + "'>");
							$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
						}
					}
				}
			});
		}
	});
	
	
	$("#searchTheme").on("click", function(){
	
		$("#searchResult").empty();
		
		$.ajax({
			"url":"/udongca_project/search/themeSearchResult.udc",
			"type":"POST",
			"data":"cafeFeature=" + $("#theme").val() + "&page=" + 1,
			"dataType":"json",
			"success":function(json){
				
				$("#searchResult").empty();
				if (json == null || json.length == 0){
					$("#searchResult").append("검색 결과 없음");
				}
				else{
					for(var i = 0; i < json.length; i++){
						$("#searchResult").append("<img src='" + json[i].cafeFakeImage + "'>");
						$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
						alert(json[i].cafeNo);
					}
				}
 			}
		
		});
	});
	
});
</script>
<c:choose>
	<c:when test="${sessionScope.login != null}">
		<c:choose>
			<c:when test="${sessionScope.login.memberType =='master'}" >
				<div style="text-align:right;height:65px;"><a href="/udongca_project/main.udc">메인</a>|<a href="/udongca_project/member/logout.udc">로그아웃</a>|<a href="/udongca_project/master/master_page.udc">관리자페이지</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/customerCenter_header_menu.jsp"/></div>
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