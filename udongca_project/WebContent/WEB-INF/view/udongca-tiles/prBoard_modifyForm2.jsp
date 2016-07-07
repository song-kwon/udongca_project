<%@ page contentType="text/html;charset=utf-8"%>
<script type="text/javascript">
	var cafeFakeImageArray = "${requestScope.cafeFakeImage}".split(";");
	var cafeRealImageArray = "${requestScope.cafeRealImage}".split(";");
	var cafeFakeImageArrayNumber = cafeFakeImageArray.length - 1;
	
	$(document).ready(function(){
		for(var i = 0; i < cafeFakeImageArrayNumber; i++){
			$("#cafeImages").append("<img src='/udongca_project/images/" + cafeFakeImageArray[i] + "' class='image" + i + "' height='20' width='20'>");
			$("#cafeImages").append("<button onclick='deleteImage(" + i + ")' class='image" + i + "'>삭제</button>");
			$("#cafeImages").append("<input type='hidden' name='modifiedCafeFakeImage' value='" + cafeFakeImageArray[i] + "' class='image" + i + "'>");
			$("#cafeImages").append("<input type='hidden' name='modifiedCafeRealImage' value='" + cafeRealImageArray[i] + "' class='image" + i + "'>");
			$("#cafeImages").append("<br class='image" + i + "'>");
		}
		
		$("input[type='text']").prop({"class":"form-control col-xs-3"});
		$("#cancel").on("click", function(){
			history.back();
		});
	});
	
	function deleteImage(i){
		$(".image" + i).remove();
	}
</script>

<style type="text/css">
table{
	border-collapse: collapse;
	width:900px;
	margin:30px;
	font-size:18px;
}

table, th{
	text-align:left;
	width:480px;
	heigth:45px;
}
.width_size{
	width:500px;
}

.width_size2{
	width:350px;
}
</style>

<div class="nonav_bodyDiv" style="width:900px; padding-left:100px;">
<div><h1>카페 홍보글 수정</h1></div><br>
<div style="color:red;"><font size="3">*표시 항목은 필수 입력 사항입니다.</font></div>
<form action="/udongca_project/prBoard/prModify.udc" enctype="multipart/form-data" method="post"><br>
	<input type="hidden" name="cafeNo" value="${requestScope.cafeNo}">
	<input type="hidden" name="cafeName" value="${requestScope.cafeName}">
	<input type="hidden" name="cafeIntro" value="${requestScope.cafeIntro}">
	<input type="hidden" name="cafeFeature" value="${requestScope.cafeFeature}">
	<input type="hidden" name="operationHour" value="${requestScope.operationHour}">
	<input type="hidden" name="cafeTel" value="${requestScope.cafeTel}">
	<input type="hidden" name="cafeAddress" value="${requestScope.cafeAddress}">
	<input type="hidden" name="coporateNumber" value="${requestScope.coporateNumber}">
	<input type="hidden" name="managerName" value="${requestScope.managerName}">
	<input type="hidden" name="managerTel" value="${requestScope.managerTel}">
	<input type="hidden" name="cafeRealImage" value="${requestScope.cafeRealImage}">
	<input type="hidden" name="cafeFakeImage" value="${requestScope.cafeFakeImage}">
	<input type="hidden" name="memberId" value="${requestScope.memberId}">
<table>
	<tr>
		<th>기존 매장 사진</th>
		<td id="cafeImages"></td>
	<tr>
		<th>추가 매장 사진</th>
		<td class="width_size"><input type="file" name="addCafeImage" multiple="multiple"></td>
	</tr>
</table>


	<div class="form-group" align="center" style="width:600px; padding-top:20px;">
		<input type="submit" value="등록">
		<input type="reset" value="다시 입력">
		<input type="button" value="취소" id="cancel">
	</div>
</form>
</div>