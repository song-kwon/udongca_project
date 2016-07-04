<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
	var countGroup = '${requestScope.countGroup}';
	$('#addReply').on('click',function(){
		alert($('#replyContent').val());
		$.ajax({
			'url':'/udongca_project/review/addReply.udc',
			'type':'post',
			'data':{'replyId':'${sessionScope.login.memberId}','replyContent':$('#replyContent').val(),'replyGroup':countGroup,'reviewNo':'${param.reviewNo}'},
			'dataType':'json',
			'error':function(xhr){alert('error occured while adding reply: ' + xhr.status + ' ' + xhr.statusText);alert(countGroup);},
			'success':function(json){
				if(json==null){
					alert('등록 실패. 다시 시도하세요.');
					return false;
				}
				location.reload(true);
			}
		});
	});
	
	$('#replyBoard').on('click','.reReplyInputBtn',function(){
		$("#reReplyInput").remove();
		alert($(this).parent().parent().parent().prop('id'));
		$(this).parent().parent().parent().append("<div id='reReplyInput' style='height:40px;'><input type='text' id='reReplyContent' placeholder='댓글 입력'><button class='addReReply'>등록</button></div>");
	});
	
	$('#replyBoard').on('click','.addReReply',function(){
		var reReply = $(this).parent().parent();
		alert(reReply.prop('id'))//parentReply
		alert(reReply.children(':first').prop('class'))//group
		alert(reReply.children(':first').find(':first').prop('id'))//targetName
		$.ajax({
			'url':'/udongca_project/review/addReReply.udc',
			'type':'post',
			'data':{'replyId':'${sessionScope.login.memberId}','replyContent':$('#reReplyContent').val(),'reviewNo':'${param.reviewNo}','parentReply':reReply.prop('id'),'targetName':reReply.children(':first').find(':first').prop('id'),'replyGroup':reReply.children(':first').prop('class')},
			'dataType':'json',
			'error':function(xhr){
				alert('error occured while adding re-reply: ' + xhr.status + ' ' + xhr.statusText);
			},
			'success':function(json){
				if(json==null){
					alert('등록 실패. 다시 시도하세요.');
					return false;
				}
				location.reload(true);
			}
		}); 
	});
	
	
});
</script>
<style type="text/css">
.replyContent{
	text-indent: 20px;
	height:30px;
}
.reReplyContent{
	text-indent: 50px;
	height:40px;
}
.reReply{
	text-indent: 50px;
}

</style>
</head>
<body>
<h2>댓글 대댓글</h2>
<table border="1">
<thead>
<tr>
	<td>${requestScope.review.reviewNo }
	<td>${requestScope.review.reviewTitle }
	<td>${requestScope.review.memberId }
	<td>${requestScope.review.reviewDate }
</thead>

<tbody>
<tr>
	<td width="300px" height="300px" colspan="4" valign="middle">
	${requestScope.review.reviewContent }
	</td>
</tbody>
</table>
---댓글---
<table id="replyBoard">
<c:forEach begin="1" end="${requestScope.countGroup }" varStatus="group">

	<c:forEach items="${requestScope.reply }" var="reply">
		<c:if test="${reply.replyGroup eq group.index  and reply.parentReply == 0}">
			<tbody class="reply" id="${reply.replyNo }">
				<tr class='${group.index }'>
					<td id="${reply.replyId }">${reply.replyId }&nbsp;<button class="reReplyInputBtn">답글</button>
				<tr>
					<td class="replyContent"><textarea style="resize:none;border: thin;background: white;" readonly="readonly">${reply.replyContent }</textarea>
			</tbody>
		</c:if>
	</c:forEach>
	
	<c:forEach items="${requestScope.reply }" var="reReply">
		<c:if test="${reReply.replyGroup eq group.index and reReply.parentReply !=0 }">
			<tbody class="reReply" id="${reReply.replyNo }">
				<tr  class='${group.index }' >
					<td id="${reReply.replyId }">${reReply.replyId }&nbsp;<button class="reReplyInputBtn">답글</button>
				<tr>
					<td class="reReplyContent"><textarea style="resize:none;border: thin;background: white;" readonly="readonly">[${reReply.targetName}]${reReply.replyContent }</textarea>
			</tbody>
		</c:if>
	</c:forEach>
</c:forEach>
</table>
	<input type="text" id="replyContent" placeholder="댓글 입력">
	<button id="addReply">등록</button>
</body>
</html>