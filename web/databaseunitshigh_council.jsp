<%-- 
    Document   : databaseunitshigh_council
    Created on : 16 Jan 2025, 11:31:49 pm
    Author     : HP
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.UnitsHigh_council"%>
<%@page import="dao.UnitsHighCouncilDAO"%>

<%
    // Ensure session is valid
    if (session == null || session.getAttribute("highCouncil") == null) {
        response.sendRedirect("units_highcouncil.jsp");
        return;
    }

    // Fetch data from the database using UnitsHighCouncilDAO
    UnitsHighCouncilDAO highCouncilDAO = new UnitsHighCouncilDAO();
    List<UnitsHigh_council> highCouncils = highCouncilDAO.getAllHighCouncilMembers();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Database Units High Council</title>
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
    text-align: center
    </style>
</head>
<body>
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">

        <a href="index.jsp">Home</a>
    </div>
    <div id="content">
        <h1>Registered List (Units High Council)</h1>
        <!-- Search Form -->
        <div class="search-form">
            <form action="databaseunits_highcouncil.jsp" method="get">
                <input type="text" name="searchQuery" placeholder="Search by name...">
                <button type="submit">Search</button>
            </form>
        </div>
        <!-- Data Table -->
        <table>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Email</th>
            </tr>
            <% 
                if (highCouncils != null && !highCouncils.isEmpty()) { 
                    for (UnitsHigh_council council : highCouncils) { %>
                        <tr>
                            <td><%= council.getName() %></td>
                            <td><%= council.getSquad() %></td>
                            <td><%= council.getPosition() %></td>
                            <td><%= council.getEmail() %></td>
                        </tr>
            <%      } 
                } else { %>
                <tr>
                    <td colspan="3" style="text-align: center;">No data found</td>
                </tr>
            <% } %>
        </table>
        <div class="button-group">
            <button onclick="location.href='dashboardunits_highcouncil.jsp'">Back</button>
        </div>
    </div>
        <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  
</body>
</html>
