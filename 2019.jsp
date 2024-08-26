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
<th>Admn No</th>
<th>StudentName</th>
<th>City</th>
<th>phone</th>
</tr>
<%
try{
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni","root","");
Statement statement=connection.createStatement();
String sql ="select * from 2019data";
ResultSet resultSet = statement.executeQuery(sql);
while(resultSet.next()){
	
%>
<tr>
<td><%=resultSet.getString("AdmnNo") %></td>
<td><%=resultSet.getString("StudentName") %></td>
<td><%=resultSet.getString("City") %></td>
<td><%=resultSet.getString("Phone") %></td>
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
