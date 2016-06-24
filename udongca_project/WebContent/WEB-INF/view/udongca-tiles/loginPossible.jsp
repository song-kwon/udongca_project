<%@ page contentType="text/html;charset=utf-8"%>
<div><h2>이메일 인증 완료</h2></div>
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
	이메일 인증에 성공했습니다.<br>로그인 후 회원 서비스가 이용 가능합니다.<br>
</div>
<div>
	<a href="/udongca_project/loginPage.udc"><input type="button" id="login" value="로그인"></a>
</div>