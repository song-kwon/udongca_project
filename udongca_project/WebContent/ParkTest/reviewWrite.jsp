<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/udongca_project/scripts/jquery.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				for (var i = 1; i < 6; i++){
					$("#ratingStars").append("<option>" + i + "</option>");
				}
				
				$("#reviewTitle").on("blur", function(){
					$("#reviewTitleTd").text(($("#reviewTitle").val()) ? "" : "입력 필수");
				});
				
				$("#reviewContent").on("blur", function(){
					$("#reviewContentTd").text(($("#reviewContent").val()) ? "" : "입력 필수");
				});
				
				$("#cancel").on("click", function(){
					history.back();
				});
				
				$("form").on("submit", function(){
					if (!($("#reviewTitle").val() && $("#reviewContent").val())){
						alert("필수 사항을 입력하세요");
						return false;
					}
				});
			});
		</script>
	</head>
	<body>
		<h2>리뷰 등록</h2><br>
		<b>굵은 글씨 항목은 필수 입력 사항을 나타냅니다.</b><br>
		<form action="/udongca_project/review/reviewWrite.udc" enctype="multipart/form-data" method="post">
			<input type="hidden" name="cafeNo" value="${requestScope.cafeNo}">
			<table>
				<tr>
					<td><b>제목</b></td>
					<td><input type="text" name="reviewTitle" id="reviewTitle"></td>
					<td id="reviewTitleTd"></td>
				</tr>
				<tr>
					<td>등급</td>
					<td>
						<select name="ratingStars" id="ratingStars"></select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td><b>내용</b></td>
					<td><textarea rows="10" cols="20" name="reviewContent" id="reviewContent"></textarea></td>
					<td id="reviewContentTd"></td>
				</tr>
				<tr>
					<td>사진</td>
					<td><input type="file" name="reviewImage" multiple="multiple"></td>
					<td></td>
				</tr>
				<tr>
					<td><input type="submit" value="확인"></td>
					<td><input type="button" value="취소" id="cancel"></td>
					<td></td>
			</table>
		</form>
	</body>
</html>