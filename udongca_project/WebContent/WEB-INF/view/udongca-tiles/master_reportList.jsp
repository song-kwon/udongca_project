<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			a($("#page").val(),$("#selectType").val());
			$("#search").on("click",function(){
				a(1,$("#selectType").val());
			});
		});
		function a(pnum,reportType){
			$.ajax({
				"url":"/udongca_project/master/reportBoardList.udc",
				"type":"post",
				"dataType":"json",
				"data": {pnum:pnum,reportType:reportType},
				"success":function(obj){
					 var page=obj['page'];
					$("#table").empty();
					$.each(obj['list'],function(){
						$("#table").append("<tr class='cursor' id='td2' onclick='link("+'"'+this.reportboardNo+'",'+page.page+")'><td>"+this.reportboardNo+"</td><td>"+this.reportMemberId+"</td><td>"+this.reportReason+"</td><td>"+this.reportResult+"</td><td>"+this.reportType+"</td></tr>");
						
					});
					
					 $("#page").empty();
					 if(page.previousPageGroup){
						 $("#page").append("<a onclick=a("+(page.beginPage-1)+",'"+$("#selectType").val()+"') style='cursor:pointer;'>◀</a>&nbsp;&nbsp;");
					 }else{
						 $("#page").append("◀");
					 }
					
					for(var i = page.beginPage;i<=page.endPage;i++){
						if(page.page!=i){
							$("#page").append("<a onclick=a("+i+",'"+$("#selectType").val()+"') style='cursor:pointer;'>"+i+"</a>&nbsp;&nbsp;");
						}else{
							$("#page").append("["+i+"]&nbsp;&nbsp;");
						}
					} 
					 if(page.nextPageGroup){
						 $("#page").append("<a onclick=a("+(page.endPage+1)+",'"+$("#selectType").val()+"') style='cursor:pointer;'>▶</a>&nbsp;&nbsp;");
					 }else{
						 $("#page").append("▶");
					 }
				},
				"error":function(xhr, status, errorMsg){
				alert(xhr+status+errorMsg);
				}
			});
			}
		function link(No,pnum){
			location.href="/udongca_project/master/reportBoardInfo.udc?reportNo="+No+"&page="+pnum;
			
			
		}
		
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
	width:800px;
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

td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}

tr#td2:hover{text-decoration:underline; color:red;}
</style>
<div id="div">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<c:if test="${sessionScope.login.memberType != master}">
<div style="margin:30px">
<h3>신고리스트</h3> 
<select id="selectType" >
	<option id="a">all</option>
	<option id="r">review</option>
	<option id="p">prboard</option>
	</select>
	<button type="button" id = "search">검색</button>
	
</div>
<table>

<thead>
	
	<tr>
	<td style="width:100px;">NO</td>
	<td style="width:100px;">ID</td>
	<td style="width:250px;">REASON</td>
	<td style="width:250px;">RESULT</td>
	<td style="width:100px;">TYPE</td>
	</tr>
	</thead>
	<tbody id = "table">
	</tbody>
	<%-- <c:forEach items="${requestScope.list.list }" var="list">
	<tr onclick='location.href="/udongca_project/master/reportBoardInfo.udc?reportNo=${list.reportboardNo}&page=${requestScope.list.pageBean.page }"'>
		<td>${list.reportboardNo}</td>
		<td>${list.reportMemberId }</td>
		<td>${list.reportReason }</td>
		<td>${list.reportResult }</td>
		<td>${list.reportType }</td>
	<tr>
	</c:forEach> --%>

</table>
<div align="center" id = "page"></div>
<!-- 이전페이지그룹 -->
<%-- <c:choose>
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
</c:choose> --%>
</c:if>
</div>
