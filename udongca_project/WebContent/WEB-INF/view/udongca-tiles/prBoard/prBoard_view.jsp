<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=fb0d10514e172c531b661118b62d9c6f&libraries=services"></script>
<style type="text/css">
	table, th{
		font-size:20px;
		font-weigth:bold;
	}
	.carousel-inner > .item > img {
	      top: 0;
	      left: 0;
	      width: 600px;
	      height: 350px;
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
		min-height:40px;
	}
	.reReply{
		text-indent: 50px;
	}
	
	.modal-header, h4, .close {
		background-color: #B8860B;
		color:white !important;
		text-align: center;
		font-size: 30px;
	}
	.modal-footer {
		background-color: #FAEBD7;
	}
</style>

<script type="text/javascript">
	var isAddedFavorite = null;
	var isMemberLicensed = null;
	var cafeFakeImageArray = "${requestScope.prBoard.cafeFakeImage}".split(";");
	var cafeFakeImageArrayNumber = cafeFakeImageArray.length - 1;
	var currentImageNumber = 0;
	var currentPage = 0;
	var currentReviewNo = null;
	var currentReviewMemberId = null;
	var reportReplyNo = null;
	var reportReplyMemberId = null;
	var cafeReviewCount = Number("${requestScope.prBoard.cafeReviewCount}");
	var cafeRating = Number("${requestScope.prBoard.cafeRating}");
	var cafeAverageRating = (cafeReviewCount) ? cafeRating / cafeReviewCount : 0;
	var countGroup = null;
	
	
	$(document).ready(function(){
		$(".sidenav").attr("style","height:1021px;")
		$("#imageArea").append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='300' width='400'>");
		
		mapLocation();
		
		if ("${sessionScope.login}"){
			if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseeMember"){
				$("#buttonArea").append("<button onclick='prModify()' class='btn btn-default'>홍보글 수정</button><button onclick='prDelete()' class='btn btn-default'>홍보글 삭제</button>");
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
							$("#buttonArea").append("<button onclick='favoriteToggle()' class='btn btn-default'>즐겨찾기 " + ((isAddedFavorite) ? "해제" : "추가") + "</button>");
						},
						"error":function(xhr){
							alert("An error occured while loading isBookmarkAdded.udc: " + xhr.status + " " + xhr.statusText);
						}
					});
				}
				$("#buttonArea").append("<button onclick='prReport()' class='btn btn-default'>홍보글 신고</button>");
			}
		}
		
		$("#cafeAverageRatingNumber").text(cafeAverageRating.toPrecision(3) + " / ${requestScope.prBoard.cafeReviewCount}");
		
		var starNumber = Math.round(cafeAverageRating * 2) / 2.0;
		
		for (var i = 1; i < 6; i++){
			$("#cafeAverageRatingIcon").append("<img src='/udongca_project/udongca-image/star" + ((i <= starNumber) ? "1" : ((i - starNumber == 0.5) ? "h" : "0") ) + ".png' height='32' width='32'>");
		}
		
		$(document).on('click','#addReply',function(){
			$.ajax({
				'url':'/udongca_project/review/addReply.udc',
				'type':'post',
				'data':{'replyId':'${sessionScope.login.memberId}','replyContent':$('#replyContent').val(),'replyGroup':countGroup+1,'reviewNo':currentReviewNo},
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
			$("#reReplyInput").remove();
			$(this).parent().parent().parent().append("<div id='reReplyInput' style='height:40px;'><input type='text' id='reReplyContent' placeholder='댓글 입력' class='form-control'><button class='addReReply'>등록</button></div>");
		});
		
		$(document).on('click','.addReReply',function(){
			var reReply = $(this).parent().parent();
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
			alert($(this).parent().parent().parent().prop('id'));
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
		
		$(document).on('submit', '#prReportForm', function(){
			if ($("#prReportReason").val() == "직접 입력" && $("#prReportContent").val() == ""){
				alert("신고 내용을 입력하세요");
				return false;
			}
			return window.confirm("정말 신고하겠습니까?");
		});
		
		$(document).on('submit', '#reviewReportForm', function(){
			if ($("#reviewReportReason").val() == "직접 입력" && $("#reviewReportContent").val() == ""){
				alert("신고 내용을 입력하세요");
				return false;
			}
			$("#reviewReportNo").val(currentReviewNo);
			$("#reviewReportMemberId").val(currentReviewMemberId);
			return window.confirm("정말 신고하겠습니까?");
		});
		
		$(document).on('submit', '#replyReportForm', function(){
			if ($("#replyReportReason").val() == "직접 입력" && $("#replyReportContent").val() == ""){
				alert("신고 내용을 입력하세요");
				return false;
			}
			
			$("#replyReportNo").val(reportReplyNo);
			$("#replyReportMemberId").val(reportReplyMemberId);
			return window.confirm("정말 신고하겠습니까?");
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
		$("#prReportModal").modal();
	};
	
	function reviewReport(){
		$("#reviewReportModal").modal();
	};
	
	function replyReport(replyNo, replyMemberId){
		/*
			replyMemberId에 json.reply[idx].replyId를 대입했으므로 ID 문자열이 전달될 줄 알았는데 실제로는 해당 id의 Table이 출력됨.
			따라서 jQuery 객체로 만들어 id 값을 뽑아내야 했는데, 왜 Table이 넘어오는지는 이유 불명.
		*/
		reportReplyNo = replyNo;
		reportReplyMemberId = $(replyMemberId).prop("id");
		$("#replyReportModal").modal();
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
		$("#imageArea").empty().append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='300' width='400'>");
	};
	
	function nextImage(){
		currentImageNumber++;
		if (currentImageNumber > cafeFakeImageArrayNumber - 1){
			currentImageNumber = 0;
		}
		$("#imageArea").empty().append("<img src='/udongca_project/images/" + cafeFakeImageArray[currentImageNumber] + "' height='300' width='400'>");
	};
	
	function menuImage(no,menuType){
		$("#content").empty();
		$(".myReviewReplyArea").empty();
		$("#content").attr("style", "");
		$("#menuType").empty();
		$.ajax({
			"url":"/udongca_project/prBoard/menuList.udc",
			"type":"POST",
			"data":{cafeNumber:no,menuType:menuType},
			"dataType":"json",
			"success":function(obj){
				
				$("#menuType").append(menuType);
				if(obj != ""){
					$("#content").append(
							"<div id='myCarousel' class='carousel slide' style='margin-bottom:60px'>"+
							"<ol class='carousel-indicators'></ol><div class='carousel-inner' role='listbox'></div>");
					for(var i =0;i<obj.length;i++){

						if(i==0){
						$(".carousel-inner").append("<div class='item active'><img src='/udongca_project/images/"+obj[i].menuFakeImage+"' alt='"+obj[i].menuName+"'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
						$(".carousel-indicators").append("<img src='/udongca_project/images/"+obj[i].menuFakeImage+"' data-target='#myCarousel' data-slide-to='0'  class='item1 active'></li>");
						}else{
							$(".carousel-inner").append("<div class='item'><img src='/udongca_project/images/"+obj[i].menuFakeImage+"' alt='"+obj[i].menuName+"'><div class='carousel-caption'><h3>"+obj[i].menuName+"</h3></div></div>");
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
					$("#content").append("<br><font size=3>해당 카테고리의 메뉴가 존재하지 않습니다.<br></font>");
				}
				
				if ("${sessionScope.login.memberId}" == "${requestScope.prBoard.memberId}" && "${sessionScope.login.memberType}" == "licenseeMember"){
					$("#content").append("<div style='padding:25px; float:right;'><button onclick='menuModifyForm()' class='btn btn-default'>메뉴 수정</button></div>");
				}
			},
			"error":function(xhr){
				alert("An error occured in menuImage(): " + xhr.status + " " + xhr.statusText);
			}
		});
	}
	
	function mapLocation(){
		$("#content").empty();
		$(".myReviewReplyArea").empty();
		$("#content").attr("style", "width:600px;height:350px;margin-left:150px;");
		
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
		currentPage = page;
		var html = "";
		$("#content").empty();
		$(".myReviewReplyArea").empty();
		$("#content").attr("style", "");
		$.ajax({
			"url":"/udongca_project/review/cafeReviewListPaging.udc",
			"type":"POST",
			"data":"cafeNo=${requestScope.prBoard.cafeNo}&pnum=" + page,
			"dataType":"json",
			"success":function(json){
				if (!json.list.length){
					html += "<br><font size=3>아직 작성된 리뷰가 없습니다.<br></font>"
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
					html += "<br><button onclick=reviewWrite() class='btn btn-default'>리뷰 작성</button>";
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
		$(".myReviewReplyArea").empty();
		$.ajax({
			"url":"/udongca_project/review/reviewDetail.udc",
			"type":"POST",
			"data":"cafeNo=" + $("#cafeNo").val() + "&reviewNo=" + reviewNo,
			"dataType":"json",
			"success":function(json){
				countGroup = json.countGroup;
				currentReviewNo = reviewNo;
				currentReviewMemberId = json.review.memberId;
				
				$("#content").append("<table><tr><td id='reviewArea'></td></tr><tr><td id='replyArea'></td></tr></table>");
				
				var writerId = "'" + currentReviewMemberId + "'";
				reviewImageArray = json.review.reviewFakeImage.split(";");
				html += "<table><tr><td id='reviewTitle'></td>";
				html += "<td>" + currentReviewMemberId + "</td>";
				html += "<td>" + json.review.reviewDate + "</td></tr>";
				html += "<tr><td colspan=3>";
				for (var i = 0; i < 5; i++){
					html += "<img src='/udongca_project/udongca-image/star" + ((i < json.review.ratingStars) ? "1" : "0" ) + ".png' height='32' width='32'>";
				}
				html += "</td></tr>";
				html += "<tr><td id='reviewContent' colspan=3>";
				html += "</td></tr>";
				html += "</table>";
				if ("${sessionScope.login.memberId}" == currentReviewMemberId){
					html += "<button onclick=reviewModifyForm(" + reviewNo + "," + writerId + ")>수정</button>";
					html += "<button onclick=reviewDelete(" + reviewNo + "," + writerId + ")>삭제</button>";
				}
				if ("${sessionScope.login.memberId}" && "${sessionScope.login.memberId}" != currentReviewMemberId){
					html += "<button onclick='reviewReport()'>신고</button>";
				}
				html += "<button onclick='reviewList(" + currentPage + ")'>목록</button>"
				
				$("#reviewArea").append(html);
				$("#reviewTitle").text(json.review.reviewTitle);
				for (var i = 0; i < reviewImageArray.length - 1; i++){
					$("#reviewContent").append("<img src='/udongca_project/images/" + reviewImageArray[i] + "' height='300' width='300'><br>");
				}
				$("#reviewContent").append("<pre id='reviewContentText'></pre>");
				$("#reviewContentText").append(document.createTextNode(json.review.reviewContent));
				
				html = "<table id='replyBoard'>";
				
				for (var group = 1; group < countGroup+1; group++){
					var isParentExist = false;
					for (var i = 0; i < 2; i++){
						for (var idx = 0; idx < json.reply.length; idx++){
							var d = new Date(json.reply[idx].replyDate);
							if (json.reply[idx].replyGroup == group && !json.reply[idx].parentReply && !i){
								isParentExist = true;
								html += "<tbody class='reply' id='" + json.reply[idx].replyNo + "'>";
								html += "<tr class='" + group + "'><td id='" + json.reply[idx].replyId + "'>" + json.reply[idx].replyId;
								if ("${sessionScope.login}"){
									html += "&nbsp;<button class='reReplyInputBtn'>답글</button>";
								}
								if ("${sessionScope.login.memberId}" == json.reply[idx].replyId){
									html += "&nbsp;<button class='deleteReply'>삭제</button>";
								}
								if ("${sessionScope.login.memberId}" && "${sessionScope.login.memberId}" != json.reply[idx].replyId){
									html += "&nbsp;<button onclick='replyReport(" + json.reply[idx].replyNo + ", " + json.reply[idx].replyId + ")'>신고</button>";
								}
								html += "</td></tr>";
								html += "<tr><td>" + d.getFullYear() + "/" + (Number(d.getMonth()) + 1) + "/" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + "</td></tr>";
								html += "<tr><td class='replyContent'><textarea style='height:auto;resize:none;border: thin;background: white;' readonly='readonly'>" + json.reply[idx].replyContent + "</textarea></td></tr></tbody>";
							}
							else if(json.reply[idx].replyGroup == group && json.reply[idx].parentReply && i){
								html += "<tbody class='reReply' id='" + json.reply[idx].replyNo + "'>";
								html += "<tr class='" + group + "'><td id='" + json.reply[idx].replyId + "'>" + json.reply[idx].replyId;
								if (isParentExist && "${sessionScope.login}"){
									html += "&nbsp;<button class='reReplyInputBtn'>답글</button>";
								}
								if ("${sessionScope.login.memberId}" == json.reply[idx].replyId){
									html += "&nbsp;<button class='deleteReply'>삭제</button>";
								}
								if ("${sessionScope.login.memberId}" && "${sessionScope.login.memberId}" != json.reply[idx].replyId){
									html += "&nbsp;<button onclick='replyReport(" + json.reply[idx].replyNo + ", " + json.reply[idx].replyId + ")'>신고</button>";
								}
								html += "</td></tr>";
								html += "<tr><td>" + d.getFullYear() + "/" + (Number(d.getMonth()) + 1) + "/" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + "</td></tr>";
								html += "<tr><td class='reReplyContent'><textarea  style='resize:none;border: thin;background: white;' readonly='readonly'>[" + json.reply[idx].targetName + "]" + json.reply[idx].replyContent + "</textarea></td></tr></tbody>";
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
<div style="width:1000px; padding-left:50px;">
<input type="hidden" id="cafeNo" value="${requestScope.prBoard.cafeNo}">
<div><h1 style="margin-top:0px;" id="cafeName">  ${requestScope.prBoard.cafeName }</h1></div><p>
<div style="color:darkorange;"><font size="4">&nbsp;&nbsp;안녕하세요! "${requestScope.prBoard.cafeName }"에 오신 것을 환영합니다!!</font></div><br>
<table style="width:950px;">
	<tr>
		<td rowspan="5" style="width:300px; padding-right:15px;">
			<!--
				홍보글 객체에서 fakeImage를 불러 와, 이를 Split한 뒤 for 문으로 경로를 순차적으로 조회.
			-->
		
			<div id="imageArea" style="padding:10px; width:450px;"></div>
			<div align="center">
				<button onclick="prevImage()">이전</button>
				<button onclick="nextImage()">다음</button>
			</div>
		</td>
		<th>영업 시간</th>
		<td>${requestScope.prBoard.operationHour}</td>
	</tr>
	<tr>
					<th>연락처</th>
					<td>
						카페: ${requestScope.prBoard.cafeTel}<br>
						사업자: ${requestScope.prBoard.managerTel}
					</td>
				</tr>
				<tr>
					<th>카페 평점</th>
					<td id="cafeAverageRatingIcon"></td>
					<td id="cafeAverageRatingNumber"></td>
				</tr>
				<tr>
					<th>카페 특징</th>
					<td>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'wifi')}">
							<img src="/udongca_project/udongca-image/coffee-cup-with-wireless-symbol.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'socket')}">
							<img src="/udongca_project/udongca-image/socket.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'park')}">
							<img src="/udongca_project/udongca-image/parking-sign.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'smoking')}">
							<img src="/udongca_project/udongca-image/smoking-area.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme1')}">
							<img src="/udongca_project/udongca-image/sweet-cake-piece.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme2')}">
							<img src="/udongca_project/udongca-image/books-stack.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme3')}">
							<img src="/udongca_project/udongca-image/plain-dog.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme4')}">
							<img src="/udongca_project/udongca-image/halloween-black-cat.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme5')}">
							<img src="/udongca_project/udongca-image/mother-and-child-with-balloons.png" height="40" width="40">
						</c:if>
						<c:if test="${fn:contains(requestScope.prBoard.cafeFeature, 'cafeTheme6')}">
							<img src="/udongca_project/udongca-image/question-button.png" height="40" width="40">
						</c:if>
					</td>
				</tr>
				<tr>
					<th>카페 소개</th>
					<td><pre><c:out value="${requestScope.prBoard.cafeIntro}"/></pre></td>
				</tr>
	</table>
	
		<div id="buttonArea" class="form-group" align="center" style="width:800px; padding-top:20px;"></div>
		<table style="margin-left:15%">
		<tr>
			<td>
			<span id="menuType" style="font-size:x-large;"></span>
			</td>
		</tr>
			<tr>
			<td id="content">
			</td>
			</tr>
		</table>
		
</div>

<!-- Modal -->
<div class="modal fade" id="prReportModal" role="dialog">
	<div class="modal-dialog">
	
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding:35px 50px;">
				<h4>홍보글 신고</h4>
			</div>
			<div class="modal-body" style="padding:40px 50px;">
				<form role="form" id="prReportForm" action="/udongca_project/member/addReport.udc" method="post">
					<input type="hidden" name="reportType" value="prBoard">
					<input type="hidden" name="reportNO" value="${requestScope.prBoard.cafeNo}">
					<input type="hidden" name="reportMemberId" value="${requestScope.prBoard.memberId}">
					<input type="hidden" name="cafeNo" value="${requestScope.prBoard.cafeNo}">
					<div>
						<label for="reportReason">신고 사유</label>
						<select name="reportReason" id="prReportReason" class="form-control">
							<option>허위 정보</option>
							<option>욕설, 저속한 언어 사용</option>
							<option>타인/타 점포 비방</option>
							<option>홈페이지 주제와 관련 없는 정보</option>
							<option>중복 정보</option>
							<option>직접 입력</option>
						</select>
					</div>
					<div>
						<label for="reportContent">신고 내용</label>
						<input type="text" class="form-control" id="prReportContent" name="reportContent">
					</div>
					<button type="submit" class="btn btn-success btn-block">전송</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="reviewReportModal" role="dialog">
	<div class="modal-dialog">
	
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding:35px 50px;">
				<h4>리뷰 신고</h4>
			</div>
			<div class="modal-body" style="padding:40px 50px;">
				<form role="form" id="reviewReportForm" action="/udongca_project/member/addReport.udc" method="post">
					<input type="hidden" name="reportType" value="review_board">
					<input type="hidden" name="reportNO" id="reviewReportNo" value="">
					<input type="hidden" name="reportMemberId" id="reviewReportMemberId" value="">
					<input type="hidden" name="cafeNo" value="${requestScope.prBoard.cafeNo}">
					<div>
						<label for="reportReason">신고 사유</label>
						<select name="reportReason" id="reviewReportReason" class="form-control">
							<option>허위 정보</option>
							<option>욕설, 저속한 언어 사용</option>
							<option>타인/타 점포 비방</option>
							<option>홈페이지 주제와 관련 없는 정보</option>
							<option>중복 정보</option>
							<option>직접 입력</option>
						</select>
					</div>
					<div>
						<label for="reportContent">신고 내용</label>
						<input type="text" class="form-control" id="reviewReportContent" name="reportContent">
					</div>
					<button type="submit" class="btn btn-success btn-block">전송</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="replyReportModal" role="dialog">
	<div class="modal-dialog">
	
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding:35px 50px;">
				<h4>리플 신고</h4>
			</div>
			<div class="modal-body" style="padding:40px 50px;">
				<form role="form" id="replyReportForm" action="/udongca_project/member/addReport.udc" method="post">
					<input type="hidden" name="reportType" value="review_reply">
					<input type="hidden" name="reportNO" id="replyReportNo" value="">
					<input type="hidden" name="reportMemberId" id="replyReportMemberId" value="">
					<input type="hidden" name="cafeNo" value="${requestScope.prBoard.cafeNo}">
					<div>
						<label for="reportReason">신고 사유</label>
						<select name="reportReason" id="replyReportReason" class="form-control">
							<option>허위 정보</option>
							<option>욕설, 저속한 언어 사용</option>
							<option>타인/타 점포 비방</option>
							<option>홈페이지 주제와 관련 없는 정보</option>
							<option>중복 정보</option>
							<option>직접 입력</option>
						</select>
					</div>
					<div>
						<label for="reportContent">신고 내용</label>
						<input type="text" class="form-control" id="replyReportContent" name="reportContent">
					</div>
					<button type="submit" class="btn btn-success btn-block">전송</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>