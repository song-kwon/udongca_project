<%@ page contentType="text/html;charset=utf-8" %>
<style type="text/css">
table{
	border-collapse: collapse;
	width:400px;
	margin:40px;
	font-size:18px;
}

table, th{
	text-align:left;
	width:300px;
}
</style>

<div class="nav_bodyDiv">
<div><h1>회원 정보 수정</h1></div>
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" style="background-color: white; border: thin;" value="${sessionScope.login.memberId}" readonly="readonly" id="id"></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" id="password"></td>
</table>
<div align="center"><button id="verify">확인</button></div>
</div>
