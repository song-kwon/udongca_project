<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
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
	
	if(checkCategory==true && checkTitle==true && checkContent==true)
		return true;
	else
		return false;
}
</script>

<div><h2>공지 사항 수정</h2></div>
<form action="/udongca_project/noticeBoard/modifyNoticeBoard.udc?noticeNo=${requestScope.notice.noticeNo }" method="post" onsubmit="return checkSubmit();">
<table>
	<tr>
		<td>말머리</td>
		<td>
			<select id="category" name="noticeCategory">
				<c:forEach items="${requestScope.code.codeType }" var="code">
					<option>말머리선택</option>
					<option ${code == param.category?'selected="selected"':'' }>${code.codeName }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="noticeTitle" id="title" placeholder="제목 입력" value="${requestScope.noticeBoard.noticeTitle }"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="noticeContent" id="content" rows="80" cols="100" placeholder="내용을 입력해주세요..">${requestScope.noticeBoard.noticeContent }</textarea></td>
	</tr>
</table>
<div><input type="submit" value="등록"> <a href=""><input type="button" id="cancel" value="취소"></a></div>
</form>