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
	
});

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
</div>
</c:if>
