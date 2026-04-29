<%-- 
    Document   : database
    Created on : 3 Jan 2025, 1:19:14 am
    Author     : HP
--%>

<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>All Users</title>
    <style>
        body {
            background-color: peachpuff;
            font-family: Arial, sans-serif;
        }
        #sidebar {
            background-color: olive;
            color: black;
            width: 200px;
            height: 100%;
            position: fixed;
            padding: 20px;
        }
        #sidebar a {
            color: black;
            text-decoration: none;
            display: block;
            margin: 10px 0;
        }
        #content {
            margin-left: 220px;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="images/logo_umt.png" alt="UMT Logo" width="100">
        <a href="index.jsp">Home</a>
    </div>
    <div id="content">
        <h1>All Users</h1>
        <form method="get" action="database.jsp">
            <input type="text" name="search" placeholder="Search by Name">
            <button type="submit">Search</button>
        </form>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Date of Birth</th>
                    <th>IC</th>
                    <th>Gender</th>
                    <th>Squad</th>
                    <th>Address</th>
                    <th>Bank Account</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String search = request.getParameter("search");
                    List<model.User> users = new dao.UserDAO().getAllUsers();
                    for (model.User user : users) {
                        if (search == null || user.getName().toLowerCase().contains(search.toLowerCase())) {
                %>
                <tr>
                    <td><%= user.getName() %></td>
                    <td><%= user.getPhoneNumber() %></td>
                    <td><%= user.getDateOfBirth() %></td>
                    <td><%= user.getIc() %></td>
                    <td><%= user.getGender() %></td>
                    <td><%= user.getSquad() %></td>
                    <td><%= user.getAddress() %></td>
                    <td><%= user.getBankAccount() %></td>
                    
                    <td>
                         <a href="delete?id=<%= user.getId() %>">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
        <a href="dashboard.jsp">Back</a>
    </div>
</body>
</html>

