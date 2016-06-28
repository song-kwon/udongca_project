<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//major category
	$.ajax({
		"url":"/udongca_project/search/selectAllMajorAddress.udc",
		"type":"post",
		"data":"",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				$("#address1").append("<option value=" + json[i].majorCategoryNo + ">" + json[i].addressName + "</option>");
			}
		}
	});
	
	//theme category
	$.ajax({
		"url":"/udongca_project/search/selectThemeCategory.udc",
		"type":"post",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				$("#theme").append("<option value=" + json[i].codeId + ">" + json[i].codeName + "</option>");
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
				"type":"post",
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

	$("#searchAddress").on("click", function(){
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
			$.ajax({
				"url":"/udongca_project/search/locationSearchResult.udc",
				"type":"POST",
				"data":"cafeAddress=" + submitString + "&page=" + 1,
				"dataType":"json",
				"error":function(){
					alert('qwdqwd');	
				},
				"success":function(json){
					alert(json.list.length);
					submitString = "'"+submitString+"'";
					$("#searchResult").empty();
					$("#pageNum").empty();
					if (json == null || json.list.length == 0){
						$("#searchResult").append("검색 결과 없음");
					}
					else{
						for(var i = 0; i < json.list.length; i++){
							$("#searchResult").append("<div style='padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left;'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>" + json.list[i].cafeNo + " " + json.list[i].cafeName + "</div>");
							//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
						}
						
						
						if(json.pageBean.previousPageGroup){
							$("#pageNum").append('<a href="#" onclick="addressPage('+submitString+','+(json.pageBean.beginPage-1)+')">◀</a>');
						}else{
							$("#pageNum").append('◀');
						}
						
						for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
							if(idx == json.pageBean.page)
								$("#pageNum").append('['+idx+']');
							else
								$("#pageNum").append('<a href="#" onclick="addressPage('+submitString+','+idx+')"> '+idx+' </a>');
						}
					}
					
					if(json.pageBean.nextPageGroup){
						$("#pageNum").append('<a href="#" onclick="addressPage('+ submitString+','+ ++json.pageBean.endPage +')">▶</a>');
					}else{
						$("#pageNum").append('▶');
					}
				}
			});
		} 
	});
	
	
	$("#searchTheme").on("click", function(){
		$("#searchResult").empty();
		
		$.ajax({
			"url":"/udongca_project/search/themeSearchResult.udc",
			"type":"POST",
			"data":"cafeFeature=" + $("#theme").val() + "&page="+1,
			"dataType":"json",
			"success":function(json){
				$("#searchResult").empty();
				$("#pageNum").empty();
				if (json == null || json.list.length == 0){
					$("#searchResult").append("검색 결과 없음");
				}
				else{
					for(var i = 0; i < json.list.length; i++){
						$("#searchResult").append("<div style='padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left;'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>" + json.list[i].cafeNo + " " + json.list[i].cafeName + "</div>");
						//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
					}
					
					
					if(json.pageBean.previousPageGroup){
						$("#pageNum").append('<a href="#" onclick="themePage('+(json.pageBean.beginPage-1)+')">◀</a>');
					}else{
						$("#pageNum").append('◀');
					}
					
					for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
						if(idx == json.pageBean.page)
							$("#pageNum").append('['+idx+']');
						else
							$("#pageNum").append('<a href="#" onclick="themePage('+idx+')"> '+idx+' </a>');
					}
				}
				
				if(json.pageBean.nextPageGroup){
					$("#pageNum").append('<a href="#" onclick="themePage('+ ++json.pageBean.endPage +')">▶</a>');
				}else{
					$("#pageNum").append('▶');
				}
				
 			}
		
		});
	});
	
 	 //var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
	 //alert(isID.test(/*비교할 대상*/)); 
});

function themePage(page){
	$.ajax({
		"url":"/udongca_project/search/themeSearchResult.udc",
		"type":"POST",
		"data":"cafeFeature=" + $("#theme").val() + "&page=" + page,
		"dataType":"json",
		"success":function(json){
			$("#searchResult").empty();
			$("#pageNum").empty();
			if (json == null || json.list.length == 0){
				$("#searchResult").append("검색 결과 없음");
			}
			else{
				for(var i = 0; i < json.list.length; i++){
					$("#searchResult").append("<div style='padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left;'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>" + json.list[i].cafeNo + " " + json.list[i].cafeName + "</div>");
					//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
				}
				
				if(json.pageBean.previousPageGroup){
					$("#pageNum").append('<a href="#" onclick="themePage('+ (json.pageBean.beginPage-1) +')">◀</a>');
				}else{
					$("#pageNum").append('◀');
				}
				
				for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
					if(idx == json.pageBean.page)
						$("#pageNum").append('['+idx+']');
					else
						$("#pageNum").append('<a href="#" onclick="themePage('+idx+')"> '+idx+' </a>');
				}
			}
			if(json.pageBean.nextPageGroup){
				$("#pageNum").append('<a href="#" onclick="themePage('+ ++json.pageBean.endPage +')">▶</a>');
			}else{
				$("#pageNum").append('▶');
			}
		}
	
	});
}

 function addressPage(submitString,page){
	$.ajax({
		"url":"/udongca_project/search/locationSearchResult.udc",
		"type":"POST",
		"data":"cafeAddress=" + submitString + "&page=" + page,
		"dataType":"json",
		"success":function(json){
			alert()
			submitString= "'"+submitString+"'";
			$("#searchResult").empty();
			$("#pageNum").empty();
			if (json == null || json.list.length == 0){
				$("#searchResult").append("검색 결과 없음");
			}
			else{
				for(var i = 0; i < json.list.length; i++){
					$("#searchResult").append("<div style='padding-right: 10px;padding-top: 10px;width:200px;height:220px;float:left;'><img style='width:200px;height:200px;' src='../images/" + json.list[i].cafeFakeImage + "'>" + json.list[i].cafeNo + " " + json.list[i].cafeName + "</div>");
					//$("#searchResult").append(" " + json[i].cafeNo + " " + json[i].cafeName + "<br>");
				}
				
				
				if(json.pageBean.previousPageGroup){
					$("#pageNum").append('<a href="#" onclick="addressPage('+submitString+','+(json.pageBean.beginPage-1)+')">◀</a>');
				}else{
					$("#pageNum").append('◀');
				}
				
				for(var idx = json.pageBean.beginPage ; idx <= json.pageBean.endPage ; idx++){
					if(idx == json.pageBean.page)
						$("#pageNum").append('['+idx+']');
					else
						$("#pageNum").append('<a href="#" onclick="addressPage('+submitString+','+idx+')"> '+idx+' </a>');
				}
			}
			
			if(json.pageBean.nextPageGroup){
				$("#pageNum").append('<a href="#" onclick="addressPage('+ submitString+','+ ++json.pageBean.endPage +')">▶</a>');
			}else{
				$("#pageNum").append('▶');
			}
		}
	});
} 
</script>

<style type="text/css">
a{
	text-decoration: none;
}
</style>
</head>
<body>
<div>지역선택&nbsp;<select id="address1"><option value=0>시/도</option></select>&nbsp;<select id="address2"><option value=0>시/도 먼저 선택</option></select>&nbsp;<button id="searchAddress">검색</button>&nbsp;&nbsp;테마검색&nbsp;<select id="theme"><option value=0>테마 선택</option></select>&nbsp;<button id="searchTheme">검색</button></div>
<div id="searchResult" style="width:800px; background-color: red;">

</div>
<div id="pageNum" style="clear:both;">
</div>

</body>
</html>