<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.nav-pills > li.active > a,
.nav-pills > li.active > a:hover,
 .nav-pills > li.active > a:focus{
	background-color:#6b4004;
}
.nav>li>a{
	font-weight: bold;
	font-size:12pt;
}
.nav > li > a:hover,
.nav > li > a:focus{
	background-color:#faebd7;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	if("${param.nav}"=='member'){
		$(".member").addClass("active");
	}
	if("${param.nav}"=='master'){
		$(".master").addClass("active");
	}
	if("${param.nav}"=='oneToOneInquiry'){
		$(".oneToOneInquiry").addClass("active");
	}
});
	


</script>
<div style="width:180px;">
<ul class="nav nav-pills nav-stacked">
	<li class="li member"><a href="/udongca_project/member/memberListPaging.udc?nav=member">회원정보관리</a></li>
	<li class="li master"><a href="/udongca_project/master/reportBoard.udc?reportType=all&nav=master">신고내역</a></li>
	<li class="li oneToOneInquiry"><a href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?nav=oneToOneInquiry">1:1문의관리</a></li>
</ul>
</div>