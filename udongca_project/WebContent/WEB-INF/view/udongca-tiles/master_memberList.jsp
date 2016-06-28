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
	width:400px;
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

.td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>

<div id="p">
<input type="hidden" id="pnum" value="${param.pnum }">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<input type="hidden" id="success" value="${param.success}">
<c:if test="${sessionScope.login.memberType == 'master'}">
<div><h1>회원리스트</h1></div> 
<table>
	<thead>
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>이메일</td>
			<td>벌점</td>
			<td>로그인허용</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${requestScope.map.list }" var="list">
			<tr id="list" class="td" onclick='location.href="/udongca_project/member/memberInfoMaster.udc?id=${list.memberId}&page=${requestScope.page }"'>
				<td style="width:60px;" id="td1">${list.memberId }</td>
				<td style="width:60px;" id="td2">${list.memberName }</td>
				<td style="width:100px;">${list.memberEmail }</td>
				<td style="width:30px;">${list.memberPenalty }</td>
				<td style="width:30px;">${list.loginPossibility }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div align="center">
<!-- 이전페이지그룹 -->
<c:choose>
 	<c:when test="${requestScope.map.pageBean.previousPageGroup }">
 		<a href="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.map.pageBean.beginPage-1 }">
 			◀
 		</a>	
 	</c:when>
 	<c:otherwise>
		◀ 	
 	</c:otherwise>
 </c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.map.pageBean.beginPage }" end="${requestScope.map.pageBean.endPage }"
			   var="p">
	<c:choose>
		<c:when test="${p != requestScope.map.pageBean.page }">
			<a href="/udongca_project/member/memberListPaging.udc?pnum=${p }">
				${p }
			</a>
			&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			[${p }]&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>
</c:forEach>	
<!-- 다음페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.map.pageBean.nextPageGroup }">
		<a href="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.map.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>
			<span id="page"></span>
</div>
</c:if>
</div>
