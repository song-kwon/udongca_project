<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$('img').mouseover(function(){
		$(this).css({'opacity':'0.5'})
	});
	
	$('img').mouseout(function(){
		$(this).css({'opacity':'1'})
	});
	
});
</script>

<style type="text/css">
.main_style{
	font-size:30px;
	font-weight:bold;
	font-famaily:'맑은고딕';
	color:sandybrown;
	text-shadow: -2px 0 linen, 0 2px linen, 2px 0 linen, 0 -2px linen;
	box-shadow:5px 5px 8px 5px lightgray;
	letter-spacing:10px;
	margin:10px;
	margin-left:20px;
	margin-right:40px;
}
</style>

<div style="width:1030px; height:910px;" class="nonav_bodyDiv" align="center">
	<c:choose>
		<c:when test="${sessionScope.login.memberType eq 'generalMember'}">
			<c:choose>
				<c:when test="${not empty requestScope.bookmark }">
					<div style="float:left; width:500px; height:450px; margin-left:10px;">
						<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">즐겨찾는 카페</div>
						<div id="BookmarkCafe">
							<c:forEach items="${requestScope.bookmark }" var="bookmark" varStatus="status">
								<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
									<a href="/udongca_project/prBoard/prView.udc?cafeNo=${bookmark.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${bookmark.prBoard.cafeFakeImage }"></a>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div style="float:left; width:500px; height:450px;">
						<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">추천</div>
						<div id="cafeRating">
							<c:forEach items="${requestScope.cafeRating }" var="cafeRating" varStatus="status" >
								<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
									<a href="/udongca_project/prBoard/prView.udc?cafeNo=${cafeRating.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${cafeRating.cafeFakeImage }"></a>
								</div>
							</c:forEach>				
						</div>
					</div>				
				</c:otherwise>
			</c:choose>
			
			<div style=" float:left; width:500px; height:450px; margin-left:20px;">
				<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">공지</div>
				<div id="notice" style="margin-left:20px;">
					<c:forEach items="${requestScope.notice }" var="notice" varStatus="status" end="4">
						<div style="height:38px; margin-top:25px; font-size:18px;">
							<a href="/udongca_project/noticeBoard/noticeBoard.udc?noticeNo=${notice.noticeNo }">${notice.noticeTitle }</a>
						</div>
					</c:forEach>
				</div>
			</div>
		
		<c:choose>
			<c:when test="${not empty requestScope.preferLocation}">
				<div style="float:left; width:500px; height:450px; margin-top:5px; margin-left:20px;">
					<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">선호지역 카페</div>
					<div id="preferLocationCafe">
						<c:forEach begin="0" end="2" varStatus="no">
							<c:forEach items="${requestScope.preferLocation[no.index] }" var="preferLocation">
								<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
									<a href="/udongca_project/prBoard/prView.udc?cafeNo=${preferLocation.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${preferLocation.cafeFakeImage }"></a>
								</div>
							</c:forEach>
						</c:forEach>
					</div>
				</div>
			</c:when>
			
			<c:otherwise>
				<div style="float:left; width:500px; height:450px; margin-top:5px;">
					<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">신규</div>
					<div id="newCafe">
						<c:forEach items="${requestScope.newCafe }" var="newCafe" varStatus="status">
							<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
								<a href="/udongca_project/prBoard/prView.udc?cafeNo=${newCafe.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${newCafe.cafeFakeImage }"></a>
							</div>
						</c:forEach>	
					</div>
				</div>				
			</c:otherwise>
		</c:choose>
		
			<div style=" float:left; width:500px; height:450px; margin-top:5px; margin-left:20px;">
				<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">리뷰</div>
				<div id="review" style="margin-left:20px;">
					<c:forEach items="${requestScope.reviewBoard }" var="reviewBoard" varStatus="status">
						<div style="height:38px; margin-top:25px; font-size:18px;">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${reviewBoard.cafeNo }">${reviewBoard.reviewTitle }</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:when>
		
		<c:otherwise>
			<div style="float:left; width:500px; height:450px;">
				<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">추천</div>
				<div id="cafeRating">
					<c:forEach items="${requestScope.cafeRating }" var="cafeRating" varStatus="status">
						<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${cafeRating.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${cafeRating.cafeFakeImage }"></a>
						</div>
					</c:forEach>				
				</div>
			</div>
			
			<div style=" float:left; width:500px; height:450px; margin-left:20px;">
				<div style="width:500px;height:50px; margin-top: 25px; margin-left:10px;" class="main_style">공지</div>
				<div id="notice" style="margin-left:20px;">
					<c:forEach items="${requestScope.notice }" var="notice" varStatus="status" end="4">
						<div style="height:38px; margin-top:25px; font-size:18px;">
							<a href="/udongca_project/noticeBoard/noticeBoard.udc?noticeNo=${notice.noticeNo }">${notice.noticeTitle }</a>
						</div>
					</c:forEach>
				</div>
			</div>
		
			<div style="float:left; width:500px; height:450px; margin-top:5px;">
				<div style="width:500px;height:50px; margin-top: 25px;" class="main_style">신규</div>
				<div id="newCafe">
					<c:forEach items="${requestScope.newCafe }" var="newCafe">
						<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${newCafe.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${newCafe.cafeFakeImage }"></a>
						</div>
					</c:forEach>	
				</div>
			</div>
		
			<div style=" float:left; width:500px; height:450px; margin-top:5px; margin-left:20px;">
				<div style="width:500px;height:50px; margin-top: 25px;" class="main_style">리뷰</div>
				<div id="review" style="margin-left:20px;">
					<c:forEach items="${requestScope.reviewBoard }" var="reviewBoard" varStatus="status">
						<div style="height:38px; margin-top:25px; font-size:18px;">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${reviewBoard.cafeNo }">${reviewBoard.reviewTitle }</a>
						</div>
					</c:forEach>					
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>