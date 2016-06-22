<%@ page contentType="text/html;charset=utf-8" %>

<div style="background-color: blue;" class="nav_bodyDiv" >
<div>아이디:${sessionScope.login.memberId }</div>
<div>이름:${sessionScope.login.memberName }</div>
<div>이메일:${sessionScope.login.memberEmail }</div>
<div><button id="member_modify">정보수정</button></div>
</div>