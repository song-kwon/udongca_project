<%@ page contentType="text/html;charset=utf-8" %>

<div style="background-color: aqua; margin-left: 25%;"><h2>로그인</h2></div>
<div style="background-color: fuchsia; min-height:200px; width:400px; margin-left: 25%;">
	<form action="member/loginTest.udc" method="post">
	<div style="float:left; width:230px;">
		<div style="background-color: green; width:200px; min-height:30px;"><input type="text" style="width:200px; height: 30px;" placeholder="아이디" name="id"></div>
		<div style="background-color: gray; width:200px; min-height:30px;"><input type="password" style="width:200px; height: 30px;" placeholder="비밀번호" name="pwd"></div>
	</div>
	<div style="background-color: maroon;"><button type="submit" style="width:150px; float:left;">로그인</button></div>
	</form>
	<div style="background-color: teal; clear: both;">아이디찾기/비밀번호찾기</div>
</div>