
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 != null) {
        session1.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <script type="text/javascript">
        // Redirect the parent window to home.html
        window.top.location.href = "home.html";
    </script>
</head>
<body>
    <!-- If JavaScript is disabled, provide a link -->
    <noscript>
        <p>JavaScript is disabled. Click <a href="home.html">here</a> to go to the home page.</p>
    </noscript>
</body>
</html>
