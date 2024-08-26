
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Form</title>
    
 <style>
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
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #E6E6FA;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .column {
            flex: 1;
            padding: 10px;
        }

        .column:nth-child(odd) {
            margin-right: 10px; /* Add margin between columns */
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"],
        select {
            width: 100%;
            padding: 7px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            margin-top: 20px;
            <% if (request.getMethod().equalsIgnoreCase("post")) { %> display: none; <% } %>
        }

        .message p {
            font-size: 14px;
        }

        .message a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }

        .message a:hover {
            text-decoration: underline;
        }

        .success-message {
            text-align: center;
            margin-top: 20px;
            display: none;
        }

        .success-message p {
            font-size: 14px;
            color: green;
        }
    </style>
</head>
<body>
    <h2>Registration</h2>
    <form id="registration-form" type="register" action="register.jsp" method="post">
        <div class="column">
            <label for="firstname">First Name:</label>
            <input type="text" id="firstname" name="firstname" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" required>
        </div>
        <div class="column">
            <label for="lastname">Last Name:</label>
            <input type="text" id="lastname" name="lastname" required>
            
            <label for="username">User Name:</label>
            <input type="text" id="username" name="username" required>

            <label for="phonenumber">Phone Number:</label>
            <input type="text" id="phonenumber" name="phonenumber" required>

            <label for="confirmpassword">Confirm Password:</label>
            <input type="password" id="confirmpassword" name="confirmpassword" required>

            <label for="batch">Batch:</label>
            <select id="batch" name="batch" required>
                <option value="">Select Year</option>
                <option value="2023">2023</option>
                <option value="2022">2022</option>
                <option value="2021">2021</option>
                <option value="2020">2020</option>
                <option value="2019">2019</option>
                <option value="2018">2018</option>
                <option value="2017">2017</option>
                <option value="2016">2016</option>
                <option value="2015">2015</option>
            </select>
        </div>
        <div class="column">
            <label for="profile">Profile</label>
            <input type="file" id="profile" name="profile" accept="image/*">
        </div>
        <br>
        <input type="submit" value="Register">
    </form>

    <!-- Success message -->
    <div class="success-message">
        <p>Registration successful! You can now <a href="login.jsp">login here</a>.</p>
    </div>

    <!-- Footer with login link -->
    <div class="footer">
        <p class="message">If already registered, <a href="login.jsp">click here</a> to login.</p>
    </div>

    <% 
        if(request.getMethod().equalsIgnoreCase("post")) {
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String dob = request.getParameter("dob");
            String phonenumber = request.getParameter("phonenumber");
            String batch = request.getParameter("batch");
            String username = request.getParameter("username"); // Retrieve username from form

            // Database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/alumni";
            String dbUser = "root";
            String dbPassword = "";

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a database connection
                Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Insert registration data into database
                String insertSql = "INSERT INTO registrations (firstname, lastname, email, password, dob, phonenumber, batch, username) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, firstname);
                insertStmt.setString(2, lastname);
                insertStmt.setString(3, email);
                insertStmt.setString(4, password);
                insertStmt.setString(5, dob);
                insertStmt.setString(6, phonenumber);
                insertStmt.setString(7, batch);
                insertStmt.setString(8, username); // Set username parameter
                insertStmt.executeUpdate();

                // Close database resources
                insertStmt.close();
                conn.close();

                // Display success message after registration
                out.println("<script>document.querySelector('.success-message').style.display = 'block';</script>");

            } catch (Exception e) {
                e.printStackTrace();
                // Display error message on error
                out.println("<div class='message' style='text-align: center;'><p>An error occurred while processing your registration. Please try again later.</p></div>");
            }
        }
    %>
</body>
</html>
