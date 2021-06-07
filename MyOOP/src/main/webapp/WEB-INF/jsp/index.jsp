<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<sec:authorize access="isAuthenticated()">
				Welcome	<sec:authentication property="principal.username" />
				<sec:authorize access="hasAnyAuthority('USER')">
					<div class="col-xs-6">
						<a id="userDetails"
							href="${pageContext.request.contextPath }/employee/details/<sec:authentication property="principal.employeeId" /> ">
							<button>User Details</button></a>
					</div>
				</sec:authorize>
				<sec:authorize access="hasAnyAuthority('ADMIN')">
				<a href="${pageContext.request.contextPath }/employee/listEmp.htm/1">Quan ly giang vien</a>
				<a href="${pageContext.request.contextPath }/classes/get/1">Quan ly lop hoc</a>
				</sec:authorize>
			</sec:authorize>
</body>
</html>