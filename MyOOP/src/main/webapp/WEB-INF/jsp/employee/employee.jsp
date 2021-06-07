<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap CRUD Data Table for Database with Modal Form</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="css/class_style.css"> -->
<c:url value="/css/class/class_style.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" >
<%-- <link href="<c:url value = '/resources/css/class-style.css'></c:url>"> --%>
<!-- <link rel="stylesheet" href="/css/class/class_style.css"> -->
<script>
	$(document).ready(function() {
		// Activate tooltip
		$('[data-toggle="tooltip"]').tooltip();

		// Select/Deselect checkboxes
		var checkbox = $('table tbody input[type="checkbox"]');
		$("#selectAll").click(function() {
		if (this.checked) {
			checkbox.each(function() {
			this.checked = true;
			});
		} else {
				checkbox.each(function() {
					this.checked = false;
				});
		}
		});
		checkbox.click(function() {
			if (!this.checked) {
				$("#selectAll").prop("checked", false);
			}
		});
		$('table .delete').on('click', function() {
			var id = $(this).parent().find("#empId").val();
			$('#deleteEmployeeModal #deleteId').val(id);
		});
		$('table .edit').on('click',function() {
			var id = $(this).parent().find("#empId").val();
			$("#editEmployeeModal #update_id").val(id);
							/*  goi controller lay model theo id  */
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath }'
						+ '/employee/findById/'
						+ id,
				success : function(employee) {
						/* name object phoneNumber email office */
						$("#editEmployeeModal #update_name").val(employee.employeeName),
						$("#editEmployeeModal #update_subject").val(employee.subject),
						$("#editEmployeeModal #update_phoneNumber").val(employee.phoneNumber),
						$("#editEmployeeModal #update_email").val(employee.email),
						$("#editEmployeeModal #update_office").val(employee.office)
				}
			  })
			});
		});
</script>
</head>
<body>
<jsp:include page=".././header/header.jsp"></jsp:include>
	<div class="container">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-xs-6">
							<h2 id = "navigation-link">
								<a href="${pageContext.request.contextPath }/classes/get/1">Manage <b>Classes</b></a>
								<a href="${pageContext.request.contextPath }/employee/listEmp.htm/1">Manage <b>Employees</b></a>
							</h2>
						</div>
						<sec:authorize access="hasAnyAuthority('ADMIN')">
						<div class="col-xs-6">
							<a href="#addEmployeeModal" class="btn btn-success"
								data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add
									New Employee</span></a> <a href="#deleteEmployeeModal"
								class="btn btn-danger" data-toggle="modal"><i
								class="material-icons">&#xE15C;</i> <span>Delete</span></a>
						</div>
						</sec:authorize>
