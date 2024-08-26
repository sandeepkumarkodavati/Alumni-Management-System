
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2a4a4;
        }
        section {
            margin: 20px;
            padding: 20px;
            background-color: #d9f69a;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }
        h1, h2 {
            color: #333;
        }
        form {
            margin-top: 10px;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 7px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        input[type="submit"] {
            background-color: #333333;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }
        .success-message {
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");
    String successMessage = "";

    if (name != null && email != null && message != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni", "root", "");

            // Get the current time
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String submissiontime = formatter.format(new Date());

            String sql = "INSERT INTO contacts (name, email, message, submissiontime) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, message);
            pstmt.setString(4, submissiontime);

            pstmt.executeUpdate();

            successMessage = "Thank you for your message! We'll get back to you soon.";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

<section>
    <h2>Contact Information</h2>
    <p>If you have any questions or feedback, please feel free to get in touch with us:</p>
    <ul>
        <li>Email: <a href="mailto:contact@example.com">contact@example.com</a></li>
        <li>Phone: +1 (123) 456-7890</li>
    </ul>
</section>

<section>
    <h2>Contact Form</h2>
    <form id="contactForm" action="contact.jsp" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="message">Message:</label><br>
        <textarea id="message" name="message" rows="4" required></textarea><br>

        <input type="submit" value="Submit">
    </form>
    <div class="success-message"><%= successMessage %></div>
</section>

<footer>
    <p>&copy; 2023 Your Company Name. All rights reserved.</p>
</footer>

</body>
</html>