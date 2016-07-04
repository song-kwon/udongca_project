<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('tr').find(':first').css({'font-size':25})	;
	$('tr').find(':second').css({'font-size':20});
	
})

</script>
<style type="text/css">
textarea {
	border: thin;
	background-color: white;
	resize:none;
}
table, td, th{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width:350px;
}
td,th{
	padding: 5px;
}
div{
	width: 360px;
}
textarea{
	outline: none;
}
</style>
</head>
<body>
<div>
	<table>
		<tr>
			<td>제목
			<td>[${requestScope.report.reportType }]${requestScope.report.reportContent }
		<tr>
			<td>작성자
			<td>${requestScope.report.memberId }
		<tr>
			<td>선택 사유
			<td>${requestScope.report.reportReason }
		<tr>
			<td colspan="2"><textarea rows="10" cols="30" readonly="readonly">${requestScope.report.reportContent }</textarea>
		</table>
		<br>
		<table>
		<tr>
			<td colspan="2">처리결과
		<tr>
			<td colspan="2"><textarea rows="10" cols="30" readonly="readonly" >${requestScope.report.reportResult }</textarea>
		</table>
<div style="margin-top:5px;" align="center" onclick="window.close()"><button>닫기</button></div>
</div>
</body>
</html>