<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://use.fontawesome.com/d86bc62528.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
	$(".btn").on("click",function(){
		listAndPage($("#pnum").val());
	});
	listAndPage($("#pnum").val());
	$('.fa').on('click',function(){
		 var $this = $(this); 
		 if($this.hasClass("fa-thumbs-down")){
			 $this.removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down");
		 }else if($this.hasClass("fa-thumbs-o-down")){
			 $this.removeClass("fa-thumbs-o-down").addClass("fa-thumbs-down");
		 }
		
		 $this.nextAll().removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down");
		 $this.prevAll().removeClass("fa-thumbs-o-down").addClass("fa-thumbs-down"); 
		});
});
function link(id){
	$.ajax({
		"url":"/udongca_project/member/memberInfoMaster.udc",
		"type":"post",
		"dataType":"json",
		"data":"id="+id,
		"success":function(obj){
			$("#loginPossibility").empty();
			$.each(obj.code,function(){
				$("#loginPossibility").append("<option id='"+this.codeId+"' value='"+this.codeId+"'>"+this.codeName+"</option>")
			});
			$("#memberId").val(obj.memberInfo.memberId);
			$("#memberName").val(obj.memberInfo.memberName);
			$("#memberEmail").val(obj.memberInfo.memberEmail);
			$("#memberPenalty").val(obj.memberInfo.memberPenalty);
			$("#loginPossibility").val(obj.memberInfo.loginPossibility);
			$(".fa").removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down");
			for(var i =0; i<$("#memberPenalty").val();i++){
				$(".fa")[i].className = "fa fa-thumbs-down";
			}
			 if($("#loginPossibility").val()=='possible'){
				$("#possible").attr("selected","selected");
			}else if($("#loginPossibility").val()=='impossible'){
				$("#impossible").attr("selected","selected");
			} 
			
		},
		"error" : function(xhr,status,errorMsg) {
			alert(xhr.status+","+status+","+errorMsg);
			
		}
	});
}
 function listAndPage(pnum){
	 $("#pnum").val(pnum);
	$.ajax({
		"url":"/udongca_project/member/memberList.udc",
		"type":"post",
		"dataType":"json",
		"data":"pnum="+pnum,
		"success":function(obj){
			 var page=obj['page'];
			$("#table").empty();
			$.each(obj['list'],function(){
				
				 $("#table").append("<tr class='cursor' data-toggle='modal' data-backdrop='static' data-target='#myModal' id='td2' onclick='link("+'"'+this.memberId+'"'+")'><td>"+this.memberId+"</td><td >"+this.memberName+"</td><td>"+this.memberEmail+"</td><td>"+this.memberPenalty+"</td><td>"+this.loginPossibility+"</td></tr>");
			});
			
			$("#page").empty();
			 $("#page").append("<ul class='pagination'></ul>")
			 if(page.previousPageGroup){
				 $(".pagination").append("<li><a onclick=listAndPage("+(page.beginPage-1)+") style='cursor:pointer;'>◀</a></li>");
			 }else{
				 $(".pagination").append("<li><a>◀</a></li>");
			 }
			
			for(var i = page.beginPage;i<=page.endPage;i++){
				
				if(page.page!=i){
					$(".pagination").append("<li><a onclick=listAndPage("+i+") style='cursor:pointer;'>"+i+"</a></li>");
				}else{
					$(".pagination").append("<li class='active'><a>"+i+"</a></li>");
				}
			} 
			 if(page.nextPageGroup){
				 $(".pagination").append("<li><a onclick=listAndPage("+(page.endPage+1)+") style='cursor:pointer;'>▶</a></li>");
			 }else{
				 $(".pagination").append("<li><a>▶</a></li>");
			 }
		},
		"error" : function(xhr,status,errorMsg) {
			alert(xhr.status+","+status+","+errorMsg);
			
		}
	});
	
}
 function submit(){
		var value=0;
		 for(var i =0;i<$(".fa").length;i++){
			if($(".fa")[i].className=="fa fa-thumbs-down"){
				value++;
			}
		} 
			if(value>=3 && $("#loginPossibility").val()=="possible"){
				alert("벌점3점이상 로그인 불가");
				$("#loginPossibility").val("impossible");
				return false;
			}
			if(value<3 && $("#loginPossibility").val()=="impossible"){
				$("#loginPossibility").val("possible");
			}
		$.ajax({
			"url" : "/udongca_project/member/memberUpdate.udc",
			"type" : "post",
			"data" : {
						memberId : $("#memberId").val(),
						memberName : $("#memberName").val(),
						memberEmail	: $("#memberEmail").val(),	
						memberPenalty : value,
						loginPossibility : $("#loginPossibility").val(),
					},
			"success" : function(obj) {
				if(obj=="true"){
					alert("등록성공");
					
					
				}else{
					alert("등록실패");
				}
			},
			"beforeSend" : function(){
				var result = confirm("수정하시겠습니까?");
				if(result==true)
					return true;
				else
					return false;
			},
			"error" : function(xhr,status,errorMsg) {
				alert(xhr.status+","+status+","+errorMsg);
				
			}
		});
	}
</script> 
<style type="text/css">
nav{
	line-height: 40px;
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
label{
	margin-top:7px;
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
.modal-footer{
	background-color:#faebd7;
	border-radius:6px;
}
.modal-header{
	background-color:darkgoldenrod;
	border-radius:6px;
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
.fa{
	cursor:pointer;
	font-size:30pt;
}
.pagination > .active > a,
.pagination > .active > a:hover{
	background-color:#6b4004;
}
.pagination > li > a{
	color:#a2522d;
}
.pagination > li > a:hover{
	color:#6b4004;
}
.modal-title{
	color:white;
}
</style>


<div id="p">
<input type="hidden" id="pnum" >
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<input type="hidden" id="memberPenalty">
<c:if test="${sessionScope.login.memberType == 'master'}">
<h3 style="margin:30px;">회원리스트</h3> 
<table class="table table-hover">
<thead>
	<tr>
		<td style="width: 160px;">아이디</td>
		<td style="width: 160px;">이름</td>
		<td style="width: 160px;">이메일</td>
		<td style="width: 160px;">페널티</td>
		<td style="width: 160px;">로그인허용</td>
	</tr>
</thead>
<tbody id = "table" >

</tbody>
</table>
</c:if>
</div>
<div id="page" align="center"></div>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title">회원정보관리</h4>
      </div>
      <div class="modal-body">
        
<form role="form">
  <div class="form-group">
    <label for="id">아이디</label>
    <input type="text" class="form-control" id="memberId" readonly="readonly" >
  </div>
  <div class="form-group">
    <label for="name">이름</label>
    <input type="text" class="form-control" id="memberName" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="email">이메일</label>
    <input type="text" class="form-control" id="memberEmail" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="penalty">벌점</label><br>
    <span>
   		<i class="fa fa-thumbs-o-down"></i>
		<i class="fa fa-thumbs-o-down" ></i>
		<i class="fa fa-thumbs-o-down" ></i>
		</span>
  </div>
	<div class="form-group">
		<label for="select">로그인 가능여부</label>
		<select id="loginPossibility" class="form-control">
		</select>
	</div>
</form>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-success" onclick="submit()">수정</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>