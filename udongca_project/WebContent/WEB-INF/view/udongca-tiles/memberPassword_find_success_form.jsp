<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="window.resizeTo('300','250');window.resizeTo(false);">
<div>
<h2>비밀번호 찾기</h2>
찾으시는 아이디의 비밀번호는<br>
${requestScope.success.memberEmail }로 전송 되었습니다.
</div>
</body>
</html>