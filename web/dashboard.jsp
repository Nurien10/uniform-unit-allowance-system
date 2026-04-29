<%-- 
    Document   : dashboard
    Created on : 15 Jan 2025, 8:02:15 pm
    Author     : HP
--%>

<%@page import="kor_suksis.model.User"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("units_members.jsp?error=Please login first");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            background-color: #fffbf0;
            font-family: 'Times New Roman', Times, serif;
        }
    </style>
</head>
<body>
    <h1>Welcome, <%= user.getName() %></h1>
    <p>Email: <%= user.getEmail() %></p>
    <p>Phone: <%= user.getPhoneNumber() %></p>
</body>
</html>

