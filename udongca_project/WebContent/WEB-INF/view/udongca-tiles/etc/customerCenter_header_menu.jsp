<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	var menuObj = document.getElementById("ccMenu").getElementsByTagName("div");
	var submenuObj = document.getElementById("subMenu").getElementsByTagName("div");
	for(var i=0; i<menuObj.length;i++){
		menuObj[i].onmouseover = function(evt){
			var idx = i+1;
			return function(){
				document.getElementById("subMenu").style.display="";
			}
		}();
		for(var j=0;j<submenuObj.length; j++){
			submenuObj[j].onmouseover = function(evt){
				var idx = j+1;
				return function(){
					document.getElementById("subMenu").style.display="";
				}
			}();
		}
		
		menuObj[i].onmouseout = function(evt){
			var idx = i+1;
			return function(){
				document.getElementById("subMenu").style.display="none";
			}
		}();
		for(var j=0;j<submenuObj.length; j++){
			submenuObj[j].onmouseout = function(evt){
				var idx = j+1;
				return function(){
					document.getElementById("subMenu").style.display="none";
				}
			}();
		}
	}
});
</script>

<style type="text/css">
div#ccMenu{
color:antiquewhite;
font-size:18px;
cursor:pointer;
}
</style>


<div id="ccMenu" style="float:right;"><div>&nbsp;고객센터▼</div></div>
<div>
	<div id="subMenu" style="display:none;">
		<div><a href="/udongca_project/noticeBoard/noticeBoardListPaging.udc" class="menu">공지사항</a></div>
		<div>
			<c:choose>
				<c:when test="${sessionScope.login.memberId=='udongca' }">
					<a href="/udongca_project/oneToOneInquiry/oneToOneInquiryListPaging.udc" class="menu">1:1문의관리</a>
				</c:when>
				<c:when test="${!empty sessionScope.login.memberId }">
					<a href="/udongca_project/oneToOneInquiry/registerOneToOneInquiryform.udc?codeType=inquiry_type" class="menu">1:1문의하기</a>
				</c:when>
				<c:otherwise>
					<a href="/udongca_project/loginPage.udc" class="menu">1:1문의</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
