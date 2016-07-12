<%@ page contentType="text/html;charset=utf-8"%>
<script src="https://use.fontawesome.com/d86bc62528.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$
								.ajax({
									'url' : '/udongca_project/member/member_myPage_loading.udc',
									'type' : 'post',
									'dataType' : 'json',
									'success' : function(object) {

										if (object.loginError != null) {
											//alert(object.loginError);
											//location.href = "/udongca_project/loginPage.udc";
											//return false;
										}

										//loginInfo
										$(".loginInfo").empty();
										$(".loginInfo")
												.append(
														"<tr style='border-top-style:hidden;'><td>아이디</td><td>"
																+ object.loginInfo.memberId
																+ "</td><tr><td>이름</td><td>"
																+ object.loginInfo.memberName
																+ "</td><tr><td>이메일</td><td>"
																+ object.loginInfo.memberEmail
																+ "</td><tr><td>벌점</td><td id='penalty'></td></tr>");
										var penalty = object.loginInfo.memberPenalty;
										if (penalty != 0) {
											$('#penalty').empty();
											for (var i = 1; i <= 3; i++) {
												if (penalty == 0)
													$('#penalty')
															.append(
																	'<i class="fa fa-thumbs-o-down" style="font-size: 25px;">');
												else {
													$('#penalty')
															.append(
																	'<i class="fa fa-thumbs-down" style="font-size: 25px;">');
													penalty--;
												}
											}
										} else {
											$('#penalty')
													.empty()
													.append(
															'<i class="fa fa-thumbs-o-down" style="font-size: 25px;"></i><i class="fa fa-thumbs-o-down" style="font-size: 25px;"></i><i class="fa fa-thumbs-o-down" style="font-size: 25px;"></i>');
										}

										//신고내역
										if (object.reportError == null) {
											$("#memberReportList").empty();
											for (var idx = 0; idx < object.reportList.length; idx++) {
												$("#memberReportList")
														.append(
																"<tr onclick='memberReportDetail("+object.reportList[idx].reportboardNo+")'><td>"
																		+ object.reportList[idx].myReportNo
																		+ "</td><td>["
																		+ object.reportList[idx].reportType
																		+ "]"
																		+ (object.reportList[idx].reportContent == null ? object.reportList[idx].reportReason
																				: object.reportList[idx].reportContent)
																		+ "</td><td>"
																		+ (object.reportList[idx].reportResult == null ? '처리중'
																				: '처리완료')
																		+ "</td></tr>");
											}
										} else {
											$("#memberReportList")
													.empty()
													.append(
															"<tr><td colspan='3'>"
																	+ object.reportError
																	+ "</td></tr>");
										}

										//1:1문의 내역
										if (object.inquiryList.error == null) {
											$("#memberInquiryList").empty();
											for (var idx = 0; idx < object.inquiryList.list.length; idx++) {
												$("#memberInquiryList")
														.append(
																"<tr class='tr'><td id='"+object.inquiryList.list[idx].inquiryNo+"'>"
																		+ object.inquiryList.list[idx].myInquiryNo
																		+ "</td><td>"
																		+ object.inquiryList.list[idx].inquiryTitle
																		+ "</td><td>["
																		+ object.inquiryList.list[idx].inquiryType
																		+ "]"
																		+ object.inquiryList.list[idx].inquiryContent
																		+ "</td><td>"
																		+ (object.inquiryList.list[idx].inquiryReply == null ? '처리중'
																				: '처리완료')
																		+ "</td></tr>");
											}
										} else {
											$("#memberInquiryList")
													.empty()
													.append(
															"<tr><td colspan='4'>"
																	+ object.inquiryList.error
																	+ "</td></tr>");
										}

									}
								})
					});
</script>
<style type="text/css">
.table {
	border-collapse: collapse;
	width: 800px;
	margin: 30px;
	text-align: center;
}

thead {
	text-align: center;
	width: 800px;
	height: 40px;
	font-size: 13pt;
	font-weight: bold;
	border-bottom: 3px solid;
	cursor: default;
}

table, tbody {
	height: 30px;
}

.cursor{
	text-align:left;
	margin:30px;
	cursor:pointer;
	overflow:hidden;white-space:nowrap;text-overflow:ellipsis;
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
#memberReportList tr:hover,#memberInquiryList tr:hover{text-decoration:underline; color:red;}
</style>
<div class="nav_bodyDiv">
	<div class="panel-group" id="accordion" style="width: 915px">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapse1" style="color: sienna; text-decoration: none;">
						내정보</a>
				</h4>
			</div>
			<div id="collapse1" class="panel-collapse collapse in">
				<div class="panel-body">
					<table class="table table-hover">
						<tbody class="loginInfo">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapse2" style="color: sienna; text-decoration: none;">
						신고 내역</a>
				</h4>
			</div>
			<div id="collapse2" class="panel-collapse collapse">
				<div class="panel-body" align="center">
					<table class="table table-hover">
						<thead>
							<tr id="tr">
								<td style="width: 100px;">No</td>
								<td style="width: 300px;">신고 내역</td>
								<td style="width: 100px;">처리 결과</td>
							</tr>
						</thead>
						<tbody class="tbody" id="memberReportList">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapse3" style="color: sienna; text-decoration: none;">
						1:1문의 내역</a>
				</h4>
			</div>
			<div id="collapse3" class="panel-collapse collapse">
				<div class="panel-body">
					<table style="table-layout: fixed;" class="table table-hover">
						<thead>
							<tr id="tr">
								<td style="width: 100px;">No</td>
								<td style="width: 100px;">문의 제목</td>
								<td style="width: 300px;">문의 내용</td>
								<td style="width: 100px;">처리 결과</td>
							</tr>
						</thead>
						<tbody id="memberInquiryList">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="report_detail" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content" style="width: 500px;">
				<div class="modal-header" align="center">
					<h4>신고 상세 내역</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form class="form-vertical" role="form">
						<div class="form-group">
							<label for="reportTitle" style="width: 100px">제목</label>
							<div class="form-control" style="margin-top: 15px;"
								id="reportTitle"></div>
						</div>
						<div class="form-group">
							<label for="memberId" style="width: 100px">작성자</label>
							<div class="form-control" id="memberId"></div>
						</div>
						<br>
						<div class="form-group">
							<label for="reportReason" style="width: 100px">선택사유</label>
							<div class="form-control" id="reportReason"></div>
						</div>
						<br>
						<div class="form-group">
							<label for="reportResult" style="width: 100px">처리결과</label>
							<div class="form-control" id="reportResult"
								style="height: 200px;"></div>
						</div>
						<br>
						<div align="right">
						<button class="btn btn-default" data-dismiss="modal" style="margin-top: 15px;">닫기</button>
						</div>
					</form>
				</div>

			</div>

		</div>
	</div>
</div>