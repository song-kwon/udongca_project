<%@ page contentType="text/html;charset=utf-8"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/udongca_project/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#cafeAddress").on("click", function(){
		execDaumPostcode();
	});
	
	$("#cafeAddress").on("select", function(){
		execDaumPostcode();
	});
	
	$("#cafeAddress").on("focusin", function(){
		execDaumPostcode();
	});
	
	$("#searchAddressButton").on("click", function(){
		execDaumPostcode();
	});
	
	$("#cafeName").on("blur", function(){
		$("#cafeNameTd").text(($("#cafeName").val()) ? "" : "입력 필수");
	});
	
	$("#cafeIntro").on("blur", function(){
		$("#cafeIntroTd").text(($("#cafeIntro").val()) ? "" : "입력 필수");
	});
	
	$("#operationHour").on("blur", function(){
		$("#operationHourTd").text(($("#operationHour").val()) ? "" : "입력 필수");
	});
	
	$("#cafeTel").on("blur", function(){
		$("#cafeTelTd").text(($("#cafeTel").val()) ? "" : "입력 필수");
	});
	
	$("#managerName").on("blur", function(){
		$("#managerNameTd").text(($("#managerName").val()) ? "" : "입력 필수");
	});
	
	$("#managerTel").on("blur", function(){
		$("#managerTelTd").text(($("#managerTel").val()) ? "" : "입력 필수");
	});
	
	$("#coporateNumber").on("change", function(){
		var result = isValidCoporateNumber();
		if (result){
			$("#coporateNumberTd").text("중복 확인 필요");
		}
	});
	
	$("#isCoporateNumberDuplicated").on("click", function(){
		var result = isValidCoporateNumber();
		if (result){
			$.ajax({
				"url":"/udongca_project/prBoard/isCoporateNumberDuplicated.udc",
				"type":"POST",
				"data":"coporateNumber=" + $("#coporateNumber").val(),
				"dataType":"text",
				"success":function(text){
					$("#coporateNumberTd").text(((text == "true") ? "중복" : "사용 가능" ) + " 사업자 등록 번호");
				},
				"error":function(xhr){
					alert("An error occured: " + xhr.status + " " + xhr.statusText);
				}
			});
		}
	});
	
	$("#themeCheck").on("change", function(){
		if ($("#themeCheck").prop("checked")){
			$.ajax({
				"url":"/udongca_project/prBoard/cafeThemeList.udc",
				"type":"POST",
				"data":"",
				"dataType":"json",
				"success":function(json){
					$("#cafeFeature2").empty().append("<option>테마 선택</option>");
					for (var i = 0; i < json.length; i++){
						$("#cafeFeature2").append("<option value=" + json[i].codeId + ">" + json[i].codeName + "</option>");
					}
				},
				"error":function(xhr){
					alert("An error occured: " + xhr.status + " " + xhr.statusText);
				}
			});
		}
		else{
			$("#cafeFeature2").empty().append("<option>테마 선택</option>");
		}
	});
	
	$("#cancel").on("click", function(){
		history.back();
	});
	
	$("form").on("submit", function(){
		if (!($("#cafeName").val() && $("#operationHour").val() && $("#cafeTel").val() && $("#managerName").val() && $("#managerTel").val() && $("#cafeAddress").val() && $("#coporateNumberTd").text() == "사용 가능 사업자 등록 번호")){
			alert("필수 사항을 입력하세요");
			return false;
		}
	});
});

function execDaumPostcode(){
	new daum.Postcode({
        oncomplete: function(data) {
        	$("#cafeAddress").val(data.jibunAddress);
        	$("#cafeAddressTd").text("");
        },
		onclose: function(state) {
	        //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
	        if(state === 'FORCE_CLOSE' && !($("#cafeAddress"))){
	            //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.
	        	$("#cafeAddressTd").text("입력 필수");
	        }
	    }
    }).open();
};

function isValidCoporateNumber(){
	if (!($("#coporateNumber").val())){
		$("#coporateNumberTd").text("입력 필수");
		return 0;
	}
	else if ($("#coporateNumber").val().length != 10 || !($("#coporateNumber").val().match(/\d{10}/))){
		$("#coporateNumberTd").text("양식에 맞게 입력");
		return 0;
	}
	else{
		$("#coporateNumberTd").text("");
		return 1;
	}
}
</script>
<div class="nonav_bodyDiv" style="width:400px;">
<c:forEach var="${requestScope.errorList}" items="errorList">
	${errorList}<br>
</c:forEach>
<br>
<form action="/udongca_project/prBoard/moveToNewPr2Jsp.udc"	method="post" role="form">
	<div class="form-group">
			<label for="cafeName">카페명</label>
			<input type="text" name="cafeName" value="${requestScope.cafeName}" id="cafeName" class="form-control">
			<span id="cafeNameTd"></span>
	</div>
	<div class="form-group">
			<label for="cafeIntro">카페 소개</label>
			<textarea rows="10" cols="20" name="cafeIntro" id="cafeIntro" class="form-control">${requestScope.cafeIntro}</textarea>
			<span id="cafeIntroTd"></span>
	</div>
		<div class="form-group">
			<label for="cafeFeature">특징</label>
			<div class="form-inline">
			<input type="checkbox" name="cafeFeature1" value="wifi" >와이파이
			<input type="checkbox" name="cafeFeature1" value="socket" >콘센트
			<input type="checkbox" name="cafeFeature1" value="park" >주차
			<input type="checkbox" name="cafeFeature1" value="smoking" >흡연실<br>
			<input type="checkbox" id="themeCheck">테마 
			<select name="cafeFeature2" id="cafeFeature2" class="form-control">
				<option>테마 선택</option>
			</select>
			</div>
		</div>
	<div class="form-group">
			<label for="operationHour">영업시간</label>
			<input type="text" name="operationHour" value="${requestScope.operationHour}" id="operationHour" class="form-control">
			<span id="operationHourTd"></span>
	</div>
	<div class="form-group">
			<label for="cafeTel">카페연락처</label>
			<input type="text" name="cafeTel" value="${requestScope.cafeTel}" id="cafeTel" class="form-control">
			<span id="cafeTelTd"></span>
	</div>
	<div class="form-group">
			<label for="cafeAddress">카페주소</label>
			
			<div class="form-inline">
				<input type="text" name="cafeAddress" value="${requestScope.cafeAddress}" id="cafeAddress" class="form-control">
				<input type="button" value="주소검색" id="searchAddressButton" class="form-control">
				<span id="cafeAddressTd"></span>
			</div>
	</div>
	<div class="form-group">
			<label for="coporateNumber">사업자등록번호</label>
			<div class="form-inline">
				<input type="text" name="coporateNumber" id="coporateNumber" value="${requestScope.coporateNumber}" class="form-control" placeholder=" - 없이 입력">
				<input type="button" value="중복확인" id="isCoporateNumberDuplicated" class="form-control">
			</div>
			<span id="coporateNumberTd"></span>
			
	</div>
	<div class="form-group">
			<label for="managerName">관리자명</label>
			<input type="text" name="managerName" value="${requestScope.managerName}" id="managerName" class="form-control">
			<span id="managerNameTd"></span>
	</div>
	<div class="form-group">
			<label for="managerTel">관리자 연락처</label>
			<input type="text" name="managerTel" value="${requestScope.managerTel}" id="managerTel">
			<span id="managerTelTd"></span>
	</div>
	<div class="form-group">
		<button type="submit" class="btn btn-default">다음단계</button>
		<button type="button" id="cancel">취소</button>
	</div>
</form>
</div>