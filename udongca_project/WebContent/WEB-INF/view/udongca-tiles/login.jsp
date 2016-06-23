<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="nonav_bodyDiv" style="width: 555px; height: auto;margin:0 auto;">
<div style="min-height: auto; width: 555px;">
	<form action="/udongca_project/member/login.udc" method="post" onsubmit="return loginCheck();">
	<div style="float:left; width:230px;">
		<div style="width:200px; min-height:30px;"><input type="text" style="width:400px; height: 60px; font-size: 20pt" placeholder="아이디" id="id" name="id"></div>
		<div style="width:200px; min-height:30px;"><input type="password" style="width:400px; height: 60px; font-size:20pt;" placeholder="비밀번호" id="password" name="password"></div>
		<c:if test="${not empty requestScope.error }"><div style="width:400px;"><font color="red">${requestScope.error }</font></div></c:if>
	</div>
	<div><button type="submit" style="width:150px; height:132px; float:right;">로그인</button></div>
	</form>
	<div style="padding-top:15px;clear: both;"><a href="" onclick="window.open('/udongca_project/memberId_find_form.udc','newWin','width=140px','height=150px');">아이디찾기</a>/<a href="" onclick="window.open('/udongca_project/memberPassword_find_form.udc','newWin','width=140px','height=150px');">비밀번호찾기</a></div>
</div>
</div>