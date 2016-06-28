<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

function chkCategory(){
	if($("#category").val()=="말머리선택"){
		return false;
	}
	else
		return true;
}

function checkSubmit(){
	var checkCategory = chkCategory();
	var checkTitle = chkTitle();
	var checkContent = chkContent();
	
	if(checkCategory==false){
		alert("말머리를 선택해주세요.");
		return false;
	}else if(checkTitle==false){
		alert("제목을 입력해주세요.");
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

<div><h1>공지 사항 등록</h1></div>
<br>
<form action="/udongca_project/noticeBoard/registerNoticeBoard.udc" method="post" onsubmit="return checkSubmit();">
<div class="div">
<table>
	<tr>
		<td class="text">말머리</td>
		<td>
			<select id="category" name="category">
					<option>말머리선택</option>
					<option>말머리</option>
					<option>말머리2</option>
					<c:forEach items="${requestScope.code.codeType }" var="code">
					<!-- <option ${code == param.category?'selected="selected"':'' }>${code.codeName }</option> -->
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td class="text">제목</td>
		<td><input type="text" name="noticeTitle" id="title" placeholder="제목 입력" style="width:660px;"></td>
	</tr>
	<tr>
		<td class="text">내용</td>
		<td><textarea name="noticeContent" id="content" rows="30" cols="80" placeholder="내용을 입력해주세요.."></textarea></td>
	</tr>
</table>
</div>
<br>
<div align="center"><input type="submit" value="등록"> <a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc"><input type="button" id="cancel" value="취소"></a></div>
</form>