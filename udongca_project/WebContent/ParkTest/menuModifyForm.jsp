<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/udongca_project/scripts/jquery.js"></script>
		<script type="text/javascript">
			menuTypeList = null;
			menuId = 0;
			
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
									$("#menuList").append("<div class='menu" + menuId + "'><input type='hidden' name='menuNOArray' value='" + json[i].menuNO + "'><b>종류:</b> <select name='menuTypeArray'><option>종류</option></select>" + "<b>이름:</b> <input type='text' name='menuNameArray' value='" + json[i].menuName + "'>" + "<b>기존 사진:</b> <img src='/udongca_project/images/" + json[i].menuFakeImage + "' height='30' width='30'>" + "교체 사진: <input type='file' name='menuImageArray'> " + "<input type='button' value='메뉴 삭제' onclick='menuDelete(" + menuId + ")'></div>");
									for (var j = 0; j < menuTypeList.length; j++){
										$("[name='menuTypeArray']:last").append("<option value=" + menuTypeList[j].codeId + ">" + menuTypeList[j].codeName + "</option>");
										if (json[i].menuType == menuTypeList[j].codeId){
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
							return false;
						}
					});
					$("[name='menuNameArray']").each(function(){
						if (!($(this).val())){
							alert("메뉴 이름을 입력하세요");
							flag = false;
							return false;
						}
					});
					return flag;
				});
				
				("#cancel").on("click", function(){
					history.back();
				});
			});
			
			
			
			function menuAdd(){
				$("#menuList").append("<div class='menu" + menuId + "'><input type='hidden' name='menuNOArray' value='0'><b>종류:</b> <select name='menuTypeArray'><option>종류</option></select>" + "<b>이름:</b> <input type='text' name='menuNameArray'>" + "사진: <input type='file' name='menuImageArray'>" + "<input type='button' value='메뉴 삭제' onclick='menuDelete(" + menuId + ")'></div>");
				for (var i = 0; i < menuTypeList.length; i++){
					$("[name='menuTypeArray']:last").append("<option value=" + menuTypeList[i].codeId + ">" + menuTypeList[i].codeName + "</option>");
				}
				menuId++;
			}
			
			function menuDelete(no){
				$("div.menu" + no).remove();
			}
		</script>
	</head>
	<body>
		<form action="/udongca_project/prBoard/menuModify.udc" enctype="multipart/form-data" method="post">
			<input type="hidden" name="cafeNo" value="${requestScope.cafeNo}">
			<table>
				<tr>
					<td>메뉴</td>
					<td id="menuList"></td>
					<td><input type="button" value="메뉴 추가" onclick="menuAdd()"></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="확인"></td>
					<td><input type="button" value="취소" id="cancel"></td>
				</tr>
			</table>
		</form>
	</body>
</html>