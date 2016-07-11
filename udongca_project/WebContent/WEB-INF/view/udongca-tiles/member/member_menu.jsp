<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#dropBtn").on("click",function(){
		var result=confirm("탈퇴 후 같은 정보로는 가입이 불가능합니다. 정말로 탈퇴하시겠습니까? 확인을 누르면 탈퇴에 성공하고, 메인페이지로 이동합니다.");
		if(result==true)
			location.replace("/udongca_project/member/member_drop.udc");
	});
});
</script>

<style type="text/css">
div#dropBtn{
	color:sienna;
}
a{
	color:sienna;
}
.nav-pills > li.active > a,
.nav-pills > li.active > a:hover,
 .nav-pills > li.active > a:focus{
	background-color:#6b4004;
}
.nav>li>a{
	font-size:15pt;
}
.nav > li > a:hover,
.nav > li > a:focus{
	font-weight:bold;
	background-color:#faebd7;
}

.nav-pills > li.active > div#dropBtn,
.nav-pills > li.active > div#dropBtn:hover,
 .nav-pills > li.active > div#dropBtn:focus{
	background-color:#6b4004;
}
.nav > li > div#dropBtn:hover,
.nav > li > div#dropBtn:focus{
	color:red;
	font-weight:bold;
	background-color:#faebd7;
	cursor:pointer;
}

</style>

<div style="width:180px;">
<input type="hidden" value="${sessionScope.login.memberId }" id="loginId">
<c:choose>
	<c:when test="${sessionScope.login.memberType == 'licenseeMember' }">
		<ul class="nav nav-pills nav-stacked">
		<li class="li member"><a href="/udongca_project/member/member_prBoard_list.udc">내 홍보글</a></li>
		<li class="li member"><a href="/udongca_project/member/memberReportListPaging.udc">신고내역</a></li>
		<li class="li member"><a href="/udongca_project/member/memberInquiryListPaging.udc">1:1문의</a></li>
		<li class="li member"><a href="/udongca_project/member/member_verify.udc">정보수정</a></li>
		<li class="li member"><div id="dropBtn" style="cursor:pointer;">회원탈퇴</div></li>
		</ul>
	</c:when>
	<c:otherwise>
		<div class="menuLink">
			<ul class="nav nav-pills nav-stacked">
			<li class="li member"><a id="book" href="/udongca_project/member/member_bookmark.udc">즐겨찾기</a></li>
			<li class="li member"><a href="/udongca_project/member/member_preferLocation_form.udc">선호지역</a></li>
			<li class="li member"><a href="/udongca_project/member/memberReviewListPaging.udc">내가쓴리뷰</a></li>
			<li class="li member"><a href="/udongca_project/member/memberReportListPaging.udc">신고내역</a></li>
			<li class="li member"><a href="/udongca_project/member/memberInquiryListPaging.udc">내 1:1문의 내역</a></li>
			<li class="li member"><a href="/udongca_project/member/member_verify.udc">정보수정</a></li>
			<li class="li member"><div id="dropBtn" style="padding:12px;">회원탈퇴</div></li>
			</ul>
		</div>
	</c:otherwise>
</c:choose>
</div>