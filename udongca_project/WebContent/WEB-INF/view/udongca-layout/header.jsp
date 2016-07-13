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
.div2{
	padding:7px;
	text-align:center;
	background-color:antiquewhite;
	font-size:20px;
	color:sienna;
	width:auto;
	height:48px;
}

.col-xs-1{
	width:120px;
}
.col-xs-2{
	width:150px;
}
.col-xs-offset-1{
    margin-left: 14%;
}
div#menu1,a:hover{color:navajowhite; font-weight:bold;}
div#menu2,a:hover{color:navajowhite; font-weight:bold;}
div#menu3,a:hover{color:navajowhite; font-weight:bold;}
</style>

<div id="header_div">
<c:choose>
	<c:when test="${sessionScope.login != null}">
		<c:choose>
			<c:when test="${sessionScope.login.memberType =='master'}" >
				<div id="menu1" style="text-align:right;height:65px;"><a href="/udongca_project/main.udc" class="menu">메인&nbsp;</a>|<a href="/udongca_project/member/logout.udc" class="menu">&nbsp;로그아웃&nbsp;</a>|<a href="/udongca_project/member/master_page.udc" class="menu">&nbsp;관리자페이지&nbsp;</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/etc/customerCenter_header_menu.jsp"/>
					<div style="font-size:18px; font-weight:bold; color:antiquewhite;">
						${sessionScope.login.memberName }님! 반갑습니다.&nbsp;&nbsp;
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div id="menu2" style="text-align:right;height:65px;"><a href="/udongca_project/main.udc" class="menu">메인&nbsp;</a>|<a href="/udongca_project/member/logout.udc" class="menu">&nbsp;로그아웃&nbsp;</a>|<a href="/udongca_project/member/member_myPage.udc" class="menu">&nbsp;마이페이지&nbsp;</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/etc/customerCenter_header_menu.jsp"/>
					<div style="font-size:18px; font-weight:bold; color:antiquewhite;">
						${sessionScope.login.memberName }님! 반갑습니다.&nbsp;&nbsp;
					</div>
					<c:if test="${sessionScope.login.memberType eq 'licenseeMember' }">
						<a href="/udongca_project/prBoard_write_form.udc"><input type="button" value="홍보글 등록하기"></a>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
	</c:when>
	
	<c:otherwise>
		<div id="menu3" style="text-align:right;height:65px;"><a href="/udongca_project/main.udc" class="menu">메인&nbsp;</a>|<a href="/udongca_project/joinSelect.udc" class="menu">&nbsp;회원가입&nbsp;</a>|<a href="/udongca_project/loginPage.udc" class="menu">&nbsp;로그인&nbsp;</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/etc/customerCenter_header_menu.jsp"/></div>
	</c:otherwise>
</c:choose>

<div style="font-size: x-large;"><a href="/udongca_project/main.udc"><img style="width:300px;height:150px" src="/udongca_project/udongca-image/udongca_logo.jpg"></a></div>
<br>
<div class="form-inline">
<div class="div2">
<div class="col-xs-1 col-xs-offset-1" style="width:120px;">지역선택</div><div class="col-xs-2" style="width:150px;"><select id="address1" class="form-control"><option >시/도</option></select></div><div class="col-xs-2" style="width:150px;"><select id="address2" class="form-control"><option >시/도 먼저 선택</option></select></div><div class="col-xs-1" style="width:120px;"><button class="btn btn-default" id="main_searchAddress">검색</button></div>
<div class="col-xs-1" style="width:120px;">테마검색</div><div class="col-xs-2" style="width:150px;"><select id="theme"  class="form-control"><option >테마 선택</option></select></div><div class="col-xs-1"><button class="btn btn-default" id="main_searchTheme">검색</button></div>
</div>
</div>
</div>