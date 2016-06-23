<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="window.resizeTo(350,250)">
	<div>
		<form action="/udongca_project/member/memberId_find.udc">
			이름 : <input type="text" name="memberName" size="5"> <br> 이메일:<input
				type="text" name="memberEmail">@<select id="emailAddress"
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