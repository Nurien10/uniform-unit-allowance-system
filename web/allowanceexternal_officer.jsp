<%-- 
    Document   : allowanceexternal_officer
    Created on : 11 Jun 2025, 4:19:13 am
    Author     : HP
--%>

<%@page import="model.External_officer"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.User" %>
<%@ page import="model.Attendance" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.AttendanceDAO" %>

<html>
<head>
    <title>Allowance Overview - External Officer</title>
    <style>
     body {
    background-color: #f5f5f5; /* Match members' grey-white background */
    font-family: 'Times New Roman', Times, serif;
}
#sidebar {
    background-color: #1A252F; /* Match members' sidebar color */
    color: white;
    width: 200px;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0; /* Ensure flush to the left */
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
    padding: 60px; /* Match members' padding */
}
h1 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #34495e; /* Match members' header color */
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
    background-color: #f0f0f5; /* Match members' input background */
}
table {
    width: calc(100% - 40px);
    max-width: 800px;
    border-collapse: collapse;
    margin: 0 auto;
    background-color: #ffffff; /* Match members' table background */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Match members' shadow */
}
table, th, td {
    border: 1px solid #ccc;
}
th, td {
    padding: 12px;
    text-align: center;
}
th {
    background-color: #A9A9A9; /* Match members' header color */
    color: white;
}
table tr:hover {
    background-color: #f0f0f5; /* Match members' hover effect */
}
.filter-button a, .pdf-button a {
    width: 48%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    font-family: 'Times New Roman', Times, serif;
    font-size: 14px;
    cursor: pointer;
    font-weight: bold;
    text-align: center;
    transition: background-color 0.3s;
}
.filter-button a {
    background-color: #27ae60; /* Green for filter button */
    color: white;
}
.filter-button a:hover {
    background-color: #219653; /* Darker green on hover */
}
.pdf-button a {
    background-color: #3498db; /* Blue for PDF button */
    color: white;
}
.pdf-button a:hover {
    background-color: #2980b9; /* Darker blue on hover */
}
footer {
    margin-top: 20px;
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    left: 220px;
    width: calc(100% - 220px);
    font-size: 14px;
    font-family: 'Times New Roman', Times, serif;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: transparent; /* Match members' transparent footer */
}
    </style>
</head>
<body>

<div id="sidebar">
    <h2>UMT Uniform Unit Allowance</h2>
    <img src="assets/images/logo_umt.png" alt="Logo UMT">
    <a href="dashboardexternal_officer.jsp">Dashboard</a>
    <a href="allowanceexternal_officer.jsp">Allowance</a>
    <a href="paymentexternal_officer.jsp">Payment</a>
    <a href="index.jsp">Logout</a>

</div>

<div id="content">
    <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
        <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
        <%= ((External_officer) request.getSession().getAttribute("officer")).getName() %></h5>

    <h1>Allowance Units Members (External Officer)</h1>

    <!-- Filter -->
    <div style="display: flex; justify-content: center; margin-bottom: 20px;">
        <form method="get" action="allowanceexternal_officer.jsp" style="display: flex; gap: 10px; align-items: center;">
            <select name="month" style="padding: 5px;">
                <option value="">All</option>
                <% String[] months = {"01","02","03","04","05","06","07","08","09","10","11","12"};
                   String[] monthNames = {"January","February","March","April","May","June","July","August","September","October","November","December"};
                   for (int i = 0; i < months.length; i++) {
                %>
                    <option value="<%= months[i] %>" <%= months[i].equals(request.getParameter("month")) ? "selected" : "" %>>
                        <%= monthNames[i] %>
                    </option>
                <% } %>
            </select>
            <input type="text" name="year" placeholder="Year" style="padding: 5px;" value="<%= request.getParameter("year") != null ? request.getParameter("year") : "" %>"/>
            <button type="submit" style="padding: 6px 12px;">Filter</button>
        </form>
    </div>

    <table>
        <tr>
            <th>No</th>
            <th>Name</th>
            <th>Total Program Hours</th>
            <th>Total Allowance (RM)</th>
            <th>Account Number (CIMB)</th>
            <!-- 🔴 REMOVED: Status and Action column -->
        </tr>
        <%
            AttendanceDAO dao = new AttendanceDAO();
            UserDAO userDAO = new UserDAO();

            String selectedMonth = request.getParameter("month");
            String selectedYear = request.getParameter("year");

            List<Attendance> allAttendance = dao.getAllAttendance();
            Map<String, Integer> studentHours = new HashMap<>();

            for (Attendance att : allAttendance) {
                String date = att.getDateTime();
                String month = date.substring(5, 7);
                String year = date.substring(0, 4);

                boolean match = true;
                if (selectedMonth != null && !selectedMonth.isEmpty()) {
                    match = month.equals(selectedMonth);
                }
                if (match && selectedYear != null && !selectedYear.isEmpty()) {
                    match = year.equals(selectedYear);
                }

                if (!match || !"Present".equalsIgnoreCase(att.getStatus())) continue;

                String name = att.getMemberName();
                int hours = att.getProgramHours();
                studentHours.put(name, studentHours.getOrDefault(name, 0) + hours);
            }

            int no = 1;
            for (Map.Entry<String, Integer> entry : studentHours.entrySet()) {
                String name = entry.getKey();
                int totalHours = entry.getValue();
                int totalAllowance = totalHours * 8;

                User user = userDAO.searchUsersByName(name).stream().findFirst().orElse(null);
                String bankAccount = (user != null && user.getBankAccount() != null) ? user.getBankAccount() : "-";
        %>
        <tr>
            <td><%= no++ %></td>
            <td><%= name %></td>
            <td><%= totalHours %></td>
            <td>RM <%= totalAllowance %></td>
            <td><%= bankAccount %></td>
            <!-- 🔴 REMOVED: <td>Status</td> and <td>Action</td> -->
        </tr>
        <% } %>
    </table>
</div>

<footer>
    © 2025 UMT Uniform Unit Allowance Management System
</footer>

</body>
</html>
