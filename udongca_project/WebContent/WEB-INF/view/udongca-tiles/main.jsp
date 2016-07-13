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
	 // Activate Carousel
    $("#rating").carousel({interval:3000});
    // Enable Carousel Indicators
    $("#rating .item1").on("click",function(){
        $("#rating").carousel(0);
    });
    $("#rating .item2").click(function(){
        $("#rating").carousel(1);
    });
    $("#rating .item3").click(function(){
        $("#rating").carousel(2);
    });
    $("#rating .item4").click(function(){
        $("#rating").carousel(3);
    });
    // Activate Carousel
    $("#new").carousel({interval:3000});
    // Enable Carousel Indicators
    $("#new .item1").on("click",function(){
        $("#new").carousel(0);
    });
    $("#new .item2").click(function(){
        $("#new").carousel(1);
    });
    $("#new .item3").click(function(){
        $("#new").carousel(2);
    });
    $("#new .item4").click(function(){
        $("#new").carousel(3);
    });
    // Activate Carousel
    $("#bookmark").carousel({interval:3000});
    // Enable Carousel Indicators
    $("#bookmark .item1").on("click",function(){
        $("#bookmark").carousel(0);
    });
    $("#bookmark .item2").click(function(){
        $("#bookmark").carousel(1);
    });
    $("#bookmark .item3").click(function(){
        $("#bookmark").carousel(2);
    });
    $("#bookmark .item4").click(function(){
        $("#bookmark").carousel(3);
    });
    
    // Activate Carousel
    $("#preferCafe").carousel({interval:3000});
    // Enable Carousel Indicators
    $("#preferCafe .item1").on("click",function(){
        $("#preferCafe").carousel(0);
    });
    $("#preferCafe .item2").click(function(){
        $("#preferCafe").carousel(1);
    });
    $("#preferCafe .item3").click(function(){
        $("#preferCafe").carousel(2);
    });
    $("#preferCafe .item4").click(function(){
        $("#preferCafe").carousel(3);
    });
});
</script>
<style>
.main_style{
	font-size:30px;
	font-weight:bold;
	font-famaily:'맑은고딕';
	color:sandybrown;
	text-shadow: -2px 0 linen, 0 2px linen, 2px 0 linen, 0 -2px linen;
	box-shadow:5px 5px 8px 5px lightgray;
	letter-spacing:10px;
	margin:10px;
	margin-left:0px;
	margin-right:40px;
	margin-top:0px;
}
a.list-group-item:hover{
	background-color:#faebd7;
}
.list-group-item{
	height:38px; 
	margin-top:25px; 
	font-size:18px;
}
 .carousel-inner > .item > img {
	      top: 0;
	      left: 0;
	      width: 600px;
	      height: 400px;
} 
.carousel-indicators{
		width:100%;
		left:30%;
	 	bottom:-70px;
 }
.carousel-indicators .active{
	 	width:60px;
	 	height:60px;
}
.carousel-indicators > img{
		width:40px;
		height:40px;
}
</style>

