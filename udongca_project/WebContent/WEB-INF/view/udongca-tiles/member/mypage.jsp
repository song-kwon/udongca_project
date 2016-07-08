<%@ page contentType="text/html;charset=utf-8" %>
<script src="https://use.fontawesome.com/d86bc62528.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var penalty = Number('${sessionScope.login.memberPenalty}');
	if(penalty != 0){
		$('#penalty').empty();
		for(var i = 1 ; i <=3; i++ ){
			if(penalty == 0)
				$('#penalty').append('<i class="fa fa-thumbs-o-down" style="font-size: 25px;">');
			else{
				$('#penalty').append('<i class="fa fa-thumbs-down" style="font-size: 25px;">');
				penalty--;
			}
		}
	}else{
		$('#penalty').empty().append('<i class="fa fa-thumbs-o-down" style="font-size: 25px;"></i><i class="fa fa-thumbs-o-down" style="font-size: 25px;"></i><i class="fa fa-thumbs-o-down" style="font-size: 25px;"></i>');
	}
});
</script>
<style type="text/css">
table{
	border-collapse: collapse;
	width:500px;
	margin:40px;
	font-size:18px;
}

table, th{
	text-align:left;
	width:300px;
}

</style>

<div class="nav_bodyDiv">
<div><h1>내 정보</h1></div>
<table>
	<tr>
		<th>아이디</th>
		<td>${sessionScope.login.memberId }</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${sessionScope.login.memberName }</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${sessionScope.login.memberEmail }</td>
	</tr>
	<tr>
		<th>내 벌점</th>
		<td id="penalty">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" ><a href="/udongca_project/member/member_verify.udc"><button class="btn btn-default" style="margin-top:6px;">정보수정</button></a>
</table>
</div>