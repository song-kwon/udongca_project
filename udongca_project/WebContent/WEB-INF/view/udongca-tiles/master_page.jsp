<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			"url":"",
			"type":"post",
			"dataType":"json",
			"success":function(obj){
				var txt = obj.inquiryNo;
				alert(txt);
			},
		"error":function(xhr, status, errorMsg){
			alert(xhr+status+errorMsg);
		}
		});
	});
</script>
<body></body>
<h3>1:1문의</h3>

<h3>리뷰신고</h3>
<h3>홍보글신고</h3>