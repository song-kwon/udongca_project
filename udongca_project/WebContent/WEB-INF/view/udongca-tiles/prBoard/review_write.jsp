<%@ page contentType="text/html;charset=utf-8"%>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("input[type='text']").prop({"class":"form-control"});
		for (var i = 1; i < 6; i++){
			$("#ratingStars").append("<option>" + i + "</option>");
		}
		
		$("#reviewTitle").on("keyup keypress", function(){
			if($(this).val().length>50){
				$(this).val($(this).val().substr(0,50));
				return false;
			}
		});
		
		$("#cancel").on("click", function(){
			history.back();
		});
	});
		
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
	width:100px;
	height:40px;
}

</style>
<div><h1>리뷰 등록</h1></div><br>
<div style="color:red;"><font size="3">*표시 항목은 필수 입력 사항입니다.</font></div><br>
<form action="/udongca_project/review/reviewWrite.udc" enctype="multipart/form-data" method="post" onsubmit="return checkSubmit();">
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
				<select name="ratingStars" id="ratingStars" class="form-control" style="width:130px;">
				</select>
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
