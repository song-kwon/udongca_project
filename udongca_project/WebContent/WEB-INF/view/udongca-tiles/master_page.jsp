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
						$("#table1").append("<tr id='tr1' class='cursor' onclick='one("+obj[i][j].inquiryNo+")'><td>"+obj[i][j].inquiryNo+"</td><td>"+obj[i][j].inquiryTitle+"</td><td>"+obj[i][j].inquiryType+"</td><td>"+obj[i][j].memberId+"</td></tr>");
						}else if(i==1){
							$("#table2").append("<tr id='tr1' class='cursor' onclick='review("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}else{
							$("#table3").append("<tr id='tr1' class='cursor' onclick='review("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
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
table{
	border-collapse: collapse;
	border-top:2px solid;
	border-bottom:2px solid;
	width:800px;
	margin:30px;
	text-align:center;
}

thead{
	text-align:center;
	width:800px;
	height:40px;
	margin:20px;
	font-size:13pt;
	font-weight:bold;
	cursor:default;
	border-bottom:1.5px solid;
}


table, tbody{
	height:30px;
	font-size:12pt;
}

#tr1, .td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}

tr#tr1:hover{text-decoration:underline; color:red;}
</style>


<h3>1:1문의</h3>
<table >
	<thead>
	<tr id="tr">
		<td style="width:100px;">NO</td>
		<td style="width:300px;">제목</td>
		<td style="width:300px;">문의유형</td>
		<td style="width:100px;">id</td>
	</tr>
	</thead>
	<tbody id = "table1" >
	
	</tbody>
</table>
<h3>리뷰신고</h3>
<table>
<thead>
	<tr id="tr">
		<td style="width:50px;">NO</td>
		<td style="width:50px;">ID</td>
		<td style="width:300px;">REASON</td>
		<td style="width:300px;">RESULT</td>
	</tr>
</thead>
<tbody id = "table2">

</tbody>
</table>
<h3>홍보글신고</h3>
<table>
<thead>
	<tr id="tr">
	<td style="width:50px;">NO</td>
	<td style="width:50px;">ID</td>
	<td style="width:300px;">REASON</td>
	<td style="width:300px;">RESULT</td>
	</tr>
</thead>
<tbody id="table3">
</tbody>
</table>


