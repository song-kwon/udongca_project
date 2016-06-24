<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#idVerification").on("click",function(){
		$.ajax({
				"url":"/udongca_project/member/countSameId.udc",
				"type":"POST",
				"data":"memberId="+$("#id").val(),
				"dataType":"text",
				"success" : function(countId){
					if(countId!=0){
						alert("이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
						$("#id").focus();
					}else{
						confirm("사용 가능한 아이디입니다. 사용하시겠습니까?");
						$("#password").focus();
						$("#idVerify").val(true);
					}
				},
				"beforeSend" : function(){
					if($("#id").val().length<6){
						alert("아이디는 6글자 이상 입력해주세요.");
						return false;
					}
				}
		});
	});
	
	$("#id").on("focus",function(){
		$("#idVerify").val(false);
	})
});

//패스워드 조건 검사
function chkPwd1(str){
	 var pw = str;
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	 if(pw.length < 10 || pw.length > 20){
	  alert("비밀번호는 10자리 ~ 20자리 이내로 입력해주세요.");
	  return false;
	 }

	 if(pw.search(/₩s/) != -1){
	  alert("비밀번호는 공백없이 입력해주세요.");
	  return false;
	 }

	 if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
	  alert("비밀번호는 영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.");
	  return false;
	 }

	if(!chkPwd1( $.trim($('#password').val()))){
	   $('#password').val('');
	   $('#password').focus();
	   return false;
	}
	
	return true;
}

//패스워드 일치 검사
function chkPwd2(){
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
	if($("#idVerify").val()=="true"){
		//가입 하기 전, 비밀번호 확인과 이메일 확인
		var checkPassword1 = chkPwd1($("#password").val());
		var checkPassword2 = chkPwd2();
		var checkEmail = chkEmail();
		if(checkPassword1==true && checkPassword2==true && checkEmail==true){
			return true;
		}else
			return false;
	}else{
		alert("아이디 확인을 해주세요.");
		return false;
	}
}
</script>
<div><h2>일반 회원 가입</h2></div>
<div><font size="2">**모든 사항은 필수 입력 사항입니다.</font></div>
<div><font size="1">비밀 번호는 영문, 숫자, 특수문자 중 2가지를 혼합하여 10~20자 이내로 작성해주십시오.</font></div>
<form action="/udongca_project/member/generalMemberJoin.udc" method="post" onsubmit="return checkSubmit();">
<input type="hidden" value="false" id="idVerify">
<table>
	<tr>
		<td>   </td>
	</tr>
	<tr>
		<th>아이디</th>
		<td><input type="text" id="id" name="memberId" value="${requestScope.member.memberId }"></td>
		<td><input type="button" id="idVerification" value="아이디 확인"></td>
		<td><span class="error"><form:errors path="member.memberId"/></span></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" id="password" name="memberPassword" value="${requestScope.member.memberPassword }"></td>
		<td> </td>
		<td><span class="error"><form:errors path="member.memberPassword"/></span></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" id="password2"></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" id="name" name="memberName" value="${requestScope.member.memberName }"></td>
		<td> </td>
		<td><span class="error"><form:errors path="member.memberName"/></span></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="text" id="email" name="memberEmail" value="${requestScope.member.memberEmail }"></td>
		<td>@<select id="emailAddress" name="emailAddress">
				<option>이메일선택</option>
				<option>naver.com</option>
				<option>daum.net</option>
				<option>hanmail.net</option>
				<option>gmail.com</option>
				<option>nate.com</option>
			</select>
		</td>
		<td><span class="error"><form:errors path="member.memberEmail"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="가입하기"/>
		</td>
		<td colspan="2">
			<a href="/udongca_project/main.udc"><input type="button" id="cancel" value="취소"></a>
		</td>
	</tr>
</table>
</form>
</div>