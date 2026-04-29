<%-- 
    Document   : update
    Created on : 3 Jan 2025, 1:17:37 am
    Author     : HP
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Details</title>
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
        form {
            max-width: 400px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
        }
        label, input, select, textarea {
            display: block;
            width: 100%;
            margin-bottom: 10px;
        }
        button {
            display: block;
            width: 100%;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System System</h2>
        <img src="images/logo_umt.png" alt="UMT Logo" width="100">
        <a href="index.jsp">Home</a>
    </div>
    <div id="content">
        <h1>Update Your Details</h1>
        <form action="update" method="post">
            <input type="hidden" name="id" value="<%= session.getAttribute("userId") %>" required>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= session.getAttribute("userName") %>" required>

            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" value="<%= session.getAttribute("userPhone") %>" required>

            <label for="address">Address:</label>
            <textarea id="address" name="address" required><%= session.getAttribute("userAddress") %></textarea>

            <label for="bank">Bank Account:</label>
            <input type="text" id="bank" name="bank" value="<%= session.getAttribute("userBank") %>" required>

            <button type="submit">Save</button>
            <a href="dashboard.jsp">Back</a>
        </form>
    </div>
</body>
</html>

