<%@ page contentType="text/html;charset=utf-8"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
			var menuTypeList = null;

			$(document).ready(function(){
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
					});
					return flag;
				});
				
				$("#cancel").on("click", function(){
					history.back();
				});
			});
</script>
<div class="nonav_bodyDiv" style="width:400px;">
굵은 글씨 항목은 필수 입력 사항입니다.
<br>
<form action="/udongca_project/prBoard/prWrite.udc" enctype="multipart/form-data" method="post" role="form">
	<input type="hidden" name="cafeName" value="${requestScope.cafeName}">
	<input type="hidden" name="cafeIntro" value="${requestScope.cafeIntro}">
	<input type="hidden" name="cafeFeature"
		value="${requestScope.cafeFeature}"> <input type="hidden"
		name="operationHour" value="${requestScope.operationHour}"> <input
		type="hidden" name="cafeTel" value="${requestScope.cafeTel}">
	<input type="hidden" name="cafeAddress"
		value="${requestScope.cafeAddress}"> <input type="hidden"
		name="coporateNumber" value="${requestScope.coporateNumber}"> <input
		type="hidden" name="managerName" value="${requestScope.managerName}">
	<input type="hidden" name="managerTel"
		value="${requestScope.managerTel}">
	<div class="form-group">
			<label for="cafeImage">매장사진(다수 선택 가능)</label>
			<input type="file" name="cafeImage" multiple="multiple"><br>
	</div>
	<div class="form-group">
			<label for="menu">메뉴</label>
				<div id="menuList" class="form-inline">
					<div>
						종류: <select name="menuTypeArray" class="form-control"><option>종류</option></select><br>
						이름: <input type="text" name="menuNameArray" class="form-control"><br>
						사진: <input type="file" name="menuImageArray">
						<hr>
					</div>
				</div>
				<div>
				<input type="button" value="메뉴 추가" id="menuAdd"><input type="button" value="메뉴 삭제" id="menuDelete">
				</div>
	</div>
	<div class="form-group">
		<input type="submit" value="확인">
		<input type="button" value="취소" id="cancel">
	</div>
</form>
</div>