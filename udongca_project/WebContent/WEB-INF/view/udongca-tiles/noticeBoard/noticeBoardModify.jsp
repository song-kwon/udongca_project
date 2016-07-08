<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
<script  type="text/javascript">
$(document).ready(function(){
	$("input[type='text']").prop({"class":"form-control"});
	$("#title").on("keyup keypress", function(){
		if($(this).val().length>50){
			$(this).val($(this).val().substr(0,50));
			return false;
		}
	});
});

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

function chkCategory(){
	if($("#category").val()=="말머리선택"){
		alert("말머리를 선택해주세요.")
		return false;
	}
	else
		return true;
}

function checkSubmit(){
	var checkCategory = chkCategory();
	var checkTitle = chkTitle();
	var checkContent = chkContent();
	
	if(checkCategory==true && checkTitle==true && checkContent==true){
		var result = confirm("수정하시겠습니까?");
		if(result==true)
			return true;
		else
			return false;
	}
	else
		return false;
}
</script>

<style type="text/css">
table{
	margin:30px;
	margin-top:20px;
	margin-bottom:20px;
	text-align:left;
	font-size:18px;
}
.div{
	border:1px dotted;
	height:auto;
	background-color:antiquewhite;
}

.text{
	font-weight:bold;
	width:100px;
	height:40px;
}
</style>

<div><h1>공지 사항 수정</h1></div>
<br>
<form action="/udongca_project/noticeBoard/modifyNoticeBoard.udc?noticeNo=${requestScope.map.noticeBoard.noticeNo}" method="post" onsubmit="return checkSubmit();">
<div class="div">
<table>
	<tr>
		<td class="text">말머리</td>
		<td>
			<select id="category" name="category" class="form-control" style="width:130px;">
				<option>말머리선택</option>
				<c:forEach items="${requestScope.map.codeList }" var="code">
					<option ${code.codeName == requestScope.map.noticeBoard.category?'selected="selected"':'' }>${code.codeName }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td class="text">제목</td>
		<td><input type="text" name="noticeTitle" id="title" placeholder="제목은 한글 기준 최대 50자까지 입력 가능합니다.." value="${requestScope.map.noticeBoard.noticeTitle }" style="width:660px;"></td>
	</tr>
	<tr>
		<td class="text">내용</td>
		<td><textarea name="noticeContent" id="content" rows="30" cols="80" placeholder="내용을 입력해주세요..">${requestScope.map.noticeBoard.noticeContent }</textarea></td>
	</tr>
</table>
</div>
<br>
<div align="center"><input type="submit" value="수정"> <a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc"><input type="button" id="cancel" value="취소"></a></div>
</form>