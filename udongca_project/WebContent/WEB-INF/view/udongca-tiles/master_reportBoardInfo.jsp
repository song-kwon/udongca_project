<%@ page contentType = "text/html;charset=utf-8"%>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
});
	function update(){
			$.ajax({
				"url" : "/udongca_project/master/updateInfo.udc",
				"type" : "post",
				"data" : {
							reportboardNo : $("#reportboardNo").val(),
							reportMemberId : $("#reportMemberId").val(),
							reportReason : $("#reportReason").val(),
							reportType : $("#reportType").val(),
							reportNO : $("#reportNO").val(),
							memberId : $("#memberId").val(),
							reportContent : $("#reportContent").val(),
							reportResult : $("#reportResult").val(),
							reportCancelReason : $("#cancelReason").val(),
							page : $("#page").val()
							
						},
				"success" : function(obj) {
					if(obj==1){
						alert("등록성공");
					}
				},
				"error" : function(aa,bb,cc) {
					alert(aa,bb,cc);
				}
		});
		
	}
	function deleteArticle(){

		$.ajax({
			"url" : "/udongca_project/master/deleteArticle.udc",
			"type" : "post",
			"data" : {
						reportType : $("#reportType").val(),
						reportNO : $("#reportNO").val(),
					},
			"success" : function(obj) {
				if(obj==1){
					alert("삭제성공");
				}else{
					alert("삭제실패");
				}
			},
			"error" : function(aa,bb,cc) {
				alert(aa,bb,cc);
			}
	});
	
}
function memberPenalty(){
		
		$.ajax({
			"url" : "/udongca_project/master/memberPenalty.udc",
			"type" : "post",
			"data" : {
						reportType : $("#reportType").val(),
						reportNO : $("#reportNO").val(),
					},
			"success" : function(obj) {
				if(obj==1){
					alert("삭제성공");
				}else{
					alert("삭제실패");
				}
			},
			"error" : function(aa,bb,cc) {
				alert(aa,bb,cc);
			}
	});
	
}
$(document).ready(function(){
	$("#info").on("click",function(){
	});
});
 function memberPenalty(){
	$("#penalty").prop("formaction","/udongca_project/member/memberInfoMaster.udc?reportMemberId="+$("#reportMemberId").val());
} 
</script>
<style type="text/css">
table{
border-top:1px solid;
border-collapse: collapse;
	margin:30px;
	margin-top:20px;
	margin-bottom:20px;
}

.text{
	font-weight:bold;
}
td{
	border-top: 1px dotted;
}
</style>
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<h1 style="margin:30px">신고처리</h1>
	<table border="1">
		<tr>
			<td class="text">
				NO:<input type="text" style="border: 0px;" id="reportboardNo" readonly="readonly" value="${requestScope.reportInfo.reportboardNo }">
				신고당한 id : <input type="text" style="border: 0px;" id="reportMemberId" readonly="readonly" value="${requestScope.reportInfo.reportMemberId }">
				신고 이유  :<input type="text" style="border: 0px;" id="reportReason" readonly="readonly" value="${requestScope.reportInfo.reportReason }">  
			</td>
		</tr>	
		<tr>
			<td class="text">
				신고 게시판 : <input type="text" style="border: 0px;" id="reportType" readonly="readonly" value="${requestScope.reportInfo.reportType }">  
				신고 게시판 글번호 : <input type="text" style="border: 0px;" id="reportNO" readonly="readonly" value="${requestScope.reportInfo.reportNO }">  
				신고한 사람 :  <input type="text" style="border: 0px;" id="memberId" readonly="readonly" value="${requestScope.reportInfo.memberId }">   
			</td>
		</tr>
		<tr>
			<td colspan="1" class="text">
			<textarea rows="10" cols="100" style="border: 0px;" readonly="readonly" id="reportContent"> ${requestScope.reportInfo.reportContent }</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="1" class="text">
				신고 결과 : <input type="text" style="border: 0px;" id="reportResult" value="${requestScope.reportInfo.reportResult }"> 
				신고 취소 이유:<input type="text" style="border: 0px;" id="cancelReason" value=" ${requestScope.reportInfo.reportCancelReason }">
			</td>
		</tr>
	</table>
	<input type="hidden" id="page"	value="${requestScope.page }">
	<div align="center">
	<input type="button" onclick="update()" value="등록">
	<input type="button" onclick="deleteArticle()" value="게시글 삭제">
	<button data-toggle='modal' data-target='#myModal'onclick='location.href="/udongca_project/member/memberInfoMaster.udc?id=${requestScope.reportInfo.reportMemberId }&page=${requestScope.page }"' >id벌점</button>
	<input type="button" onclick='location.href="/udongca_project/master/reportBoard.udc?reportType=${requestScope.reportInfo.reportType }&page=${requestScope.page }"' value="취소">
	</div>
