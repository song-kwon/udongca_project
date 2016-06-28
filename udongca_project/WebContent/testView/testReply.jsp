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
	$('#addReply').on('click',function(){
		$.ajax({
			'url':'/udongca_project/review/addReply.udc',
			'type':'post',
			'data':{'replyId':'${sessionScope.login.memberId}','replyContent':$('#replyContent').val(),'reviewNo':'${param.reviewNo}'},
			'dataType':'text',
			'success':function(txt){
				if(txt==0){
					alert('등록 실패. 다시 시도하세요.');
					return false;
				}
				else{
					$('#replyBoard').append('<div class="reply"><div>${sessionScope.login.memberId}</div><div class="replyContent">'+$('#replyContent').val()+'</div></div>');
					$('#replyContent').val("");
				}
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
<div id="replyBoard">
<c:forEach items="${requestScope.reply }" var="reply">
	<c:if test="${reply.parentReply eq 0 }">
			<div class="reply">
			<div>${reply.replyId }&nbsp;<button>답글</button></div>
			<div class="replyContent">${reply.replyContent }</div>
			</div>
	</c:if>
	
	<c:forEach items="${requestScope.reply }" var="reReply">
		<c:if test="${reReply.parentReply eq reply.replyNo }">
			<div class="reReply">
			<div>${reReply.replyId }&nbsp;<button>답글</button></div>
			<div class="reReplyContent">[${reReply.targetName}]${reReply.replyContent }</div>
			</div>
		</c:if>
	</c:forEach>
</c:forEach>
</div>
	<input type="text" id="replyContent" placeholder="댓글 입력">
	<button id="addReply">등록</button>
</body>
</html>