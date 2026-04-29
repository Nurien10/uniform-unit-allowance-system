<%-- 
    Document   : databaseunits_members
    Created on : 3 Jan 2025, 12:37:52 pm
    Author     : HP
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>

<%
    // Pastikan session ada dan valid
    if (session == null || (session.getAttribute("highCouncil") == null && session.getAttribute("trainer") == null)) {
        response.sendRedirect("units_members.jsp");
        return;
    }
    // Semak parameter 'ref'
    String refPage = request.getParameter("ref");

    // Tetapkan default jika refPage kosong
    if (refPage == null || refPage.isEmpty()) {
        if (session.getAttribute("trainer") != null) {
            refPage = "dashboardunits_trainers.jsp";
        } else {
            refPage = "dashboardunits_highcouncil.jsp"; // Default lain
        }
    }
    // Ambil data dari database melalui UserDAO
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Database Units Members</title>
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
.search-form {
    text-align: center;
    margin-bottom: 20px;
}
.search-form input[type="text"] {
    width: 300px;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    background-color: #f0f0f5; /* Latar input seperti gambar */
}
.search-form button, .button-group button {
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
.search-form button {
    background-color: #27ae60; /* Hijau untuk Search */
    color: white;
}
.search-form button:hover {
    background-color: #219653; /* Warna hover hijau */
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
.button-group button:not([type="submit"]) {
    background-color: #3498db; /* Biru untuk Back */
    color: white;
}
.button-group button:not([type="submit"]):hover {
    background-color: #2980b9; /* Warna hover biru */
}
table {
    width: calc(100% - 40px);
    max-width: 800px;
    border-collapse: collapse;
    margin: 0 auto;
    background-color: #ffffff; /* Latar putih untuk jadual */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Bayang lembut */
}
table th, table td {
    border: 1px solid #ccc; /* Border lebih lembut */
    padding: 12px; /* Tambah padding untuk kelihatan lebih luas */
    text-align: center;
}
table th {
    background-color: #A9A9A9; /* Warna header kekal */
    color: white; /* Teks putih untuk kontras */
}
table tr:hover {
    background-color: #f0f0f5; /* Hover effect pada baris */
}
    </style>
</head>
<body>
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
                <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">

        <a href="dashboardunits_highcouncil.jsp"> Dashboard </a>
        <a href="program.jsp">Program Schedule</a>
        <a href="attendanceunits_highcouncil.jsp">Attendance</a>
        <a href="allowance.jsp">Allowance</a>
        <a href="payment.jsp">Payment</a>
        <a href="index.jsp">Logout</a>

    </div>
    <div id="content">
        <h1>Registered List (Units Members) </h1>
        <!-- Search Form -->
        <div class="search-form">
            <form action="databaseunits_members.jsp" method="get">
                <input type="text" name="searchQuery" placeholder="Search by name...">
                <button type="submit">Search</button>
            </form>
        </div>
        <!-- Data Table -->
        <table>
            <tr>
                <th>Name</th>
                <th>Date of Birth</th>
                <th>IC</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Gender</th>
                <th>Squad</th>
                <th>Bank Account</th>
            </tr>
            <% 
                if (users != null && !users.isEmpty()) { 
                    for (User user : users) { %>
                        <tr>
                            <td><%= user.getName() %></td>
                            <td><%= user.getDateOfBirth() %></td>
                            <td><%= user.getIc() %></td>
                            <td><%= user.getAddress() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getPhoneNumber() %></td>
                            <td><%= user.getGender() %></td>
                            <td><%= user.getSquad() %></td>
                            <td><%= user.getBankAccount() %></td>
                        </tr>
            <%      } 
                } else { %>
                <tr>
                    <td colspan="9" style="text-align: center;">No data found</td>
                </tr>
            <% } %>
        </table>
        <div class="button-group">
            <button onclick="location.href='<%= refPage %>'">Back</button>

        </div>
    </div>
            <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  
</body>
</html>
