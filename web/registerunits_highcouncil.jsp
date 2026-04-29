<%-- 
    Document   : register_highcouncil
    Created on : 15 Jan 2025, 3:44:17 pm
    Author     : HP
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
    body {
        background-color: #f5f5f5; /* Kelabu putih */
        font-family: 'Times New Roman', Times, serif;
    }

    #sidebar {
        background-color: #1A252F; /* Warna sidebar asal */
        color: white;
        width: 200px;
        height: 100%;
        position: fixed;
        top: 0;
        left: 0;
        padding: 20px;
        text-align: center;
    }

    #sidebar img {
        display: block;
        margin: 20px auto;
        width: 150px;
        height: auto;
        border: none;
    }

    #sidebar a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        display: block;
        margin: 20px 0;
        font-family: 'Times New Roman', Times, serif;
    }

    footer {
    margin-top: 20px;
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    left: 220px; /* Bermula selepas sidebar */
    width: calc(100% - 220px); /* Lebar penuh tolak sidebar */
    font-size: 14px;
    font-family: 'Times New Roman', Times, serif;
    display: flex;
    justify-content: center; /* Horizontal center */
    align-items: center; /* Vertical center */
    background-color: transparent; /* Background transparent */
}

    #content {
        margin-left: 220px;
        padding: 60px;
    }

    h1 {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #34495e;
    }

    form {
        max-width: 400px;
        margin: 0 auto;
        background: #ffffff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
        color: #34495e;
        margin-bottom: 5px;
    }

    input, select, textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
        background-color: #f0f0f5;
    }

    select {
        height: 40px;
    }

    .message {
        text-align: center;
        color: green;
    }

    .error {
        text-align: center;
        color: red;
    }

    .error-message {
        color: red;
        font-size: 0.9em;
        margin-top: -8px;
        margin-bottom: 10px;
    }

    .button-group {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 20px;
    }

    .button-group button, .button-group .back-button {
        width: 120px;
        padding: 10px;
        border: none;
        border-radius: 5px;
        font-family: 'Times New Roman', Times, serif;
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .button-group button[type="submit"] {
        background-color: #27ae60;
        color: white;
    }

    .button-group button[type="submit"]:hover {
        background-color: #219653;
    }

    .button-group .back-button {
        background-color: #3498db;
        color: white;
        text-decoration: none;
    }

    .button-group .back-button:hover {
        background-color: #2980b9;
    }
</style>

</head>
<body>
    <!-- Sidebar Section -->
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">
        <a href="index.jsp">Home</a>
    </div>

    <!-- Main Content Section -->
    <div id="content">
        <h1>Register (Units High Council)</h1>

        <!-- Display success or error message -->
        <% if (message != null) { %>
        <p style="color: green; text-align: center;"><%= message %></p>
        <% } %>
        <% if (error != null) { %>
        <p style="color: red; text-align: center;"><%= error %></p>
        <% } %>

        <!-- Registration Form -->
        <form action="register" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="role" value="HighCouncil">

            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>

            
            <label for="squad">Squad:</label>
            <select id="squad" name="squad" required>
                <option value="SQ16">SQ16</option>
                <option value="SQ17">SQ17</option>
                <option value="SQ18">SQ18</option>
            </select>
            
            
            <label for="position">Position:</label>
            <select id="position" name="position" required>
                <option value="President">President</option>
                <option value="Secretary">Secretary</option>
                <option value="Treasurer">Treasurer</option>
            </select>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <div class="button-group">

        
                <button type="submit" class="register-button">Register</button>

        <a href="units_highcouncil.jsp" class="back-button">Back</a>
    </div>
        </form>
        
        <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  
</body>
</html>
