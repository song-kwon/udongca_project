<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="/udongca_project/scripts/jquery.js"></script>
		<script type="text/javascript">
			var menuTypeList = null;
			var isAddedFavorite = null;
			var isMemberLicensed = null;
			var cafeFakeImage = "${requestScope.prBoard.cafeFakeImage}";
			var cafeFakeImageArray = cafeFakeImage.split(";");
			var currentImageNumber = 0;
			
			$(document).ready(function(){
				$.ajax({
					"url":"/udongca_project/search/getMenuTypeList.udc",
					"type":"GET",
					"data":"",
					"dataType":"json",
					"success":function(json){
						menuTypeList = json;
					}
				});
				
				if (menuTypeList){
					for(var i = 0; i < menuTypeList.length; i++){
						$("#menuCategoryList").append("<li>" + menuTypeList[i].codeName + "</li>");
					}
				}
				
				if ("${sessionScope.login}"){
					if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseemember"){
						$("#buttonArea").append("<button onclick='prModify()'>홍보글 수정</button>");
						$("#buttonArea").append("<button onclick='prDelete()'>홍보글 삭제</button>");
					}
					else{
						$.ajax({
							"url":"/udongca_project/member/getMemberBookmark.udc",
							"type":"POST",
							"data":"memberId=" + "${sessionScope.login.memberId}",
							"dataType":"json",
							"success":function(json){
								isAddedFavorite = (json) ? true : false;
							}
						});
						
						$("#buttonArea").append("<button onclick='favorite" + ((isAddedFavorite) ? "Remove()'>즐겨찾기 해제" : "Add()'>즐겨찾기 추가") + "</button>");
						$("#buttonArea").append("<button onclick='prReport()'>홍보글 신고</button>");
					}
				}
			});
			
			function prModify(){
				
			};
			
			function prDelete(){
				
			};
			
			function prReport(){
				
			};
			
			function favoriteRemove(){
				
			};
			
			function favoriteAdd(){
				
			};
			
			function prevImage(){
				
			};
			
			function nextImage(){
				
			};
		</script>
	</head>
	<body>
		${requestScope.prBoard}<br>
		<table>
			<tr>
				<td id="cafeName" colspan=3>${requestScope.prBoard.cafeName}</td>
			</tr>
			<tr>
				<td id="optionList">
					<ul>
						<li id="location">지도</li>
						<li>
							메뉴
							<ul id="menuCategoryList">
							</ul>
						</li>
						<li id="reviewList">리뷰</li>
					</ul>
				</td>
				<td>그림 띄울 곳
					<!--
						홍보글 객체에서 fakeImage를 불러 와, 이를 Split한 뒤 for 문으로 조회하면서 경로를 조회해야 함.
					-->
					<div id="imageArea"></div>
					<button onclick="prevImage()"></button>
					<button onclick="nextImage()"></button>
				</td>
				<td id="cafeInfo">
					<table>
						<tr>
							<td>카페 소개</td>
							<td>${requestScope.prBoard.cafeIntro}</td>
						</tr>
						<tr>
							<td>영업 시간</td>
							<td>${requestScope.prBoard.operationHour}</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td>
								카페: ${requestScope.prBoard.cafeTel}<br>
								사업자: ${requestScope.prBoard.managerTel}
							</td>
						</tr>
						<tr>
							<td>카페 특징</td>
							<td>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'wifi')}">
									<img src="/udongca_project/udongca-image/coffee-cup-with-wireless-symbol.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'socket')}">
									<img src="/udongca_project/udongca-image/socket.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'park')}">
									<img src="/udongca_project/udongca-image/parking-sign.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'smoking')}">
									<img src="/udongca_project/udongca-image/smoking-area.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme1')}">
									<img src="/udongca_project/udongca-image/sweet-cake-piece.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme2')}">
									<img src="/udongca_project/udongca-image/books-stack.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme3')}">
									<img src="/udongca_project/udongca-image/plain-dog.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme4')}">
									<img src="/udongca_project/udongca-image/halloween-black-cat.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme5')}">
									<img src="/udongca_project/udongca-image/mother-and-child-with-balloons.png" height="64" width="64">
								</c:if>
								<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme6')}">
									<img src="/udongca_project/udongca-image/question-button.png" height="64" width="64">
								</c:if>
								<!--
									특징에 따라 Image를 출력할 예정 
									홍보글 객체의 cafeFeature에 있는 문자열들을 공백에 따라 분리함
									분리된 문자열 배열을 조건문을 포함한 반복문에 포함시켜, 문자열에 대응되는 이미지 파일을 불러옴.
								 -->
							</td>
						</tr>
						<tr>
							<td colspan=2 id="buttonArea">
								
							</td>
					</table>
				</td>
			</tr>
			<tr>
				<td id="content" colspan=3>지도/메뉴 목록/리뷰 목록</td>
			</tr>
		</table>
	</body>
</html>