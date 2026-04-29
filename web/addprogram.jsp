<%-- 
    Document   : addprogramunits_highcouncil
    Created on : 19 Jan 2025, 7:59:02 pm
    Author     : HP
--%>
<%@page import="model.UnitsHigh_council"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Program</title>
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
    left: 0; /* Pastikan penuh ke kiri tanpa gap */
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
#content {
    margin-left: 220px;
    padding: 60px; /* Tambah padding untuk jarak di sekeliling kandungan */
}
h1 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #34495e; /* Warna tajuk serasi dengan gambar */
}
form {
    max-width: 400px;
    margin: 0 auto;
    background: #ffffff; /* Putih seperti dalam gambar */
    padding: 40px;
    border-radius: 10px; /* Sudut bulat seperti gambar */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); /* Bayang lembut */
    margin-bottom: 20px; /* Tambah jarak di bawah form */
}
label {
    font-weight: bold;
    color: #34495e;
    margin-bottom: 5px;
}
input, textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    background-color: #f0f0f5; /* Latar input seperti gambar */
}
.button-group {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}
.button-group button {
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
    background-color: #27ae60; /* Hijau untuk Save */
    color: white;
}
.button-group button[type="submit"]:hover {
    background-color: #219653; /* Warna hover hijau */
}
.button-group button.view-button {
    background-color: #3498db; /* Biru untuk View */
    color: white;
    text-decoration: none;
}
.button-group button.view-button:hover {
    background-color: #2980b9; /* Warna hover biru */
}
.message {
    text-align: center;
    color: green;
}
.error {
    text-align: center;
    color: red;
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
      </style>
</head>
<body>
    <div id="sidebar">        
        <h2>UMT Uniform Unit Allowance Management System</h2>

        <img src="assets/images/logo_umt.png" alt="Logo UMT">
        <a href="dashboardunits_highcouncil.jsp"> Dashboard </a>
        <a href="ViewProgramController"> Program Schedule</a>
        <a href="attendanceunits_highcouncil.jsp">Attendance</a>
        <a href="allowance.jsp">Allowance</a>
        <a href="payment.jsp">Payment</a>
        <a href="index.jsp">Logout</a>

    </div>
    <div id="content">
        <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
            <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
            <%= ((UnitsHigh_council) request.getSession().getAttribute("highCouncil")).getName() %></h5>

        <h1>Add Program Schedule (Units High Council)</h1>

        <%-- Display success or error message --%>
        <%
            String message = request.getParameter("message");
            String error = request.getParameter("error");
            if (message != null) {
        %>
        <p class="message"><%= message %></p>
        <% 
            }
            if (error != null) {
        %>
        <p class="error"><%= error %></p>
        <% } %>

        <form action="AddProgramController" method="post">
            <label>Program Name:</label>
            <input type="text" name="programName" required>
            <label>Date & Time:</label>
            <input type="datetime-local" name="dateTime" required>
            <label>Program Hours:</label>
            <input type="text" name="programHours" required>
            <label>Venue:</label>
            <input type="text" name="venue" required>
            <label>Trainer:</label>
            <input type="text" name="trainer" required>
            
            <div class="button-group">
            <button type="submit">Save</button>
            </div>
        </form>
    </div>
         <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer> 
</body>
</html>
