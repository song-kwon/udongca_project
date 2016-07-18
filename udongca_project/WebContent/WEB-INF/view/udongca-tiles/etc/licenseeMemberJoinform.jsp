<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
//아이디 조건 검사
$(document).ready(function(){
	$("input[type='text']").prop({"class":"form-control col-xs-2","style":"width:150px;"});
	
	$("#id").on("keyup keypress", function(){
		if($(this).val().length>50){
			$(this).val($(this).val().substr(0,50));
			return false;
		}
	});
	$("#name").on("keyup keypress", function(){
		if($(this).val().length>50){
			$(this).val($(this).val().substr(0,50));
			return false;
		}
	});
	$("#email").on("keyup keypress", function(){
		if($(this).val().length>50){
			$(this).val($(this).val().substr(0,50));
			return false;
		}
	});
	
	$("#emailVerification").on("click",function(){
		$.ajax({
			"url":"/udongca_project/member/countSameEmail.udc",
			"type":"POST",
			"data":"memberEmail="+$("#email").val()+"@"+$("#emailAddress").val(),
			"dataType":"text",
			"success" : function(countSameEmail){
				if(countSameEmail!=0){
					alert("이미 가입되어있는 이메일입니다. 다른 이메일을 입력해주세요.");
					$("#email").focus();
				}else{
					var result = confirm("'"+$.trim($("#email").val())+"@"+$("#emailAddress").val()+"'"+"는 사용 가능한 이메일입니다. 사용하시겠습니까?");
					if(result == false){
						$("#email").focus();
					}else{
						$("#emailVerify").val(true);
					}
				}
			},
			"beforeSend" : function chkEmail(){
				if($("#email").val()==''){
					alert("이메일은 필수입력사항입니다.");
					return false;
				}else if($("#emailAddress").val()=="이메일선택"){
					alert("이메일 주소를 선택해주세요.")
					return false;
				}
				return true;
			}
		});
	});
	
	$("#email").on("focus",function(){
		$("#emailVerify").val(false);
	});
	
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
						var result = confirm("'"+$.trim($("#id").val())+"'"+"는 사용 가능한 아이디입니다. 사용하시겠습니까?");
						if(result == false){
							$("#id").focus();
						}else{
							$("#id").val($.trim($("#id").val()));
							$("#password").focus();
							$("#idVerify").val(true);
						}
					}
				},
				"beforeSend" : function chkId(){
					var id = $("#id").val();
					var id2 = $.trim($("#id").val());
					var num = id.search(/[0-9]/g);
					var eng = id.search(/[a-z]/ig);
					var spe = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
					
					//아이디 한글 에러 처리
					for (i = 0; i < id.length; i++) {
						   var retCode = id.charCodeAt(i);
						   var retChar = id.substr(i,1).toUpperCase();
						   retCode = parseInt(retCode);
						   
						  if ( (retChar < "0" || retChar > "9") && (retChar < "A" || retChar > "Z") && ((retCode > 255) || (retCode < 0)) ){
							  alert("아이디는 영문과 숫자만 입력가능합니다.");
							  $("#id").focus();
							  return false;
						  }
					}
				
					//영문, 숫자 이외의 문자 입력시 에러 처리
					if((num<0 && eng<0) || spe.test(id)==true){
						  alert("아이디는 영문과 숫자만 입력가능합니다.");
						  $("#id").focus();
						  return false;
					}
					
					//공백 입력시 에러 처리
					if((id.length != id2.length) || id.length<6 || (id.search(/[" "]/g) > 0)){
						alert("아이디는 공백없이 6글자 이상 입력해주세요.");
						$("#id").focus();
						return false;
					}
					return true;
				}
		});
	});
	
	$("#id").on("focus",function(){
		$("#idVerify").val(false);
	})
});

