<%@ page contentType="text/html;charset=utf-8" %>
<div class="nonav_bodyDiv" style="width: 555px; height: auto;margin:0 auto;">
<div style="min-height: auto; width: 555px;">
	<form action="member/login.udc" method="post">
	<div style="float:left; width:230px;">
		<div style="width:200px; min-height:30px;"><input type="text" style="width:400px; height: 60px; font-size: 20pt" placeholder="아이디" name="id"></div>
		<div style="width:200px; min-height:30px;"><input type="password" style="width:400px; height: 60px; font-size:20pt;" placeholder="비밀번호" name="password"></div>
	</div>
	<div><button type="submit" style="width:150px; height:132px; float:right;">로그인</button></div>
	</form>
	<div style="padding-top:15px;clear: both;"><a onclick="memberId_find_form();">아이디찾기</a>/비밀번호찾기</div>
</div>

</div>