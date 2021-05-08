<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
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
					</div>
				</div>
				<br>
				<!-- search -->
				<table class="table table-striped table-hover">
					<thead>
						<tr>
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
								<td><a href="#editEmployeeModal" class="edit"
									data-toggle="modal"><i class="material-icons"
										data-toggle="tooltip" title="Edit">&#xE254;</i></a> <a
									href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i
										class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
									<input type="hidden" id="empId" value="${employee.employeeId }"></td>
							</tr>
		
							<!-- <input	type="hidden" id="updateEmpId" value="${employee.employeeId }">  -->
						
					</tbody>
				</table>
				<!-- lop trong thi -->
				<h1>Danh sach lop coi thi</h1>
				<table class="table table-striped table-hover">
					<tbody>
							<c:forEach items="${employee.classes }" var = "class">
							<tr>
							<td>${class.moduleName }</td>
							<td>${class.classId }</td>
							</tr>
							</c:forEach>
					</tbody>
				</table>
				<f:form	action="${pageContext.request.contextPath }/employee/updateLopTrongThi"
					method="post" modelAttribute="employee">
					<input type = "text" name = "classId" placeholder="Nhap ma lop" required="required"/>
					<input type="submit" value="Change">
					<input type="hidden" name="employeeId"
						value="${employee.employeeId }">
				</f:form>
			</div>
		</div>
	</div>
</body>
</html>