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
					"url":"/udongca_project/search/GetThemeCodeList.udc",
					"type":"GET",
					"data":"",
					"dataType":"json",
					"success":function(json){
						for(var i = 0; i < json.length; i++){
							$("#address1").append("<option value=" + json[i].addressId + ">" + json[i].addressName + "</option>");
						}
					}
				});
				
				$("#theme").on("change", function(){
					if ($(this).val() == "테마 선택"){
						alert("테마를 선택하세요");
						$("#theme").focus();
					}
				});
				
				$("#search").on("click", function(){
					if ($("#theme").val() == "테마 선택"){
						alert("올바른 지역을 선택하세요");
						$("#theme").focus();
						return false;
					}
					else{
						$("#searchResult").empty();
						$.ajax({
							"url":"/udongca_project/search/themeSearchResult.udc",
							"type":"POST",
							"data":"cafeFeature=" + $("#theme").val() + "&page=" + 1 + "&itemsPerPage=" + 10,
							"dataType":"json",
							"success":function(json){
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
		테마:
		<select name="theme" id="theme">
			<option>테마 선택</option>
		</select>
		<button id="search">검색</button><br>
		<div id="searchResult"></div>
	</body>
</html>