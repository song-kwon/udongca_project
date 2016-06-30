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
							$("[name='menuTypeArray']:last").append("<option value=" + menuTypeList[i].codeId + ">" + menuTypeList[i].codeName + "</option>");
						}
					},
					"error":function(xhr){
						alert("An error occured: " + xhr.status + " " + xhr.statusText);
					}
				});
				
				$("#menuAdd").on("click", function(){
					$("#menuList").append("<div><b>종류:</b> <select name='menuTypeArray'><option>종류</option></select> <b>이름:</b> <input type='text' name='menuNameArray'> 사진: <input type='file' name='menuImageArray'><br></div>");
					if (menuTypeList){
						for(var i = 0; i < menuTypeList.length; i++){
							$("[name='menuTypeArray']:last").append("<option value=" + menuTypeList[i].codeId + ">" + menuTypeList[i].codeName + "</option>");
						}
					}
				});
				
				$("#menuDelete").on("click", function(){
					if ($("#menuList div").length > 1){
						$("#menuList div:last").remove();
					}
				});
				
				$("form").on("submit", function(){
					$("[name='menuTypeArray']").each(function(){
						if ($("option:selected", this).text() == "종류"){
							alert("종류를 선택하세요");
						}
					});
					$("[name='menuNameArray']").each(function(){
						if (!($(this).val())){
							alert("메뉴 이름을 입력하세요");
							return false;
						}
					});
				});
				
				$("#cancel").on("click", function(){
					history.back();
				});
			});
</script>
<div id="nonav_bodyDiv">
굵은 글씨 항목은 필수 입력 사항입니다.
<br>
<form action="/udongca_project/prBoard/prWrite.udc"
	enctype="multipart/form-data" method="post">
	<input type="hidden" name="cafeName" value="${requestScope.cafeName}">
	<input type="hidden" name="cafeIntro" value="${requestScope.cafeIntro}">
	<input type="hidden" name="cafeFeature"
		value="${requestScope.cafeFeature}"> <input type="hidden"
		name="operationHour" value="${requestScope.operationHour}"> <input
		type="hidden" name="cafeTel" value="${requestScope.cafeTel}">
	<input type="hidden" name="cafeAddress"
		value="${requestScope.cafeAddress}"> <input type="hidden"
		name="coporateNumb" value="${requestScope.coporateNumb}"> <input
		type="hidden" name="managerName" value="${requestScope.managerName}">
	<input type="hidden" name="managerTel"
		value="${requestScope.managerTel}">
	<table>
		<tr>
			<td>매장사진</td>
			<td><input type="file" name="cafeImage" multiple="multiple"><br></td>
			<td></td>
		</tr>
		<tr>
			<td>메뉴</td>
			<td id="menuList">
				<div>
					<b>종류:</b> <select name="menuTypeArray"><option>종류</option></select>
					<b>이름:</b> <input type="text" name="menuNameArray"> 사진: <input
						type="file" name="menuImageArray"><br>
				</div>
			</td>
			<td><input type="button" value="메뉴 추가" id="menuAdd"><input
				type="button" value="메뉴 삭제" id="menuDelete"></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="확인"></td>
			<td><input type="button" value="취소" id="cancel"></td>
		</tr>
	</table>
</form>
</div>