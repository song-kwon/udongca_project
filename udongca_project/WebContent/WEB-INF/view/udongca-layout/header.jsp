<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	$('#main_searchAddress').on('click',function(){
		if ($("#address1").val() == "시/도" || $("#address2").val() == "군/구"){
			alert("올바른 지역을 선택하세요");
			return false;
		}
		location.href='/udongca_project/search/address_search_result.udc?address1='+$("#address1 option:selected").text()+'&address2='+$("#address2 option:selected").text();
	});
	
	$('#main_searchTheme').on('click',function(){
		if($('#theme').val() == '테마 선택'){
			alert('테마를 선택해주세요.')
			return false;
		}
		
		location.href='/udongca_project/search/theme_search_result.udc?cafeFeature='+$("#theme option:selected").val();
	});
});
</script>

<style type="text/css">
.div{
	padding:7px;
	text-align:center;
	background-color:antiquewhite;
	font-size:20px;
	color:sienna;
	width:auto;
	height:48px;
}

</style>

<div id="header_div">
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
<div class="form-inline">
<div class="div">지역선택&nbsp;&nbsp;<select id="address1" class="form-control"><option >시/도</option></select>&nbsp;<select id="address2" class="form-control"><option >시/도 먼저 선택</option></select>&nbsp;<button class="btn btn-default" id="main_searchAddress">검색</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;테마검색&nbsp;&nbsp;<select id="theme" class="form-control"><option >테마 선택</option></select>&nbsp;<button class="btn btn-default" id="main_searchTheme">검색</button></div>
</div>
<c:if test="${sessionScope.login.memberType eq 'licenseeMember' }"><div><a href="/udongca_project/prBoard_write_form.udc"><button>홍보글 등록하기</button></a></div></c:if>
</div>