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
				$("#table4").empty();
				 for(var i = 0; i<obj.length;i++){
					 for(var j = 0 ;j<obj[i].length;j++){
						if(i==0){ 
						$("#table1").append("<tr id='tr1' class='cursor' data-backdrop='static' data-toggle='modal' data-target='#oneInquiry' onclick='one("+obj[i][j].inquiryNo+")'><td>"+obj[i][j].inquiryNo+"</td><td>"+obj[i][j].inquiryTitle+"</td><td>"+obj[i][j].inquiryType+"</td><td>"+obj[i][j].memberId+"</td></tr>");
						}else if(i==1){
							if(obj[i][j].reportResult==null){
								obj[i][j].reportResult="처리안됨";
							}
							$("#table2").append("<tr id='tr1' class='cursor' data-toggle='modal' data-backdrop='static' data-target='#report' onclick='report("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}else if(i==2){
							if(obj[i][j].reportResult==null){
								obj[i][j].reportResult="처리안됨";
							}
							$("#table3").append("<tr id='tr1' class='cursor' data-toggle='modal' data-backdrop='static' data-target='#report' onclick='report("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
						}else{
							if(obj[i][j].reportResult==null){
								obj[i][j].reportResult="처리안됨";
							}
							$("#table4").append("<tr id='tr1' class='cursor' data-toggle='modal' data-backdrop='static' data-target='#report' onclick='report("+obj[i][j].reportboardNo+")'><td>"+obj[i][j].reportboardNo+"</td><td>"+obj[i][j].reportMemberId+"</td><td>"+obj[i][j].reportReason+"</td><td>"+obj[i][j].reportResult+"</td></tr>");
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
	var success;
	 function ajaxUpdate(){
		  $.ajax({
				"url" : "/udongca_project/master/updateInfo.udc",
				"type" : "post",
				"async"	: false,
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
	/* 신고취소처리  */
	  function cancel(){
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
	border-bottom:3px solid;
	cursor:default;
	 
}

table, tbody{
	height:30px;
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
.panel-default > .panel-heading{
	background-image:linear-gradient(to bottom, #faebd7 0%, rgba(218, 159, 76, 0.68) 100%);
}
.panel-title>a{
	font-weight: bold;
	font-size:12pt;
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
<!-- 3table -->
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">
<div class="panel-group" id="accordion" style="width:915px">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1" style="color:sienna;text-decoration:none;">
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
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse2" style="color:sienna;text-decoration:none;">
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
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse3" style="color:sienna;text-decoration:none;">
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
	  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse4" style="color:sienna;text-decoration:none;">
        	리플신고</a>
      </h4>
    </div>
		<div id="collapse4" class="panel-collapse collapse">
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
					<tbody id="table4">
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
      <button class="btn btn-success" onclick="requiryReply()">답변등록</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="refresh()" id="close">Close</button>
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
      <button type="button" class="btn btn-success " onclick="cancel()">신고취소이유 등록</button>
	<button type="button" class="btn btn-success" onclick="deleteArticle()">게시글삭제</button>
	<button class="btn btn-success" data-toggle='modal' data-target='#memberModal' data-backdrop='static' id="penalty">id벌점</button>
        <button type="button" id="close" class="btn btn-danger" onclick="refresh()" data-dismiss="modal">Close</button>
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
      <button type="button" class="btn btn-success" onclick="submit()">수정</button>
        <button type="button" id="close" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> 