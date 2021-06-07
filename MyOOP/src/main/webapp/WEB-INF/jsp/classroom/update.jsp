<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    label{
        display: table-cell;

    }
    input{
        display: table-cell;
       width: 250px;
        border: 2px solid #ccc;
        height: 27px;
        opacity: 50%;
        transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        font-size: 17px;



        
    }
    form{
        width: 300px;
        padding-top: -10px;
        height: 700px;

      display: grid;
        justify-content: center;
       justify-self: center;
    
        align-content: center;
    }
    body{
        display: grid;
        background-color: #6d695c;
background-image:
repeating-linear-gradient(120deg, rgba(255,255,255,.1), rgba(255,255,255,.1) 1px, transparent 1px, transparent 60px),
repeating-linear-gradient(60deg, rgba(255,255,255,.1), rgba(255,255,255,.1) 1px, transparent 1px, transparent 60px),
linear-gradient(60deg, rgba(0,0,0,.1) 25%, transparent 25%, transparent 75%, rgba(0,0,0,.1) 75%, rgba(0,0,0,.1)),
linear-gradient(120deg, rgba(0,0,0,.1) 25%, transparent 25%, transparent 75%, rgba(0,0,0,.1) 75%, rgba(0,0,0,.1));
background-size: 70px 120px;
        justify-self: center;
        align-content: center;
    }
    label{
        align-self: center;
        justify-content: center;
        color:#566787;

    }
    h3{
        font-size: x-large ;
        
        color: gainsboro;
        justify-self: center;
    }
    #submit{
        color: black;
        border: black 3px;
        
        opacity: 100%;
        background-color: #ccc;
        margin-bottom: 10px;
    }
    hr{
        color: #566787;
        opacity: 100%;
    }
    #form-body{
        align-self: center;
        justify-self: center;
        margin-top: 0px;
        height: 750px;
    }
    #tag{
        justify-self:center;
        background-color: #566787;
        display: grid;
        width: 400px;

    }
</style>

</head>
    <body>
        <h3>Welcome, Enter The Class Details</h3>
        <f:form method="POST" action="/classes/update.htm" modelAttribute="myClass">
             <table>
                <tr>
                    <label for="classId">Ma lop</label>
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