<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript" src="/udongca_project/scripts/udongca.js"></script>
<style type="text/css">
header{
	background-color:darkgoldenrod;
	min-height:150px;
	text-align:center;
	padding: 5px;
}
nav{
	line-height: 70px;
	background-color:burlywood;
	padding: 15px;
	min-height:700px;
	width:180px;
	overflow:auto;
	float:left;
	text-align:center;
	font-size:20px;
	color:black;
	color-link:saddlebrown;
}
section{
	padding: 15px;
	min-height:700px;
	float:left;
}
footer{
	background-color:darkgoldenrod;
	padding-top:20px;
	text-align:center;
	height:50px;
	clear:both;
}
a{
	text-decoration: none;
}
#wrap{
	width:1280px;
}
</style>
</head>
<body>
<div id="wrap">
<header>
<tiles:insertAttribute name="header"/>
</header>

<nav class="nav">
<tiles:insertAttribute name="menu"/>
</nav>

<section class="nav_section">
<tiles:insertAttribute name="body"/>
</section>

<footer>
<tiles:insertAttribute name="footer"/>
</footer>
</div>
</body>
</html>