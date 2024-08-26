


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
<th>AdmissionNO</th>
<th>Name of the Student</th>
<th>Address</th>
<th>PhoneNo</th>
<th>EmailID</th>
<th>Gender</th>
</tr>
<%
try{
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni","root","");
Statement statement=connection.createStatement();
String sql ="select * from 2016data";
ResultSet resultSet = statement.executeQuery(sql);
while(resultSet.next()){
	
%>
<tr>
<td><%=resultSet.getString("AdmnNo") %></td>
<td><%=resultSet.getString("StudentName") %></td>
<td><%=resultSet.getString("Address") %></td>
<td><%=resultSet.getString("PhoneNo") %></td>
<td><%=resultSet.getString("EmailID") %></td>
<td><%=resultSet.getString("Gender") %></td>

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
