
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<body>
<h1>ALUMNI</h1>
<table border="1">
<tr>
<th>AdmissionType</th>
<th>Name of the Student</th>
<th>Gender</th>
<th>StudentAadhar</th>
<th>MobileNumber</th>
<th>Email_Id</th>
<th>Address</th>
</tr>
<%
try{
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni","root","");
Statement statement=connection.createStatement();
String sql ="select * from 2020data";
ResultSet resultSet = statement.executeQuery(sql);
while(resultSet.next()){
	
%>
<tr>
<td><%=resultSet.getString("AdmissionType") %></td>
<td><%=resultSet.getString("Name of the Student") %></td>
<td><%=resultSet.getString("Gender") %></td>
<td><%=resultSet.getString("StudentAadharNumber") %></td>
<td><%=resultSet.getString("MobileNumber") %></td>
<td><%=resultSet.getString("Email_Id") %></td>
<td><%=resultSet.getString("Address") %></td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table> 
</body>
</html>
