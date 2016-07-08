<%@ page contentType="text/html;charset=utf-8"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
			var menuTypeList = null;

			$(document).ready(function(){
				$("input[type='text']").prop({"class":"form-control input-sm"});
				$.ajax({
					"url":"/udongca_project/prBoard/cafeMenuList.udc",
					"type":"GET",
					"data":"",
					"dataType":"json",
					"success":function(json){
						menuTypeList = json;
						for(var i = 0; i < menuTypeList.length; i++){
							$("[name='menuTypeArray']:last").append("<option>" + menuTypeList[i].codeName + "</option>");
						}
					},
					"error":function(xhr){
						alert("An error occured: " + xhr.status + " " + xhr.statusText);
					}
				});
				
				$("#menuAdd").on("click", function(){
					$("#menuList").append("<div><b>종류:</b> <select name='menuTypeArray' class='form-control'><option>종류</option></select><br> <b>이름:</b> <input type='text' name='menuNameArray' class='form-control'><br> 사진: <input type='file' name='menuImageArray'><hr></div>");
					if (menuTypeList){
						for(var i = 0; i < menuTypeList.length; i++){
							$("[name='menuTypeArray']:last").append("<option>" + menuTypeList[i].codeName + "</option>");
						}
					}
				});
				
				$("#menuDelete").on("click", function(){
					if ($("#menuList div").length > 1){
						$("#menuList div:last").remove();
					}
				});
				
				$("form").on("submit", function(){
					var flag = true;
					$("[name='menuTypeArray']").each(function(){
						if ($("option:selected", this).text() == "종류"){
							alert("종류를 선택하세요");
							flag = false;
						}
					});
					$("[name='menuNameArray']").each(function(){
						if (!($(this).val())){
							alert("메뉴 이름을 입력하세요");
							flag = false;
						}
						else if (countUtf8(($(this).val())) > 50){
							alert($(this).val() + ": 메뉴 이름이 너무 깁니다");
							flag = false;
						}
					});
					return flag;
				});
				
				$("#cancel").on("click", function(){
					history.back();
				});
			});
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
	width:450px;
}
.width_size{
	width:500px;
}

.width_size2{
	width:350px;
}
</style>

<div class="nonav_bodyDiv" style="width:900px; padding-left:100px;">
<div><h1>카페 홍보글 등록</h1></div><br>
<div style="color:red;"><font size="3">*표시 항목은 필수 입력 사항입니다.</font></div>
<form action="/udongca_project/prBoard/prWrite.udc" enctype="multipart/form-data" method="post" role="form"><br>
	<input type="hidden" name="cafeName" value="${requestScope.cafeName}">
	<input type="hidden" name="cafeIntro" value="${requestScope.cafeIntro}">
	<input type="hidden" name="cafeFeature" value="${requestScope.cafeFeature}">
	<input type="hidden" name="operationHour" value="${requestScope.operationHour}">
	<input type="hidden" name="cafeTel" value="${requestScope.cafeTel}">
	<input type="hidden" name="cafeAddress" value="${requestScope.cafeAddress}">
	<input type="hidden" name="coporateNumber" value="${requestScope.coporateNumber}">
	<input type="hidden" name="managerName" value="${requestScope.managerName}">
	<input type="hidden" name="managerTel" value="${requestScope.managerTel}">
	
<table>
	<tr>
		<th style="padding-bottom:55px;">매장 사진</th>
		<td class="width_size" style="padding-bottom:55px;"><input type="file" name="cafeImage" multiple="multiple"></td>
	</tr>
	<tr>
		<th>*메뉴</th>
		<td class="width_size">
			<div id="menuList" class="form-inline">
					<div>
						<b>종류:</b> <select name="menuTypeArray" class="form-control"><option>종류</option></select><br>
						<b>이름:</b> <input type="text" name="menuNameArray"><br>
						사진: <input type="file" name="menuImageArray"><br>
					</div>
			</div>
		</td>
	</tr>
	<tr>
		<th></th>
		<td class="width_size">
			<input type="button" value="메뉴 추가" id="menuAdd">&nbsp;<input type="button" value="메뉴 삭제" id="menuDelete">
		</td>
	</tr>	

</table>


	<div class="form-group" align="center" style="width:600px; padding-top:20px;">
		<input type="submit" value="등록">
		<input type="reset" value="다시 입력">
		<input type="button" value="취소" id="cancel">
	</div>
</form>
</div>