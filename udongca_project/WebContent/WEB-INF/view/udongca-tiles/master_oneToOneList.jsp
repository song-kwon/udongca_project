<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">
	$(document).ready(function() {
		if ($("#memberCheck").val() != "master") {
			alert("권한이 없습니다.");
			location.href = "/udongca_project/main.udc";
		}
		a($("#pnum").val());
	});
	function a(pnum){
		$.ajax({
			"url":"/udongca_project/oneToOneInquiry/oneList.udc",
			"type":"post",
			"dataType":"json",
			"data":"pnum="+pnum,
			"success":function(obj){
				 var page=obj['page'];
				$("#table").empty();
				
				$.each(obj['list'],function(){
					$("#table").append("<tr class='cursor' id='td2' onclick='link("+'"'+this.inquiryNo+'",'+page.page+")'><td>"+this.inquiryNo+"</td><td>"+this.inquiryTitle+"</td><td>"+this.inquiryType+"</td><td>"+this.memberId+"</td></tr>");
					
				});
				
				 $("#page").empty();
				 if(page.previousPageGroup){
					 $("#page").append("<a onclick=a("+(page.beginPage-1)+") style='cursor:pointer;'>◀</a>&nbsp;&nbsp;");
				 }else{
					 $("#page").append("◀");
				 }
				
				for(var i = page.beginPage;i<=page.endPage;i++){
					if(page.page!=i){
						$("#page").append("<a onclick=a("+i+") style='cursor:pointer;'>"+i+"</a>&nbsp;&nbsp;");
					}else{
						$("#page").append("["+i+"]&nbsp;&nbsp;");
					}
				} 
				 if(page.nextPageGroup){
					 $("#page").append("<a onclick=a("+(page.endPage+1)+") style='cursor:pointer;'>▶</a>&nbsp;&nbsp;");
				 }else{
					 $("#page").append("▶");
				 }
			},
			"error":function(xhr, status, errorMsg){
			alert(xhr+status+errorMsg);
			}
		});
		}
	function link(no,pnum){
		location.href="/udongca_project/oneToOneInquiry/master/oneInfo.udc?page="+pnum+"&inquiryNo="+no;
		
		
	}
</script>
<div id="div">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<input type="hidden" id="pnum" value="${param.pnum }">
<c:if test="${sessionScope.login.memberType != master}">
	<div style="margin:30px"><h1>1:1문의관리</h1></div>
	<table>
		<thead>
		<tr>
			<td style="width:100px;">No</td>
			<td style="width:300px;">제목</td>
			<td style="width:300px;">문의유형</td>
			<td style="width:100px;">작성자</td>
		</tr>
		</thead>
		<tbody id="table">
		
		</tbody>
	</table>
	<div align="center" id="page"></div>
	<!-- 이전페이지그룹 -->
	<%-- <c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }">
			<a
				href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?pnum=${requestScope.pageBean.beginPage-1 }">
				◀ </a>
		</c:when>
		<c:otherwise>
		◀ 	
 	</c:otherwise>
	</c:choose>
	<!-- 숫자 -->
	<c:forEach begin="${requestScope.pageBean.beginPage }"
		end="${requestScope.pageBean.endPage }" var="p">
		<c:choose>
			<c:when test="${p != requestScope.pageBean.page }">
				<a
					href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?pnum=${p }">
					${p } </a>
			&nbsp;&nbsp;
		</c:when>
			<c:otherwise>
			[${p }]&nbsp;&nbsp;
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<!-- 다음페이지그룹 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup }">
			<a
				href="/udongca_project/oneToOneInquiry/master/oneToOneList.udc?pnum=${requestScope.pageBean.endPage+1 }">
				▶ </a>
		</c:when>
		<c:otherwise>
		▶
	</c:otherwise>
	</c:choose> --%>
</c:if>
</div>

