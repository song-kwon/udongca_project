<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	.replyContent{
		text-indent: 20px;
		height:30px;
	}
	.reReplyContent{
		text-indent: 50px;
		height:40px;
	}
	.reReply{
		text-indent: 50px;
	}
</style>

<script type="text/javascript">
	var isAddedFavorite = null;
	var isMemberLicensed = null;
	var cafeFakeImageArray = "${requestScope.prBoard.cafeFakeImage}".split(";");
	var cafeFakeImageArrayNumber = cafeFakeImageArray.length - 1;
	var currentImageNumber = 0;
	var currentMenuList = null;
	var currentMenuType = null;
	var cafeReviewCount = Number("${requestScope.prBoard.cafeReviewCount}");
	var cafeRating = Number("${requestScope.prBoard.cafeRating}");
	var cafeAverageRating = (cafeReviewCount) ? cafeRating / cafeReviewCount : 0;
	var countGroup = null;
	var currentReviewNo = null;
	
	$(document).ready(function(){
		$.ajax({
			"url":"/udongca_project/prBoard/cafeMenuList.udc",
			"type":"GET",
			"data":"",
			"dataType":"json",
			"success":function(json){
				for(var i = 0; i < json.length; i++){
					var a= "'"+json[i].codeName+"'" ;
					$("#menuCategoryList").append('<li><a onclick="menuImage('+$("#cafeNo").val()+','+ a +')">' + json[i].codeName + '</a></li>');
				}
			},
			"error":function(xhr){
				alert("An error occured while loading cafeMenuList.udc: " + xhr.status + " " + xhr.statusText);
			}
		});
		
		$("#imageArea").append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='200' width='200'>");
		
		if ("${sessionScope.login}"){
			if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseeMember"){
				$("#buttonArea").append("<button onclick='prModify()'>홍보글 수정</button><button onclick='prDelete()'>홍보글 삭제</button>");
			}
			else{
				if("${sessionScope.login.memberType}" == "generalMember"){
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
				}
				$("#buttonArea").append("<button onclick='prReport()'>홍보글 신고</button>");
			}
		}
		
		$("#cafeAverageRatingNumber").text(cafeAverageRating.toPrecision(3) + " / ${requestScope.prBoard.cafeReviewCount}");
		
		for (var i = 1; i < 6; i++){
			$("#cafeAverageRatingIcon").append("<img src='/udongca_project/udongca-image/star" + ((i <= cafeAverageRating) ? "1" : "0" ) + ".png' height='32' width='32'>");
		}
		
		$(document).on('click','#addReply',function(){
			$.ajax({
				'url':'/udongca_project/review/addReply.udc',
				'type':'post',
				'data':{'replyId':'${sessionScope.login.memberId}','replyContent':$('#replyContent').val(),'replyGroup':countGroup,'reviewNo':currentReviewNo},
				'dataType':'json',
				'error':function(xhr){alert('error occured while adding reply: ' + xhr.status + ' ' + xhr.statusText)},
				'success':function(json){
					if(json==null){
						alert('등록 실패. 다시 시도하세요.');
						return false;
					}
					reviewDetail(currentReviewNo);
				}
			});
		});
		
		$(document).on('click','.reReplyInputBtn',function(){
			alert("reReplyInputBtn");
			$("#reReplyInput").remove();
			alert($(this).parent().parent().parent().prop('id'));
			$(this).parent().parent().parent().append("<div id='reReplyInput' style='height:40px;'><input type='text' id='reReplyContent' placeholder='댓글 입력'><button class='addReReply'>등록</button></div>");
		});
		
		$(document).on('click','.addReReply',function(){
			alert("addReReply");
			var reReply = $(this).parent().parent();
			alert(reReply.prop('id'))//parentReply
			alert(reReply.children(':first').prop('class'))//group
			alert(reReply.children(':first').find(':first').prop('id'))//targetName
			$.ajax({
				'url':'/udongca_project/review/addReReply.udc',
				'type':'post',
				'data':{'replyId':'${sessionScope.login.memberId}','replyContent':$('#reReplyContent').val(),'reviewNo':currentReviewNo,'parentReply':reReply.prop('id'),'targetName':reReply.children(':first').find(':first').prop('id'),'replyGroup':reReply.children(':first').prop('class')},
				'dataType':'json',
				'error':function(xhr){
					alert('error occured while adding re-reply: ' + xhr.status + ' ' + xhr.statusText);
				},
				'success':function(json){
					if(json==null){
						alert('등록 실패. 다시 시도하세요.');
						return false;
					}
					reviewDetail(currentReviewNo);
				}
			});
		});
		
		$(document).on('click','.deleteReply',function(){
			if (window.confirm("정말 삭제하겠습니까?")){
				$.ajax({
					'url':'/udongca_project/review/deleteReply.udc',
					'type':'post',
					'data':'replyNo=' + $(this).parent().parent().parent().prop('id'),
					'dataType':'json',
					'error':function(xhr){
						alert('error occured while deleting reply: ' + xhr.status + ' ' + xhr.statusText);
					},
					'success':function(json){
						reviewDetail(currentReviewNo);
					}
				});
			}
		});
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
		$("#content").attr("style", "");
		$.ajax({
			"url":"/udongca_project/prBoard/menuList.udc",
			"type":"POST",
			"data":{cafeNumber:no,menuType:menuType},
			"dataType":"json",
			"success":function(obj){
				if(obj != ""){
					$("#content").append(
							"<div id='myCarousel' class='carousel slide'>"+
							"<ol class='carousel-indicators'></ol><div class='carousel-inner' role='listbox'></div>");
					for(var i =0;i<obj.length;i++){

						if(i==0){
						$(".carousel-inner").append("<div class='item active'>"+
							      "<img src='/udongca_project/images/"+obj[i].menuFakeImage+"' alt='"+obj[i].menuName+"'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
						$(".carousel-indicators").append("<img src='/udongca_project/images/"+obj[i].menuFakeImage+"' data-target='#myCarousel' data-slide-to='0'  class='item1 active'></li>");
						}else{
							$(".carousel-inner").append("<div class='item'>"+
								    "<img src='/udongca_project/images/"+obj[i].menuFakeImage+"' alt='"+obj[i].menuName+"'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
							$(".carousel-indicators").append("<img src='/udongca_project/images/"+obj[i].menuFakeImage+"' data-target='#myCarousel' data-slide-to='"+(i)+"'  class='item"+(i+1)+"'></li>");
						}
					}
					 // Activate Carousel
				    $("#myCarousel").carousel({interval:3000});
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
				}
				else{
					$("#content").append("해당 카테고리의 메뉴가 존재하지 않습니다<br>");
				}
				
				if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseeMember"){
					$("#content").append("<button onclick='menuModifyForm()'>메뉴 수정</button>");
				}
			},
			"error":function(xhr){
				alert("An error occured in menuImage(): " + xhr.status + " " + xhr.statusText);
			}
		});
	}
	
	function mapLocation(){
		$("#content").empty();
		$("#content").attr("style", "width:350px;height:350px;");
		
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
	
	function menuModifyForm(){
		window.location.href = "menuModifyForm.udc?cafeNo=${requestScope.prBoard.cafeNo}";
	}
	
	function reviewList(page){
		var html = "";
		$("#content").empty();
		$("#content").attr("style", "");
		$.ajax({
			"url":"/udongca_project/review/cafeReviewListPaging.udc",
			"type":"POST",
			"data":"cafeNo=${requestScope.prBoard.cafeNo}&pnum=" + page,
			"dataType":"json",
			"success":function(json){
				if (!json.list.length){
					html += "리뷰가 존재하지 않습니다<br>"
				}
				else{
					html += "<table>";
					for (var i = 0; i < json.list.length; i++){
						html += "<tr>";
						html += "<td>" + json.list[i].reviewNo + "</td>";
						html += "<td><a href='javascript:void(0)' onclick='reviewDetail(" + json.list[i].reviewNo + ")'>" + json.list[i].reviewTitle + "</a></td>";
						html += "<td>" + json.list[i].reviewDate + "</td>";
						html += "</tr>";
					}
					html += "</table><br>";
					html += ((!json.pageBean.previousPageGroup) ? "◀" : "<a href='javascript:void(0)' onclick='reviewList(" + (json.pageBean.beginPage-1) + ")'>◀</a>");
					
					for (var i = json.pageBean.beginPage; i < json.pageBean.endPage+1; i++){
						html += ((i == page) ? "<b>" + i + "</b>" : "<a href='javascript:void(0)' onclick='reviewList(" + i + ")'>" + i + "</a>");
					}
					
					html += ((!json.pageBean.nextPageGroup) ? "▶" : "<a href='javascript:void(0)' onclick='reviewList(" + (json.pageBean.endPage+1) + ")'>▶</a><br>");
				}
				
				if ("${sessionScope.login.memberType}" == "generalMember"){
					html += "<button onclick=reviewWrite()>리뷰 작성</button>";
				}
				
				$("#content").append(html);
			},
			
			"error":function(xhr){
				alert("An error occured in reviewList(): " + xhr.status + " " + xhr.statusText);
			}
		});
	}
	
	function reviewDetail(reviewNo){
		var html = "";
		var reviewImageArray = null;
		$("#content").empty();
		$.ajax({
			"url":"/udongca_project/review/reviewDetail.udc",
			"type":"POST",
			"data":"cafeNo=" + $("#cafeNo").val() + "&reviewNo=" + reviewNo,
			"dataType":"json",
			"success":function(json){
				countGroup = json.countGroup;
				currentReviewNo = reviewNo;
				
				$("#content").append("<table><tr><td id='reviewArea'></td></tr><tr><td id='replyArea'></td></tr></table>");
				
				var writerId = "'" + json.review.memberId + "'";
				reviewImageArray = json.review.reviewFakeImage.split(";");
				html += "<table><tr><td id='reviewTitle'></td>";
				html += "<td>" + json.review.memberId + "</td>";
				html += "<td>" + json.review.reviewDate + "</td></tr>";
				html += "<tr><td colspan=3>";
				for (var i = 0; i < 5; i++){
					html += "<img src='/udongca_project/udongca-image/star" + ((i < json.review.ratingStars) ? "1" : "0" ) + ".png' height='32' width='32'>";
				}
				html += "</td></tr>";
				html += "<tr><td id='reviewContent' colspan=3>";
				html += "</td></tr>";
				html += "</table>";
				html += "<button onclick=reviewModifyForm(" + reviewNo + "," + writerId + ")>수정</button>";
				html += "<button onclick=reviewDelete(" + reviewNo + "," + writerId + ")>삭제</button>";
				
				$("#reviewArea").append(html);
				$("#reviewTitle").text(json.review.reviewTitle);
				for (var i = 0; i < reviewImageArray.length - 1; i++){
					$("#reviewContent").append("<img src='/udongca_project/images/" + reviewImageArray[i] + "' height='300' width='300'><br>");
				}
				$("#reviewContent").append("<pre id='reviewContentText'></pre>");
				$("#reviewContentText").append(document.createTextNode(json.review.reviewContent));
				
				html = "<table id='replyBoard'>";
				
				for (var group = 1; group < countGroup; group++){
					for (var i = 0; i < 2; i++){
						for (var idx = 0; idx < json.reply.length; idx++){
							if (json.reply[idx].replyGroup == group && !json.reply[idx].parentReply && !i){
								html += "<tbody class='reply' id='" + json.reply[idx].replyNo + "'>";
								html += "<tr class='" + group + "'><td id='" + json.reply[idx].replyId + "'>" + json.reply[idx].replyId;
								if ("${sessionScope.login}"){
									html += "&nbsp;<button class='reReplyInputBtn'>답글</button>";
								}
								if ("${sessionScope.login.memberId}" == json.reply[idx].replyId){
									html += "&nbsp;<button class='deleteReply'>삭제</button>";
								}
								html += "</td></tr>";
								html += "<tr><td class='replyContent'><textarea style='resize:none;border: thin;background: white;' readonly='readonly'>" + json.reply[idx].replyContent + "</textarea></td></tr></tbody>";
							}
							else if(json.reply[idx].replyGroup == group && json.reply[idx].parentReply && i){
								html += "<tbody class='reReply' id='" + json.reply[idx].replyNo + "'>";
								html += "<tr class='" + group + "'><td id='" + json.reply[idx].replyId + "'>" + json.reply[idx].replyId;
								if ("${sessionScope.login}"){
									html += "&nbsp;<button class='reReplyInputBtn'>답글</button>";
								}
								if ("${sessionScope.login.memberId}" == json.reply[idx].replyId){
									html += "&nbsp;<button class='deleteReply'>삭제</button>";
								}
								html += "</td></tr>";
								html += "<tr><td class='reReplyContent'><textarea style='resize:none;border: thin;background: white;' readonly='readonly'>[" + json.reply[idx].targetName + "]" + json.reply[idx].replyContent + "</textarea></td></tr></tbody>";
							}
						}
					}
				}
				html += "</table>"
				if ("${sessionScope.login}"){
					html += "<input type='text' id='replyContent' placeholder='댓글 입력'>";
					html += "<button id='addReply'>등록</button>";
				}
				
				$("#replyArea").append(html);
			},
			
			"error":function(xhr){
				alert("An error occured in reviewDetail(): " + xhr.status + " " + xhr.statusText);
			}
		});
	}
	
	function reviewWrite(){
		window.location.href = "/udongca_project/review/reviewWriteForm.udc?cafeNo=" + $("#cafeNo").val();
	}
	
	function reviewModifyForm(reviewNo, writerId){
		window.location.href = "/udongca_project/review/reviewModifyForm.udc?reviewNo=" + reviewNo + "&writerId=" + writerId;
	}
	
	function reviewDelete(reviewNo, writerId){
		if (window.confirm("정말 삭제하겠습니까?")){
			window.location.href = "/udongca_project/review/reviewDelete.udc?reviewNo=" + reviewNo + "&writerId=" + writerId + "&cafeNo=" + $("#cafeNo").val();
		}
	}
</script>

<input type="hidden" id="cafeNo" value="${requestScope.prBoard.cafeNo}">
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
					<td>카페 점수</td>
					<td id="cafeAverageRatingIcon"></td>
					<td id="cafeAverageRatingNumber"></td>
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
					<td colspan=2 id="buttonArea"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td id="content" colspan=3 style="width:350px;height:350px;"></td>
	</tr>
</table>