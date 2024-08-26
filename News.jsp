

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>News Access Form</title>
    <style>
        /* Your existing CSS styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #fafea5;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #f5c69d;
            color: #000000;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #befff4;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
        }
        .news-item {
            border-bottom: 1px solid #ccc;
            padding: 20px 0;
        }
        .news-title {
            font-size: 24px;
            font-weight: bold;
        }
        .news-date {
            color: #888;
        }
        .news-content {
            margin-top: 10px;
        }

        /* Form styles */
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group textarea,
        .form-group input[type="date"] {
            width: 100%;
            padding: 7px;
        }
        .form-group textarea {
            height: 100px;
        }
        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>News Access Form</h1>
    </div>
    <div class="container">
        <!-- Add News Form Section -->
        <div id="add-news">
            <form id="add-form" action="news.jsp" method="post">
                <div class="form-group">
                    <label for="news-title">News Title</label>
                    <input type="text" id="news-title" name="news-title" placeholder="News Title" required>
                </div>
                <div class="form-group">
                    <label for="news-content">News Content</label>
                    <textarea id="news-content" name="news-content" placeholder="News Content" rows="4" required></textarea>
                </div>
                <div class="form-group">
                    <label for="news-date">News Date</label>
                    <input type="date" id="news-date" name="news-date" required>
                </div>
                <div class="form-group">
                    <input type="submit" value="Add News">
                </div>
            </form>
        </div>

        <!-- Display News Items -->
        <div id="news-list">
            <% 
                // Database connection parameters
                String jdbcUrl = "jdbc:mysql://localhost:3306/alumni";
                String dbUser = "root";
                String dbPassword = "";

                Connection conn = null;
                PreparedStatement insertStmt = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a database connection
                    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Check if form is submitted
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        // Retrieve form data
                        String title = request.getParameter("news-title");
                        String content = request.getParameter("news-content");
                        String date = request.getParameter("news-date");

                        // Insert data into database
                        String insertSql = "INSERT INTO news (title, content, date) VALUES (?, ?, ?)";
                        insertStmt = conn.prepareStatement(insertSql);
                        insertStmt.setString(1, title);
                        insertStmt.setString(2, content);
                        insertStmt.setString(3, date);
                        insertStmt.executeUpdate();
                    }

                    // Retrieve news items from database (latest first)
                    String selectSql = "SELECT * FROM news ORDER BY date DESC";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(selectSql);

                    // Iterate through result set and display news items
                    while (rs.next()) {
            %>
                        <div class="news-item">
                            <div class="news-title"><%= rs.getString("title") %></div>
                            <div class="news-date"><%= rs.getString("date") %></div>
                            <div class="news-content"><%= rs.getString("content") %></div>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='message' style='text-align: center;'><p>An error occurred while processing your request.</p></div>");
                } finally {
                    // Close database resources
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (insertStmt != null) try { insertStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>

    <script>
        // Optional: JavaScript to handle form submission via AJAX for better user experience
    </script>
</body>
</html>
