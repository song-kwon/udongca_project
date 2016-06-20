<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#memberType").on("change",function(){
		var value = $("#memberType").val();
		if(value=="generalMember"){
			a.html("<a href='member/generalMemberJoin'><input type='button' value='회원가입하기'></a>");
		}else{
			a.html("<a href='member/licenseeMemberJoin'><input type='button' value='회원가입하기'></a>");
		}
	});
});
</script>
<div style="background-color: aqua; margin-left: 25%;"><h2>우동카 회원가입</h2></div>
<table>
	<tr align="center">
		<td><h2>일반 회원 가입</h2><br><input type="radio" id="memberType" value="generalMember"></td>
		<td><h2>사업자 회원 가입</h2><br><input type="radio" id="memberType" value="licenseeMember"></td>
	</tr>
	<tr align="center">
		<td id="a"><input type="button" value="회원가입하기"></td>
	</tr>
</table>
