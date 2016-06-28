<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			"url":"/udongca_project/master/masterPage.udc",
			"type":"post",
			"dataType":"json",
			"success":function(obj){
				 for(var i = 0; i<obj.length;i++){
					 for(var j = 0 ;j<obj[i].length;j++){
						if(i==0){ 
						$("#table1").append("<tr><td>"+obj[i][j].inquiryNo+"</td><td>"+obj[i][j].inquiryTitle+"</td><td>"+obj[i][j].inquiryType+"</td><td>"+obj[i][j].memberId+"</td></tr>");
						}else if(i==1){
							$("#table2").append("<tr><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}else{
							$("#table3").append("<tr><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}
					 }
				 } 
			},
			"error":function(xhr, status, errorMsg){
			alert(xhr+status+errorMsg);
			}
		});
	});
	
</script>
<style type="text/css">
table, td, th{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width: 700px;
	text-align:center;
}
thead{
	font-weight:bold;
}
td,th{
	padding: 5px;
}
</style>
<h2>1:1문의</h2>
<table id = "table1" border="1">
	<thead>
	<tr>
		<td style="width:30px;">No</td>
		<td style="width:200px;">제목</td>
		<td style="width:60px;">문의유형</td>
		<td style="width:60px;">작성자</td>
	</tr>
	</thead>
</table>
<br><br>
<h2>리뷰 신고</h2>
<table id = "table2" border="1">
	<thead>
	<tr>
		<td style="width:30px;">No</td>
		<td style="width:60px;">신고자</td>
		<td style="width:300px;">신고사유</td>
		<td style="width:60px;">처리결과</td>
	</tr>
	</thead>
</table>
<br><br>
<h2>홍보글 신고</h2>
<table id = "table3" border="1">
	<thead>
	<tr>
		<td style="width:30px;">No</td>
		<td style="width:60px;">신고자</td>
		<td style="width:300px;">신고사유</td>
		<td style="width:60px;">처리결과</td>
	</tr>
	</thead>
</table>

