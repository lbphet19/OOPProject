<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
label {
	display: table-cell;
}

input {
	display: table-cell;
	width: 250px;
	border: 2px solid #ccc;
	height: 27px;
	opacity: 50%;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	font-size: 17px;
}

form {
	width: 300px;
	padding-top: 10px;
	height: 720px;
	display: grid;
	justify-content: center;
	justify-self: center;
	align-content: center;
}

body {
	display: grid;
	background-color: #6d695c;
	background-image: repeating-linear-gradient(120deg, rgba(255, 255, 255, .1),
		rgba(255, 255, 255, .1) 1px, transparent 1px, transparent 60px),
		repeating-linear-gradient(60deg, rgba(255, 255, 255, .1),
		rgba(255, 255, 255, .1) 1px, transparent 1px, transparent 60px),
		linear-gradient(60deg, rgba(0, 0, 0, .1) 25%, transparent 25%,
		transparent 75%, rgba(0, 0, 0, .1) 75%, rgba(0, 0, 0, .1)),
		linear-gradient(120deg, rgba(0, 0, 0, .1) 25%, transparent 25%,
		transparent 75%, rgba(0, 0, 0, .1) 75%, rgba(0, 0, 0, .1));
	background-size: 70px 120px;
	justify-self: center;
	align-content: center;
}

label {
	align-self: center;
	justify-content: center;
	color: #566787;
}

h3 {
	font-size: x-large;
	color: gainsboro;
	justify-self: center;
}

#submit {
	color: black;
	border: black 3px;
	opacity: 100%;
	background-color: #ccc;
 	margin-bottom: 35px; 
}

hr {
	color: #566787;
	opacity: 100%;
}

#form-body {
	align-self: center;
	justify-self: center;
	margin-top: 0px;
	height: 750px;
}

#tag {
	justify-self: center;
	background-color: #566787;
	display: grid;
	width: 400px;
}
</style>
<body>
	<div id="tag">

		<h3>Welcome, Enter The Employee Details</h3>
		<div id="form-body">
			<f:form style="background-color: white;" method="POST"
				action="/classes/create.htm" modelAttribute="myClass">
				<table>
					<div style="padding-top:20px">
						<label for="classId">Ma lop</label>
						<f:input path="classId" />
					</div>
					<div>
						<label for="moduleId">Ma hoc phan</label>
						<f:input path="moduleId" />
					</div>
					<div>
						<label for="moduleName">Ten hoc phan</label>
						<f:input path="moduleName" />
					</div>
					<div>
						<label for="descriptions">Ghi chu</label>
						<f:input path="descriptions" />
					</div>

					<div>
						<label for="classGroup">Nhom</label>
						<f:input path="classGroup" />
					</div>

					<div>
						<label for="openTime">Thoi gian mo</label>
						<f:input path="openTime" />
					</div>

					<div>
						<label for="week">Tuan</label>
						<f:input path="week" />
					</div>

					<div>
						<label for="dayOfWeek">Thu</label>
						<f:input path="dayOfWeek" />
					</div>

					<div>
						<label for="testDay">Ngay thi</label> <input type="date"
							name="testDay">
					</div>

					<div>
						<label for="kip">Kip thi</label>
						<f:input path="kip" />
					</div>

					<div>
						<label for="classAmount">So luong</label>
						<f:input path="classAmount" />
					</div>

					<div>
						<label for="testRoom">Phong thi</label>
						<f:input path="testRoom" />
					</div>
					<hr></hr>
					<div>
						<input id="submit" type="submit" value="Submit" />
					</div>
				</table>
			</f:form>
		</div>
	</div>
</body>

</html>