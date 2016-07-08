<%@ page contentType="text/html;charset=utf-8" %>
<style type="text/css">
table{
	border-collapse: collapse;
	width:500px;
	margin:40px;
	font-size:18px;
}

table, th{
	text-align:left;
	width:250px;
}
</style>

<div class="nav_bodyDiv">
<div><h1>회원 정보 수정</h1></div>
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" style="background-color: white; border: thin; width:150px;" value="${sessionScope.login.memberId}" readonly="readonly" id="id"></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" id="password"></td>
	<tr>
		<td colspan="2" align="center"><button id="verify" class="btn btn-default" style="margin-top:6px;">확인</button>
</table>
</div>
