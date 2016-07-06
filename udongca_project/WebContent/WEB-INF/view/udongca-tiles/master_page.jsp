<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://use.fontawesome.com/d86bc62528.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if ($("#memberCheck").val() != "master") {
			alert("권한이 없습니다.");
			location.href = "/udongca_project/main.udc";
		}
		/* 첫 조회  */
		refresh();
		
		/* 클릭시 thumbs-down기능 */
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
	
		/* 회원 벌점주기 */
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
						/* memberPenalty 값에 따라 검정 thumbs로 바뀜  */
						$(".fa").removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down");
						for(var i =0; i<$("#memberPenalty").val();i++){
							$(".fa")[i].className = "fa fa-thumbs-down";
						}
						/* loginPossibility값에 따라 선택*/
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
	/* 리스트들을 각 테이블에 뿌림 */
	function refresh(){
		$.ajax({
			"url":"/udongca_project/master/masterPage.udc",
			"type":"post",
			"dataType":"json",
			"success":function(obj){
				$("#table1").empty();
				$("#table2").empty();
				$("#table3").empty();
				 for(var i = 0; i<obj.length;i++){
					 for(var j = 0 ;j<obj[i].length;j++){
						if(i==0){ 
						$("#table1").append("<tr id='tr1' class='cursor' data-backdrop='static' data-toggle='modal' data-target='#oneInquiry' onclick='one("+obj[i][j].inquiryNo+")'><td>"+obj[i][j].inquiryNo+"</td><td>"+obj[i][j].inquiryTitle+"</td><td>"+obj[i][j].inquiryType+"</td><td>"+obj[i][j].memberId+"</td></tr>");
						}else if(i==1){
							$("#table2").append("<tr id='tr1' class='cursor' data-toggle='modal' data-backdrop='static' data-target='#report' onclick='report("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}else{
							$("#table3").append("<tr id='tr1' class='cursor' data-toggle='modal' data-backdrop='static' data-target='#report' onclick='report("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}
					 }
				 } 
			},
			"error" : function(xhr,status,errorMsg) {
				alert(xhr.status+","+status+","+errorMsg);
				
			}
		});
	}
	/* 1:1상세 조회 */
	function one(No){
		$.ajax({
			"url":"/udongca_project/oneToOneInquiry/master/oneInfo.udc",
			"type":"post",
			"dataType":"json",
			"data": {page:1,inquiryNo:No},
			"success":function(obj){
				$("#inquiryNo").val(obj.inquiry.inquiryNo);
				$("#inquiryTitle").val(obj.inquiry.inquiryTitle);
				$("#oneMemberId").val(obj.inquiry.memberId);
				$("#inquiryContent").val(obj.inquiry.inquiryContent);
				$("#inquiryReply").val(obj.inquiry.inquiryReply);
			},
			"error" : function(xhr,status,errorMsg) {
				alert(xhr.status+","+status+","+errorMsg);
				
			}
		});
	}
	/* 1:1답변  */
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
								memberId : $("#oneMemberId").val(),
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
	/* 신고글 상세 조회 */
	function report(No){
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
	/* reportBoard update */
	 function ajaxUpdate(){
		  $.ajax({
				"url" : "/udongca_project/master/updateInfo.udc",
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
					return obj;
				},
				"error" : function(xhr,status,errorMsg) {
					alert(xhr.status+","+status+","+errorMsg);
					
				}
				
			});
	  }
	/* 신고취소처리  */
	  function cancel(){
		  var txt = $("#cancelReason").val();
			 if(txt.trim()=="" || txt.length==0){
				 alert("취소이유 등록하세요");
				 return false;
			 }else{
					$("#reportResult").val("신고취소");
					var obj = ajaxUpdate();
					if(obj.error){
						alert(obj.error);
					}else if(obj.value==1){
						alert("취소완료");
					}else{
						alert("취소처리실패 ");
					}
					
			 }
	}
	/* 신고당한 게시글 삭제 */
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
								$("#reportResult").val("게시글 삭제");
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
	/* 회원 정보 수정 */
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
						$("#reportResult").val("벌점 부과");
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
nav{
	line-height: 40px;
}
.table{
	border-collapse: collapse;
	width:800px;
	margin:30px;
	text-align:center;
}

thead{
	text-align:center;
	width:800px;
	height:40px;
	font-size:13pt;
	font-weight:bold;
	border-bottom:2px solid;
	cursor:default;
	 
}

table, tbody{
	height:30px;
}
.modal-body>form{
	height:750px;

}
label{
	margin-top:7px;
}

.cursor{
	cursor:pointer;
	table-layout:fixed;
}
h2{
	margin-left:30px;
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
.loading {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translateY(-50%);
	height: 25px;
	width: 10px;
	border-radius: 10%;
	background: $bg-light;
	border-top-color: $fg;
	animation: fade2 1s infinite;
	transition: background .2s;
	&:after,
	&:before {
		content: '';
		position: absolute;
		display: block;
		height: 20px;
		width: 10px;
		background: $bg-light;
		top: 50%;
		transform: translateY(-50%);
		left: -15px;
		border-radius: 10%;
		animation: fade1 1s infinite;
		transition: background .2s;
	}
	&:before {
		left: 15px;
		animation: fade3 1s infinite;
	}
}

@keyframes fade1 {
	0% {
		background: $fg;
	}
}

@keyframes fade2 {
	33% {
		background: $fg;
	}
}

@keyframes fade3 {
	66% {
		background: $fg;
	}
}
</style>
<!-- 3table -->
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<div class="panel-group" id="accordion" style="width:915px">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
       1:1문의</a>
      </h4>
    </div>
		<div id="collapse1" class="panel-collapse collapse in">
			<div class="panel-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<td style="width: 50px;">No</td>
							<td style="width: 200px;">제목</td>
							<td style="width: 300px;">문의유형</td>
							<td style="width: 100px;">작성자</td>
						</tr>
					</thead>
					<tbody id="table1">
					</tbody>
				</table>
			</div>
		</div>
	</div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
        리뷰 신고</a>
      </h4>
    </div>
		<div id="collapse2" class="panel-collapse collapse">
			<div class="panel-body" align="center">
				<table class="table table-hover">
					<thead>
						<tr id="tr">
							<td style="width: 100px;">No</td>
							<td style="width: 100px;">신고자</td>
							<td style="width: 300px;">신고사유</td>
							<td style="width: 100px;">처리결과</td>
						</tr>
					</thead>
					<tbody id="table2">
					</tbody>
				</table>
			</div>
		</div>
	</div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
        	홍보글신고</a>
      </h4>
    </div>
		<div id="collapse3" class="panel-collapse collapse">
			<div class="panel-body">
				<table style="table-layout: fixed;" class="table table-hover">
					<thead>
						<tr id="tr">
							<td style="width: 100px;">No</td>
							<td style="width: 100px;">신고자</td>
							<td style="width: 300px;">신고사유</td>
							<td style="width: 100px;">처리결과</td>
						</tr>
					</thead>
					<tbody id="table3">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- onetoOneInquiry Modal -->
<div id="oneInquiry" class="modal fade" role="dialog">
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
    <input type="text" class="form-control" id="oneMemberId" readonly="readonly">
  </div>
 <div class="form-group">
    <label for="content">content</label><br>
  <textarea rows="10" cols="130" class="form-control" id="inquiryContent" readonly="readonly"></textarea>
  </div>
	<div class="form-group">
    <label for="reportNO">답변</label><br>
   <textarea rows="10" cols="130" class="form-control" id="inquiryReply" placeholder="답변을 입력하세요"></textarea>
  </div>
 
</form>
      </div>
      <div class="modal-footer">
      <button class="btn btn-default" onclick="requiryReply()">답변등록</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="refresh()" id="close">Close</button>
      </div>
    </div>
</div>
</div>
<!-- reportBoard Modal -->
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
      <button type="button" class="btn btn-default" onclick="cancel()">신고취소이유 등록</button>
	<button type="button" class="btn btn-default" onclick="deleteArticle()">게시글삭제</button>
	<button class="btn btn-default" data-toggle='modal' data-target='#memberModal' data-backdrop='static' id="penalty">id벌점</button>
        <button type="button" id="close" class="btn btn-default" onclick="refresh()" data-dismiss="modal">Close</button>
      </div>
    </div>
</div>
</div>
<!-- 회원상세정보 모달 -->
<div id="memberModal" class="modal fade" role="dialog">
<div class="loading"></div>
  <div class="modal-dialog">

    <!-- Modal content -->
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title">회원정보관리</h4>
      </div>
      <div class="modal-body">
        
<form role="form" style="height:351px;">
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
    <input type="hidden" id="memberPenalty">
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
      <button type="button" class="btn btn-default" onclick="submit()">수정</button>
        <button type="button" id="close" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> 