//패스워드 조건 검사
function chkPwd1(){
	 var pw = $("#password").val();
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	 
	 var pw2 = pw.trim();
	 
	 if((pw.length != pw2.length) || (pw.search(/[" "]/g) > 0)){
		alert("비밀번호는 공백없이 입력해주세요.");
		$("#password").val('');
		$("#password2").val('');
		$("#password").focus();
		return false;
	 }
	 
	 if(pw.length < 10 || pw.length > 20){
	  alert("비밀번호는 10자리 ~ 20자리 이내로 입력해주세요.");
	  $("#password").val('');
	  $("#password2").val('');
	  $("#password").focus();
	  return false;
	 }

	 if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
	  alert("비밀번호는 영문, 숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.");
	  $("#password").val('');
	  $("#password2").val('');
	  $("#password").focus();
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

//이름 입력 검사
function chkName(){
	var name = $("#name").val();
	var name2 = $.trim(name);
	if(name==''){
		alert("이름은 필수입력사항입니다.");
		return false;
	}else if((name.length != name2.length)||(name.search(/[" "]/g) > 0)){
		  alert("이름은 공백없이 입력해주세요.");
		  $("#name").focus();
		  return false;
	}
	return true;
}

//이메일 입력 검사
function chkEmail(){
	if($("#email").val()==''){
		alert("이메일은 필수입력사항입니다.");
		return false;
	}else if($("#emailAddress").val()=="이메일선택"){
		alert("이메일 주소를 선택해주세요.")
		return false;
	}
	return true;
}

function checkSubmit(){
	if($("#idVerify").val()=="true" && $("#emailVerify").val()=="true"){
		//가입 하기 전, 비밀번호 확인과 이메일 확인
		var checkPassword1 = chkPwd1();
		var checkPassword2 = chkPwd2();
		var checkName = chkName();
		var checkEmail = chkEmail();
		if(checkPassword1==true && checkPassword2==true && checkName==true && checkEmail==true){
			return true;
		}else
			return false;
	}else if($("#idVerify").val()=="false"){
		alert("아이디 확인을 해주세요.");
		return false;
	}else{
		alert("이메일 확인을 해주세요.");
		return false;
	}
}
</script>
<style type="text/css">
table{
	border-collapse: collapse;
	width:550px;
	margin:30px;
	font-size:18px;
	text-align:left;
}

table, th{
	text-align:left;
	width:580px;
}

.width_size2{
	width:80px;
}

</style>

<div class="nonav_bodyDiv" style="width:700px;">
<div><h1>사업자 회원 가입</h1></div><br>
<div style="color:red;"><font size="3">**모든 사항은 필수 입력 사항입니다.</font></div>
<div><font size="2">아이디는 공백을 제외하여 영문, 숫자 또는 영문과 숫자를 혼합하여 6글자 이상으로 작성해주십시오.</font></div>
<div><font size="2">비밀 번호는 공백을 제외하여 영문, 숫자, 특수문자 중 2가지를 혼합하여 10~20자 이내로 작성해주십시오.</font></div>
<br>
<form action="/udongca_project/member/licenseeMemberJoin.udc" method="post" onsubmit="return checkSubmit();">
<input type="hidden" value="false" id="idVerify">
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" id="id" name="memberId" value="${requestScope.member.memberId }"></td>
		<td>&nbsp;<input type="button" id="idVerification" value="아이디 확인"></td>
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
		<td><input type="password" id="password2" class="width_size"></td>
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
		<td class="input-group"><span class="input-group-addon">@</span><select id="emailAddress" name="emailAddress" style="width:130px;"class="form-control" aria-describedby="inputGroupSuccess1Status">
				<option>이메일선택</option>
				<option>naver.com</option>
				<option>daum.net</option>
				<option>hanmail.net</option>
				<option>gmail.com</option>
				<option>nate.com</option>
			</select>
		</td>
		<td><input type="button" id="emailVerification" value="이메일 확인"></td>
		<td><span class="error"><form:errors path="member.memberEmail"/></span></td>
	</tr>
</table>
	<div align="center" style="width:550px;">
		<input type="submit" class="width_size2" value="가입하기"/>&nbsp;&nbsp;
		<a href="/udongca_project/main.udc"><input type="button" id="cancel" class="width_size2" value="취소"></a>
	</div>
</form>
</div>
