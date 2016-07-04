<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/udongca_project/scripts/jquery.js"></script>
		<script type="text/javascript">
			var reviewFakeImageArray = "${requestScope.review.reviewFakeImage}".split(";");
			var reviewRealImageArray = "${requestScope.review.reviewRealImage}".split(";");
			var reviewFakeImageArrayNumber = reviewFakeImageArray.length - 1;
			
			$(document).ready(function(){
				$("#reviewTitle").on("blur", function(){
					$("#reviewTitleTd").text(($("#reviewTitle").val()) ? "" : "입력 필수");
				});
				
				$("#reviewContent").on("blur", function(){
					$("#reviewContentTd").text(($("#reviewContent").val()) ? "" : "입력 필수");
				});
				
				for(var i = 0; i < reviewFakeImageArrayNumber; i++){
					$("#reviewImages").append("<img src='/udongca_project/images/" + reviewFakeImageArray[i] + "' class='image" + i + "' height='20' width='20'>");
					$("#reviewImages").append("<button onclick='deleteImage(" + i + ")' class='image" + i + "'>삭제</button>");
					$("#reviewImages").append("<input type='hidden' name='modifiedReviewFakeImage' value='" + reviewFakeImageArray[i] + "' class='image" + i + "'>");
					$("#reviewImages").append("<input type='hidden' name='modifiedReviewRealImage' value='" + reviewRealImageArray[i] + "' class='image" + i + "'>");
					$("#reviewImages").append("<br class='image" + i + "'>");
				}
				
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
			
			function deleteImage(i){
				$(".image" + i).remove();
			}
		</script>
	</head>
	<body>
		<h2>리뷰 수정</h2><br>
		<b>굵은 글씨 항목은 필수 입력 사항을 나타냅니다.</b><br>
		<form action="/udongca_project/review/reviewModify.udc" enctype="multipart/form-data" method="post">
			<input type="hidden" name="reviewNo" value="${requestScope.review.reviewNo}">
			<input type="hidden" name="cafeNo" value="${requestScope.review.cafeNo}">
			<input type="hidden" name="writerId" value="${requestScope.review.memberId}">
			<input type="hidden" name="reviewRealImage" value="${requestScope.review.reviewRealImage}">
			<input type="hidden" name="reviewFakeImage" value="${requestScope.review.reviewFakeImage}">
			<table>
				<tr>
					<td><b>제목</b></td>
					<td><input type="text" name="reviewTitle" id="reviewTitle" value="${requestScope.review.reviewTitle}"></td>
					<td id="reviewTitleTd"></td>
				</tr>
				<tr>
					<td>등급</td>
					<td>
						<select name="ratingStars" id="ratingStars">
							<c:forEach var="i" begin="1" end="5">
								<c:choose>
									<c:when test="${requestScope.review.ratingStars eq i}">
										<option selected>${i}</option>
									</c:when>
									<c:otherwise>
										<option>${i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td><b>내용</b></td>
					<td><textarea rows="10" cols="20" name="reviewContent" id="reviewContent">${requestScope.review.reviewContent}</textarea></td>
					<td id="reviewContentTd"></td>
				</tr>
				<tr>
					<td>기존 리뷰 이미지</td>
					<td id="reviewImages"></td>
					<td></td>
				</tr>
				<tr>
					<td>추가 리뷰 이미지</td>
					<td><input type="file" name="addReviewImage" multiple="multiple"></td>
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