<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript" src="/udongca_project/scripts/udongca.js"></script>
<style type="text/css">
header {
	background-color: skyblue;
	text-align: center;
	padding: 5px;
	min-width: 1024px;
	width: auto;
	min-height: 150px;
}

nav {
	line-height: 50px;
	background-color: lightgray;
	padding: 15px;
	min-height: 700px;
	width: 250px;
	float: left;
}

section {
	padding: 15px;
	width: 100%;
	min-height: 768px;
	float: left;
}

footer {
	background-color: skyblue;
	padding-top: 20px;
	text-align: center;
	height: 50px;
	clear: both;
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
			<tiles:insertAttribute name="header" />
		</header>

		<section class="nonav_section">
			<tiles:insertAttribute name="body" />
		</section>

		<footer>
			<tiles:insertAttribute name="footer" />
		</footer>
</div>
</body>
</html>