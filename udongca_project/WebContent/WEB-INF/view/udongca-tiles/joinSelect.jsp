<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$("input[name='memberType']").on("change",function(){
		var value = $(this).val();
		if(value=="generalMember"){
			$("#a").html("<a href='/udongca_project/generalMemberJoinform.udc'><input type='button' value='회원가입하기'></a>");
		}else{
			$("#a").html("<a href='licenseeMemberJoinform.udc'><input type='button' value='회원가입하기'></a>");
		}
	});
});
</script>
<div class="nonav_bodyDiv" style="width:350px;">
<div><h2>우동카 회원가입</h2></div>
<table>
	<tr align="center">
		<td><h2>일반 회원 가입</h2><br><input type="radio" name="memberType" value="generalMember"></td>
		<td><h2>사업자 회원 가입</h2><br><input type="radio" name="memberType" value="licenseeMember"></td>
	</tr>
	<tr align="center">
		<td id="a" colspan="2"><input type="button" value="회원가입하기"></td>
	</tr>
</table>
</div>