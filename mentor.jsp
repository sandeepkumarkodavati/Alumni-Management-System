<%@ page import="java.sql.*" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Application Submitted</title>
</head>
<body>
<%
    String dbURL = "jdbc:mysql://localhost:3306/alumni_mentor_db";
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
    String meetingTopic = request.getParameter("meeting_topic");
    String meetingAgenda = request.getParameter("meeting_agenda");
    String meetingDuration = request.getParameter("meeting_duration");

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
            // Create Zoom Meeting
            String zoomAPIKey = "YOUR_ZOOM_API_KEY";
            String zoomAPISecret = "YOUR_ZOOM_API_SECRET";
            String zoomJWTToken = "YOUR_GENERATED_JWT_TOKEN"; // You should generate this token

            URL url = new URL("https://api.zoom.us/v2/users/me/meetings");
            HttpURLConnection connZoom = (HttpURLConnection) url.openConnection();
            connZoom.setRequestMethod("POST");
            connZoom.setRequestProperty("Authorization", "Bearer " + zoomJWTToken);
            connZoom.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            connZoom.setDoOutput(true);

            String zoomMeetingDetails = "{"
                + "\"topic\": \"" + meetingTopic + "\","
                + "\"type\": 2,"
                + "\"agenda\": \"" + meetingAgenda + "\","
                + "\"duration\": " + meetingDuration + ","
                + "\"settings\": {\"join_before_host\": true}"
                + "}";

            OutputStream os = connZoom.getOutputStream();
            os.write(zoomMeetingDetails.getBytes("UTF-8"));
            os.close();

            int responseCode = connZoom.getResponseCode();
            if (responseCode == 201) { // 201 Created
                BufferedReader in = new BufferedReader(new InputStreamReader(connZoom.getInputStream()));
                String inputLine;
                StringBuffer response1 = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                }
                in.close();

                // Parse the response to get meeting details (e.g., join URL)
                // Assuming the response contains a field "join_url" for the join URL
                String joinURL = "parsed_join_url_from_response"; // You need to parse the JSON response to get this value

%>
                <h1>Application Submitted Successfully!</h1>
                <p>Thank you, <strong><%= fullName %></strong>. Your application has been submitted.</p>
                <p>Zoom Meeting created successfully. Join URL: <a href="<%= joinURL %>"><%= joinURL %></a></p>
<%
            } else {
%>
                <h1>Application Submitted Successfully!</h1>
                <p>Thank you, <strong><%= fullName %></strong>. Your application has been submitted.</p>
                <p>Failed to create Zoom meeting. Response code: <%= responseCode %></p>
<%
            }
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