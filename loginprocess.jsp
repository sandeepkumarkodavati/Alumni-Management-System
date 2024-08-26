
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    // Retrieve form parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Check for empty fields
    if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
        response.sendRedirect("login.jsp?error=empty_fields");
        return;
    }

    // JDBC Connection parameters
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/alumni"; 
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

        // Check if username and password match
        pstmt = conn.prepareStatement("SELECT * FROM logindata WHERE username=? AND password=?");
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Login successful, set session attribute
            session.setAttribute("isLoggedIn", "true");
            session.setAttribute("username", username);

            // Store login details in database
            PreparedStatement pstmtInsert = conn.prepareStatement("INSERT INTO login (username, login_time) VALUES (?, ?)");
            pstmtInsert.setString(1, username);
            pstmtInsert.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmtInsert.executeUpdate();
            pstmtInsert.close();

            // Redirect to homepage
            response.sendRedirect("home.html");
        } else {
            // Login failed, redirect back to login page with error message
            response.sendRedirect("login.jsp?error=invalid_credentials");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle SQL exception
        response.sendRedirect("login.jsp?error=database_error"); // Redirect with database error message
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        // Handle class not found exception
        response.sendRedirect("login.jsp?error=server_error"); // Redirect with server error message
    } finally {
        // Close resources
        try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignored */ }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* Ignored */ }
        try { if (conn != null) conn.close(); } catch (SQLException e) { /* Ignored */ }
    }
%>
