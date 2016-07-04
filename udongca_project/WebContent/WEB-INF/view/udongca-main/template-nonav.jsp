<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript" src="/udongca_project/scripts/udongca.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("button").prop({"class":"btn btn-default"});
	$("input[type='button']").prop({"class":"btn btn-default"});
	$("input[type='submit']").prop({"class":"btn btn-default"});
	$("input[type='text']").prop({"class":"form-control"});
	$("textarea").prop({"class":"form-control"});
});
</script>

<style type="text/css">
header {
	background-color: darkgoldenrod;
	text-align: center;
	padding: 5px;
	min-width: 1024px;
	width: auto;
	min-height: 150px;
}

nav {
	line-height: 70px;
	background-color: burlywood;
	padding: 15px;
	min-height: 700px;
	width: 180px;
	float: left;
	font-size:20px;
	text-align:center;
	color:black;
	color-link:saddlebrown;
}

section {
	padding: 15px;
	width: 100%;
	min-height: 768px;
	float: left;
}

footer {
	background-color: darkgoldenrod;
	padding-top: 20px;
	text-align: center;
	height: 90px;
	clear: both;
}
a{
	color:sienna;
	text-decoration: none;
}
#wrap{
	width:1280px;
	margin: 0 auto;
}
.nonav_bodyDiv{
	width:1280px;
	margin:0 auto;
}
a:hover{color:saddlebrown;}
button{
	color:black;
}
input[type="submit"]{
	color:black;
}
input[type="button"]{
	color:black;
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