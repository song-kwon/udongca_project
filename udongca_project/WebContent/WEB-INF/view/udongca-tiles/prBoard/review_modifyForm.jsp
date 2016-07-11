<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
	var reviewFakeImageArray = "${requestScope.review.reviewFakeImage}".split(";");
	var reviewRealImageArray = "${requestScope.review.reviewRealImage}".split(";");
	var reviewFakeImageArrayNumber = reviewFakeImageArray.length - 1;
	
	$(document).ready(function(){
		$("button").prop({"class":"btn btn-default"});
		$("input[type='text']").prop({"class":"form-control"});
		
		$("#reviewTitle").on("keyup keypress", function(){
			if($(this).val().length>50){
				$(this).val($(this).val().substr(0,50));
				return false;
			}
		});
		
		for(var i = 0; i < reviewFakeImageArrayNumber; i++){
			$("#reviewImages").append("<img src='/udongca_project/images/" + reviewFakeImageArray[i] + "' class='image" + i + "' height='300' width='400'>");
			$("#reviewImages").append("<button onclick='deleteImage(" + i + ")' class='image" + i + " btn btn-default'>삭제</button>");
			$("#reviewImages").append("<input type='hidden' name='modifiedReviewFakeImage' value='" + reviewFakeImageArray[i] + "' class='image" + i + "'>");
			$("#reviewImages").append("<input type='hidden' name='modifiedReviewRealImage' value='" + reviewRealImageArray[i] + "' class='image" + i + "'>");
			$("#reviewImages").append("<br class='image" + i + "'>");
		}
		
		$("#cancel").on("click", function(){
			history.back();
		});
		
	});
	
	function deleteImage(i){
		$(".image" + i).remove();
	}
	
	function chkTitle(){
		if(!$("#reviewTitle").val()){
			return false;
		}else
			return true;
	}
	function chkContent(){
		if(!$("#reviewContent").val()){
			return false;
		}else
			return true;
	}

	function chkRatingStars(){
		if($("#ratingStars").val()=="1"){
			return false;
		}
		else
			return true;
	}
	
	function checkSubmit(){
		var checkRatingStars = chkRatingStars();
		var checkTitle = chkTitle();
		var checkContent = chkContent();
		
		if(checkTitle==false){
			alert("제목을 입력해주세요.");
			return false;
		}else if(checkContent==false){
			alert("내용을 입력해주세요.");
			return false;
		}else{
			if(checkRatingStars==false){
				var ratingResult=confirm("기본 등급은 1점입니다. 등록하시겠습니까?");
				if(ratingResult==true)
					return true;
				else
					return false;
			}
			var result = confirm("등록하시겠습니까?");
			if(result==true)
				return true;
			else
				return false;
		}
	}
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
	width:130px;
	height:40px;
}

</style>



<div><h1>리뷰 수정</h1></div>
<div style="color:red;"><font size="3">*표시 항목은 필수 입력 사항입니다.</font></div><br>
<form action="/udongca_project/review/reviewModify.udc" enctype="multipart/form-data" method="post" onsubmit="return checkSubmit();">
	<div class="div">
	<input type="hidden" name="reviewNo" value="${requestScope.review.reviewNo}">
	<input type="hidden" name="cafeNo" value="${requestScope.review.cafeNo}">
	<input type="hidden" name="writerId" value="${requestScope.review.memberId}">
	<input type="hidden" name="reviewRealImage" value="${requestScope.review.reviewRealImage}">
	<input type="hidden" name="reviewFakeImage" value="${requestScope.review.reviewFakeImage}">
	<table>
		<tr>
			<td class="text">*제목</td>
			<td><input type="text" name="reviewTitle" id="reviewTitle" value="${requestScope.review.reviewTitle}"></td>
			<td id="reviewTitleTd"></td>
		</tr>
		<tr>
			<td class="text">등급</td>
			<td>
				<select name="ratingStars" id="ratingStars" class="form-control" style="width:130px;">
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
			<td class="text">*내용</td>
			<td><textarea rows="30" cols="80" name="reviewContent" id="reviewContent">${requestScope.review.reviewContent}</textarea></td>
			<td id="reviewContentTd"></td>
		</tr>
		<tr>
			<td class="text">기존 이미지</td>
			<td id="reviewImages" style="padding:20px;"></td>
			<td></td>
		</tr>
		<tr>
			<td class="text">추가 이미지</td>
			<td><input type="file" name="addReviewImage" multiple="multiple"></td>
			<td></td>
		</tr>
	</table>
</div>
	<br>
	<div align="center" style="width:800px;">
		<input type="submit" value="리뷰 수정">
		<input type="button" value="취소" id="cancel">
	</div>
</form>