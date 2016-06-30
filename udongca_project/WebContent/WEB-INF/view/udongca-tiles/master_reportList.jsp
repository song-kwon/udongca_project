<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
		
		$(document).ready(function(){
			if($("#memberCheck").val()!="master"){
				alert("권한이 없습니다.");
				location.href="/udongca_project/main.udc";
			}
			$.ajax({
				"url":"/udongca_project/master/reportSelect.udc",
				"type":"GET",
				"dataType":"json",
				"success":function(list){
					$.each(list,function(){
						var id= this.codeId;
						$("#selectType").append("<option id="+id+">"+id+"</option>");
						
					});
					a($("#page").val(),$("#selectType").val());
				}
			});
			
		/* 
			if($("#all").val()==$("#hidden").val()){
				$("#all").prop("selected","selected");
			}
			if($("#review").val()==$("#hidden").val()){
				$("#review").prop("selected","selected");
			}
			if($("#prboard").val()==$("#hidden").val()){
				$("#prboard").prop("selected","selected");
			}  */
			
			
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
				alert("오류발생");
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
	margin-left:30px;
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
<div style="margin-left:30px; margin-top:30px">
<h3>신고리스트</h3> 
<select id="selectType" >
</select>
	<button type="button" id = "search">검색</button>
	
</div>
<table>
	<thead>
		<tr>
		<td style="width:100px;">No</td>
		<td style="width:100px;">신고자</td>
		<td style="width:250px;">신고사유</td>
		<td style="width:250px;">처리결과</td>
		<td style="width:100px;">유형</td>
		</tr>
	</thead>
	<tbody id = "table">
	</tbody>

</table>
<div align="center" id = "page" style="margin-top:30px"></div>
</c:if>
</div>
