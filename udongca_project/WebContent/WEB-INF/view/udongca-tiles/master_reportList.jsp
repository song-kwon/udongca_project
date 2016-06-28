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
			if($("#memberCheck").val()!="master"){
				alert("권한이 없습니다.");
				location.href="/udongca_project/main.udc";
			}
			if($("#a").val()==$("#hidden").val()){
				$("#a").prop("selected","selected");
			}
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
table{
	border-collapse: collapse;
	border-top:2px solid;
	border-bottom:2px solid;
	width:800px;
	margin:30px;
	text-align:center;
}

thead{
	text-align:center;
	width:400px;
	height:40px;
	margin:20px;
	font-size:13pt;
	font-weight:bold;
	cursor:default;
	border-bottom:1.5px solid;
}


table, tbody{
	height:30px;
	font-size:12pt;
}

tr#tr, td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}

tr#tr>td:hover{text-decoration:underline; color:red;}
</style>

<div id="div">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<c:if test="${sessionScope.login.memberType != master}">
<h1 id="head">${requestScope.reportType} 신고리스트</h1> 
<input type="hidden" id="hidden" value="${requestScope.reportType}">
<form id="form" method="post">
<br>신고 유형 별 검색 : <select id="type" >
	<option id="a">all</option>
	<option id="r">review</option>
	<option id="p">prboard</option>
</select>
&nbsp;<input id="go" type="submit" value="검색">
</form>
<table>
	<thead>
	<tr>
	<td>No</td>
	<td>유형</td>
	<td>신고자</td>
	<td>신고사유</td>
	<td>처리결과</td>
	</tr>
	</thead>
	
	<tbody>
	<c:forEach items="${requestScope.list.list }" var="list">
	<tr id="tr" onclick='location.href="/udongca_project/master/reportBoardInfo.udc?reportNo=${list.reportboardNo}&page=${requestScope.list.pageBean.page }"'>
		<td style="width:30px;">${list.reportboardNo}</td>
		<td style="width:60px;">${list.reportType }</td>
		<td style="width:60px;">${list.reportMemberId }</td>
		<td style="width:300px;" class="cursor">${list.reportReason }</td>
		<td style="width:60px;">${list.reportResult }</td>
	<tr>
	</c:forEach>
	</tbody>
</table>

<div align="center">
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
</c:if>
</div>