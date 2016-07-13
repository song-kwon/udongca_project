<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function(){
	//major category
/* 	$.ajax({
		"url":"/udongca_project/search/selectAllMajorAddress.udc",
		"type":"GET",
		"data":"",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				$("#address1").append("<option value=" + json[i].majorCategoryNo + ">" + json[i].addressName + "</option>");
			}
			
		}
	}); */
	
	//theme category
	$.ajax({
		"url":"/udongca_project/search/selectThemeCategory.udc",
		"type":"GET",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				$("#theme").append("<option value=" + json[i].codeId + ">" + json[i].codeName + "</option>");
			
				if('${param.cafeFeature}'.length != 0){
					$("#theme").val('${param.cafeFeature}')
				}
			}
		}
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
				<div id="menu2" style="text-align:right;height:65px;"><a href="/udongca_project/main.udc" class="menu">메인&nbps;</a>|<a href="/udongca_project/member/logout.udc" class="menu">&nbsp;로그아웃&nbsp;</a>|<a href="/udongca_project/member/member_myPage.udc" class="menu">&nbsp;마이페이지&nbps;</a>|<jsp:include page="/WEB-INF/view/udongca-tiles/etc/customerCenter_header_menu.jsp"/>
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

<div style="font-size: x-large;"><a href="/udongca_project/main.udc"><img style="width:300px;height:150px;" src="/udongca_project/udongca-image/udongca_logo.jpg"></a></div>
<br>
<div class="form-inline">
	<div class="div2">
	
	<div class="col-xs-1 col-xs-offset-1">지역선택</div>
	<div class="col-xs-2">
	<select class="form-control" id="address1" style="width:auto;">
	<option value=0>시/도</option>
		<c:forEach items="${requestScope.result.majorCategory}" var="majorList" varStatus="status">
			<option value="${majorList.majorCategoryNo }"
				${param.address1 == majorList.addressName ? 'selected':'' }>${majorList.addressName }</option>
		</c:forEach>
	</select>
	</div>
	<div class="col-xs-2">
	<select class="form-control" id="address2" style="width:auto;">
	<option value=0>전체</option>
		<c:forEach items="${requestScope.result.middleCategory}" var="middleList" varStatus="status">
			<option value="${middleList.middleCategoryNo }"
				${param.address2 == middleList.addressName ? 'selected':'' }>${middleList.addressName }</option>
		</c:forEach>
	</select>
	</div>
	<div class="col-xs-1"><button id="searchAddress">검색</button></div>
	<div class="col-xs-1">테마검색</div>
	<div class="col-xs-2">
	<select class="form-control" id="theme" style="width:auto;">
	<option value=0>테마 선택</option>
	</select></div>
	<div class="col-xs-1">
	<button id="searchTheme">검색</button>
	</div>
	</div>
	<c:if test="${sessionScope.login.memberType eq 'licenseeMember' }"><div><a href="/udongca_project/prBoard_write_form.udc"><button>홍보글 등록하기</button></a></div></c:if>
	</div>
	<div>
</div>
	
</div>