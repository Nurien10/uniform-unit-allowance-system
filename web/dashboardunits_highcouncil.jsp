<%-- 
    Document   : dashboardunits_highcouncil
    Created on : 15 Jan 2025, 8:24:21 pm
    Author     : HP
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.UnitsHigh_council"%>

<%
    // Check if session exists and high council member is logged in
    if (session == null || session.getAttribute("highCouncil") == null) {
        response.sendRedirect("units_highcouncil.jsp");
        return;
    }

    // Retrieve high council member from session
    UnitsHigh_council highCouncil = (UnitsHigh_council) session.getAttribute("highCouncil");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Units High Council</title>
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
.button-group button {
    background-color: #3498db; /* Biru untuk semua butang */
    color: white;
}
.button-group button:hover {
    background-color: #2980b9; /* Warna hover biru */
}
    </style>
</head>
<body>
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">
        <a href="dashboardunits_highcouncil.jsp"> Dashboard </a>
        <a href="ViewProgramController">Program Schedule</a>
        <a href="attendanceunits_highcouncil.jsp">Attendance</a>
        <a href="allowanceunits_highcouncil.jsp">Allowance</a>
        <a href="paymentunits_highcouncil.jsp">Payment</a>
        <a href="index.jsp">Logout</a>


    </div>
    <div id="content">
        <h1>Welcome, <%= highCouncil.getName() %></h1>
        <form>
            <label><strong>Email:</strong></label>
            <input type="text" value="<%= highCouncil.getEmail() %>" readonly>
            
            <label><strong>Squad:</strong></label>
            <input type="text" value="<%= highCouncil.getSquad() %>" readonly>
            
            <label><strong>Position:</strong></label>
            <input type="text" value="<%= highCouncil.getPosition() %>" readonly>

            <div class="button-group">
                <button type="button" onclick="location.href='updateunits_highcouncil.jsp'">Update</button>
                <button type="button" onclick="location.href='databaseunits_members.jsp?ref=dashboardunits_highcouncil.jsp'">View Members</button>

            </div>
        </form>
    </div>
             <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  
</body>
</html>
