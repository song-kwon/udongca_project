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
	table-layout:fixed;
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
td#td1:hover{text-decoration:underline; color:red;}
td#td2:hover{text-decoration:underline; color:red;}
</style>
<input type="hidden" value="${requestScope.error }" id="error">
<div id="page" style="width: 700px;">
	<h1>나의 신고 내역</h1>
	<c:choose>
		<c:when test="${empty requestScope.error }">
			<table id="memberReportList" border="1">
				<thead>
					<tr>
						<td style="width:30px;">No</td>
						<td style="width:300px;">신고내역</td>
						<td style="width:60px;">처리결과</td>
					</tr>
				</thead>
				<tbody class="tbody" id="reportList">
					<c:forEach items="${requestScope.reportList.list }" var="list">
						<tr id="tr" onclick="memberReportDetail(${list.reportboardNo})">
							<td class="cursor">${list.myReportNo }</td>
							<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="cursor">[${list.reportType}]${empty list.reportContent ? list.reportReason
																				: list.reportContent}</td>
							<td class="cursor">${empty list.reportResult ? '처리중':'처리됨'}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 이전페이지그룹 -->
			<div style="text-align: center; margin-top: 6px; width:800px;">
				<ul class="pagination">
				<c:choose>
					<c:when
						test="${requestScope.reportList.pageBean.previousPageGroup }">
						<li><a
							href="/udongca_project/member/memberReportListPaging.udc?pnum=${requestScope.reportList.pageBean.beginPage-1 }">
							◀ </a></li>
					</c:when>
					<c:otherwise>
		<li><a href="#">◀</a></li> 	
 	</c:otherwise>
				</c:choose>
				<!-- 숫자 -->
				<c:forEach begin="${requestScope.reportList.pageBean.beginPage }"
					end="${requestScope.reportList.pageBean.endPage }" var="p">
					<c:choose>
						<c:when test="${p != requestScope.reportList.pageBean.page }">
							<li ><a
								href="/udongca_project/member/memberReportListPaging.udc?pnum=${p }">
								${p } </a></li>
						</c:when>
						<c:otherwise>
			<li class="active"><a href="#">${p }</a></li>
		</c:otherwise>
					</c:choose>
				</c:forEach>
				<!-- 다음페이지그룹 -->
				<c:choose>
					<c:when test="${requestScope.reportList.pageBean.nextPageGroup }">
						<li><a
							href="/udongca_project/member/memberReportListPaging.udc?pnum=${requestScope.reportList.pageBean.endPage+1 }">
							▶ </a></li>
					</c:when>
					<c:otherwise>
		<li><a href="#">▶</a></li>
	</c:otherwise>
				</c:choose>
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<h3>
				<font style="color: red;">${requestScope.error }</font>
			</h3>
		</c:otherwise>
	</c:choose>
</div>

<div  class="modal fade" id="report_detail" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content" style="width:500px;">
        <div class="modal-header" align="center">
          <h4>신고 상세 내역</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form class="form-vertical" role="form">
            <div class="form-group" >
              <label for="reportTitle"  style="width:100px">제목</label>
              <div class="form-control" style="margin-top:15px;" id="reportTitle"></div>
            </div>
            <div class="form-group">
              <label for="memberId" style="width:100px">작성자</label>
              <div class="form-control" id="memberId"></div>
            </div><br>
            <div class="form-group">
              <label for="reportReason" style="width:100px">선택사유</label>
              <div class="form-control" id="reportReason"></div>
            </div><br>
            <div class="form-group">
              <label for="reportResult" style="width:100px">처리결과</label>
              <div class="form-control" id="reportResult" style="height:200px;"></div>
            </div><br>
            <div align="right">
				<button class="btn btn-default" data-dismiss="modal" style="margin-top: 15px;">닫기</button>
			</div>
          </form>
        </div>
      
      </div>
      
    </div>
  </div>