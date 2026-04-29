<%-- 
    Document   : paymentunits_trainer
    Created on : 30 Jun 2025, 6:23:53 pm
    Author     : HP
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page import="model.Units_trainers" %>
<%@ page import="model.User" %>
<%@ page import="model.Attendance" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.AttendanceDAO" %>
<%@ page import="dao.PaymentDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String trainerName = (String) request.getSession().getAttribute("name");
    if (trainerName == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<html>
<head>
    <title>Payment Units Members (Unit Trainer)</title>
    <style>
        /* (Gunakan CSS yang sama seperti awak bagi) */
        body {
            background-color: #f5f5f5;
            font-family: 'Times New Roman', Times, serif;
        }
        #sidebar {
            background-color: #1A252F;
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
            padding: 60px;
        }
        h1 {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #34495e;
        }
        table {
            width: calc(100% - 40px);
            max-width: 800px;
            border-collapse: collapse;
            margin: 0 auto;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #A9A9A9;
            color: white;
        }
        table tr:hover {
            background-color: #f0f0f5;
        }
        .filter-button a, .pdf-button {
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
            background-color: #27ae60;
            color: white;
        }
        .filter-button a:hover {
            background-color: #219653;
        }
        .pdf-button {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-family: 'Times New Roman', Times, serif;
            font-size: 14px;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            transition: background-color 0.3s;
        }
        .pdf-button:hover {
            background-color: #2980b9;
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
            background-color: transparent;
        }
    </style>
</head>
<body>
<div id="sidebar">
    <h2>UMT Uniform Unit Allowance</h2>
    <img src="assets/images/logo_umt.png" alt="Logo UMT">
    <a href="dashboardunits_trainers.jsp">Dashboard</a>
    <a href="addprogram.jsp">Program Schedule</a>
    <a href="attendanceunits_trainers.jsp">Attendance</a>
    <a href="allowanceunits_trainers.jsp">Allowance</a>
    <a href="paymentunits_trainers.jsp">Payment</a>
    <a href="index.jsp">Logout</a>
</div>

<div id="content">
    <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
        <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
        <%= trainerName %></h5>

    <h1>Payment Units Members (Units Trainers)</h1>

    <!-- Filter -->
    <div style="display: flex; justify-content: center; margin-bottom: 20px;">
        <form method="get" action="paymentunits_trainers.jsp" style="display: flex; gap: 10px; align-items: center;">
            <select name="month" style="padding: 5px;">
                <option value="">All</option>
                <%
                    String[] months = {"01","02","03","04","05","06","07","08","09","10","11","12"};
                    String[] monthNames = {"January","February","March","April","May","June","July","August","September","October","November","December"};
                    for (int i = 0; i < months.length; i++) {
                %>
                <option value="<%= months[i] %>" <%= months[i].equals(request.getParameter("month")) ? "selected" : "" %>><%= monthNames[i] %></option>
                <% } %>
            </select>
            <input type="text" name="year" placeholder="Year" style="padding: 5px;" value="<%= request.getParameter("year") != null ? request.getParameter("year") : "" %>"/>
            <button type="submit" style="padding: 6px 12px;">Filter</button>
        </form>
    </div>

<%
    String selectedMonth = request.getParameter("month");
    String selectedYear = request.getParameter("year");

    if (selectedMonth != null && !selectedMonth.isEmpty() && selectedYear != null && !selectedYear.isEmpty()) {
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        UserDAO userDAO = new UserDAO();
        PaymentDAO paymentDAO = new PaymentDAO();

        List<Attendance> allAttendance = attendanceDAO.getAllAttendance();
        Map<String, Integer> studentHours = new HashMap<>();

        for (Attendance att : allAttendance) {
            String date = att.getDateTime();
            String month = date.substring(5, 7);
            String year = date.substring(0, 4);

            if (month.equals(selectedMonth) && year.equals(selectedYear) && "Present".equalsIgnoreCase(att.getStatus())) {
                String name = att.getMemberName();
                int hours = att.getProgramHours();
                studentHours.put(name, studentHours.getOrDefault(name, 0) + hours);
            }
        }

        if (!studentHours.isEmpty()) {
%>

    <table>
        <tr>
            <th>No</th>
            <th>Name</th>
            <th>Total Program Hours</th>
            <th>Total Allowance (RM)</th>
            <th>Account Number (CIMB)</th>
            <th>Status</th>
        </tr>
        <%
            int no = 1;
            for (Map.Entry<String, Integer> entry : studentHours.entrySet()) {
                String name = entry.getKey();
                int totalHours = entry.getValue();
                int totalAllowance = totalHours * 8;

                User user = userDAO.searchUsersByName(name).stream().findFirst().orElse(null);
                String bankAccount = (user != null && user.getBankAccount() != null) ? user.getBankAccount() : "-";

                String paymentStatus = paymentDAO.getStatus(name, selectedMonth, selectedYear);
                if (paymentStatus == null || paymentStatus.isEmpty()) {
                    paymentStatus = "Pending";
                }
        %>
        <tr>
            <td><%= no++ %></td>
            <td><%= name %></td>
            <td><%= totalHours %></td>
            <td>RM <%= totalAllowance %></td>
            <td><%= bankAccount %></td>
            <td><%= paymentStatus %></td>
        </tr>
        <% } %>
    </table>

<%
        } else {
%>
    <p style="text-align:center;">No records found for selected month and year.</p>
<%
        }
    } else {
%>
    <p style="text-align:center;">Please select a month and year.</p>
<%
    }
%>

</div>

<footer>
    © 2025 UMT Uniform Unit Allowance Management System
</footer>

</body>
</html>
