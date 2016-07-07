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
	width:300px;
}

</style>

<div class="nav_bodyDiv">
<div><h1>내 정보</h1></div>
<table>
	<tr>
		<th>아이디</th>
		<td>${sessionScope.login.memberId }</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${sessionScope.login.memberName }</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${sessionScope.login.memberEmail }</td>
	</tr>
</table>
	<div align="center">
		<a href="/udongca_project/member/member_modify_form.udc"><button>정보수정</button></a>
	</div>
</div>