<%-- 						<sec:authorize access="hasAnyAuthority('USER')"> --%>
<!-- 							<div class = "col-xs-6"> -->
<%-- 								<a id = "userDetails" href="${pageContext.request.contextPath }/employee/details/<sec:authentication property="principal.employeeId" /> "> --%>
<!-- 								User Details</a> -->
<!-- 							</div> -->
<%-- 						</sec:authorize> --%>
					</div>
				</div>
				<br>
				<br>
				<br>
				<!-- search -->
				<form action="${pageContext.request.contextPath }/employee/listEmp.htm/1" method="get">
					<div class="col-lg-12 search-field">
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-12 p-0">
								<input type="text" class="form-control search-slt" name = "name"
									placeholder="Enter Pickup City">
							</div>
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<select class="form-control search-slt"
									id="exampleFormControlSelect1">
									<option>Select Vehicle</option>
									<option>Example one</option>
									<option>Example one</option>
									<option>Example one</option>
									<option>Example one</option>
									<option>Example one</option>
									<option>Example one</option>
								</select>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<button type="submit" class="btn btn-danger wrn-btn">Search</button>
							</div>
						</div>
					</div>
				</form>
				<br>
				<!-- search -->
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th><span class="custom-checkbox"> <input
									type="checkbox" id="selectAll"> <label for="selectAll"></label>
							</span></th>
							<th>Mã giảng viên</th>
							<th>Họ tên</th>
							<th>Bộ môn công tác</th>
							<th>SĐT</th>
							<th>Email</th>
							<th>Phòng làm việc</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listEmp }" var="employee">
							<tr>
								<td><span class="custom-checkbox"> <input
										type="checkbox" id="checkbox" name="options[]" value="1">
										<label for="checkbox"></label>
								</span></td>
								<td>${employee.employeeId }</td>
								<td>${employee.employeeName }</td>
								<td>${employee.subject }</td>
								<td>${employee.phoneNumber }</td>
								<td>${employee.email }</td>
								<td>${employee.office }</td>
								<sec:authorize access="hasAnyAuthority('ADMIN')">
								<td><a href="${pageContext.request.contextPath }/employee/details/${employee.employeeId }">Details</a></td>
								</sec:authorize>
								<sec:authorize access="hasAnyAuthority('ADMIN')">
								<td><a href="#editEmployeeModal" class="edit"
									data-toggle="modal"><i class="material-icons"
										data-toggle="tooltip" title="Edit">&#xE254;</i></a> <a
									href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i
										class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
									<input type="hidden" id="empId" value="${employee.employeeId }"></td>
								</sec:authorize>
							</tr>
							<!-- <input 
									type="hidden" id="updateEmpId" value="${employee.employeeId }">  -->
						</c:forEach>
					</tbody>
				</table>
				<div class="clearfix">
					<div class="hint-text">
						Total result: ${totalItems }
					</div>
					<ul class="pagination">
						<c:choose>
							<c:when test="${currentPage != 1 }">
								<li class="page-item"><a
									href="${pageContext.request.contextPath }/employee/listEmp.htm/${currentPage-1 }"
									class="page-link">Previous</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
								<a href="#">Previous</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${totalPages }" var="i">
							<c:choose>
								<c:when test="${currentPage eq i }">
									<li class="page-item disabled"><a href="#">${i }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a
										href="${pageContext.request.contextPath }/employee/listEmp.htm/${i}"
										class="page-link">${i }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- last -->
						<c:choose>
							<c:when test="${currentPage != totalPages }">
								<li class="page-item"><a
									href="${pageContext.request.contextPath }/employee/listEmp.htm/${currentPage+1 }"
									class="page-link">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
								<a href="#">Next</a>
								</li>
							</c:otherwise>
						</c:choose>
						<!-- <li class="page-item disabled"><a href="#">Previous</a></li>
						<li class="page-item"><a href="#" class="page-link">1</a></li>
						<li class="page-item"><a href="#" class="page-link">2</a></li>
						<li class="page-item active"><a href="#" class="page-link">3</a></li>
						<li class="page-item"><a href="#" class="page-link">4</a></li>
						<li class="page-item"><a href="#" class="page-link">5</a></li>
						<li class="page-item"><a href="#" class="page-link">Next</a></li> -->
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- Add Modal HTML -->
	<div id="addEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<f:form action="${pageContext.request.contextPath }/employee/save" method="post">
					<div class="modal-header">
						<h4 class="modal-title">Add Employee</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Name</label> <input type="text" class="form-control"
								name="name" required>
						</div>
						<div class="form-group">
							<label>Bộ môn</label> <input type="text" class="form-control"
								name="subject" required>
						</div>
						<div class="form-group">
							<label>Phone Number</label> <input type="text"
								class="form-control" name="phoneNumber" required>
						</div>
						<div class="form-group">
							<label>Email</label> <input type="email" class="form-control"
								name="email" required>
						</div>
						<div class="form-group">
							<label>Phòng làm việc</label> <input type="text"
								class="form-control" name="office" required>
						</div>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-success" value="Add">
					</div>
				</f:form>
			</div>
		</div>
	</div>
	<!-- Edit Modal HTML -->
	<div id="editEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<f:form action="${pageContext.request.contextPath }/employee/put" method="post">
					<div class="modal-header">
						<h4 class="modal-title">Edit Employee</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Name</label> <input type="text" class="form-control"
								name="update_name" id="update_name" required>
						</div>
						<div class="form-group">
							<label>Bộ môn</label> <input type="text" class="form-control"
								name="update_subject" id="update_subject" required>
						</div>
						<div class="form-group">
							<label>Phone Number</label> <input type="text"
								class="form-control" name="update_phoneNumber"
								id="update_phoneNumber" required>
						</div>
						<div class="form-group">
							<label>Email</label> <input type="email" class="form-control"
								name="update_email" id="update_email" required>
						</div>
						<div class="form-group">
							<label>Phòng làm việc</label> <input type="text"
								class="form-control" name="update_office" id="update_office"
								required>
						</div>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit" class="btn btn-info"
							value="Save"> <input type="hidden" name = "update_id" id="update_id">
					</div>
				</f:form>
			</div>
		</div>
	</div>
	<!-- for each element -> nut delete /{id}  -->
	<!-- Delete Modal HTML -->
	<div id="deleteEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<f:form action="${pageContext.request.contextPath }/employee/delete"
					method="post">
					<div class="modal-header">
						<h4 class="modal-title">Delete Employee</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-danger" value="Delete"> <input
							type="hidden" id="deleteId" name="id">
					</div>
				</f:form>
			</div>
		</div>
	</div>
</body>
</html>