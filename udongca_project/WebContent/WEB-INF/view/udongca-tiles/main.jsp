<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
</script>
<div style="width:1030px; height:910px;" class="nonav_bodyDiv" align="center">
	<c:choose>
		<c:when test="${sessionScope.login.memberType eq 'generalMember' }">
			<div style="float:left; width:500px; height:450px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">즐겨찾는 카페</div>
				<div id="BookmarkCafe">
					<c:forEach items="${requestScope.bookmark }" var="bookmark">
						<div style="width:160px;height:100px; margin-left:5px; margin-top:17px;float: left">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${bookmark.cafeNo }"><img style="width:150px;height:100px;" src="/udongca_project/images/${bookmark.prBoard.cafeFakeImage }"></a>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div style=" float:left; width:500px; height:450px; margin-left:5px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">공지</div>
				<div id="notice">
					<c:forEach items="${requestScope.notice }" var="notice">
						<div style="height:38px;">
							<a href="/udongca_project/noticeBoard/noticeBoard.udc?noticeNo=${notice.noticeNo }">${notice.noticeTitle }</a>
						</div>
					</c:forEach>
				</div>
			</div>
		
			<div style="float:left; width:500px; height:450px; margin-top:5px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">선호지역 카페</div>
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
		
			<div style=" float:left; width:500px; height:450px; margin-top:5px; margin-left:5px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">리뷰</div>
				<div id="review">
					<c:forEach items="${requestScope.reviewBoard }" var="reviewBoard">
						<div style="height:38px;">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${reviewBoard.cafeNo }">${reviewBoard.reviewTitle }</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:when>
		
		<c:otherwise>
			<div style="float:left; width:500px; height:450px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">추천</div>
				<div id="bestCafe">
				
				</div>
			</div>
			
			<div style=" float:left; width:500px; height:450px; margin-left:5px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">공지</div>
				<div id="notice">
					<c:forEach items="${requestScope.notice }" var="notice">
						<div style="height:38px;">
							<a href="/udongca_project/noticeBoard/noticeBoard.udc?noticeNo=${notice.noticeNo }">${notice.noticeTitle }</a>
						</div>
					</c:forEach>
				</div>
			</div>
		
			<div style="float:left; width:500px; height:450px; margin-top:5px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">신규</div>
				<div id="newCafe"></div>
			</div>
		
			<div style=" float:left; width:500px; height:450px; margin-top:5px; margin-left:5px; border:1px solid;">
				<div style="width:500px;height:50px; border-bottom: 1px solid; margin-top: 25px;">리뷰</div>
				<div id="review">
					<c:forEach items="${requestScope.reviewBoard }" var="reviewBoard">
						<div style="height:38px;">
							<a href="/udongca_project/prBoard/prView.udc?cafeNo=${reviewBoard.cafeNo }">${reviewBoard.reviewTitle }</a>
						</div>
					</c:forEach>					
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>