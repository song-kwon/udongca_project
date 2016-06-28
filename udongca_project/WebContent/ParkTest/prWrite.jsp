<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
				
				$("#coporateNumb").on("change", function(){
					var result = isValidCoporateNumb();
					if (result){
						$("#coporateNumbTd").text("중복 확인 필요");
					}
				});
				
				$("#isCoporateNumbDuplicated").on("click", function(){
					var result = isValidCoporateNumb();
					if (result){
						$.ajax({
							"url":"/udongca_project/prBoard/isCoporateNumbDuplicated.udc",
							"type":"POST",
							"data":"coporateNumb=" + $("#coporateNumb").val(),
							"dataType":"text",
							"success":function(text){
								$("#coporateNumbTd").text(((text == "true") ? "중복" : "사용 가능" ) + " 사업자 등록 번호");
							},
							"error":function(xhr){
								alert("An error occured: " + xhr.status + " " + xhr.statusText);
							}
						});
					}
				});
				
				$("#theme").on("change", function(){
					if ($("#theme").prop("checked")){
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
					if (!($("#cafeName").val() && $("#operationHour").val() && $("#cafeTel").val() && $("#managerName").val() && $("#managerTel").val() && $("#cafeAddress").val() && $("#coporateNumbTd").text() == "사용 가능 사업자 등록 번호")){
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
			
			function isValidCoporateNumb(){
				if (!($("#coporateNumb").val())){
					$("#coporateNumbTd").text("입력 필수");
					return 0;
				}
				else if ($("#coporateNumb").val().length != 10 || !($("#coporateNumb").val().match(/\d{10}/))){
					$("#coporateNumbTd").text("양식에 맞게 입력");
					return 0;
				}
				else{
					$("#coporateNumbTd").text("");
					return 1;
				}
			}
		</script>
	</head>
	<body>
		굵은 글씨 항목은 필수 입력 사항을 나타냅니다.<br>
		<form action="/udongca_project/prBoard/moveToNewPr2Jsp.udc" method="post">
			<table>
				<tr>
					<td><b>카페명</b></td>
					<td><input type="text" name="cafeName" id="cafeName"></td>
					<td id="cafeNameTd"></td>
				</tr>
				<tr>
					<td>카페 소개</td>
					<td><textarea rows="10" cols="20" name="cafeIntro" id="cafeIntro"></textarea></td>
					<td></td>
				</tr>
				<tr>
					<td>특징</td>
					<td>
						<input type="checkbox" name="cafeFeature1" value="wifi">와이파이
						<input type="checkbox" name="cafeFeature1" value="socket">콘센트
						<input type="checkbox" name="cafeFeature1" value="park">주차
						<input type="checkbox" name="cafeFeature1" value="smoking">흡연실<br>
						<input type="checkbox" id="theme">테마
						<select name="cafeFeature2" id="cafeFeature2">
							<option>테마 선택</option>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td><b>영업시간</b></td>
					<td><input type="text" name="operationHour" id="operationHour"></td>
					<td id="operationHourTd"></td>
				</tr>
				<tr>
					<td><b>카페연락처</b></td>
					<td><input type="text" name="cafeTel" id="cafeTel"></td>
					<td id="cafeTelTd"></td>
				</tr>
				<tr>
					<td><b>카페주소</b></td>
					<td>
						<input type="text" name="cafeAddress" id="cafeAddress">
						<input type="button" value="주소검색" id="searchAddress">
					</td>
					<td id="cafeAddressTd"></td>
				</tr>
				<tr>
					<td><b>사업자등록번호</b><br> - 없이 입력</td>
					<td>
						<input type="text" name="coporateNumb" id="coporateNumb">
						<input type="button" value="중복확인" id="isCoporateNumbDuplicated">
					</td>
					<td id="coporateNumbTd"></td>
				</tr>
				<tr>
					<td><b>관리자명</b></td>
					<td><input type="text" name="managerName" id="managerName"></td>
					<td id="managerNameTd"></td>
				</tr>
				<tr>
					<td><b>관리자 연락처</b></td>
					<td><input type="text" name="managerTel" id="managerTel"></td>
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