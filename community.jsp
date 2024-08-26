
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create or View Communities</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #edc993;
            padding: 20px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .button-container button {
            padding: 10px 20px;
            margin: 0 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .button-container button:hover {
            background-color: #45a049;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            display: none; /* Initially hide the form */
        }
        .form-container.visible {
            display: block; /* Show the form when visible class is applied */
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"] {
            width: calc(100% - 10px);
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .form-group button:hover {
            background-color: #45a049;
        }
        .community-list {
            max-width: 600px;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .community-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .community-item h3 {
            margin: 0;
        }
        .community-item form button {
            background-color: #007BFF;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        .community-item form button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function toggleFormVisibility(formId) {
            var formContainer = document.getElementById(formId);
            formContainer.classList.toggle("visible");
        }
    </script>
</head>
<body>
    <h1>Communities</h1>

    <div class="button-container">
        <button onclick="toggleFormVisibility('joinForm')">Join a Community</button>
        <button onclick="toggleFormVisibility('createForm')">Create a Community</button>
    </div>

    <div id="joinForm" class="form-container">
        <h2>Join a Community</h2>
        <div class="community-list">
            <h2>Existing Communities</h2>
            <% 
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni", "root", "");
                    stmt = conn.createStatement();
                    String sql = "SELECT id, communityname, communitylink FROM community";
                    rs = stmt.executeQuery(sql);
                    while(rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("communityname");
                        String link = rs.getString("communitylink");
            %>
            <div class="community-item">
                <h3><%= name %></h3>
                <form action="joinCommunity.jsp" method="post">
                    <input type="hidden" name="communityId" value="<%= id %>">
                    <button type="submit">Join</button>
                </form>
            </div>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </div>
    </div>

    <div id="createForm" class="form-container">
        <h2>Create a Community</h2>
        <!-- Form for creating a new community -->
        <form action="community.jsp" method="post">
            <div class="form-group">
                <label for="communityName">Community Name:</label>
                <input type="text" id="communityName" name="communityName" required>
            </div>
            <div class="form-group">
                <label for="communityLink">Link for Community:</label>
                <input type="text" id="communityLink" name="communityLink" required>
            </div>
            <div class="form-group">
                <button type="submit">Create Community</button>
            </div>
        </form>
    </div>

    <% 
        String communityName = request.getParameter("communityName");
        String communityLink = request.getParameter("communityLink");
        if (communityName != null && communityLink != null) {
            Connection con1 = null;
            PreparedStatement pstmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni", "root", "");
                String sql = "INSERT INTO community (communityname, communitylink) VALUES (?, ?)";
                pstmt = con1.prepareStatement(sql);
                pstmt.setString(1, communityName);
                pstmt.setString(2, communityLink);
                pstmt.executeUpdate();
    %>
        <h2>Community created successfully!</h2>
        <a href="community.jsp">Go back</a>
    <%
            } catch (Exception e) {
                e.printStackTrace();
    %>
        <h2>Error creating community!</h2>
        <a href="community.jsp">Go back</a>
    <%
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (con1 != null) try { con1.close(); } catch (SQLException e) {}
            }
        }
    %>
</body>
</html>
