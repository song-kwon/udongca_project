<%@ page contentType = "text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="https://use.fontawesome.com/d86bc62528.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#memberCheck").val()!="master"){
		alert("권한이 없습니다.");
		location.href="/udongca_project/main.udc";
	}
	for(var i =0; i<document.submit.memberPenalty.value;i++){
		$(".fa")[i].className = "fa fa-thumbs-down";
	}
	
	$('.fa').on('click',function(){
		 var $this = $(this); 
		 if($this.hasClass("fa-thumbs-down")){
			 
			 if($this.next().hasClass("fa-thumbs-down")){
				 $this.removeClass("fa-thumbs-o-down").addClass("fa-thumbs-down");
			 }else{
			 $this.removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down");
			 }
		 }else if($this.hasClass("fa-thumbs-o-down")){
			 $this.removeClass("fa-thumbs-o-down").addClass("fa-thumbs-down");
		 }
		 
		 $this.nextAll().removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down");
		 $this.prevAll().removeClass("fa-thumbs-o-down").addClass("fa-thumbs-down");
		});
});
function checkPenalty(){
	var value=0;
	 for(var i =0;i<$(".fa").length;i++){
		if($(".fa")[i].className=="fa fa-thumbs-down"){
			value++;
		}
	} 
	 
	 var form=document.submit
	 form.memberPenalty.value=value;
	if(value>=3 && form.loginPossibility.value=="possible"){
		alert("벌점3점이상 로그인 불가");
		form.loginPossibility.value="impossible";
		return false;
	}
	if(value<3 && form.loginPossibility.value=="impossible"){
		form.loginPossibility.value="possible";
	}
}

</script> 
<style>
.fa{
  font-size:30px;
}
</style>
<input type="hidden" id="memberCheck" value="${sessionScope.login.memberType }">

<c:if test="${sessionScope.login.memberType == 'master'}">
<h3>회원정보관리</h3>${requestScope.succeess }
<form name="submit" onsubmit="return checkPenalty()" action="/udongca_project/member/memberUpdate.udc?page=${requestScope.page }" method="post">
	<input type="hidden" name="memberPenalty" value="${requestScope.memberInfo.memberPenalty }">
	<table>
		<tr>
			<td>아이디</td>
	 		<td><input type="text" name = "memberId" readonly="readonly" value="${requestScope.memberInfo.memberId }"></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="memberName" readonly="readonly" value="${requestScope.memberInfo.memberName }"></td>
		</tr>
		<tr>	
			<td>이메일</td>
			<td><input type="text" name="memberEmail" readonly="readonly" value="${requestScope.memberInfo.memberEmail }"></td>
		</tr>
		<tr>
			<td>벌점</td>
			<td>
			<i class="fa fa-thumbs-o-down" ></i>
			<i class="fa fa-thumbs-o-down" ></i>
			<i class="fa fa-thumbs-o-down" ></i>
			</td>
		</tr>
		<tr>
			<td>로그인 가능여부</td>
			<td>
				<select name="loginPossibility">
					<c:forEach items="${requestScope.code }" var="p">
								<c:choose>
									<c:when test="${p.codeId==requestScope.memberInfo.loginPossibility }">
										<option selected="selected" value=${p.codeId }>${p.codeName }</option>
									</c:when>
									<c:otherwise>
										<option value=${p.codeId }>${p.codeName }</option>
									</c:otherwise>
								</c:choose>
					</c:forEach>
				</select>
			</td>
			<tr>
				<td rowspan="1">
				<input type="submit" value="수정">
				<button id="cancel" formaction="/udongca_project/member/memberListPaging.udc?pnum=${requestScope.page }">취소</button>
				</td>
			</tr>
	</table>
</form>
</c:if>