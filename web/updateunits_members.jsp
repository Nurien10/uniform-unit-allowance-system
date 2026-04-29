<%-- 
    Document   : updateunits_members
    Created on : 3 Jan 2025, 12:37:17 pm
    Author     : HP
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.User"%>

<%
    // Pastikan session sudah ada
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("units_members.jsp");
        return;
    }

    // Ambil user dari session
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Units Members</title>
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
            const bankInput = document.getElementById("bankAccount");

            const phoneError = document.getElementById("phone-error");
            const icError = document.getElementById("ic-error");
            const bankError = document.getElementById("bank-error");

            const phonePattern = /^\d{3}-\d{7,8}$/;
            const icPattern = /^\d{6}-\d{2}-\d{4}$/;
            const bankPattern = /^\d{10}$/;

            // Reset error messages
            phoneError.textContent = "";
            icError.textContent = "";
            bankError.textContent = "";

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

            // Validate Bank Account
            if (!bankPattern.test(bankInput.value)) {
                bankError.textContent = "Bank account must be exactly 10 digits.";
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
        <a href="dashboardunits_members.jsp"> Dashboard </a>
        <a href="ViewProgramController">Program Schedule</a>
        <a href="attendanceunits_members.jsp">Attendance</a>
        <a href="allowance.jsp">Allowance</a>
        <a href="paymentunits_members.jsp">Payment</a>
        <a href="index.jsp">Logout</a>

        
    </div>
            <div id="content">
                
    <h1>Update Information (Units Members)</h1>
    <form action="updateController" method="post" onsubmit="return validateForm()">
        <label>Name:</label>
        <input type="text" name="name" value="<%= user.getName() %>" required>

        <label>Date of Birth:</label>
        <input type="text" id="dateOfBirth" name="dateOfBirth" value="<%= user.getDateOfBirth() %>" required>

        <label>IC:</label>
        <input type="text" id="ic" name="ic" value="<%= user.getIc() %>" required>
        <div id="ic-error" class="error-message"></div>

        <label>Address:</label>
        <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required>

        <label>Email:</label>
        <input type="text" name="email" value="<%= user.getEmail() %>" required readonly>

        <label>Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" value="<%= user.getPhoneNumber() %>" required>
        <div id="phone-error" class="error-message"></div>

        <label>Gender:</label>
        <select name="gender" required>
           <option value="Male" <%= user.getGender() != null && user.getGender().equals("Male") ? "selected" : "" %>>Male</option>
            <option value="Female" <%= user.getGender() != null && user.getGender().equals("Female") ? "selected" : "" %>>Female</option>

        </select>

        <label>Squad:</label>
        <select name="squad" required>
            <option value="SQ16" <%= user.getSquad().equals("SQ16") ? "selected" : "" %>>SQ16</option>
            <option value="SQ17" <%= user.getSquad().equals("SQ17") ? "selected" : "" %>>SQ17</option>
            <option value="SQ18" <%= user.getSquad().equals("SQ18") ? "selected" : "" %>>SQ18</option>
        </select>

        <label>Bank Account:</label>
        <input type="text" id="bankAccount" name="bankAccount" value="<%= user.getBankAccount() %>" required>
        <div id="bank-error" class="error-message"></div>

        <div class="button-group">
            <button type="submit">Save</button>
            <button type="button" onclick="location.href='dashboardunits_members.jsp'">Back</button>
        </div>
    </form>
            </div>
        <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  

        
</body>
</html>
