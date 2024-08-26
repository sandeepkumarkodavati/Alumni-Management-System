

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Application Submitted</title>
</head>
<body>
<%
    String dbURL = "jdbc:mysql://localhost:3306/mysql"; 
    String dbUser = "root"; 
    String dbPass = ""; 
    String fullName = request.getParameter("full_name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String batch = request.getParameter("batch");
    String currentJob = request.getParameter("current_job");
    String mentoringExperience = request.getParameter("mentoring_experience");
    String areasOfExpertise = request.getParameter("areas_of_expertise");
    String availability = request.getParameter("availability");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        String sql = "INSERT INTO mentors (full_name, email, phone, batch, current_job, mentoring_experience, areas_of_expertise, availability) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, fullName);
        pstmt.setString(2, email);
        pstmt.setString(3, phone);
        pstmt.setInt(4, Integer.parseInt(batch));
        pstmt.setString(5, currentJob);
        pstmt.setString(6, mentoringExperience);
        pstmt.setString(7, areasOfExpertise);
        pstmt.setString(8, availability);
        int rows = pstmt.executeUpdate();
        if (rows > 0) {
%>
            <h1>Application Submitted Successfully!</h1>
            <p>Thank you, <strong><%= fullName %></strong>. Your application has been submitted.</p>
<%
        } else {
%>
            <h1>Application Submission Failed</h1>
            <p>There was an error submitting your application. Please try again.</p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <h1>Error</h1>
        <p><%= e.getMessage() %></p>
<%
    } finally {
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
</body>
</html>