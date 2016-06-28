<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
		<script type="text/javascript">
			var isAddedFavorite = null;
			var isMemberLicensed = null;
			var cafeFakeImageArray = "${requestScope.prBoard.cafeFakeImage}".split(";");
			var cafeFakeImageArrayNumber = cafeFakeImageArray.length - 1;
			var currentImageNumber = 0;
			
			$(document).ready(function(){
				
				$.ajax({
					"url":"/udongca_project/prBoard/cafeMenuList.udc",
					"type":"GET",
					"data":"",
					"dataType":"json",
					"success":function(json){
						for(var i = 0; i < json.length; i++){
							$("#menuCategoryList").append("<li><a href='/udongca_project/prBoard/menuList.udc?cafeNumber=${requestScope.prBoard.cafeNo}&menuType=" + json[i].codeId + "'>" + json[i].codeName + "</a></li>");
						}
					},
					"error":function(xhr){
						alert("An error occured while loading getMenuTypeList.udc: " + xhr.status + " " + xhr.statusText);
					}
				});
				
				$("#imageArea").append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='200' width='200'>");
				
				if ("${sessionScope.login}"){
					if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseemember"){
						$("#buttonArea").append("<button onclick='prModify()'>홍보글 수정</button>");
						$("#buttonArea").append("<button onclick='prDelete()'>홍보글 삭제</button>");
					}
					else{
						$.ajax({
							"url":"/udongca_project/member/isBookmarkAdded.udc",
							"type":"POST",
							"data":"cafeNo=" + "${requestScope.prBoard.cafeNo}",
							"dataType":"json",
							"success":function(json){
								isAddedFavorite = json;
								$("#buttonArea").append("<button onclick='favoriteToggle()'>즐겨찾기 " + ((isAddedFavorite) ? "해제" : "추가") + "</button>");
							},
							"error":function(xhr){
								alert("An error occured while loading isBookmarkAdded.udc: " + xhr.status + " " + xhr.statusText);
							}
						});
						
						$("#buttonArea").append("<button onclick='prReport()'>홍보글 신고</button>");
					}
				}
				
			    


			});
			
			function prModify(){
				window.location.href = "prModifyForm.udc?cafeNo=${requestScope.prBoard.cafeNo}";
			};
			
			function prDelete(){
				if (window.confirm("정말 삭제하겠습니까?")){
					window.location.href = "prDelete.udc?cafeNo=${requestScope.prBoard.cafeNo}";
				}
			};
			
			function prReport(){
				window.open();
				// window.open을 이용해 Form을 열고, 거기서 사유를 선택하도록 해야 할 것.
			};
			
			/* function favoriteToggle(){
				$.ajax({
					"url":"/udongca_project/member/" + ((isAddedFavorite) ? "delete" : "insert" ) + "Bookmark.udc",
					"type":"POST",
					"data":"cafeNo=" + "${requestScope.prBoard.cafeNo}",
					"dataType":"json",
					"success":function(json){
						alert(((json) ? ("즐겨찾기에" + ((isAddedFavorite) ? "서 삭제" : " 추가" )) : ("오류가 발생") ) + "했습니다");
						location.reload(true);
					},
					"error":function(xhr){
						alert("An error occured in favoriteToggle(): " + xhr.status + " " + xhr.statusText);
					}
				});
			}; */
			
			function prevImage(){
				currentImageNumber--;
				if (currentImageNumber < 0){
					currentImageNumber = cafeFakeImageArrayNumber - 1;
				}
				$("#imageArea").empty().append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='200' width='200'>");
			};
			
			function nextImage(){
				currentImageNumber++;
				if (currentImageNumber > cafeFakeImageArrayNumber - 1){
					currentImageNumber = 0;
				}
				$("#imageArea").empty().append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='200' width='200'>");
			};
			function drink(no,menuType){
				$("#imageArea").empty();
				$("#cafeInfo").empty();
				$.ajax({
					"url":"/udongca_project/prBoard/menuList.udc",
					"type":"POST",
					"data":{cafeNumber:no,menuType:menuType},
					"dataType":"json",
					"success":function(obj){
							$("#cafeInfo").append(
									"<div id='myCarousel' class='carousel slide'>"+
									"<ol class='carousel-indicators'>"+
								    "<li data-target='#myCarousel' data-slide-to='0'  class='item1 active'></li>"+
								    "<li data-target='#myCarousel' data-slide-to='1' class='item2'></li>"+
								    "<li data-target='#myCarousel' data-slide-to='2' class='item3'></li>"+
								    "<li data-target='#myCarousel' data-slide-to='3' class='item4'></li>"+
								  "</ol>"+
								 " <div class='carousel-inner' role='listbox'></div>"); 
							for(var i =0;i<obj.length;i++){
								if(i==0){
								$(".carousel-inner").append("<div class='item active'>"+
									      "<img src='"+obj[i].menuRealImage+"' alt='americano' height='500' width='500'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
								}else{
									$(".carousel-inner").append("<div class='item'>"+
										    "<img src='"+obj[i].menuRealImage+"' alt='americano' height='500' width='500'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
								}
							}
								  
							 // Activate Carousel
						    $("#myCarousel").carousel();
						    // Enable Carousel Indicators
						    $(".item1").on("click",function(){
						        $("#myCarousel").carousel(0);
						    });
						    $(".item2").click(function(){
						        $("#myCarousel").carousel(1);
						    });
						    $(".item3").click(function(){
						        $("#myCarousel").carousel(2);
						    });
						    $(".item4").click(function(){
						        $("#myCarousel").carousel(3);
						    });
					},
					"error":function(xhr){
						//alert("An error occured in drink(): " + xhr.status + " " + xhr.statusText);
					}
					
				});
				
			}
		</script>
	</head>
	<body>
		<table>
			<tr>
				<td id="cafeName" colspan=3><c:out value="${requestScope.prBoard.cafeName}"/></td>
			</tr>
			<tr>
				<td id="optionList">
					<ul>
						<li><a href="">지도</a></li>
						<li>
							메뉴
							<ul id="menuCategoryList">
							<li onclick="drink(${requestScope.prBoard.cafeNo },'drink')">음료</li>
							<li>디저트</li>
							<li>베이커리</li>
							</ul>
						</li>
						<li><a href="">리뷰</a></li>
					</ul>
				</td>
				<td>
					<!--
						홍보글 객체에서 fakeImage를 불러 와, 이를 Split한 뒤 for 문으로 경로를 순차적으로 조회.
					-->
				
					<div id="imageArea"></div>
					<button onclick="prevImage()">이전</button>
					<button onclick="nextImage()">다음</button>
				</td>
				<td id="cafeInfo">
					<table>
						<tr>
							<td>카페 소개</td>
							<td><pre><c:out value="${requestScope.prBoard.cafeIntro}"/></pre></td>
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