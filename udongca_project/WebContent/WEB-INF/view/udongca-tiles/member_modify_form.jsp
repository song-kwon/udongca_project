<%@ page contentType="text/html;charset=utf-8" %>


<div class="nav_bodyDiv">
<div><h2>회원 정보 수정</h2></div>
아이디:<input type="text" readonly="readonly" style="border: thin;" value="${sessionScope.login.memberId }" id="id"><br>
이름:<input type="text"  value="${sessionScope.login.memberName }" id="name"><br>
비밀번호:<input type="password" value="${sessionScope.login.memberPassword }" id="password"><br>
Email:<input type="text" readonly="readonly" style="border: thin;" value="${sessionScope.login.memberEmail }" id="email"><br>
<input type="button" value="수정하기" id="memberModifyBtn">
</div>