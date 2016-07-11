<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		"url":"/udongca_project/prBoard/cafeMenuList.udc",
		"type":"GET",
		"data":"",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				var a= "'"+json[i].codeName+"'" ;
				$("#menuCategoryList").append('<li class="li"><a onclick="toMenuImage(' + a + ')">' + json[i].codeName + '</a></li>');
			}
		},
		"error":function(xhr){
			alert("An error occured while loading cafeMenuList.udc: " + xhr.status + " " + xhr.statusText);
		}
	});
})
	function toMapLocation(){
		location.href = "/udongca_project/prBoard/prView.udc?cafeNo=" + "${requestScope.cafeNo}";
	}
	function toReviewList(page){
		location.href = "/udongca_project/prBoard/prView.udc?cafeNo=" + "${requestScope.cafeNo}" + "&initialPage=reviewList";
	}
	function toMenuImage(menuType){
		location.href = "/udongca_project/prBoard/prView.udc?cafeNo=" + "${requestScope.cafeNo}" + "&initialPage=menuImage&initialPage2=" + menuType;
	}
</script>
<style type="text/css">
.nav-pills > li.active > a,
.nav-pills > li.active > a:hover,
 .nav-pills > li.active > a:focus{
	background-color:#6b4004;
}
.nav>li>a{
	font-size:15pt;
}
.nav > li > a:hover,
.nav > li > a:focus{
	font-weight:bold;
	background-color:#faebd7;
}
</style>
<div id="prboard_nav" style="width:180px;">
	<div id="optionList">
		<div class="panel-group">
		<ul class="nav nav-pills nav-stacked">
			<li class="li"><a data-toggle="collapse" style='cursor:pointer' onclick="toMapLocation();">지도</a></li>
			<li class="li"><a id="cafeMenuList" class="collapsed" data-toggle="collapse" href="#collapse1">메뉴</a></li>	
		</ul>
			<div id="collapse1" class="panel-collapse collapse">
				<ul class="list-group nav nav-pills nav-stacked" id="menuCategoryList">
				</ul>
			</div>
		<ul class="nav nav-pills nav-stacked">
			<li class="li"><a data-toggle="collapse" style='cursor:pointer' onclick="toReviewList();">리뷰</a></li>
		</ul>
		</div>
	</div>
</div>