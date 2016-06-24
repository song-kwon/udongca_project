<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h3>회원정보관리</h3>
<form action="/udongca_project/member/memberUpdate.udc" method="post">
	<input type="hidden" name="page" value="${requestScope.page }">
	<span class="error"><form:errors path="memberInfo.memberType" delimiter="//"/></span>
	<span class="error"><form:errors path="memberInfo.memberPassword" delimiter="//"/></span>
	<span class="error"><form:errors path="memberInfo.memberId" delimiter="//"/></span>
	<span class="error"><form:errors path="memberInfo.memberName" delimiter="//"/></span>
	<span class="error"><form:errors path="memberInfo.memberEmail" delimiter="//"/></span>
	<span class="error"><form:errors path="memberInfo.memberPenalty" delimiter="//"/></span>
	<span class="error"><form:errors path="memberInfo.loginPossibility" delimiter="//"/></span>
	<table>
		<tr><td><input type="text" name="memberType" value = "${requestScope.memberInfo.memberType }"><span class="error"><form:errors path="memberInfo.memberType" delimiter="//"/></span></td></tr>
		<tr><td><input type="text" name="memberPassword" value="${requestScope.memberInfo.memberPassword }"><span class="error"><form:errors path="memberInfo.memberPassword" delimiter="//"/></span></td></tr>
		<tr>
			<td>아이디</td>
	 		<td><input type="text" name = "memberId" readonly="readonly" value="${requestScope.memberInfo.memberId }"><span class="error"><form:errors path="memberInfo.memberId" delimiter="//"/></span></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="memberName" readonly="readonly" value="${requestScope.memberInfo.memberName }"><span class="error"><form:errors path="memberInfo.memberName" delimiter="//"/></span></td>
		</tr>
		<tr>	
			<td>이메일</td>
			<td><input type="text" name="memberEmail" readonly="readonly" value="${requestScope.memberInfo.memberEmail }"><span class="error"><form:errors path="memberInfo.memberEmail" delimiter="//"/></span></td>
		</tr>
		<tr>
			<td>벌점</td>
			<td><input type="number" name = "memberPenalty" value="${requestScope.memberInfo.memberPenalty }"><span class="error"><form:errors path="memberInfo.memberPenalty" delimiter="//"/></span></td>
		</tr>
		<tr>
			<td>로그인 가능여부</td>
			<td>
				<select name="loginPossibility" >
					<c:forEach items="${requestScope.code }" var="p">
								<c:choose>
									<c:when test="${p.codeId==requestScope.memberInfo.loginPossibility }">
										<option selected="selected" value=${p.codeId }>${p.codeName }</option>
									</c:when>
									<c:otherwise>
										<option value=${p.codeId }>${p.codeName }</option>
									</c:otherwise>
								</c:choose>
								<%-- <option ${p.codeId==requestScope.memberInfo.loginPossibility?'selected="selected" value='${p.codeId:'value=p.codeId' }>${p.codeName}</option> --%>
					</c:forEach>
				</select>
				<span class="error"><form:errors path="memberInfo.loginPossibility" delimiter="//"/></span>
			</td>
			<tr>
				<td rowspan="1"><input type="submit" value="수정"><button id="cancel" formaction="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.page }">취소</button></td>
			</tr>
	</table>
	
</form>