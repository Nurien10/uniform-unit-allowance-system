<%-- 
    Document   : updateexternal_officer
    Created on : 15 Jan 2025, 8:06:21 pm
    Author     : HP
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.External_officer"%>

<%
    // Ensure session exists and officer is logged in
    if (session == null || session.getAttribute("officer") == null) {
        response.sendRedirect("external_officer.jsp");
        return;
    }

    // Retrieve officer from session
    External_officer officer = (External_officer) session.getAttribute("officer");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update External Officer</title>
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
input, textarea, select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    background-color: #f0f0f5; /* Latar input seperti gambar */
}
select {
    height: 40px;
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
.button-group button:not([type="submit"]) {
    background-color: #3498db; /* Biru untuk Back */
    color: white;
}
.button-group button:not([type="submit"]):hover {
    background-color: #2980b9; /* Warna hover biru */
}
    </style>
    <script>
        function validateForm() {
            let isValid = true;

            const phoneInput = document.getElementById("phoneNumber");
            const icInput = document.getElementById("ic");

            const phoneError = document.getElementById("phone-error");
            const icError = document.getElementById("ic-error");

            const phonePattern = /^\\d{3}-\\d{7,8}$/;
            const icPattern = /^\\d{6}-\\d{2}-\\d{4}$/;

            // Reset error messages
            phoneError.textContent = "";
            icError.textContent = "";

            // Validate Phone Number
            if (!phonePattern.test(phoneInput.value)) {
                phoneError.textContent = "Phone number must follow the format XXX-XXXXXXX.";
                isValid = false;
            }

            // Validate IC
            if (!icPattern.test(icInput.value)) {
                icError.textContent = "IC must follow the format XXXXXX-XX-XXXX.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>
    
    
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">
        <a href="dashboardexternal_officer.jsp"> Dashboard </a>
        <a href="allowanceexternal_officer.jsp">Allowance</a>
        <a href="paymentexternal_officer.jsp">Payment</a>
        <a href="index.jsp">Logout</a>

        
    </div>
        <div id="content">

    <h1>Update Information (External Officer)</h1>
     <form action="updateController" method="post">
        <label>Full Name:</label>
        <input type="text" name="name" value="<%= officer.getName() %>" required>

        <label>Date of Birth:</label>
        <input type="text" name="dateOfBirth" value="<%= officer.getDateOfBirth() %>" required>

        <label>IC:</label>
        <input type="text" name="ic" value="<%= officer.getIc() %>" required>

        <label>Address:</label>
        <input type="text" id="address" name="address" value="<%= officer.getAddress() %>" required>


        <label>Email:</label>
        <input type="email" name="email" value="<%= officer.getEmail() %>" required readonly>

        <label>Phone Number:</label>
        <input type="text" name="phoneNumber" value="<%= officer.getPhoneNumber() %>" required>

        <label>Gender:</label>
        <select name="gender" required>
            <option value="Male" <%= officer.getGender().equals("Male") ? "selected" : "" %>>Male</option>
            <option value="Female" <%= officer.getGender().equals("Female") ? "selected" : "" %>>Female</option>
        </select>

        <div class="button-group">
            <button type="submit">Save</button>
            <button type="button" onclick="location.href='dashboardexternal_officer.jsp'">Back</button>
        </div>
    </form>
    </div>
         <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  

</body>
</html>