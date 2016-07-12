<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Comparible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1" >
<title>Insert title here</title>
<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript" src="/udongca_project/scripts/udongca.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("input[type='button']").prop({"class":"btn btn-default"});
	$("input[type='submit']").prop({"class":"btn btn-default"});
	$("input[type='reset']").prop({"class":"btn btn-default"});
	$("input[type='password']").prop({"class":"form-control"});
	$("textarea").prop({"class":"form-control"});
	$("nav").height($("section").height()+60);
	$("section").resize(function(){
		$("nav").height($("section").height()+60);
	})
});
</script>

<style type="text/css">
table{
	color:black;
}
header{
	background-color:darkgoldenrod;
	min-height:190px;
	text-align:center;
	width:1280px;
}
header, a{
	font-size:15px;
	color:antiquewhite;
}
nav, .col-md-2{
	line-height: 70px;
	background-color:burlywood;
	width:180px;
	overflow:auto;
	float:left;
	text-align:center;
	font-size:20px;
	color:black;
	color-link:saddlebrown;
	height: 100%;
}
section, .col-md-8{
	padding: 15px;
	margin-left:50px;
	margin-top:30px;
	min-height:700px; 
	float:left;
}
footer{
	background-color:darkgoldenrod;
	padding-top:20px;
	text-align:center;
	height:90px;
	clear:both;
	width:1280px;
}
.menu{
	font-size:18px;
	color:antiquewhite;
	text-decoration: none;
}
a{
	color:sienna;
}
#wrap{
	width:1280px !important;
	margin:0 auto;
}

textarea{
	outline: none;
}
a:hover{color:saddlebrown; font-weight:bold;}


button{
	color:black;
}
input[type="submit"]{
	color:black;
}
input[type="button"]{
	color:black;
}

select{
	width:150px !important;
}
.pagination > .active > a,
.pagination > .active > a:hover{
	background-color:#6b4004;
}
.pagination > li > a{
	color:#a2522d;
}
.pagination > li > a:hover{
	color:#6b4004;
}
</style>
</head>

<body>
<div id="wrap">
<header class="navbar navbar-nav"> 
<tiles:insertAttribute name="header"/>
</header>

<nav class="nav sidenav col-md-2">
<tiles:insertAttribute name="menu"/>
</nav>

<section class="nav_section col-md-8">
<tiles:insertAttribute name="body"/>
</section>

<footer class="navbar">
<tiles:insertAttribute name="footer"/>
</footer>
</div>
</body>
</html>