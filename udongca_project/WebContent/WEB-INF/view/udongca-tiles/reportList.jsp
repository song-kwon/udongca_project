<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <script type="text/javascript">
$(document).ready(function(){
		$.ajax({
			"url" : "/udongca_project/master/reportBoardList.udc",
			"type" : "post",
			"data" : {reportType : $("#review").val(), page:$("#page").text()},
			"dataType" : "json",
			"success" : function(obj) {
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
		$("#page2").on("click",function(){
			$.ajax({
				"url" : "/udongca_project/master/reportBoardList.udc",
				"type" : "post",
				"data" : {reportType : $("#review").val(), page : $("#page2").text()},
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
		
	//$.post("/udongca_project/master/reportBoard.udc");
}); 
</script> -->
<script type="text/javascript">
		
		$(document).ready(function(){
			if($("#r").val()==$("#hidden").val()){
				$("#r").prop("selected","selected");
			}
			if($("#p").val()==$("#hidden").val()){
				$("#p").prop("selected","selected");
			}
			$("#go").on("click",function(){
				var url = $("#type").val();
				$("#form").prop("action","/udongca_project/master/reportBoard.udc?reportType="+url);
			
			});
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
<h3 id="head">${requestScope.reportType}신고리스트</h3> 
<input type="hidden" id="hidden" value="${requestScope.reportType}">
<form id="form" method="post">
<select id="type" >
	<option id="r">review</option>
	<option id="p">prboard</option>
</select>
<input id="go" type="submit" value="검색">
</form>
<table id = "table" border="1">
	<tr>
	<td>NO</td>
	<td>ID</td>
	<td>REASON</td>
	<td>RESULT</td>
	<td>TYPE</td>
	</tr>
	<c:forEach items="${requestScope.list.list }" var="list">
	<tr onclick='location.href="/udongca_project/master/reportBoardInfo.udc?reportNo=${list.reportboardNo}&page=${requestScope.list.pageBean.page }"'>
		<td>${list.reportboardNo}</td>
		<td>${list.reportMemberId }</td>
		<td>${list.reportReason }</td>
		<td>${list.reportResult }</td>
		<td>${list.reportType }</td>
	<tr>
	</c:forEach>

</table>
<!-- 이전페이지그룹 -->
<c:choose>
 	<c:when test="${requestScope.list.pageBean.previousPageGroup }">
 		<a href="/udongca_project/master/reportBoard.udc?reportType=${requestScope.reportType}&pnum=${requestScope.list.pageBean.beginPage-1 }">
 			◀
 		</a>	
 	</c:when>
 	<c:otherwise>
		◀ 	
 	</c:otherwise>
 </c:choose>
<!-- 숫자 -->
<c:forEach begin="${requestScope.list.pageBean.beginPage }" end="${requestScope.list.pageBean.endPage }"
			   var="p">
	<c:choose>
		<c:when test="${p != requestScope.list.pageBean.page }">
				<a href="/udongca_project/master/reportBoard.udc?reportType=${requestScope.reportType}&pnum=${p }">
				${p }
			</a>
			&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			<span id = "page">${p }</span>&nbsp;&nbsp;
		</c:otherwise>
	</c:choose>
</c:forEach>	
<!-- 다음페이지그룹 -->
<c:choose>
	<c:when test="${requestScope.list.pageBean.nextPageGroup }">
		<a href="/udongca_project/master/reportBoard.udc?reportType=${requestScope.reportType}&pnum=${requestScope.list.pageBean.endPage+1 }">
			▶			
		</a>
	</c:when>
	<c:otherwise>
		▶
	</c:otherwise>
</c:choose>

</div>