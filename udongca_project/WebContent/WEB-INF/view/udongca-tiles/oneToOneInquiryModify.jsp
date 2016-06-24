<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script  type="text/javascript">
function chkTitle(){
	if(!$("#title").val()){
		alert("제목을 입력해주세요.");
		return false;
	}else
		return true;
}
function chkContent(){
	if(!$("#content").val()){
		alert("내용을 입력해주세요.");
		return false;
	}else
		return true;
}
function chkType(){
	if($("#inquiryType")=="유형 선택"){
		alert("문의 유형을 선택해주세요.");
		return false;
	}else
		return true;
}

function checkSubmit(){
	var checkType = chkType();
	var checkTitle = chkTitle();
	var checkContent = chkContent();
	
	if(checkType==true && checkTitle==true && checkContent==true){
		return true;
	}else
		return false;
}
</script>

<div><h2>1:1 문의 수정</h2></div>
<form action="/udongca_project/oneToOneInquiry/modifyOneToOneInquiry.udc?inquiryNo=${requestScope.oneToOneInquiry.inquiryNo}" method="post" onsubmit="return checkSubmit();">
<table>
	<tr>
		<td>아이디</td>
		<td>${sessionScope.login.memberId }</td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="inquiryTitle" placeholder="제목 입력" value="${requestScope.oneToOneInquiry.inquiryTitle }"></td>
	</tr>
	<tr>
		<td>문의 유형</td>
		<td>
			<select id="inquiryType" name="inquiryType">
				<option>유형 선택</option>
				<option></option>
			</select>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="inquiryContent" rows="80" cols="100" placeholder="내용을 입력해주세요..">${requestScope.oneToOneInquiry.inquiryContent }</textarea>
	</tr>
</table>
<div><input type="submit" value="등록"> <a href="/udongca_project/oneToOneInquiry/oneToOneInquiryList.udc"><input type="button" value="취소"></a></div>
</form>