<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function(){
	bookmarkPage(1);
});
</script>
<style type="text/css">
thead{
	text-align:center;
	width:800px;
	height:40px;
	margin:20px;
	font-size:13pt;
	font-weight:bold;
	cursor:default;
	border-bottom:2px solid;
}


table, tbody{
	height:30px;
}
</style>
<div id="nav_bodyDiv" style="width: 100%;">
		<h2>즐겨찾기</h2>
	<div id="bookmarkDiv" align="center">
		<div id="bookmarkTable" align="center">
			<table class="table table-hover" id="memberBookmark" style="width: 450px; text-align: center">
				<thead>
					<tr>
						<td></td>
						<td>카페명</td>
						<td>카페주소</td>
				</thead>
				<tbody id="tbody">
				</tbody>
			</table>
		</div>
		<div id="page" align="center">
			<ul class="pagination">
			</ul>
		</div>
	</div>
</div>