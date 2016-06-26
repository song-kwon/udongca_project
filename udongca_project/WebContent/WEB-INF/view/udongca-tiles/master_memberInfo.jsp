<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
});
function checkPenalty(){
	var form = document.submit;
	if(form.memberPenalty.value>=3 && form.loginPossibility.value=="possible"){
		alert("벌점3점이상 로그인 불가");
		form.loginPossibility.value="impossible";
		return false;
	}
}
</script> 
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<c:if test="${sessionScope.login.memberType == 'master'}">
<h3>회원정보관리</h3>${requestScope.succeess }
<form name="submit" onsubmit="return checkPenalty()"action="/udongca_project/member/memberUpdate.udc?page=${requestScope.page }" method="post">
	
	<table>
		<tr>
			<td>아이디</td>
	 		<td><input type="text" name = "memberId" readonly="readonly" value="${requestScope.memberInfo.memberId }"></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="memberName" readonly="readonly" value="${requestScope.memberInfo.memberName }"></td>
		</tr>
		<tr>	
			<td>이메일</td>
			<td><input type="text" name="memberEmail" readonly="readonly" value="${requestScope.memberInfo.memberEmail }"></td>
		</tr>
		<tr>
			<td>벌점</td>
			<td><input type="number" name = "memberPenalty" value="${requestScope.memberInfo.memberPenalty }"></td>
		</tr>
		<tr>
			<td>로그인 가능여부</td>
			<td>
				<select name="loginPossibility">
					<c:forEach items="${requestScope.code }" var="p">
								<c:choose>
									<c:when test="${p.codeId==requestScope.memberInfo.loginPossibility }">
										<option selected="selected" value=${p.codeId }>${p.codeName }</option>
									</c:when>
									<c:otherwise>
										<option value=${p.codeId }>${p.codeName }</option>
									</c:otherwise>
								</c:choose>
					</c:forEach>
				</select>
			</td>
			<tr>
				<td rowspan="1">
				<input type="submit" value="수정">
				<button id="cancel" formaction="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.page }">취소</button>
				</td>
			</tr>
	</table>
</form>
</c:if>