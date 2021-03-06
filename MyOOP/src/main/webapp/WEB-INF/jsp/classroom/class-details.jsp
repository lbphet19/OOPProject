<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
<c:url value="/css/class/class_style.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" >
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
			var id = $(this).parent().find("#classId").val();
			$('#deleteClassModal #deleteId').val(id);
		});
		$('table .edit').on('click',function() {
			var id = $(this).parent().find("#empId").val();
			$("#editClassModal #editId").val(id);
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
	<div class="container-fluid">
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
						<div class="col-xs-6">
							<a class = "btn btn-success" href="${pageContext.request.contextPath }/classes/initCreate.htm">
							<i class="material-icons">&#xE147;</i> <span>Add New Employee</span></a>
							<a href="#deleteClassModal"	class="btn btn-danger" data-toggle="modal">
							<i class="material-icons">&#xE15C;</i> <span>Delete</span></a> 
						</div>
					</div>
				</div>
				<!-- search -->
				<form action="${pageContext.request.contextPath }/classes/get/1" method="get">
					<div class="col-lg-12 search-field">
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-12 p-0">
								<input type="text" class="form-control search-slt" name = "keyword"
									placeholder="Enter anything you want to search" value="${keyword }">
							</div>
							<label for="findBy">Find by:</label>
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<select class="form-control search-slt"	id="findBy" name="findBy" >
									<option value="" disabled selected>Tim kiem theo</option>
									<option value="moduleId">Ma hoc phan</option>
									<option value="moduleName">Ten hoc phan</option>
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
							<th>M?? l???p</th>
							<th>M?? h???c ph???n</th>
							<th>T??n h???c ph???n	</th>
							<th>Ghi ch??</th>
							<th>Nh??m</th>
							<th>?????t m???</th>
							<th>Tu???n</th>
							<th>Th???</th>
							<th>Ng??y thi</th>
							<th>K??p</th>
							<th>SL??K</th>
							<th>Ph??ng thi</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td>${myClass.classId }</td>
							<td>${myClass.moduleId }</td>
							<td>${myClass.moduleName }</td>
							<td>${myClass.descriptions }</td>
							<td>${myClass.classGroup }</td>
							<td>${myClass.openTime }</td>
							<td>${myClass.week }</td>
							<td>${myClass.dayOfWeek }</td>
							<td><fmt:formatDate pattern="dd/MM/yyyy" value="${myClass.testDay }"></fmt:formatDate></td>
							<td>${myClass.kip }</td>
							<td>${myClass.classAmount }</td>
							<td>${myClass.testRoom }</td>
							<td><a href="${pageContext.request.contextPath }/classes/initUpdate.htm?classId=${myClass.classId }" class="edit">
								<i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a> 
								<a href="#deleteClassModal" class="delete" data-toggle="modal">
								<i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
								<input type="hidden" id="classId" name = "classId" value="${class.classId }">
							</td>
						</tr>				    
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- lop trong thi -->
	<h1>Danh s??ch gi??m th??? coi thi</h1>
	<table class="table table-striped table-hover">
	<thead>
	<th>ID</th>
					<th>H??? v?? T??n</th>
					<th>M??n h???c Gi???ng d???y</th>
					<th>S??? ??i???n tho???i</th>
					<th>Email</th>
					<th>
					Action
					</th>
		</thead>
		<tbody>	
			<c:forEach items="${myClass.canBoCoiThi}" var="emp">
				<tr>
					<td>${emp.employeeId }</td>
					<td>${emp.employeeName }</td>
					<td>${emp.subject }</td>
					<td>${emp.phoneNumber }</td>
					<td>${emp.email }</td>
					<td>
					<sec:authorize access="hasAuthority('ADMIN')">
					<f:form action="${pageContext.request.contextPath }/classes/${myClass.classId }/removeCanBoCoiThi/${emp.employeeId }"
	method="post">
					<input type="submit" value="Xoa">
					</f:form>
					</sec:authorize>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style=" font-size:20px;text-align:center">
		<c:if test="${myClass.classAmount > 50 && myClass.canBoCoiThi.size() < 2 }">Chua du giam thi</c:if>
		<c:if test ="(${myClass.classAmount > 50 && myClass.canBoCoiThi.size() >= 2 })||
		(${myClass.classAmount <= 50 && myClass.canBoCoiThi.size() >=1 })">
		???? ?????, n???u mu???n thay ?????i c??n b??? coi thi h??y x??a danh s??ch tr?????c
		</c:if>
		
	</div>
	<f:form	action="${pageContext.request.contextPath }/classes/updateCanBoCoiThi" method="post">
					<input type = "text" name = "empId" placeholder="Nhap ma giang vien" required="required"/>
					<input type="submit" value="Change">
					<input type="hidden" name="classId"	value="${myClass.classId }">
	</f:form>
<!-- test -->
	<h1>Gi???ng vi??n l???p h???c</h1>
	<table class="table table-striped table-hover">
					<tbody>
					       <tr>
							<td>M?? gi???ng vi??n</td>
							<td>T??n gi???ng vi??n</td>
							<td>H??? v?? t??n</td>
							<td>M??n h???c gi???ng d???y</td>
							<td>S??? ??i???n tho???i</td>
							<td>Email</td>
							</tr>
							<tr>
							<td>${myClass.employee.employeeId }</td>
							<td>${myClass.employee.employeeName}</td>
							<td>${myClass.employee.subject}</td>
							<td>${myClass.employee.phoneNumber}</td>
							<td>${myClass.employee.email}</td>
							
							</tr>
					</tbody>
							
				</table>
	<!-- for each element -> nut delete /{id}  -->
	<!-- Delete Modal HTML -->
	<div id="deleteClassModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="${pageContext.request.contextPath }/classes/delete">
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
							class="btn btn-danger" value="Delete">
						<input type = "hidden" name = "deleteId" id="deleteId">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>