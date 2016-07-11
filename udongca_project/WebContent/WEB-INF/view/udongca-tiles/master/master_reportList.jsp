<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://use.fontawesome.com/d86bc62528.js"></script>
<script type="text/javascript">
		
		$(document).ready(function(){
			 
			if($("#memberCheck").val()!="master"){
				alert("권한이 없습니다.");
				location.href="/udongca_project/main.udc";
			}
			/* 페이지 시작시 code호출 */
			$.ajax({
				"url":"/udongca_project/master/reportSelect.udc",
				"type":"GET",
				"dataType":"json",
				"success":function(list){
					$.each(list,function(){
						
						$("#selectType").append("<option value="+this.codeId+">"+this.codeName+"</option>");
						
					});
					refresh($("#pnum").text(),$("#selectType").val());
				},
				"error" : function(xhr,status,errorMsg) {
					alert(xhr.status+","+status+","+errorMsg);
				
				}
			});
			
			/* selectType에따른 리스트 출력 */
			$("#search").on("click",function(){
				refresh(1,$("#selectType").val());
			});
			/*close 클릭시 업데이트*/
			$("#close").on("click",function(){
				refresh($("#pnum").text(),$("#selectType").val());
			});
			/* 손가락 클릭시 이벤트처리 */
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
			
			
			/* 회원 벌점 */
			 $("#penalty").on("click",function(){
				 var txt =  $("#cancelReason").val();
					if(!(txt.trim()=="" || txt.length==0)){
						alert("신고취소 이유를 지워주세요");
						return false
						
					}else{
				  $.ajax({
						"url":"/udongca_project/member/memberInfoMaster.udc",
						"type":"post",
						"dataType":"json",
						"data":"id="+$("#reportMemberId").val(),
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
				
			});
		});
		/* 리스트 출력과 페이징처리 */
		function refresh(pnum,reportType){
			$.ajax({
				"url":"/udongca_project/master/reportBoardList.udc",
				"type":"post",
				"dataType":"json",
				"data": {pnum:pnum,reportType:reportType},
				"success":function(obj){
					 var page=obj['page'];
					 var list=obj['list'];
					$("#table").empty();
					
					for(var i=0;i<list.length;i++){
						if(list[i].reportResult==null){
							list[i].reportResult="처리안됨";
						}
						$("#table").append("<tr class='cursor' data-toggle='modal' data-backdrop='static' data-target='#report' id='td2' onclick='link("+list[i].reportboardNo+")'><td>"+list[i].reportboardNo+"</td><td>"+list[i].reportMemberId+"</td><td>"+list[i].reportReason+"</td><td>"+list[i].reportResult+"</td><td>"+list[i].reportType+"</td></tr>");
						
						}
					
					 $("#page").empty();
					 $("#page").append("<ul class='pagination'></ul>")
					 if(page.previousPageGroup){
						 $(".pagination").append("<li><a onclick=refresh("+(page.beginPage-1)+",'"+$("#selectType").val()+"') style='cursor:pointer;'>◀</a></li>");
					 }else{
						 $(".pagination").append("<li><a>◀</a></li>");
					 }
					
					for(var i = page.beginPage;i<=page.endPage;i++){
						if(page.page!=i){
							$(".pagination").append("<li><a onclick=refresh("+i+",'"+$("#selectType").val()+"') style='cursor:pointer;'>"+i+"</a></li>");
						}else{
							$(".pagination").append("<li id='pnum' class='active'><a>"+i+"</a></li>");
						}
					} 
					 if(page.nextPageGroup){
						 $(".pagination").append("<li><a onclick=refresh("+(page.endPage+1)+",'"+$("#selectType").val()+"') style='cursor:pointer;'>▶</a></li>");
					 }else{
						 $(".pagination").append("<li><a>▶</a></li>");
					 }
				},
				"error" : function(xhr,status,errorMsg) {
					alert(xhr.status+","+status+","+errorMsg);
					
				}
			});
			}
		/* 게시글클릭시 게시글 상세보기 정보 출력 */
		  function link(No){
			$.ajax({
				"url":"/udongca_project/master/reportBoardInfo.udc",
				"type":"post",
				"dataType":"json",
				"data": "reportNo="+No,
				"success":function(obj){
					$("#reportboardNo").val(obj.reportInfo.reportboardNo);
					$("#reportMemberId").val(obj.reportInfo.reportMemberId);
					$("#reportReason").val(obj.reportInfo.reportReason);
					$("#reportType").val(obj.reportInfo.reportType);
					$("#reportNO").val(obj.reportInfo.reportNO);
					$("#reportContent").text(obj.reportInfo.reportContent);
					$("#reportResult").val(obj.reportInfo.reportResult);
					$("#cancelReason").val(obj.reportInfo.reportCancelReason);
				},
				"error" : function(xhr,status,errorMsg) {
					alert(xhr.status+","+status+","+errorMsg);
					
				}
			});
		}  
		/* reportBoard Update */
		var success;
		  function ajaxUpdate(){
			  $.ajax({
					"url" : "/udongca_project/master/updateInfo.udc",
					"async":false,
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
								
							},
					"success":function(obj){
						success = obj;
					},
					"error" : function(xhr,status,errorMsg) {
						alert(xhr.status+","+status+","+errorMsg);
					}
				});
		  }
		  /* 취소이유 등록 ajaxUpdate를 통해 update */
		  function update(){
			  var txt = $("#cancelReason").val();
				 if(txt.trim()=="" || txt.length==0){
					 alert("취소이유 등록하세요");
					 return false;
				 }else{
					
						$("#reportResult").val("신고취소");
						 ajaxUpdate();
						if(success.error){
							alert(success.error);
						}else if(success.value==1){
							alert("취소완료");
						}else{
							alert("취소처리실패 ");
						}
				 }
		}
		/* 신고글 삭제 처리 */
		  function deleteArticle(){
			  var txt =  $("#cancelReason").val();
				if(!(txt.trim()=="" || txt.length==0)){
					alert("신고취소 이유를 지워주세요");
					return false
					
				}else{
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
									$("#reportResult").val("신고처리");
									ajaxUpdate();
								}else{
									alert("이미 삭제된 게시글입니다.");
								}
								
							},
							"error" : function(xhr,status,errorMsg) {
								alert(xhr.status+","+status+","+errorMsg);
								
							}
					});
					}
		  }
		/* 회원 로그인 수정 */
		  function submit(){
				var value=0;
				var a = $(".fa");
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
							$("#reportResult").val("신고처리");
							ajaxUpdate();
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

label{
	margin-top:7px;
}
nav{
	line-height: 40px;
}
table{
	border-collapse: collapse;
	width:800px;
	margin-left:30px;
	text-align:center;
}
.nav>li>a{
    padding-left: 0px;
    padding-bottom: 0px;
    padding-top: 0px;
    padding-right: 0px;
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

.fa{
	cursor:pointer;
	font-size:30pt;
}
table, tbody{
	height:30px;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
	margin:30px;
}

select#selectType{
	width:100px;
	float:left;
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
<div id="div">
<input type="hidden" id="memberPenalty">
	<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
	<c:if test="${sessionScope.login.memberType != master}">
		<div style="margin-left: 30px; margin-top: 30px">
			<h3>신고리스트</h3>
			<!-- 신고 테이블 선택 -->
			<div class="form-group">
				<select class="form-control" id="selectType">
				</select>
				<button type="button" class="btn btn-default" id="search">검색</button>
			</div>
		</div>
		<!-- 테이블 -->
		<table class="table table-hover">
			<thead>
				<tr>
					<td style="width: 100px;">No</td>
					<td style="width: 150px;">신고당한사람</td>
					<td style="width: 250px;">신고사유</td>
					<td style="width: 250px;">처리결과</td>
					<td style="width: 100px;">유형</td>
				</tr>
			</thead>
			<tbody id="table">
			</tbody>

		</table>
		<div align="center" id="page" style="margin-top: 30px"></div>
	</c:if>
</div>
<!-- report Modal -->
<div id="report" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title">신고처리</h4>
      </div>
      <div class="modal-body">
        
<form role="form">
  <div class="form-group">
    <label for="reportboardNo">NO</label>
    <input type="text" class="form-control" id="reportboardNo" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="reportId">신고당한 id</label>
    <input type="text" class="form-control" id="reportMemberId" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="reportReason">신고 이유</label>
    <input type="text" class="form-control" id="reportReason" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="reportBoard">신고 게시판</label><br>
   <input type="text" class="form-control" id="reportType" readonly="readonly">
  </div>
	<div class="form-group">
    <label for="reportNO">신고 게시판 글번호</label><br>
   <input type="text" class="form-control" id="reportNO" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="reportContent">content</label><br>
   <textarea rows="10" cols="130" readonly="readonly" id="reportContent" class="form-control"></textarea>
  </div>
  <div class="form-group">
    <label for="reportResult">신고 결과</label><br>
   <input type="text" class="form-control" id="reportResult" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="cancelReason">신고 취소 이유</label><br>
   <input type="text" class="form-control" id="cancelReason">
  </div>
</form>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-success" onclick="update()">신고취소이유 등록</button>
	<button type="button" class="btn btn-success" onclick="deleteArticle()">게시글삭제</button>
	<button class="btn btn-success" data-toggle='modal' data-target='#memberModal' data-backdrop='static' id="penalty">id벌점</button>
        <button type="button" id="close" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
</div>
</div>
<!-- 회원상세정보 모달 -->
 <div id="memberModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content -->
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
   		<i class="fa fa-thumbs-o-down" ></i>
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