<%@ page contentType="text/html;charset=utf-8"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#idVerification").on("click",function(){
		$.ajax({
				"url":"member/countSameId.udc",
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
						$("#idVerify").val()==true;
					}
				}
		});
	});
});

//패스워드 일치 검사
function chkPwd(){
	if($("#password").val()==$("#password2").val()){
		return true;
	}else{
		alert("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.");
		$("#password").focus();
		return false;
	}
}

//이메일 입력 검사
function chkEmail(){
	if($("#emailAddress").val()=="이메일선택"){
		alert("이메일 주소를 선택해주세요.")
		return false;
	}
	else
		return true;
}

function checkSubmit(){
	if($("#idVerify").val()==true){
		//가입 하기 전, 비밀번호 확인과 이메일 확인
		var checkPassword = chkPwd();
		var checkEmail = chkEmail();
		if(checkPassword==true && checkEmail==true){
			return true;
		}else
			return false;
	}else{
		alert("아이디 확인을 해주세요.");
		return false;
	}
}
</script>

<div style="margin-left: 25%;"><h2>일반 회원 가입</h2></div>
<div><font size="1">**모든 사항은 필수 입력 사항입니다.</font></div>
<form action="generalMemberJoin.udc" method="post" onsubmit="return checkSubmit();">
<input type="hidden" value="false" id="idVerify">
<table>
	<tr>
		<td>   </td>
	</tr>
	<tr>
		<th>아이디</th>
		<td><input type="text" id="id" value="${requestScope.generalMember.id }"><span class="error"><form:errors path="generalMember.id"/></td>
		<td><input type="button" id="idVerification" value="아이디 확인"></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" id="password" value="${requestScope.generalMember.password }"><span class="error"><form:errors path="generalMember.password"/></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" id="password2" value="${requestScope.generalMember.password2 }"><span class="error"><form:errors path="generalMember.password2"/></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" id="name" value="${requestScope.generalMember.name }"><span class="error"><form:errors path="generalMember.name"/></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="text" id="email" value="${requestScope.generalMember.email }"><span class="error"><form:errors path="generalMember.email"/></td>
		<td>@<select id="emailAddress">
				<option>이메일선택</option>
				<option>naver.com</option>
				<option>daum.net</option>
				<option>hanmail.net</option>
				<option>gmail.com</option>
				<option>nate.com</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="가입하기"/>
		</td>
		<td colspan="2">
			<a href="main.udc"><input type="button" id="cancel" value="취소"></a>
		</td>
	</tr>
</table>
</form>