<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		"url":"/udongca_project/prBoard/cafeMenuList.udc",
		"type":"GET",
		"data":"",
		"dataType":"json",
		"success":function(json){
			for(var i = 0; i < json.length; i++){
				var a= "'"+json[i].codeName+"'" ;
				$("#menuCategoryList").append('<li class="li"><a onclick="menuImage('+$("#cafeNo").val()+','+ a +')">' + json[i].codeName + '</a></li>');
			}
		},
		"error":function(xhr){
			alert("An error occured while loading cafeMenuList.udc: " + xhr.status + " " + xhr.statusText);
		}
	});
})
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

function collapseMenu(){
	if($('#cafeMenuList').prop('class') != 'collapsed')
		$('#cafeMenuList').trigger('click');	
}
function deleteMenuType(){
	$("#menuType").empty();
}
</script>
<style type="text/css">
.nav-pills > li.active > a,
.nav-pills > li.active > a:hover,
 .nav-pills > li.active > a:focus{
	background-color:#6b4004;
}
.nav>li>a{
	font-size:15pt;
}
.nav > li > a:hover,
.nav > li > a:focus{
	font-weight:bold;
	background-color:#faebd7;
}

.nav-pills > li.active > div#dropBtn,
.nav-pills > li.active > div#dropBtn:hover,
 .nav-pills > li.active > div#dropBtn:focus{
	background-color:#6b4004;
}
.nav > li > div#dropBtn:hover,
.nav > li > a:focus{
	font-weight:bold;
	background-color:#faebd7;
	cursor:pointer;
}
</style>
<div id="prboard_nav" style="width:180px;">
	<div id="optionList">
		<div class="panel-group">
		<ul class="nav nav-pills nav-stacked">
			<li class="li"><a data-toggle="collapse" style='cursor:pointer' onclick="deleteMenuType();collapseMenu();mapLocation();return false;">지도</a></li>
			<li class="li"><a id="cafeMenuList" class="collapsed" data-toggle="collapse" href="#collapse1">메뉴</a></li>	
		</ul>
			<div id="collapse1" class="panel-collapse collapse">
			<ul class="nav nav-pills nav-stacked">
				<ul class="list-group nav nav-pills nav-stacked" id="menuCategoryList">
				</ul>
			</ul>
			</div>
		<ul class="nav nav-pills nav-stacked">
			<li class="li"><a data-toggle="collapse" style='cursor:pointer' onclick="deleteMenuType();collapseMenu();reviewList(1);return false;">리뷰</a></li>
		</ul>
		</div>
	</div>
</div>