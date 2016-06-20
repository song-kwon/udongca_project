<%@ page contentType="text/html;charset=utf-8"%>

<div style="background-color: aqua; margin-left: 25%;"><h2>회원 가입 완료</h2></div>
<table>
	<tr>
		<th>아이디</th>
		<td>${reqeustScope.generalMember.id }</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${requestScope.generalMember.name }</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${reqeustScope.generalMember.email }</td>
	</tr>
	<tr align="center">
		<td>성공적으로 가입되었습니다.<br>등록된 이메일로 인증 메일이 발송됐습니다.<br>인증 메일로 인증 절차를 거쳐야 로그인이 가능합니다.
	</td>
	<tr align="center">
		<td><a href="main.udc"><input type="button" id="main" value="메인페이지"></a></td>
	</tr>
</table>
