<%@ page contentType="text/html;charset=utf-8" %>

<style type="text/css">
table{
	border-collapse: collapse;
	width:400px;
	margin:30px;
	font-size:18px;
}

table, th{
	text-align:left;
	width:300px;
}

.width_size{
	width:180px;
}

.width_size2{
	width:80px;
}

</style>

<div class="nav_bodyDiv">
<div><h1>회원 정보 수정</h1></div>
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" readonly="readonly" style="border: thin;" value="${sessionScope.login.memberId }" id="id" class="width_size"></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" value="${sessionScope.login.memberPassword }" id="password" class="width_size"></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text"  value="${sessionScope.login.memberName }" id="name" class="width_size"></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="text" readonly="readonly" style="border: thin;" value="${sessionScope.login.memberEmail }" id="email" class="width_size"></td>
	</tr>
</table>
<div align="center" style="width:300px;">
	<input type="button" value="수정하기" id="memberModifyBtn">
</div>
</div>