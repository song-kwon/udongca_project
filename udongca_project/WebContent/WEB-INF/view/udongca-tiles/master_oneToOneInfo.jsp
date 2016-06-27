<%@ page contentType = "text/html;charset=utf-8"%>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
});
function requiryReply(){
		$.ajax({
			"url" : "/udongca_project/oneToOneInquiry/master/requiryReply.udc",
			"type" : "post",
			"data" : {
						inquiryNo : $("#no").val(),
						inquiryTitle : $("#title").val(),
						inquiryType	: $("#type").val(),	
						inquiryContent : $("#content").val(),
						inquiryReply : $("#reply").val(),
						memberId : $("#id").val(),
					},
			"success" : function(obj) {
				if(obj==1){
					alert("등록성공");
				}else{
					alert("등록실패");
				}
			},
			"error" : function(aa,bb,cc) {
				alert(aa,bb,cc);
			}
	});
	
}
</script>
<div class="container">
<h3>1:1문의</h3>
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<table>
<tr>
	<td>
		<input type="text" readonly="readonly" id="no" value="${requestScope.inquiryNo.inquiryNo }">
		<input type="text" readonly="readonly" id="title" value="${requestScope.inquiryNo.inquiryTitle }">
		<input type="text" readonly="readonly" id="id" value="${requestScope.inquiryNo.memberId }">
	</td>
</tr>
<tr>
	<td>
		<textarea rows="10" cols="100" id="content" readonly="readonly">${requestScope.inquiryNo.inquiryContent }</textarea>
	</td>
</tr>
	<tr>
		<td colspan="1">
	<textarea rows="10" cols="100" id="reply">${requestScope.inquiryNo.inquiryReply }</textarea>
	</td>
	</tr>
	<tr>
	<td>
		<button onclick="requiryReply()">답변등록</button>
	<button onclick='location.href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?page=${requestScope.page }"'>뒤로가기</button>
	</td>
	</tr>
	</table>
</div>