<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
nav{
	line-height: 40px;
}

label{
	margin-top:7px;
}
table{
	border-collapse: collapse;
	width:800px;
	margin:30px;
	text-align:center;
}
.pager li > a,
.pager li > span {
  display: inline-block;
  padding: 5px 14px;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 15px;
}
thead{
	text-align:center;
	width:800px;
	height:40px;
	margin:20px;
	font-size:13pt;
	font-weight:bold;
	cursor:default;
	border-bottom:3px solid;
}


table, tbody{
	height:30px;
}

td{
	border-top:1px dotted;
	border-top-color:black;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}
.nav>li>a{
    padding-left: 0px;
    padding-bottom: 0px;
    padding-top: 0px;
    padding-right: 0px;
}

.modal-footer{
	background-color:#faebd7;
	border-radius:6px;
}
.modal-header{
	background-color:darkgoldenrod;
	border-radius:6px;
}
.modal-title{
	color:white;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		if ($("#memberCheck").val() != "master") {
			alert("권한이 없습니다.");
			location.href = "/udongca_project/main.udc";
		}
		/* 시작시 데이터 불러옴 */
		a($("#pnum").text());
		/* 닫기시 데이터 다시 */
		$("#close").on("click",function(){
			a($("#pnum").text());
		});
	});
	/* 리스트,페이지 출력 답변안달린것만 가져옴  */
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
					$("#table").append("<tr class='cursor' id='td2' data-backdrop='static' data-toggle='modal' data-target='#otoModal' onclick='link("+'"'+this.inquiryNo+'",'+page.page+")'><td>"+this.inquiryNo+"</td><td>"+this.inquiryTitle+"</td><td>"+this.inquiryType+"</td><td>"+this.memberId+"</td></tr>");
					
				});
				
				 $("#page").empty();
				 $("#page").append("<ul class='pagination'></ul>")
				 if(page.previousPageGroup){
					 $(".pagination").append("<li><a onclick=a("+(page.beginPage-1)+") style='cursor:pointer;'>◀</a></li>");
				 }else{
					 $(".pagination").append("<li><a>◀</a></li>");
				 }
				
				for(var i = page.beginPage;i<=page.endPage;i++){
					if(page.page!=i){
						$(".pagination").append("<li><a onclick=a("+i+") style='cursor:pointer;'>"+i+"</a></li>");
					}else{
						$(".pagination").append("<li id='pnum' class='active'><a>"+i+"</a></li>");
					}
				} 
				 if(page.nextPageGroup){
					 $(".pagination").append("<li><a onclick=a("+(page.endPage+1)+") style='cursor:pointer;'>▶</a></li>");
				 }else{
					 $(".pagination").append("<li><a>▶</a></li>");
				 }
			},
			"error" : function(xhr,status,errorMsg) {
				alert(xhr.status+","+status+","+errorMsg);
				
			}
		});
		}
	/* 모달 열면서 서버로부터 데이터 받아오기 */
	 function link(No,pnum){
			$.ajax({
				"url":"/udongca_project/oneToOneInquiry/master/oneInfo.udc",
				"type":"post",
				"dataType":"json",
				"data": {page:pnum,inquiryNo:No},
				"success":function(obj){
					$("#inquiryNo").val(obj.inquiry.inquiryNo);
					$("#inquiryTitle").val(obj.inquiry.inquiryTitle);
					$("#memberId").val(obj.inquiry.memberId);
					$("#inquiryContent").val(obj.inquiry.inquiryContent);
					$("#inquiryReply").val(obj.inquiry.inquiryReply);
				},
				"error" : function(xhr,status,errorMsg) {
					alert(xhr.status+","+status+","+errorMsg);
					
				}
			});
		}  
	 /* 답변등록 클릭시 서버로 데이터 전송  */
	 function requiryReply(){
		var txt = $("#inquiryReply").val(); 
		 if(txt.trim()=="" || txt.length==0){
			 alert("답변을 입력하세요");
			 return false;
		 }else{
			$.ajax({
				"url" : "/udongca_project/oneToOneInquiry/master/requiryReply.udc",
				"type" : "post",
				"data" : {
							inquiryNo : $("#inquiryNo").val(),
							inquiryTitle : $("#inquiryTitle").val(),
							inquiryType	: $("#inquiryType").val(),	
							inquiryContent : $("#inquiryContent").val(),
							inquiryReply : $("#inquiryReply").val(),
							memberId : $("#memberId").val(),
						},
				"success" : function(obj) {
					if(obj.error){
						alert(obj.error);						
					}else if(obj.value==1){
						alert("등록성공");
					}else{
						alert("등록실패");
					}
				},
				"error" : function(xhr,status,errorMsg) {
					alert(xhr.status+","+status+","+errorMsg);
					
				}
		});
		 }
	}
</script>
<div id="div">
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<c:if test="${sessionScope.login.memberType != master}">
<div style="margin-left: 30px; margin-top: 30px">
	<h3>1:1문의관리</h3>
	</div>
	<div class="form-group">
	<table class="table table-hover">
		<thead>
		<tr>
			<td style="width:100px;">NO</td>
			<td style="width:300px;">제목</td>
			<td style="width:300px;">문의유형</td>
			<td style="width:100px;">id</td>
		</tr>
		</thead>
		<tbody id="table">
		
		</tbody>
	</table>
	</div>
	<div align="center" id="page"></div>
</c:if>
</div>
<!-- 1:1Modal -->
<div id="otoModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title">1:1문의</h4>
      </div>
      <div class="modal-body">
        
<form role="form">
  <div class="form-group">
    <label for="inquiryNo">NO</label>
    <input type="text" class="form-control" id="inquiryNo" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="inquiryTitle">Title</label>
    <input type="text" class="form-control" id="inquiryTitle" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="memberId">memberId</label>
    <input type="text" class="form-control" id="memberId" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="content">content</label><br>
  <textarea rows="10" cols="130" class="form-control" id="inquiryContent" readonly="readonly"></textarea>
  </div>
	<div class="form-group">
    <label for="reportNO">답변</label><br>
   <textarea rows="15" cols="130" class="form-control" id="inquiryReply" placeholder="답변을 입력하세요"></textarea>
  </div>
 
</form>
      </div>
      <div class="modal-footer">
      <button class="btn btn-success" onclick="requiryReply()">답변등록</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="close">Close</button>
      </div>
    </div>
</div>
</div>

