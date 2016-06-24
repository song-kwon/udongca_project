<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$.ajax({
					"url":"/udongca_project/search/selectAllMajorAddress.udc",
					"type":"GET",
					"data":"",
					"dataType":"json",
					"success":function(json){
						for(var i = 0; i < json.length; i++){
							$("#address1").append("<option value=" + json[i].majorCategoryNo + ">" + json[i].addressName + "</option>");
						}
					}
				});
				
				$("#address1").on("change", function(){
					var es = this;
					$("#address2").empty().append("<option>군/구</option>");
					if ($(this).val() == "시/도"){
						alert("올바른 시/도를 선택하세요");
						$("#address1").focus();
						return false;
					}
					else{
						$.ajax({
							"url":"/udongca_project/search/selectMiddleAddressByMajorCategoryNo.udc",
							"type":"GET",
							"data":"majorCategoryNo=" + $(es).val(),
							"dataType":"json",
							"success":function(json){
								for(var i = 0; i < json.length; i++){
									$("#address2").append("<option value=" + json[i].middleCategoryNo + ">" + json[i].addressName + "</option>");
								}
							}
						});
					}
				});
				
				$("#search").on("click", function(){
					if ($("#address1").val() == "시/도" || $("#address2").val() == "군/구"){
						alert("올바른 지역을 선택하세요");
						($("#address1").val() == "시/도") ? $("#address1").focus() : $("#address2").focus();
						return false;
					}
					else{
						var submitString = $("#address1 option:selected").text() + " " + $("#address2 option:selected").text();
						if (submitString == "세종특별자치시 세종시"){
							submitString = "세종특별자치시";
						}
						$("#searchResult").empty();
						$.ajax({
							"url":"/udongca_project/search/locationSearchResult.udc",
							"type":"POST",
							"data":"cafeAddress=" + submitString + "&page=" + 1 + "&itemsPerPage=" + 10,
							"dataType":"json",
							"success":function(json){
								$("#searchResult").empty();
								if (json == null || json.length == 0){
									$("#searchResult").append("검색 결과 없음");
								}
								else{
									for(var i = 0; i < json.length; i++){
										$("#searchResult").append("<img src='" + json[i].cafeFakeImage + "'>");
										$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
									}
								}
							}
						});
					}
				});
			});
		</script>
	</head>
	<body>
		시/도:
		<select name="address1" id="address1">
			<option>시/도</option>
		</select>
		군/구:
		<select name="address2" id="address2">
			<option>군/구</option>
		</select>
		<button id="search">검색</button><br>
		<div id="searchResult"></div>
	</body>
</html>