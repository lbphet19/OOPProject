<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<div class="float-right">
			<sec:authorize access="isAuthenticated()">
			
				Welcome
				<sec:authentication property="principal.username" />
				<a href="<c:url value="/logout" />">Logout</a>
				<br>
				<sec:authorize access="hasAnyAuthority('USER')">
					<div class="col-xs-6">
						<a id="userDetails"
							href="${pageContext.request.contextPath }/employee/details/<sec:authentication property="principal.employeeId" /> ">
							<button>User Details</button></a>
					</div>
				</sec:authorize>
			</sec:authorize>
		</div>
	</div>

</body>
</html>