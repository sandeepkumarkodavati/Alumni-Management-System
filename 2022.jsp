
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<body>
<h1> 2022 ALUMNI</h1>
<table border="1">
<tr>
<th>BRANCH</th>
<th>REGD NO</th>

<th>STUDENT NAME</th>
<th>AADHAR</th>
<th>BLOOD</th>
<th>FATHER NAME</th>
<th>PHONE</th>
<th>MOBILE</th>
<th>Address</th>
<th>YEAR</th>
<th>DOB</th>
</tr>
<%
try{
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni","root","");
Statement statement=connection.createStatement();
String sql ="select * from 2022data";
ResultSet resultSet = statement.executeQuery(sql);
while(resultSet.next()){
	
%>
<tr>
<td><%=resultSet.getString("BRANCH") %></td>
<td><%=resultSet.getString("REGD NO") %></td>
<td><%=resultSet.getString("STUDENT NAME") %></td>
<td><%=resultSet.getString("AADHAR") %></td>
<td><%=resultSet.getString("BLOOD") %></td>
<td><%=resultSet.getString("FATHER NAME") %></td>
<td><%=resultSet.getString("PHONE") %></td>
<td><%=resultSet.getString("MOBILE") %></td>
<td><%=resultSet.getString("Address") %></td>
<td><%=resultSet.getString("YEAR") %></td>
<td><%=resultSet.getString("DOB") %></td>
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
