<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
    <body>
        <h3>Welcome, Enter The Class Details</h3>
        <f:form method="POST" action="/classes/update.htm" modelAttribute="myClass">
             <table>
                <tr>
                    <label for="ID">Ma lop</label>
                    <f:input path="classId" readonly="readonly"/>
                </tr>
                <br>
                 <tr>
                    <label for="moduleId">Ma hoc phan</label>
                    <f:input path="moduleId" />
                </tr>
                <br>
                 <tr>
                    <label for="moduleName">Ten hoc phan</label>
                    <f:input path="moduleName"/>
                </tr>
                <br>
                 <tr>
                    <label for="descriptions">Ghi chu</label>
                    <f:input path="descriptions"/>
                </tr>
                <br>
                 <tr>
                    <label for="classGroup">Nhom</label>
                    <f:input path="classGroup"/>
                </tr>
                <br>
                 <tr>
                    <label for="openTime">Thoi gian mo</label>
                    <f:input path="openTime"/>
                </tr>
                <br>
                 <tr>
                    <label for="week">Tuan</label>
                    <f:input path="week"/>
                </tr>
                <br>
                 <tr>
                    <label for="dayOfWeek">Thu</label>
                    <f:input path="dayOfWeek"/>
                </tr>
                <br>
                 <tr>
                    <label for="testDay">Ngay thi</label>
<!--                     <input type="date" name ="testDay"> -->
                    <f:input path="testDay" type="date"/>
                </tr>
                <br>
                 <tr>
                    <label for="kip">Kip thi</label>
                    <f:input path="kip"/>
                </tr>
                <br>
                 <tr>
                    <label for="classAmount">So luong</label>
                    <f:input path="classAmount"/>
                </tr>
                <br>
                 <tr>
                    <label for="testRoom">Phong thi</label>
                    <f:input path="testRoom"/>
                </tr>
                <br>
                <tr>
                    <td><input type="submit" value="Submit"/></td>
                </tr>
            </table>
        </f:form>
    </body>

</html>