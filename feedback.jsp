
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Feedback</title>
    <style>
        #header {
            background-color: #F5DEB3;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            padding: 20px;
            display: flex;
            z-index: 100;
        }
        .question-table {
            background-color: #FFFFF0;
            margin-top: 100px;
            padding: 20px;
        }
        body {
            background-color: #FFFFF0;
        }
        table {
            margin-top: 10px;
            width: 100%;
        }
        td {
            padding: 10px;
        }
    </style>
</head>
<body>
    <header id="header">
        <marquee behavior="alternate">
            <h1 align="center">ALUMNI FEEDBACK ON CURRICULUM</h1>
        </marquee>
    </header>
    <div class="question-table">
        <form action="feedbackform.jsp" method="POST">
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
                <option value="2014">2014</option>
                <option value="2013">2013</option>
                <option value="2012">2012</option>
                <option value="2011">2011</option>
                <option value="2010">2010</option>
                <option value="2009">2009</option>
                <option value="2008">2008</option>
                <option value="2007">2007</option>
            </select>

            <table border="1">
                <tr>
                    <td>s.no</td>
                    <td align="center">parameter</td>
                    <td>response (YES/NO)</td>
                    <td>comments</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Do you support the proposed initiative to revise the curriculum?</td>
                    <td>
                        <input type="radio" id="yes1" name="response1" value="yes">
                        <label for="yes1">yes</label><br>
                        <input type="radio" id="no1" name="response1" value="no">
                        <label for="no1">no</label><br>
                    </td>
                    <td><textarea name="comments1"></textarea></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Are there any specific topics that you believe should be added to the curriculum? If yes, please specify</td>
                    <td>
                        <input type="radio" id="yes2" name="response2" value="yes">
                        <label for="yes2">yes</label><br>
                        <input type="radio" id="no2" name="response2" value="no">
                        <label for="no2">no</label><br>
                    </td>
                    <td><textarea name="comments2"></textarea></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Are there any specific topics that you believe should be removed from the curriculum? If yes, please specify</td>
                    <td>
                        <input type="radio" id="yes3" name="response3" value="yes">
                        <label for="yes3">yes</label><br>
                        <input type="radio" id="no3" name="response3" value="no">
                        <label for="no3">no</label><br>
                    </td>
                    <td><textarea name="comments3"></textarea></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Do you recommend introducing new courses? If yes, please provide details</td>
                    <td>
                        <input type="radio" id="yes4" name="response4" value="yes">
                        <label for="yes4">yes</label><br>
                        <input type="radio" id="no4" name="response4" value="no">
                        <label for="no4">no</label><br>
                    </td>
                    <td><textarea name="comments4"></textarea></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>Is it important to incorporate practical experiences or hands-on projects into the curriculum?</td>
                    <td>
                        <input type="radio" id="yes5" name="response5" value="yes">
                        <label for="yes5">yes</label><br>
                        <input type="radio" id="no5" name="response5" value="no">
                        <label for="no5">no</label><br>
                    </td>
                    <td><textarea name="comments5"></textarea></td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>Are there particular soft skills that you believe should be emphasized in the curriculum?</td>
                    <td>
                        <input type="radio" id="yes6" name="response6" value="yes">
                        <label for="yes6">yes</label><br>
                        <input type="radio" id="no6" name="response6" value="no">
                        <label for="no6">no</label><br>
                    </td>
                    <td><textarea name="comments6"></textarea></td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>Should the curriculum include courses that encourage interdisciplinary learning?</td>
                    <td>
                        <input type="radio" id="yes7" name="response7" value="yes">
                        <label for="yes7">yes</label><br>
                        <input type="radio" id="no7" name="response7" value="no">
                        <label for="no7">no</label><br>
                    </td>
                    <td><textarea name="comments7"></textarea></td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>Does the curriculum foster stronger industry-academia collaboration?</td>
                    <td>
                        <input type="radio" id="yes8" name="response8" value="yes">
                        <label for="yes8">yes</label><br>
                        <input type="radio" id="no8" name="response8" value="no">
                        <label for="no8">no</label><br>
                    </td>
                    <td><textarea name="comments8"></textarea></td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>Are there specific ways to infuse research and innovation opportunities into the curriculum?</td>
                    <td>
                        <input type="radio" id="yes9" name="response9" value="yes">
                        <label for="yes9">yes</label><br>
                        <input type="radio" id="no9" name="response9" value="no">
                        <label for="no9">no</label><br>
                    </td>
                    <td><textarea name="comments9"></textarea></td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>Any additional suggestions, ideas, or comments regarding the curriculum revision?</td>
                    <td>
                        <input type="radio" id="yes10" name="response10" value="yes">
                        <label for="yes10">yes</label><br>
                        <input type="radio" id="no10" name="response10" value="no">
                        <label for="no10">no</label><br>
                    </td>
                    <td><textarea name="comments10"></textarea></td>
                </tr>
            </table>
            <br>
            <input type="submit" value="Submit Feedback">
        </form>
    </div>

<% 
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String batch = request.getParameter("batch");
        String response1 = request.getParameter("response1");
        String comments1 = request.getParameter("comments1");
        String response2 = request.getParameter("response2");
        String comments2 = request.getParameter("comments2");
        String response3 = request.getParameter("response3");
        String comments3 = request.getParameter("comments3");
        String response4 = request.getParameter("response4");
        String comments4 = request.getParameter("comments4");
        String response5 = request.getParameter("response5");
        String comments5 = request.getParameter("comments5");
        String response6 = request.getParameter("response6");
        String comments6 = request.getParameter("comments6");
        String response7 = request.getParameter("response7");
        String comments7 = request.getParameter("comments7");
        String response8 = request.getParameter("response8");
        String comments8 = request.getParameter("comments8");
        String response9 = request.getParameter("response9");
        String comments9 = request.getParameter("comments9");
        String response10 = request.getParameter("response10");
        String comments10 = request.getParameter("comments10");

        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni", "root", "");

            String sql = "INSERT INTO feedback (batch, response1, comments1, response2, comments2, response3, comments3, response4, comments4, response5, comments5, response6, comments6, response7, comments7, response8, comments8, response9, comments9, response10, comments10) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, batch);
            stmt.setString(2, response1);
            stmt.setString(3, comments1);
            stmt.setString(4, response2);
            stmt.setString(5, comments2);
            stmt.setString(6, response3);
            stmt.setString(7, comments3);
            stmt.setString(8, response4);
            stmt.setString(9, comments4);
            stmt.setString(10, response5);
            stmt.setString(11, comments5);
            stmt.setString(12, response6);
            stmt.setString(13, comments6);
            stmt.setString(14, response7);
            stmt.setString(15, comments7);
            stmt.setString(16, response8);
            stmt.setString(17, comments8);
            stmt.setString(18, response9);
            stmt.setString(19, comments9);
            stmt.setString(20, response10);
            stmt.setString(21, comments10);
            
            stmt.executeUpdate();
            out.println("<p>Feedback submitted successfully!</p>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error occurred while submitting feedback. Please try again.</p>");


        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
</body>
</html>