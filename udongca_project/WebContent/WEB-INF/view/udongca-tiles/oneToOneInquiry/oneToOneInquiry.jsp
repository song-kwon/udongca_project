<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
table{
	border-collapse: collapse;
	width:750px;
	margin:30px;
	text-align:left;
	font-size:18px;
}

tr#tr{
	border-bottom:1px dotted;
	height:40px;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#deleteBtn").on("click",function(){
		var result = confirm("해당 게시물을 삭제하시겠습니까?");
		if(result==true){
			location.replace("/udongca_project/oneToOneInquiry/deleteOneToOneInquiryMember.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo}");
		}
	});
	$("#deleteBtn2").on("click",function(){
		var result = confirm("해당 게시물을 삭제하시겠습니까?");		
		if(result==true){
			location.replace("/udongca_project/oneToOneInquiry/deleteOneToOneInquiryMaster.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo}");
		}
	});
});
</script>

<div><h1>1:1문의</h1></div>
<table border="1">
	<tr id="tr">
		<td style="width:80px; border-right:1px dotted; font-weight:bold;">[${requestScope.map.oneToOneInquiry.inquiryType }]</td>
		<td style="width:200px; border-right:1px dotted; font-weight:bold;">${requestScope.map.oneToOneInquiry.inquiryTitle }</td>
		<td style="width:150px;">작성자 : ${requestScope.map.oneToOneInquiry.memberId }</td>
	</tr>
	<tr>
		<td colspan="3" style="width:500px; height:250px;">${requestScope.map.oneToOneInquiry.inquiryContent }</td>
	</tr>
	<c:choose>
		<c:when test="${! empty requestScope.map.oneToOneInquiry.inquiryReply and requestScope.map.oneToOneInquiry.inquiryReply!=' '}">
			<tr><td colspan="3" align="center" style="width:500px; height:30px; border-top:3px double; border-bottom:1px dotted; font-weight:bold;">문의 답변</td></tr>
			<tr>
				<td colspan="3" style="width:500px; height:200px;">${requestScope.map.oneToOneInquiry.inquiryReply }</td>
			</tr>
		</c:when>
		
		<c:otherwise>
			<tr><td colspan="3" align="center" style="width:500px; height:30px; border-top:3px double; border-bottom:1px dotted; font-weight:bold;">문의 답변</td></tr>
			<tr>
				<td colspan="3" style="width:500px; height:200px;">아직 답변이 달리지 않았습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>
<div align="center">
	<c:if test="${sessionScope.login.memberId == requestScope.map.oneToOneInquiry.memberId}">
		<a href="/udongca_project/oneToOneInquiry/modifyOneToOneInquiryform.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo}&codeType=inquiry_type"><input type="button" id="modifyBtn" value="문의수정"></a>
		<input type="button" id="deleteBtn" value="문의삭제">
		<a href="/udongca_project/member/memberInquiryListPaging.udc"><input type="button" value="내 문의 내역"></a>
	</c:if>
	<c:if test="${sessionScope.login.memberId == 'udongca' }">
		<a href="/udongca_project/oneToOneInquiry/modifyOneToOneInquiryReplyform.udc?inquiryNo=${requestScope.map.oneToOneInquiry.inquiryNo }"><input type="button" value="답변등록"></a>
		<input type="button" id="deleteBtn2" value="문의삭제">
		<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc"><input type="button" value="문의목록"></a>
	</c:if>
	<a href="/udongca_project/main.udc"><input type="button" value="메인페이지"></a>
</div>