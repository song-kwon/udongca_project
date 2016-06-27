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
<div id="page">
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
	<c:forEach items="${requestScope.map.list }" var="list">
	<tr id="list" onclick='location.href="/udongca_project/member/memberInfoMaster.udc?id=${list.memberId}&page=${requestScope.page }"' style="cursor:hand;">
		<td>${list.memberId }</td>
		<td>${list.memberName }</td >
		<td>${list.memberEmail }</td>
		<td>${list.memberPenalty }</td>
		<td>${list.loginPossibility }</td>
	<tr>
	</c:forEach>
</table>
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
</c:if>
</div>
