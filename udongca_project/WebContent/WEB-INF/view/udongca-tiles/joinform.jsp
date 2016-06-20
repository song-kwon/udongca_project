<%@ page contentType="text/html;charset=utf-8"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#idVerification").on("click",function(){
		$.ajax({
				"url":"member/findById.udc",
				"type":"POST",
				"data":"id="+$("#id").val(),
				"dataType":"text",
				"success" : function(id){
					if(id){
						alert("이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
						$("#id").focus();
					}else{
						confirm("사용 가능한 아이디입니다. 사용하시겠습니까?");
						$("#password").focus();
					}
				},
				"beforeSend" : function(){
					if(!$("#id").val()){
						alert("아이디를 입력하세요.");
						$("#id").focus();
						return false;
					}
				}
		})
	});
});
</script>

<div style="background-color: aqua; margin-left: 25%;"><h2>회원 가입</h2></div>
<form action="member/join" method="post">
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" value="${requestScope.member.id }"><span class="error"><form:errors path="member.id"/></td>
		<td><input type="button" id="idVerification" value="아이디 확인"></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="password" value="${requestScope.member.password }"><span class="error"><form:errors path="member.password"/></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" name="password2" value="${requestScope.member.password2 }"><span class="error"><form:errors path="member.password2"/></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" name="name" value="${requestScope.member.name }"><span class="error"><form:errors path="member.name"/></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="text" name="email" value="${requestScope.member.email }"><span class="error"><form:errors path="member.email"/></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="가입하기">
		</td>
		<td colspan="2">
			<a href="main.udc"><input type="button" id="cancel" value="취소"></a>
		</td>
	</tr>
</table>
</form>