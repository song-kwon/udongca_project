<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script  type="text/javascript">
function chkTitle(){
	if(!$("#title").val()){
		return false;
	}else
		return true;
}
function chkContent(){
	if(!$("#content").val()){
		return false;
	}else
		return true;
}

function chkType(){
	if($("#inquiryType").val()=="유형 선택"){
		return false;
	}
	else
		return true;
}

function checkSubmit(){
	var checkType = chkType();
	var checkTitle = chkTitle();
	var checkContent = chkContent();
	
	if(checkTitle==false){
		alert("제목을 입력해주세요.");
		return false;
	}else if(checkType==false){
		alert("문의 유형을 선택해주세요.");
		return false;
	}else if(checkContent==false){
		alert("내용을 입력해주세요.");
		return false;
	}else
		return true;
}
</script>

<div><h2>1:1 문의 등록</h2></div>
<form action="/udongca_project/oneToOneInquiry/registerOneToOneInquiry.udc?memberId=${sessionScope.login.memberId }" method="post" onsubmit="return checkSubmit();">
<table>
	<tr>
		<td>아이디</td>
		<td>${sessionScope.login.memberId }</td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" id="title" name="inquiryTitle" placeholder="제목 입력"></td>
	</tr>
	<tr>
		<td>문의 유형</td>
		<td>
			<select id="inquiryType" name="inquiryType">
				<option>유형 선택</option>
				<option>유형1</option>
				<option>유형2</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea rows="30" cols="50" id="content" name="inquiryContent" placeholder="내용을 입력해주세요.."></textarea>
	</tr>
</table>
<div><input type="submit" value="등록"> <a href="/udongca_project/main.udc"><input type="button" value="취소"></a></div>
</form>