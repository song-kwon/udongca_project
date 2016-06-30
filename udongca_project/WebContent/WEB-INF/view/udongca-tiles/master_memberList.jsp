<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
	a($("#pnum").val());
});
function a(pnum){
	$.ajax({
		"url":"/udongca_project/member/memberList.udc",
		"type":"post",
		"dataType":"json",
		"data":"pnum="+pnum,
		"success":function(obj){
			 var page=obj['page'];
			$("#table").empty();
			$.each(obj['list'],function(){
				$("#table").append("<tr class='cursor' id='td2' onclick='link("+'"'+this.memberId+'",'+page.page+")'><td>"+this.memberId+"</td><td >"+this.memberName+"</td><td>"+this.memberEmail+"</td><td>"+this.memberPenalty+"</td><td>"+this.loginPossibility+"</td></tr>");
			});
			
			 $("#page").empty();
			 if(page.previousPageGroup){
				 $("#page").append("<a onclick=a("+(page.beginPage-1)+") style='cursor:pointer;'>◀</a>&nbsp;&nbsp;");
			 }else{
				 $("#page").append("◀");
			 }
			
			for(var i = page.beginPage;i<=page.endPage;i++){
				if(page.page!=i){
					$("#page").append("<a onclick=a("+i+") style='cursor:pointer;'>"+i+"</a>&nbsp;&nbsp;");
				}else{
					$("#page").append("["+i+"]&nbsp;&nbsp;");
				}
			} 
			 if(page.nextPageGroup){
				 $("#page").append("<a onclick=a("+(page.endPage+1)+") style='cursor:pointer;'>▶</a>&nbsp;&nbsp;");
			 }else{
				 $("#page").append("▶");
			 }
		},
		"error":function(xhr, status, errorMsg){
		alert(xhr+status+errorMsg);
		}
	});
	}
function link(id,pnum){
	location.href="/udongca_project/member/memberInfoMaster.udc?page="+pnum+"&id="+id;
	
	
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

td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}

tr#td2:hover{text-decoration:underline; color:red;}
</style>


<div id="p">
<input type="hidden" id="pnum" value="${param.pnum }">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<c:if test="${sessionScope.login.memberType == 'master'}">
<h3 style="margin:30px;">회원리스트</h3> 
<table >
<thead>
	<tr>
		<td>아이디</td>
		<td>이름</td>
		<td>이메일</td>
		<td>페널티</td>
		<td>로그인허용</td>
	</tr>
</thead>
<tbody id = "table" >

</tbody>
</table>
			<div id="page" align="center"></div>
</c:if>
</div>

