<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script src="/udongca_project/scripts/jquery.js"></script>
		<script type="text/javascript">
			var wifiChecked = false;
			var socketChecked = false;
			var parkChecked = false;
			var smokingChecked = false;
			var themeSelected = null;
			
			var cafeFeatureArray = "${requestScope.prBoard.cafeFeature}".split(" ");
			for (var i = 0; i < cafeFeatureArray.length; i++){
				if (cafeFeatureArray[i] == "wifi"){
					wifiChecked = true;
				}
				if (cafeFeatureArray[i] == "socket"){
					socketChecked = true;
				}
				if (cafeFeatureArray[i] == "park"){
					parkChecked = true;
				}
				if (cafeFeatureArray[i] == "smoking"){
					smokingChecked = true;
				}
			}
			themeSelected = cafeFeatureArray[cafeFeatureArray.length - 1];
			
			$(document).ready(function(){
				$("#cafeFeature1Wifi").prop("checked", wifiChecked);
				$("#cafeFeature1Socket").prop("checked", socketChecked);
				$("#cafeFeature1Park").prop("checked", parkChecked);
				$("#cafeFeature1Smoking").prop("checked", smokingChecked);
				$("#cafeFeature2").prop("selected", themeSelected);
				
				$("#cafeAddress").on("click", function(){
					execDaumPostcode();
				});
				
				$("#cafeAddress").on("select", function(){
					execDaumPostcode();
				});
				
				$("#searchAddress").on("click", function(){
					execDaumPostcode();
				});
				
				$("#cafeName").on("blur", function(){
					$("#cafeNameTd").text(($("#cafeName").val()) ? "" : "입력 필수");
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
				
				$("#theme").on("change", function(){
					if ($("#theme").prop("checked")){
						$.ajax({
							"url":"/udongca_project/prBoard/themeList.udc",
							"type":"POST",
							"data":"",
							"dataType":"json",
							"success":function(json){
								alert("test");
							},
							"error":function(xhr){
								alert("An error occured: " + xhr.status + " " + xhr.statusText);
							}
						});
					}
					else{
						$("#theme").empty().append("<option>테마 선택</option>");
					}
				});
				
				$("#submit").on("click", function(){
					history.back();
				});
				
				$("form").on("submit", function(){
					if (!($("#cafeName").val() && $("#operationHour").val() && $("#cafeTel").val() && $("#managerName").val() && $("#cafeAddress").val() && $("#coporateNumbTd").text() == "사용 가능 사업자 등록 번호")){
						alert("필수 사항을 입력하세요");
						return false;
					}
				});
			});
		</script>
	</head>
	<body>
		굵은 글씨 항목은 필수 입력 사항을 나타냅니다.<br>
		<form action="/udongca_project/prBoard/prModify.udc" method="post">
			<table>
				<tr>
					<td><b>카페명</b></td>
					<td><input type="text" name="cafeName" id="cafeName" value="${requestScope.prBoard.cafeName}"></td>
					<td id="cafeNameTd"></td>
				</tr>
				<tr>
					<td>카페 소개</td>
					<td><textarea rows="10" cols="20" name="cafeIntro" id="cafeIntro">${requestScope.prBoard.cafeIntro}</textarea></td>
					<td></td>
				</tr>
				<tr>
					<td>특징</td>
					<td>
						<input type="checkbox" name="cafeFeature1" id="cafeFeature1Wifi" value="wifi">와이파이
						<input type="checkbox" name="cafeFeature1" id="cafeFeature1Socket" value="socket">콘센트
						<input type="checkbox" name="cafeFeature1" id="cafeFeature1Park" value="park">주차
						<input type="checkbox" name="cafeFeature1" id="cafeFeature1Smoking" value="smoking">흡연실<br>
						<input type="checkbox" id="theme">테마
						<select name="cafeFeature2" id="cafeFeature2">
							<option>테마 선택</option>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td><b>영업시간</b></td>
					<td><input type="text" name="operationHour" id="operationHour" value="${requestScope.prBoard.operationHour}"></td>
					<td id="operationHourTd"></td>
				</tr>
				<tr>
					<td><b>카페연락처</b></td>
					<td><input type="text" name="cafeTel" id="cafeTel" value="${requestScope.prBoard.cafeTel}"></td>
					<td id="cafeTelTd"></td>
				</tr>
				<tr>
					<td><b>카페주소</b></td>
					<td>
						<input type="text" name="cafeAddress" id="cafeAddress" value="${requestScope.prBoard.cafeAddress}">
						<input type="button" value="주소검색" id="searchAddress">
					</td>
					<td id="cafeAddressTd"></td>
				</tr>
				<tr>
					<td><b>관리자명</b></td>
					<td><input type="text" name="managerName" id="managerName" value="${requestScope.prBoard.managerName}"></td>
					<td id="managerNameTd"></td>
				</tr>
				<tr>
					<td><b>관리자 연락처</b></td>
					<td><input type="text" name="managerTel" value="${requestScope.prBoard.managerTel}"></td>
					<td id="managerTelTd"></td>
				</tr>
				<tr>
					<td><input type="submit" value="확인"></td>
					<td><input type="button" value="취소" id="cancel"></td>
					<td></td>
				</tr>
			</table>
		</form>
	</body>
</html>