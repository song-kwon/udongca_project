<%@ page contentType="text/html;charset=utf-8" %>


<div class="nav_bodyDiv">
<div>아이디: <input type="text" style="background-color: white; border: thin;" value="${sessionScope.login.memberId}" readonly="readonly" id="id"></div>
<div>비밀번호:<input type="password" id="password"></div>
<div><button id="verify">확인</button></div>
</div>