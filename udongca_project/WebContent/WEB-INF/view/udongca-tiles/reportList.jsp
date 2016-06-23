<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
 /* window.onload=function(){ "/udongca_project/master/reportBoard.udc"	}  */
$(document).ready(function(){
		$.ajax({
			"url" : "/udongca_project/master/reportBoardList.udc",
			"type" : "post",
			"data" : {reportType : $("#review").val(), page:$("#page").text()},
			"dataType" : "json",
			"success" : function(obj) {
				
				if($("#table").hasChildNodes){
					$("table").append("<tr><td>NO</td><td>ID</td><td>REASON</td><td>RESULT</td></tr>");
					
				}
				for(var i =0;i<obj.length;i++){
				$("#table").append("<tr><td>"+obj[i].reportboardNo+"</td><td>"+obj[i].reportMemberId+"</td><td>"+obj[i].reportReason+"</td><td>"+obj[i].reportResult+"</td></tr>");
				}
			},
			"error" : function(aa,bb,cc) {
				alert(aa,bb,cc);
			}
	});
		$("#review").on("change",function(){
			$.ajax({
				"url" : "/udongca_project/master/reportBoardList.udc",
				"type" : "post",
				"data" : {reportType : $("#review").val(), page:$("#page").text()},
				"dataType" : "json",
				"success" : function(obj) {
					$("#table").empty();
					if(!$("#table").hasChildNodes){
						$("table").append("<tr><td>NO</td><td>ID</td><td>REASON</td><td>RESULT</td></tr>");
						
					}
					for(var i =0;i<obj.length;i++){
					$("#table").append("<tr><td>"+obj[i].reportboardNo+"</td><td>"+obj[i].reportMemberId+"</td><td>"+obj[i].reportReason+"</td><td>"+obj[i].reportResult+"</td></tr>");
					}
				},
				"error" : function(aa,bb,cc) {
					alert(aa,bb,cc);
				}
		});
		});
		$("a").on("click",function(){
			$.ajax({
				"url" : "/udongca_project/master/reportBoardList.udc",
				"type" : "post",
				"data" : {reportType : $("#review").val(), page : $("#page").text()},
				"dataType" : "json",
				"success" : function(obj) {
					$("#table").empty();
					if(!$("#table").hasChildNodes){
						$("table").append("<tr><td>NO</td><td>ID</td><td>REASON</td><td>RESULT</td></tr>");
						
					}
					for(var i =0;i<obj.length;i++){
					$("#table").append("<tr><td>"+obj[i].reportboardNo+"</td><td>"+obj[i].reportMemberId+"</td><td>"+obj[i].reportReason+"</td><td>"+obj[i].reportResult+"</td></tr>");
					}
				},
				"error" : function(aa,bb,cc) {
					alert(aa,bb,cc);
				}
		});
			
		});
	$.post("/udongca_project/master/reportBoard.udc");
}); 
</script>
<style type="text/css">
table, td, th{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width: 700px;
}
td,th{
	padding: 5px;
}
</style>
<div id="div">
<h3>신고리스트</h3> 
<select id="review" onchange="">
	<option selected="selected">review</option>
	<option>prboard</option>
</select>
<table id = "table" border="1"><tr><td>NO</td><td>ID</td><td>REASON</td><td>RESULT</td></tr></table>
<!-- 이전페이지그룹 -->
<c:choose>
 	<c:when test="${requestScope.pageBean.previousPageGroup }">
 		<a href="/udongca_project/master/reportBoardList.udc?pnum=${requestScope.pageBean.beginPage-1 }">
 			◀
 		</a>	
 	</c:when>
 	<c:otherwise>
		◀ 	
 	</c:otherwise>
 </c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.pageBean.beginPage }" end="${requestScope.pageBean.endPage }"
			   var="p">
	<c:choose>
		<c:when test="${p != requestScope.pageBean.page }">
			<a href="/udongca_project/master/reportBoard.udc?pnum=${p }">
				${p }
			</a>
			&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			[<span id="page">${p }</span>]&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>
</c:forEach>	
<!-- 다음페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.pageBean.nextPageGroup }">
		<a href="/udongca_project/master/reportBoardList.udc?pnum=${requestScope.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>

</div>