<div style="width:1030px; height:910px;" class="nonav_bodyDiv" align="center">
	<c:choose>
		<c:when test="${sessionScope.login.memberType eq 'generalMember'}">
			<c:choose>
				<c:when test="${not empty requestScope.bookmark }">
					<div style="float:left; width:500px; height:450px;">
						<div style="width:500px;height:50px; " class="main_style">즐겨찾는 카페</div>
						<div id="BookmarkCafe">
							<div id="bookmark" class="carousel slide">
							 <!-- Indicators -->
							<ol class="carousel-indicators">
								<c:forEach varStatus="status" items="${requestScope.bookmark }" var="bookmark">
									<c:choose>
										<c:when test="${status.index==0 }">
											 <img src="/udongca_project/images/${bookmark.prBoard.cafeFakeImage }" data-target='#bookmark' data-slide-to='0'  class='item1 active'>
										</c:when>
										<c:otherwise>
											<img src='/udongca_project/images/${bookmark.prBoard.cafeFakeImage }' data-target='#bookmark' data-slide-to='${status.index }'  class='item${status.index+1 }'>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ol> 
							<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<c:forEach varStatus="status" items="${requestScope.bookmark }" var="bookmark">
								<c:choose>
								 <c:when test="${status.index==0 }">
									<div class="item active">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${bookmark.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${bookmark.prBoard.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${bookmark.prBoard.cafeName}</h3>
										</div>
									</div>
									</c:when>
									<c:otherwise>
									<div class="item">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${bookmark.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${bookmark.prBoard.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${bookmark.prBoard.cafeName}</h3>
										</div>
									</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
						</div>
						</div>
						</div>
				</c:when>
				<c:otherwise>
					<div style="float:left; width:500px; height:450px; ">
						<div style="width:500px;height:50px; " class="main_style">추천</div>
						<div id="cafeRating">
					<div id="rating" class="carousel slide">
						 <!-- Indicators -->
						<ol class="carousel-indicators">
							<c:forEach varStatus="status" items="${requestScope.cafeRating }" var="cafeRating">
							<c:choose>
							<c:when test="${status.index==0 }">
							<img src="/udongca_project/images/${cafeRating.cafeFakeImage }" data-target='#rating' data-slide-to='0'  class='item1 active'>
							</c:when>
							<c:otherwise>
							<img src='/udongca_project/images/${cafeRating.cafeFakeImage }' data-target='#rating' data-slide-to='${status.index }'  class='item${status.index+1 }'>
							</c:otherwise>
							</c:choose>
							</c:forEach>
							
						</ol> 
						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<c:forEach varStatus="status" items="${requestScope.cafeRating }" var="cafeRating">
								<c:choose>
								 <c:when test="${status.index==0 }">
									<div class="item active">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${cafeRating.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${cafeRating.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${cafeRating.cafeName }</h3>
										</div>
									</div>
									</c:when>
									<c:otherwise>
									<div class="item">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${cafeRating.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${cafeRating.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${cafeRating.cafeName }</h3>
										</div>
									</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
				</div>				
				</c:otherwise>
			</c:choose>
			
			<div style=" float:left; width:500px; height:450px; margin-left:20px;">
			
				<div style="width:500px;height:50px; margin-left:10px;" class="main_style" >공지</div>
				<div id="notice" style="margin-left:20px;">
				<div class="list-group">
					<c:forEach items="${requestScope.notice }" var="notice" varStatus="status">
						<c:choose>
							<c:when test="${status.index<5 }">
								<a class="list-group-item" href="/udongca_project/noticeBoard/noticeBoard.udc?noticeNo=${notice.noticeNo }">${notice.noticeTitle }</a>
							</c:when>		
						</c:choose>
					</c:forEach>
				</div>
				</div>
				
			</div>
		<c:choose>
			<c:when test="${not empty requestScope.preferLocation}">
				<div style="float:left; width:500px; height:450px; margin-top:5px;">
					<div style="width:500px;height:50px;" class="main_style">선호지역 카페</div>
					<div id="preferLocationCafe">
					<div id="preferCafe" class="carousel slide">
					<!-- Indicators -->
						<ol class="carousel-indicators">
							<c:forEach begin="0" end="2" varStatus="no">
							<c:forEach varStatus="status" items="${requestScope.preferLocation[no.index] }"  var="preferLocation">
							<c:choose>
							<c:when test="${status.index==0 }">
							<img src="/udongca_project/images/${preferLocation.cafeFakeImage }" data-target='#preferCafe' data-slide-to='0'  class='item1 active'>
							</c:when>
							<c:otherwise>
							<img src='/udongca_project/images/${preferLocation.cafeFakeImage }' data-target='#preferCafe' data-slide-to='${status.index }'  class='item${status.index+1 }'>
							</c:otherwise>
							</c:choose>
							</c:forEach>
							</c:forEach>
						</ol> 
						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
						<c:forEach begin="0" end="2" varStatus="no">
							<c:forEach items="${requestScope.preferLocation[no.index] }" varStatus="status" var="preferLocation">
								<c:choose>
								 <c:when test="${no.index==0 }">
									<div class="item active">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${preferLocation.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${preferLocation.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${preferLocation.cafeName }</h3>
										</div>
									</div>
									</c:when>
									<c:otherwise>
									<div class="item">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${preferLocation.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${preferLocation.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${preferLocation.cafeName }</h3>
										</div>
									</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							</c:forEach>
						</div>
						</div>
					</div>
				</div>
			</c:when>
			
			<c:otherwise>
				<div style="float:left; width:500px; height:450px; margin-top:5px;">
				<div style="width:500px;height:50px; margin-left:10px;" class="main_style">신규</div>
				<div id="newCafe">
				<div id="new" class="carousel slide">
				 <!-- Indicators -->
						<ol class="carousel-indicators">
							<c:forEach varStatus="status" items="${requestScope.newCafe }" var="newCafe">
							<c:choose>
							<c:when test="${status.index==0 }">
							<img src="/udongca_project/images/${newCafe.cafeFakeImage }" data-target='#new' data-slide-to='0'  class='item1 active'>
							</c:when>
							<c:otherwise>
							<img src="/udongca_project/images/${newCafe.cafeFakeImage }" data-target='#new' data-slide-to='${status.index }'  class='item${status.index+1 }'>
							</c:otherwise>
							</c:choose>
							</c:forEach>
						</ol> 
						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<c:forEach varStatus="status" items="${requestScope.newCafe }" var="newCafe">
								<c:choose>
								 <c:when test="${status.index==0 }">
									<div class="item active">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${newCafe.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${newCafe.cafeFakeImage }"></a>
										<div class="carousel-caption">
											<h3>${newCafe.cafeName }</h3>
										</div>
									</div>
									</c:when>
									<c:otherwise>
									<div class="item">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${newCafe.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${newCafe.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${newCafe.cafeName }</h3>
										</div>
									</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>		
			</c:otherwise>
		</c:choose>
		
			<div style=" float:left; width:500px; height:450px; margin-top:5px; margin-left:20px;">
				<div style="width:500px;height:50px; margin-left:10px;" class="main_style">리뷰</div>
					<div id="review" style="margin-left:20px;">
						<div class="list-group">
							<c:forEach items="${requestScope.reviewBoard }" var="reviewBoard" varStatus="status">
								<c:choose>
									<c:when test="${status.index<5 }">
										<a class="list-group-item" href="/udongca_project/prBoard/prView.udc?cafeNo=${reviewBoard.cafeNo }">${reviewBoard.reviewTitle }</a>
									</c:when>		
								</c:choose>
							</c:forEach>
						</div>					
					</div>
				</div>
		</c:when>
	
		<c:otherwise>
			<div style="float:left; width:500px; height:450px;">
				<div style="width:500px;height:50px;" class="main_style">추천</div>
				<div id="cafeRating">
					<div id="rating" class="carousel slide">
						 <!-- Indicators -->
						<ol class="carousel-indicators">
							<c:forEach varStatus="status" items="${requestScope.cafeRating }" var="cafeRating">
							<c:choose>
							<c:when test="${status.index==0 }">
							<img src="/udongca_project/images/${cafeRating.cafeFakeImage }" data-target='#rating' data-slide-to='0'  class='item1 active'>
							</c:when>
							<c:otherwise>
							<img src='/udongca_project/images/${cafeRating.cafeFakeImage }' data-target='#rating' data-slide-to='${status.index }'  class='item${status.index+1 }'>
							</c:otherwise>
							</c:choose>
							</c:forEach>
							
						</ol> 
						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<c:forEach varStatus="status" items="${requestScope.cafeRating }" var="cafeRating">
								<c:choose>
								 <c:when test="${status.index==0 }">
									<div class="item active">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${cafeRating.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${cafeRating.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${cafeRating.cafeName }</h3>
										</div>
									</div>
									</c:when>
									<c:otherwise>
									<div class="item">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${cafeRating.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${cafeRating.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${cafeRating.cafeName }</h3>
										</div>
									</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			

			<div style=" float:left; width:500px; height:450px; margin-left:20px;">
			
				<div style="width:500px;height:50px;" class="main_style">공지</div>
				<div id="notice">
				<div class="list-group">
					<c:forEach items="${requestScope.notice }" var="notice" varStatus="status">
						<c:choose>
							<c:when test="${status.index<5 }">
								<a class="list-group-item" href="/udongca_project/noticeBoard/noticeBoard.udc?noticeNo=${notice.noticeNo }">${notice.noticeTitle }</a>
							</c:when>		
						</c:choose>
					</c:forEach>
				</div>
				</div>
				
			</div>
		
			<div style="float:left; width:500px; height:450px; margin-top:5px;">
				<div style="width:500px;height:50px;" class="main_style">신규</div>
				<div id="newCafe">
				<div id="new" class="carousel slide">
				 <!-- Indicators -->
						<ol class="carousel-indicators">
							<c:forEach varStatus="status" items="${requestScope.newCafe }" var="newCafe">
							<c:choose>
							<c:when test="${status.index==0 }">
							<img src="/udongca_project/images/${newCafe.cafeFakeImage }" data-target='#new' data-slide-to='0'  class='item1 active'>
							</c:when>
							<c:otherwise>
							<img src="/udongca_project/images/${newCafe.cafeFakeImage }" data-target='#new' data-slide-to='${status.index }'  class='item${status.index+1 }'>
							</c:otherwise>
							</c:choose>
							</c:forEach>
						</ol> 
						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<c:forEach varStatus="status" items="${requestScope.newCafe }" var="newCafe">
								<c:choose>
								 <c:when test="${status.index==0 }">
									<div class="item active">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${newCafe.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${newCafe.cafeFakeImage }"></a>
										<div class="carousel-caption">
											<h3>${newCafe.cafeName }</h3>
										</div>
									</div>
									</c:when>
									<c:otherwise>
									<div class="item">
										<a href="/udongca_project/prBoard/prView.udc?cafeNo=${newCafe.cafeNo }">
										<img style="width: 500px; height: 300px;" src="/udongca_project/images/${newCafe.cafeFakeImage }">
										</a>
										<div class="carousel-caption">
											<h3>${newCafe.cafeName }</h3>
										</div>
									</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div style=" float:left; width:500px; height:450px; margin-top:5px; margin-left:20px; ">
				<div style="width:500px; height:50px; " class="main_style">리뷰</div>
					<div id="review">
						<div class="list-group">
							<c:forEach items="${requestScope.reviewBoard }" var="reviewBoard" varStatus="status">
								<c:choose>
									<c:when test="${status.index<5 }">
										<a class="list-group-item" href="/udongca_project/prBoard/prView.udc?cafeNo=${reviewBoard.cafeNo }">${reviewBoard.reviewTitle }</a>
									</c:when>		
								</c:choose>
							</c:forEach>
						</div>					
					</div>
				</div>
		</c:otherwise>
	</c:choose>
</div>

