
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession, javax.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #E6E6FA;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-item {
            margin-bottom: 15px;
        }

        .profile-item label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .profile-item span {
            display: block;
            font-size: 16px;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

        .footer p {
            font-size: 14px;
        }

        .footer a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function goToHome() {
            if (window.top !== window.self) {
                window.top.location.href = 'home1.html';
            } else {
                window.location.href = 'home1.html';
            }
        }
    </script>
</head>
<body>
    <div class="profile-container">
        <h2>User Profile</h2>

        <% 
            HttpSession session1 = request.getSession(false);
            String username = (String) session.getAttribute("username");

            if (username == null) {
                out.println("<p>You are not logged in. Please <a href='home.html'>login</a> first.</p>");
            } else {
                // Database connection parameters
                String jdbcUrl = "jdbc:mysql://localhost:3306/alumni";
                String dbUser = "root";
                String dbPassword = "";

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a database connection
                    Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Retrieve user data from the database
                    String querySql = "SELECT firstname, lastname, email, dob, phonenumber, batch FROM registrations WHERE username = ?";
                    PreparedStatement queryStmt = conn.prepareStatement(querySql);
                    queryStmt.setString(1, username);
                    ResultSet rs = queryStmt.executeQuery();

                    if (rs.next()) {
                        String firstname = rs.getString("firstname");
                        String lastname = rs.getString("lastname");
                        String email = rs.getString("email");
                        String dob = rs.getString("dob");
                        String phonenumber = rs.getString("phonenumber");
                        String batch = rs.getString("batch");

                        out.println("<div class='profile-item'><label>First Name:</label><span>" + firstname + "</span></div>");
                        out.println("<div class='profile-item'><label>Last Name:</label><span>" + lastname + "</span></div>");
                        out.println("<div class='profile-item'><label>Email:</label><span>" + email + "</span></div>");
                        out.println("<div class='profile-item'><label>Date of Birth:</label><span>" + dob + "</span></div>");
                        out.println("<div class='profile-item'><label>Phone Number:</label><span>" + phonenumber + "</span></div>");
                        out.println("<div class='profile-item'><label>Batch:</label><span>" + batch + "</span></div>");
                    } else {
                        out.println("<p>User data not found. Please try again later.</p>");
                    }

                    // Close database resources
                    rs.close();
                    queryStmt.close();
                    conn.close();

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>An error occurred while retrieving your profile data. Please try again later.</p>");
                }
            }
        %>
    </div>

    <!-- Footer with logout and back links -->
    <div class="footer">
        <p><a href="logout.jsp">Logout</a>
        <br>
        <br>
        <a href="#" onclick="goToHome()">Back</a></p>
    </div>
</body>
</html>
