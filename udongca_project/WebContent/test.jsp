<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
function CheckPassWord(ObjUserID, ObjUserPassWord) {
	 if(ObjUserPassWord.value.length < 6) {
	  alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
	  return false;
	 } // if

	 
	 
	 if(!ObjUserPassWord.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/))  {
	  alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
	  return false;
	 } // if
	 
	 if(ObjUserID.value.valueOf(ObjUserPassWord.value) > -1) {
	  alert("비밀번호에 아이디를 사용할 수 없습니다.");
	  return false;
	 } // if
	 
	 var SamePass_0 = 0; //동일문자 카운트
	 var SamePass_1 = 0; //연속성(+) 카운드
	 var SamePass_2 = 0; //연속성(-) 카운드
	 
	 var chr_pass_0;
	 var chr_pass_1;
	 
	 for(var i=0; i < ObjUserPassWord.value.length; i++) {
	  chr_pass_0 = ObjUserPassWord.value.charAt(i);
	  chr_pass_1 = ObjUserPassWord.value.charAt(i+1);
	 
	  //동일문자 카운트
	  if(chr_pass_0 == chr_pass_1) {
	   SamePass_0 = SamePass_0 + 1
	  } // if
	 
	 
	  //연속성(+) 카운드
	  if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1) {
	   SamePass_1 = SamePass_1 + 1
	  } // if
	 
	  //연속성(-) 카운드
	  if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1) {
	  SamePass_2 = SamePass_2 + 1
	  } // if
	 } // for
	 
	 if(SamePass_0 > 1) {
	  alert("동일문자를 3번 이상 사용할 수 없습니다.");
	  return false;
	 } // if
	 
	 if(SamePass_1 > 1 || SamePass_2 > 1 )  {
	  alert("연속된 문자열(123 또는 321, abc, cba 등)을\n 3자 이상 사용 할 수 없습니다.");
	  return false;
	 } // if
	 return true;
	} // function
</script>
</head>
<body>
아이디:<input id="id" type="text">
비밀번호:<input id="pwd" type="text">
<button onclick="CheckPassWord(id, pwd);">버튼</button>
</body>
</html>