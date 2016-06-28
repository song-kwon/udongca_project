<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
	if($("#success").val()==1){
		alert("수정성공");
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
			if(!$("#table").hasChildNodes){
				$("table").append("<tr><td>아이디</td><td>이름</td><td>이메일</td><td>페널티</td><td>로그인허용</td></tr>");
			
			}
			$.each(obj['list'],function(){
				$("#table").append("<tr onclick='link("+'"'+this.memberId+'",'+page.page+")'><td>"+this.memberId+"</td><td>"+this.memberName+"</td><td>"+this.memberEmail+"</td><td>"+this.memberPenalty+"</td><td>"+this.loginPossibility+"</td></tr>");
				
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
<div id="p">
<input type="hidden" id="pnum" value="${param.pnum }">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<input type="hidden" id="success" value="${param.success}">
<c:if test="${sessionScope.login.memberType == 'master'}">
<h3>회원리스트</h3> 
<table id = "table" border="1" >
	<tr>
		<td>아이디</td>
		<td>이름</td>
		<td>이메일</td>
		<td>페널티</td>
		<td>로그인허용</td>
	</tr>
</table>
			<span id="page"></span>
</c:if>
</div>
