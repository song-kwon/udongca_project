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
		<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=fb0d10514e172c531b661118b62d9c6f&libraries=services"></script>
		<style type="text/css">
		.carousel-inner > .item > img {
		      top: 0;
		      left: 0;
		      width: 600px;
		      height: 400px;
		 } 
		 .carousel-indicators{
		 	bottom:-70px;
		 }
		 .carousel-indicators .active{
		 	width:60px;
		 	height:60px;
		 }
		.carousel-indicators > img{
			width:50px;
			height:50px;
		}
		
		</style>
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
							var a= "'"+json[i].codeName+"'" ;
							$("#menuCategoryList").append('<li><a onclick="menuImage('+$("#cafeNo").val()+','+a+')">' + json[i].codeName + '</a></li>');
						}
					},
					"error":function(xhr){
						alert("An error occured while loading getMenuTypeList.udc: " + xhr.status + " " + xhr.statusText);
					}
				});
				
				$("#imageArea").append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='200' width='200'>");
				
				if ("${sessionScope.login}"){
					if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseemember"){
						$("#buttonArea").append("<button onclick='prModify()'>홍보글 수정</button><button onclick='prDelete()'>홍보글 삭제</button>");
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
			
			function favoriteToggle(){
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
			}; 
			
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
			function menuImage(no,menuType){
			
			$("#content").empty();
				$.ajax({
					"url":"/udongca_project/prBoard/menuList.udc",
					"type":"POST",
					"data":{cafeNumber:no,menuType:menuType},
					"dataType":"json",
					"success":function(obj){
							$("#content").append(
									"<div id='myCarousel' class='carousel slide'>"+
									"<ol class='carousel-indicators'></ol><div class='carousel-inner' role='listbox'></div>");
							for(var i =0;i<obj.length;i++){
								
								if(i==0){
								$(".carousel-inner").append("<div class='item active'>"+
									      "<img src='"+obj[i].menuRealImage+"' alt='americano'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
								$(".carousel-indicators").append("<img src='"+obj[i].menuRealImage+"' data-target='#myCarousel' data-slide-to='0'  class='item1 active'></li>");
								}else{
									$(".carousel-inner").append("<div class='item'>"+
										    "<img src='"+obj[i].menuRealImage+"' alt='americano'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
									$(".carousel-indicators").append("<img src='"+obj[i].menuRealImage+"' data-target='#myCarousel' data-slide-to='0'  class='item1'></li>");
								}
							}
								  
							 // Activate Carousel
						    $("#myCarousel").carousel({interval:500});
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
						alert("An error occured in drink(): " + xhr.status + " " + xhr.statusText);
					}
					
				});
				
			
			function mapLocation(){
				$("#content").empty();
				var mapContainer = document.getElementById('content'), // 지도를 표시할 div 
			    mapOption = {
			        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
				
				// 지도를 생성합니다
				var map = new daum.maps.Map(mapContainer, mapOption); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new daum.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				geocoder.addr2coord('${requestScope.prBoard.cafeAddress}', function(status, result) {
				    // 정상적으로 검색이 완료됐으면
				     if (status === daum.maps.services.Status.OK) {
				        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
						
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new daum.maps.Marker({
				            map: map,
				            position: coords
				        });
						
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new daum.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">카페 위치</div>'
				        });
				        
				        infowindow.open(map, marker);
						
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
			}
			
		/* 	function menuListByType(menuType){
				$.ajax({
					"url":"/udongca_project/prBoard/menuList.udc",
					"type":"POST",
					"data":"cafeNumber=${requestScope.prBoard.cafeNo}&menuType=" + menuType,
					"dataType":"json",
					"success":function(json){
						$("#content").empty();
						for (var i = 0; i < json.length; i++){
							$("#content").append("<a href='javascript:void(0)' onclick='menuRead(" + json[i].menuNO + ")'>" +  json[i].menuName + "</a><br>");
						}
					},
					"error":function(xhr){
						alert("An error occured in menuListByType(): " + xhr.status + " " + xhr.statusText);
					}
				});
			}
			
			function menuRead(menuNO){
				
				$.ajax({
					"url":"/udongca_project/prBoard/menuList.udc",
					"type":"POST",
					"data":"cafeNumber=${requestScope.prBoard.cafeNo}&menuType=" + menuType,
					"dataType":"json",
					"success":function(json){
						$("#content").empty();
						for (var i = 0; i < json.length; i++){
							$("#content").append("<a href='javascript:void(0)' onclick='menuRead(" + json[i].menuNO + ")'>" +  json[i].menuName + "</a><br>");
						}
					},
					"error":function(xhr){
						alert("An error occured in menuListByType(): " + xhr.status + " " + xhr.statusText);
					}
				});
				
			}
			 */
			function reviewList(page){
				
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
				
			}
			}
			</script>
	</head>
	<body>
	<input type="hidden" id="cafeNo" value="${requestScope.prBoard.cafeNo }">
		<table>
			<tr>
				<td id="cafeName" colspan=3><c:out value="${requestScope.prBoard.cafeName}"/></td>
			</tr>
			<tr>
				<td id="optionList">
					<ul>
						<li><a href="javascript:void(0)" onclick="mapLocation();return false;">지도</a></li>
						<li>
							메뉴
							<ul id="menuCategoryList">
							</ul>
						</li>
						<li><a href="javascript:void(0)" onclick="reviewList(1);return false;">리뷰</a></li>
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
							</td>
						</tr>
						<tr>
							<td colspan=2 id="buttonArea">
								
							</td>
					</table>
				</td>
			
			</tr>
			<tr>
			<td></td>
				<td id="content" colspan=3 style="width:350px;height:350px;"></td>
			</tr>
		</table>
	</body>
</html>