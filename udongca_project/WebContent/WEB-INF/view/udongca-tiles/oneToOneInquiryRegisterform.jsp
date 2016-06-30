<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script  type="text/javascript">
$(document).ready(function(){
	$("#title").on("keyup keypress", function(){
		if($(this).val().length>50){
			$(this).val($(this).val().substr(0,50));
			return false;
		}
	});
});

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
	}else{
		var result = confirm("등록하시겠습니까?");
		if(result==true)
			return true;
		else
			return false;
	}
}
</script>

<style type="text/css">
table{
	margin:30px;
	margin-top:20px;
	margin-bottom:20px;
}
.div{
	border:1px dotted;
}

.text{
	font-weight:bold;
}
</style>

<div><h1>1:1문의 등록</h1></div>
<br>
<form action="/udongca_project/oneToOneInquiry/registerOneToOneInquiry.udc?memberId=${sessionScope.login.memberId }" method="post" onsubmit="return checkSubmit();">
<div class="div">
<table>
	<tr>
		<td class="text">아이디</td>
		<td>${sessionScope.login.memberId }</td>
	</tr>
	<tr>
		<td class="text">문의 유형</td>
		<td>
			<select id="inquiryType" name="inquiryType">
				<option>유형 선택</option>
				<c:forEach items="${requestScope.codeList }" var="code">
					<option>${code.codeName }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td class="text">제목</td>
		<td><input type="text" id="title" name="inquiryTitle" placeholder="제목 입력" style="width:660px;"></td>
	</tr>
	<tr>
		<td class="text">내용</td>
		<td><textarea rows="30" cols="80" id="content" name="inquiryContent" placeholder="내용을 입력해주세요.."></textarea>
	</tr>
</table>
</div>
<br>
<div align="center"><input type="submit" value="등록"> <a href="/udongca_project/main.udc"><input type="button" value="취소"></a></div>
</form>