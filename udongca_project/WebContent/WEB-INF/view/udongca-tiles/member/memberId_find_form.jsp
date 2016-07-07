<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function windowResize(){
	window.resizeTo(350,250);
}
function error(){
	var er = '${requestScope.error}';
	if(er.length!=0){
		alert(er);
	}
}
</script>
</head>
<body onload="windowResize();error();">
	<div>
	<h2>아이디 찾기</h2>
		<form action="/udongca_project/member/memberId_find.udc">
			이름 : <input type="text" name="memberName" size="5"> <br> 이메일:<input
				type="text" name="memberEmail" size="5">@<select id="emailAddress"
				name="emailAddress">
				<option>이메일선택</option>
				<option>naver.com</option>
				<option>daum.net</option>
				<option>hanmail.net</option>
				<option>gmail.com</option>
				<option>nate.com</option>
			</select>
			<input type="submit" value="찾기">
		</form>
	</div>
</body>
</html>