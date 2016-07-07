<%@ page contentType="text/html;charset=utf-8"%>
<style type="text/css">
table{
	border-collapse: collapse;
	width:400px;
	margin:30px;
}

table, th{
	text-align:left;
	width:250px;
}
</style>

<div><h1>회원 가입 완료</h1></div>
<table>
	<tr>
		<th>아이디</th>
		<td>${requestScope.member.memberId }</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${requestScope.member.memberName }</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${requestScope.member.memberEmail }</td>
	</tr>
</table>

<div>
	성공적으로 가입되었습니다!<br>등록된 이메일로 인증 메일이 발송됐습니다.<br>인증 메일로 인증 절차를 거쳐야 로그인이 가능합니다.
</div>
<div align="center" style="margin:20px; width:300px;">
	<a href="/udongca_project/main.udc"><input type="button" id="main" value="메인페이지"></a>
</div>
