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

td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
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
				if(!$("#table").hasChildNodes){
					$("table").append("<tr><td>NO</td><td>제목</td><td>문의유형</td><td>id</td></tr>");
				
				}
				$.each(obj['list'],function(){
					$("#table").append("<tr onclick='link("+'"'+this.inquiryNo+'",'+page.page+")'><td>"+this.inquiryNo+"</td><td>"+this.inquiryTitle+"</td><td>"+this.inquiryType+"</td><td>"+this.memberId+"</td></tr>");
					
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
	<div><h1>1:1문의관리</h1></div>
	<table>
		<thead id="thead">
			<tr>
				<td>No</td>
				<td>유형</td>
				<td>문의 제목</td>
				<td>문의 내용</td>
				<td>작성자</td>
			</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach items="${requestScope.list }" var="list">
				<tr id="tr"
					onclick='location.href="/udongca_project/oneToOneInquiry/master/oneInfo.udc?page=${requestScope.pageBean.page}&inquiryNo=${list.inquiryNo }"'>
					<td style="width:30px;">${list.inquiryNo }</td>
					<td style="width:60px;">${list.inquiryType }</td>
					<td style="width:200px;" id="td1" class="cursor">${list.inquiryTitle }</td>
					<td style="width:300px;" id="td2" class="cursor">${list.inquiryContent }</td>
					<td style="width:60px;">${list.memberId }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<div align="center">
	<span id="page"></span>
	<!-- 이전페이지그룹 -->
	<c:choose>
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
	</c:choose>
</div>
</c:if>
</div>
