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
						$("#table1").append("<tr onclick='one("+obj[i][j].inquiryNo+")'><td>"+obj[i][j].inquiryNo+"</td><td>"+obj[i][j].inquiryTitle+"</td><td>"+obj[i][j].inquiryType+"</td><td>"+obj[i][j].memberId+"</td></tr>");
						}else if(i==1){
							$("#table2").append("<tr onclick='review("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}else{
							$("#table3").append("<tr onclick='review("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}
					 }
				 } 
			},
			"error":function(xhr, status, errorMsg){
			alert(xhr+status+errorMsg);
			}
		});
		
	});
	function one(no){
		location.href="/udongca_project/oneToOneInquiry/master/oneInfo.udc?page=1&inquiryNo="+no;
	}
	function review(no){
		location.href="/udongca_project/master/reportBoardInfo.udc?page=1&reportNo="+no;
	}
</script>
<style type="text/css">
table, td, th{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width: 700px;
}
td,th{
	padding: 5px;
}
</style>
<h3>1:1문의</h3>
<table id = "table1" border="1">
	<tr>
		<td>NO</td>
		<td>제목</td>
		<td>문의유형</td>
		<td>id</td>
	</tr>
</table>
<h3>리뷰신고</h3>
<table id = "table2" border="1">
	<tr>
	<td>NO</td>
	<td>ID</td>
	<td>REASON</td>
	<td>RESULT</td>
	</tr>
</table>
<h3>홍보글신고</h3>
<table id = "table3" border="1">
	<tr>
	<td>NO</td>
	<td>ID</td>
	<td>REASON</td>
	<td>RESULT</td>
	</tr>
</table>

