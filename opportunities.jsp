
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Alumni Opportunities</title>
    <style>
        /* Your existing CSS styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #fdaafa;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #76bff3;
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        h1 {
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #d1efb2;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .opportunity {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
        }
        .opportunity h2 {
            margin-top: 0;
        }
        .opportunity p {
            margin-bottom: 0;
        }
        #add-opportunity {
            text-align: center;
            margin-bottom: 20px;
        }
        #add-button {
            background-color: #76bff3;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-right: 10px;
        }
        #add-button:hover {
            background-color: #45a049;
        }
        #add-form {
            display: none;
            border: 1px solid #000000;
            padding: 20px;
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
        .form-group input[type="date"],
        .form-group input[type="url"] {
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
    <header>
        <h1>Alumni Opportunities</h1>
    </header>
    <div class="container">
        <!-- Add Opportunity Section -->
        <div id="add-opportunity">
            <button id="add-button">Add Opportunity</button>
            <form id="add-form" action="opportunities.jsp" method="post">
                <div class="form-group">
                    <label for="opportunity-title">Opportunity Title</label>
                    <input type="text" id="opportunity-title" name="opportunity-title" placeholder="Opportunity Title" required>
                </div>
                <div class="form-group">
                    <label for="opportunity-description">Opportunity Description</label>
                    <textarea id="opportunity-description" name="opportunity-description" placeholder="Opportunity Description" rows="4" required></textarea>
                </div>
                <div class="form-group">
                    <label for="alumni-name">Alumni Name</label>
                    <input type="text" id="alumni-name" name="alumni-name" placeholder="Alumni Name" required>
                </div>
                <div class="form-group">
                    <label for="post-date">Post Date</label>
                    <input type="date" id="post-date" name="post-date" required>
                </div>
                <div class="form-group">
                    <label for="applyLink">Apply Link</label>
                    <input type="url" id="applyLink" name="applyLink" placeholder="https://example.com/apply" required>
                </div>
                <div class="form-group">
                    <input type="submit" value="Post">
                </div>
            </form>
        </div>

        <!-- Display Opportunities -->
        <div id="opportunity-list">
            <% 
                // Database connection parameters
                String jdbcUrl = "jdbc:mysql://localhost:3306/alumni";
                String dbUser = "root";
                String dbPassword = "";

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a database connection
                    Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Check if form is submitted
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        // Retrieve form data
                        String title = request.getParameter("opportunity-title");
                        String description = request.getParameter("opportunity-description");
                        String alumniName = request.getParameter("alumni-name");
                        String postDate = request.getParameter("post-date");
                        String applyLink = request.getParameter("applyLink");

                        // Check if opportunity already exists
                        String checkSql = "SELECT COUNT(*) AS count FROM opportunities WHERE title = ? AND alumni_name = ?";
                        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                        checkStmt.setString(1, title);
                        checkStmt.setString(2, alumniName);
                        ResultSet rs = checkStmt.executeQuery();
                        rs.next();
                        int count = rs.getInt("count");

                        if (count == 0) {
                            // Insert data into database
                            String insertSql = "INSERT INTO opportunities (title, description, alumni_name, post_date, apply_link) VALUES (?, ?, ?, ?, ?)";
                            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                            insertStmt.setString(1, title);
                            insertStmt.setString(2, description);
                            insertStmt.setString(3, alumniName);
                            insertStmt.setString(4, postDate);
                            insertStmt.setString(5, applyLink);
                            insertStmt.executeUpdate();
                            insertStmt.close();
                        } else {
                            // Opportunity already exists, handle accordingly
                            out.println("<div class='message' style='text-align: center;'><p>Opportunity already exists!</p></div>");
                        }

                        // Close database resources
                        rs.close();
                        checkStmt.close();
                    }

                    // Retrieve opportunities from database (default to latest 10)
                    String selectSql = "SELECT * FROM opportunities ORDER BY post_date DESC LIMIT 10";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(selectSql);

                    // Iterate through result set and display opportunities
                    while (rs.next()) {
            %>
                        <div class="opportunity">
                            <h2><%= rs.getString("title") %></h2>
                            <p><%= rs.getString("description") %></p>
                            <p>Posted by <%= rs.getString("alumni_name") %> on <%= rs.getString("post_date") %></p>
                            <p>Apply Link: <a href="<%= rs.getString("apply_link") %>" target="_blank"><%= rs.getString("apply_link") %></a></p>
                        </div>
            <%
                    }

                    // Close database resources
                    rs.close();
                    stmt.close();
                    conn.close();

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='message' style='text-align: center;'><p>An error occurred while processing your request.</p></div>");
                }
            %>
        </div>
    </div>

    <script>
        // JavaScript to toggle the display of the add form
        const addButton = document.getElementById("add-button");
        const addForm = document.getElementById("add-form");

        addButton.addEventListener("click", () => {
            addForm.style.display = "block";
        });
    </script>
</body>
</html>
