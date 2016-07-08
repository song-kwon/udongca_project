<%@ page contentType="text/html;charset=utf-8"%>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
	var menuTypeList = null;
	var menuId = 0;
	
	$(document).ready(function(){
		$.ajax({
			"url":"/udongca_project/prBoard/cafeMenuList.udc",
			"type":"GET",
			"data":"",
			"dataType":"json",
			"success":function(json){
				menuTypeList = json;
				$.ajax({
					"url":"/udongca_project/prBoard/menuListAll.udc",
					"type":"POST",
					"data":"cafeNumber=${requestScope.cafeNo}",
					"dataType":"json",
					"success":function(json){
						for (var i = 0; i < json.length; i++){
							$("#menuList").append("<div class='menu" + menuId + "' style='width:300px; padding-bottom:20px;'><input type='hidden' name='menuNOArray' value='" + json[i].menuNo + "'><b>종류 :</b> <select name='menuTypeArray' class='form-control'><option>종류</option></select>" + "<br><b>이름 :</b> <input type='text' name='menuNameArray' class='form-control' value='" + json[i].menuName + "'>" + "<br><b>기존 사진 :</b> <img src='/udongca_project/images/" + json[i].menuFakeImage + "' height='30' width='30'>" + "<br><b>교체 사진 :</b> <input type='file' name='menuImageArray'> " + "<br><input type='button' value='메뉴 삭제' class='btn btn-default' onclick='menuDelete(" + menuId + ")'></div>");
							for (var j = 0; j < menuTypeList.length; j++){
								$("[name='menuTypeArray']:last").append("<option>" + menuTypeList[j].codeName + "</option>");
								if (json[i].menuType == menuTypeList[j].codeName){
									$("[name='menuTypeArray'] option:last").prop("selected", true);
								}
							}
							menuId++;
						}
					},
					"error":function(xhr){
						alert("An error occured while loading menuListAll.udc: " + xhr.status + " " + xhr.statusText);
					}
				});
			},
			"error":function(xhr){
				alert("An error occured: " + xhr.status + " " + xhr.statusText);
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
	});
	
	function menuAdd(){
		$("#menuList").append("<div class='menu" + menuId + "' style='width:300px; padding-bottom:20px;'><input type='hidden' name='menuNOArray' value='0'><b>종류 :</b> <select name='menuTypeArray' class='form-control'><option>종류</option></select>" + "<br><b>이름 :</b> <input type='text' name='menuNameArray' class='form-control'>" + "<br><b>사진 :</b> <input type='file' name='menuImageArray'>" + "<input type='button' value='메뉴 삭제' onclick='menuDelete(" + menuId + ")' class='btn btn-default'></div>");
		for (var i = 0; i < menuTypeList.length; i++){
			$("[name='menuTypeArray']:last").append("<option>" + menuTypeList[i].codeName + "</option>");
		}
		menuId++;
	}
	
	function menuDelete(no){
		$("div.menu" + no).remove();
	}
	
	function cancel(){
		history.back();
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
	width:550px;
}
.width_size{
	width:500px;
}

.width_size2{
	width:350px;
}
</style>
<div><h1>메뉴 수정</h1></div><br>
<div style="width:700px;">
<form action="/udongca_project/prBoard/menuModify.udc" enctype="multipart/form-data" method="post">
	<input type="hidden" name="cafeNo" value="${requestScope.cafeNo}">
	<table>
		<tr>
			<th>메뉴</th>
			<td id="menuList" style="width:550px;"></td>
			<td><input type="button" value="메뉴 추가" onclick="menuAdd()"></td>
		</tr>
	</table>
		
		<div class="form-group" align="center" style="width:600px; padding-top:20px;">
			<input type="submit" value="확인">
			<input type="button" value="취소" onclick="cancel()">
		</div>
</form>
</div>