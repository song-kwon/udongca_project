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
	for(var i =0; i<$("#memberPenalty").val();i++){
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
	/* $("#cancel").on("click",function(){
		location.href="/udongca_project/member/memberListPaging.udc?pnum=";
	}); */
	
});
/* function checkPenalty(){
	var value=0;
	 for(var i =0;i<$(".fa").length;i++){
		if($(".fa")[i].className=="fa fa-thumbs-down"){
			value++;
		}
	} 
	 
	
} */
function cancel(pnum){
	location.href="/udongca_project/member/memberListPaging.udc?pnum="+pnum;
}
function submit(){
	var value=0;
	 for(var i =0;i<$(".fa").length;i++){
		if($(".fa")[i].className=="fa fa-thumbs-down"){
			value++;
		}
	} 
	 $("#memberPenalty").val(value);
		if($("#memberPenalty").val()>=3 && $("#loginPossibility").val()=="possible"){
			alert("벌점3점이상 로그인 불가");
			$("#loginPossibility").val("impossible");
			return false;
		}
		if($("#memberPenalty").val()<3 && $("#loginPossibility").val()=="impossible"){
			$("#loginPossibility").val("possible");
		}
	$.ajax({
		"url" : "/udongca_project/member/memberUpdate.udc",
		"type" : "post",
		"data" : {
					memberId : $("#memberId").val(),
					memberName : $("#memberName").val(),
					memberEmail	: $("#memberEmail").val(),	
					memberPenalty : $("#memberPenalty").val(),
					loginPossibility : $("#loginPossibility").val(),
					page : $("#page").val()
				},
		"success" : function(obj) {
			if(obj=="true"){
				alert("등록성공");
			}else{
				alert("등록실패");
			}
		},
		"error" : function(aa,bb,cc) {
			alert(aa,bb,cc);
		}
	});
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
	<input type="hidden" id="memberPenalty" value="${requestScope.memberInfo.memberPenalty }">
	<input type="hidden" id="page" value="${param.page }">
	<table>
		<tr>
			<td>아이디</td>
	 		<td><input type="text" id = "memberId" readonly="readonly" value="${requestScope.memberInfo.memberId }"></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" id="memberName" readonly="readonly" value="${requestScope.memberInfo.memberName }"></td>
		</tr>
		<tr>	
			<td>이메일</td>
			<td><input type="text" id="memberEmail" readonly="readonly" value="${requestScope.memberInfo.memberEmail }"></td>
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
				<select id="loginPossibility">
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
				<button type="button" onclick="submit()">수정</button>
				<button type="button" onclick="cancel(${param.page})">뒤로가기</button>
				</td>
			</tr>
	</table>
</c:if>