<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="/udongca_project/oneToOneInquiry/registerOneToOneInquiry.udc" method="post">
<c:if test="${sessionScope.login.memberId=='udongca' }">
	<div align="right"><input type="submit" value="답글달기"></div>
</c:if>

</form>