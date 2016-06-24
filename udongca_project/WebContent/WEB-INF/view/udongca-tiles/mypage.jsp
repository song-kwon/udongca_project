<%@ page contentType="text/html;charset=utf-8" %>
<div class="nav_bodyDiv">
<div><h2>내 정보</h2></div>
<div style="margin-left: 10px;">
	아이디:${sessionScope.login.memberId }<p>
	이름:${sessionScope.login.memberName }<p>
	이메일:${sessionScope.login.memberEmail }<p>
	<a href="/udongca_project/member/member_modify_form.udc"><button>정보수정</button></a>
</div>
</div>