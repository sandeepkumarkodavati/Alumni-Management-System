
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    // Retrieve form parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String fullname = request.getParameter("fullname");
    String birthdate = request.getParameter("birthdate");
    String gender = request.getParameter("gender");

    // JDBC Connection parameters
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/alumni"; // Change 'your_database_name' to your actual database name
    String dbUsername = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL driver
        Class.forName(driver);

        // Establish the connection
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        // Check if username already exists
        pstmt = conn.prepareStatement("SELECT * FROM logindata WHERE username=?");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Username already exists, handle the error
            // Redirect to registration page with an error message or display an error message
            response.sendRedirect("register.jsp?error=username_exists");
        } else {
            // Insert the user into the database
            pstmt = conn.prepareStatement("INSERT INTO registration (username, password, email, fullname, birthdate, gender) VALUES (?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.setString(4, fullname);
            pstmt.setString(5, birthdate);
            pstmt.setString(6, gender);
            pstmt.executeUpdate();

            // Redirect to login page after successful registration
            response.sendRedirect("login.jsp?registered=true");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle SQL exception
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        // Handle class not found exception
    } finally {
        // Close resources
        try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignored */ }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* Ignored */ }
        try { if (conn != null) conn.close(); } catch (SQLException e) { /* Ignored */ }
    }
%>
