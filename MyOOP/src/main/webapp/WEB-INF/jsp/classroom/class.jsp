<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
<head>
	    <style>
        .excel{
            color:white;
            background-color:#337ab7;
            height: 40px;
            
        }
        #getLable{
			display: flex;
            background-color: indigo;
  color: white;
  padding: 0.5rem;
  font-family: sans-serif;
  border-radius: 0.3rem;
  cursor: pointer;
  margin-top: 1rem;
			height: 40px;
			text-align: center;
			align-items: center;
			justify-content: center;
			width: 145px;
			float: left;
			
        }
		#getLable:hover{
			box-shadow:  inset 0 3px 5px rgb(0 0 0 / 13%);
			background-color: #204d74;;
		}
        #function{
            text-align:justify;

        }
		#chosen-file{
			
			height: 40px;
			margin-top: 10px;
			width: 150px;

			
		}
	</style>
</head>
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
		$("#multiple-delete").on('click',function(){
			
			var checkedVals = $("input:checkbox[class=checkboxes]:checked").map(function(){
				return $(this).val();
			}).get();
			alert(checkedVals);
		})
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
						<sec:authorize access="hasAnyAuthority('ADMIN')">
						<div class="col-xs-6">
							<a href="${pageContext.request.contextPath }/classes/initCreate.htm" class="btn btn-success"
								data-toggle="modal"><i class="material-icons">&#xE147;</i>
								 <span>Add New Class</span></a> 
							<a href="#deleteClassModal" class="btn btn-danger" 
								data-toggle="modal" id = "multiple-delete"><i class="material-icons">&#xE15C;</i>
								 <span>Delete</span></a>
						</div>
						</sec:authorize>
						<sec:authorize access="hasAnyAuthority('USER')">
							
						</sec:authorize>
					</div>
				</div>
				<!-- search -->
				<form action="${pageContext.request.contextPath }/classes/get/1" method="get">
					<div class="col-lg-12 search-field">
						<div class="row">
							<div class="col-lg-4 col-md-6 col-sm-12 p-0">
								<input type="text" class="form-control search-slt" name = "keyword"
									placeholder="Enter anything you want to search" value="${keyword }">
							</div>
							<div class="col-lg-2 col-md-3 col-sm-12 p-0">
								<select class="form-control search-slt"	id="findBy" name="findBy" >
									<option value="" disabled selected>Tìm kiếm theo</option>
									<option value="moduleId">Mã học phần</option>
									<option value="moduleName">Tên học phần</option>
									<option value="classId">Mã lớp</option>
								</select>
							</div>
							<div class="col-lg-2 col-md-3 col-sm-12 p-0">
								<select class="form-control search-slt"	id="sortBy" name="sortBy" >
									<option value="" disabled selected>Sắp xếp theo</option>
									<option value="moduleId">Mã học phần</option>
									<option value="moduleName">Tên học phần</option>
									<option value="testDay">Ngày thi</option>
								</select>
							</div>
							<div class="col-lg-2 col-md-3 col-sm-12 p-0">
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
							<th>Mã lớp</th>
							<th>Mã học phần</th>
							<th>Tên học phần</th>
							<th>Ghi chú</th>
							<th>Nhóm</th>
							<th>Đợt mở</th>
							<th>Tuần</th>
							<th>Thứ</th>
							<th>Ngày thi</th>
							<th>Kíp</th>
							<th>SLĐK</th>
							<th>Phòng thi</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listClass }" var="class">
						<tr>
							<td><span class="custom-checkbox"> <input class = "checkboxes"
									type="checkbox" name="options[]" id = "${class.classId }" value="${class.classId }">
									<label for="${class.classId }"></label>
							</span></td>
							<td>${class.classId }</td>
							<td>${class.moduleId }</td>
							<td>${class.moduleName }</td>
							<td>${class.descriptions }</td>
							<td>${class.classGroup }</td>
							<td>${class.openTime }</td>
							<td>${class.week }</td>
							<td>${class.dayOfWeek }</td>
							<td><fmt:formatDate pattern="dd/MM/yyyy" value="${class.testDay }"></fmt:formatDate></td>
							<td>${class.kip }</td>
							<td>${class.classAmount }</td>
							<td>${class.testRoom }</td>
							<td><a href="${pageContext.request.contextPath }/classes/details/${class.classId}">Details</a></td>
							<sec:authorize access="hasAnyAuthority('ADMIN')">
							<td><a href="${pageContext.request.contextPath }/classes/initUpdate.htm?classId=${class.classId }" class="edit">
								
								<i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a> 
								<a href="#deleteClassModal" class="delete" data-toggle="modal">
								<i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
								<input type="hidden" id="classId" name = "classId" value="${class.classId }">
								
								</sec:authorize> 
								
							</td>
						</tr>
						</c:forEach>
					    
					</tbody>
				</table>
				<!-- page -->
				<div class="clearfix">
					<div class="hint-text">Total result: ${totalItems }</div>
					<ul class="pagination">
						<c:choose>
							<c:when test="${currentPage != 1 }">
								<li class="page-item"><a
									href="${pageContext.request.contextPath }/classes/get/${currentPage-1 }"
									class="page-link">Previous</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a href="#">Previous</a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="1" end="${totalPages }" var="i">
							<c:choose>
								<c:when test="${currentPage eq i }">
									<li class="page-item disabled"><a href="#">${i }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a
										href="${pageContext.request.contextPath }/classes/get/${i}"
										class="page-link">${i }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- last -->
						<c:choose>
							<c:when test="${currentPage != totalPages }">
								<li class="page-item"><a
									href="${pageContext.request.contextPath }/classes/get/${currentPage+1 }"
									class="page-link">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a href="#">Next</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- download -->
	 <div id="function">
	<!-- download -->
	<a href="${pageContext.request.contextPath }/excel/download" class="btn btn-primary btn-lg active"
	 role="button" aria-pressed="true" style="margin: 10px;">Download</a>
	 <!-- upload  -->
	
	<f:form action="${pageContext.request.contextPath }/excel/upload" style="margin-left: 10px;" method="post" enctype="multipart/form-data">
		
        <input id="getExcel" class="excel" type="file" name = "excelFile" value="Chon tep" style="display: none;">
		
		<label id="getLable" for="getExcel" >Upload Excel File</label>
		<input id='chosen-file'  value="No chosen File" readonly></input>
		<input class="excel" type="submit" value="Upload">
	</f:form>
    </div>
	<script>
		const fileChosen=document.getElementById("chosen-file");
		const getFileButton=document.getElementById("getExcel");
		getFileButton.addEventListener('change',function(){
			fileChosen.value = this.files[0].name;

		})
	</script>
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