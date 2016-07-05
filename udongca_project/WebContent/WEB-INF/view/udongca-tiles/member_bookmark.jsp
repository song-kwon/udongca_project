<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function(){
	bookmarkPage(1);
});
</script>
<style type="text/css">
table {
	border-collapse: collapse;
}
</style>
<div id="nav_bodyDiv" style="width: 400px;">
	<div id="bookmarkDiv">
		<h2>즐겨찾기</h2>
		<div id="bookmarkTable" align="center">
			<table class="table table-hover" id="memberBookmark" style="width: 400px;">
				<thead>
					<tr>
						<td colspan="2" align="center"><h4>목록</h4></td>
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