<%@ page contentType="text/html;charset=utf-8"%>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("input[type='text']").prop({"class":"form-control"});
		for (var i = 1; i < 6; i++){
			$("#ratingStars").append("<option>" + i + "</option>");
		}
		
		$("#reviewTitle").on("blur", function(){
			$("#reviewTitleTd").text(($("#reviewTitle").val()) ? (countUtf8($("#reviewTitle").val()) > 50 ? "글자 수 한도 초과" : "") : "입력 필수");
		});
		
		$("#reviewContent").on("blur", function(){
			$("#reviewContentTd").text(($("#reviewContent").val()) ? "" : "입력 필수");
		});
		
		$("#cancel").on("click", function(){
			history.back();
		});
		
		$("form").on("submit", function(){
			if (!($("#reviewTitle").val() && $("#reviewContent").val())){
				alert("필수 사항이 입력되지 않았거나 입력 문장이 너무 깁니다");
				return false;
			}
		});
	});
</script>
<style type="text/css">
table{
	margin:30px;
	margin-top:20px;
	margin-bottom:20px;
	text-align:left;
	font-size:18px;
}
.div{
	border:1px dotted;
	height:auto;
	background-color:antiquewhite;
}

.text{
	color:black;
	font-weight:bold;
	width:100px;
	height:40px;
}

</style>
<div><h1>리뷰 등록</h1></div><br>
<div style="color:red;"><font size="3">*표시 항목은 필수 입력 사항입니다.</font></div><br>
<form action="/udongca_project/review/reviewWrite.udc" enctype="multipart/form-data" method="post">
	<div class="div">
	<input type="hidden" name="cafeNo" value="${requestScope.cafeNo}">
	<table>
		<tr>
			<td class="text">*제목</td>
			<td><input type="text" name="reviewTitle" id="reviewTitle" style="width:600px;" placeholder="제목은 한글 기준 최대 50자까지 입력 가능합니다.."></td>
			<td id="reviewTitleTd"></td>
		</tr>
		<tr>
			<td class="text">등급</td>
			<td>
				<select name="ratingStars" id="ratingStars" class="form-control" style="width:80px;"></select>
			</td>
			<td></td>
		</tr>
		<tr>
			<td class="text">*내용</td>
			<td><textarea rows="30" cols="80" name="reviewContent" id="reviewContent" placeholder="내용을 입력해주세요.."></textarea></td>
			<td id="reviewContentTd"></td>
		</tr>
		<tr>
			<td class="text">사진</td>
			<td><input type="file" name="reviewImage" multiple="multiple"></td>
			<td></td>
		</tr>
	</table>
</div>
<br>
	<div align="center" style="width:800px;">
		<input type="submit" value="리뷰 등록">
		<input type="button" value="취소" id="cancel">
	</div>
</form>
