<%-- 
    Document   : addattendanceunits_members
    Created on : 20 Apr 2025, 8:51:26 pm
    Author     : HP
--%>


<%@page import="model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // DITAMBAH: Ambil parameter URL berdasarkan nama field yang digunakan
    String programName = request.getParameter("programName");
    String dateTime = request.getParameter("dateTime");
    String programHours = request.getParameter("programHours");
%>
<html>
<head>
    <title>Add Attendance</title>
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
    max-width: 600px;
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

.status-group {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
}

.status-group label {
    font-weight: normal;
}

.message {
    text-align: center;
    color: green;
    font-weight: bold;
}

.error {
    text-align: center;
    color: red;
    font-weight: bold;
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
    background-color: #27ae60; /* Hijau untuk Submit */
    color: white;
}

.button-group button[type="submit"]:hover {
    background-color: #219653;
}

.button-group .back-button {
    background-color: #3498db; /* Biru untuk Back */
    color: white;
    text-decoration: none;
}

.button-group .back-button:hover {
    background-color: #2980b9;
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

    <script>
        function validateForm() {
            var status = document.querySelector('input[name="status"]:checked');
            var reasonProof = document.getElementById("reasonProof").value;

            if (!status) {
                alert("Please select a status (Present or Absent).");
                return false;
            }

            if (status.value === "Absent" && reasonProof === "") {
                alert("You must upload proof if you are absent!");
                return false;
            }
            return true;
        }

        window.onload = function() {
            var absentRadio = document.querySelector('input[name="status"][value="Absent"]');
            if (absentRadio) {
                absentRadio.addEventListener('click', function() {
                    alert("Please upload proof if you are absent!");
                });
                
        }
            // <!-- Added: Set submission date and time to current time -->
            var submissionDateTime = document.getElementById("submissionDateTime");
            if (submissionDateTime) {
                var now = new Date();
                var offset = now.getTimezoneOffset() * 60000; // Offset in milliseconds
                var localISOTime = new Date(now - offset).toISOString().slice(0, 16);
                submissionDateTime.value = localISOTime;
            }
        };
    </script>
</head>
<body>

<div id="sidebar">
     <h2>UMT Uniform Unit Allowance Management System</h2>
    <img src="assets/images/logo_umt.png" alt="Logo UMT">
        <a href="dashboardunits_members.jsp"> Dashboard </a>
        <a href="ViewProgramController.jsp"> Program Schedule</a>
        <a href="attendanceunits_members.jsp">Attendance</a>
        <a href="allowanceunit_members.jsp">Allowance</a>
        <a href="paymentunits_members.jsp">Payment</a>
        <a href="index.jsp">Logout</a>

</div>
    

<div id="content">
    <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
        <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
        <%= ((User) request.getSession().getAttribute("user")).getName() %></h5>
    <h1>Add Attendance (Units Members)</h1>

    <% 
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) { %>
            <div class="message"><%= message %></div>
    <% } else if (error != null) { %>
            <div class="error"><%= error %></div>
    <% } %>

    <form action="AddAttendanceController" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
        
        <label for="programName">Program Name:</label>
        <!-- DIUBAH: Autofill guna parameter programName -->
        <input type="text" id="programName" name="programName" value="<%= programName != null ? programName : "" %>" readonly required>

        <label for="dateTime">Date & Time:</label>
<%
    String displayDateTime = "N/A";
    if (dateTime != null && !dateTime.isEmpty()) {
        try {
            java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date parsedDate = inputFormat.parse(dateTime);
            java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm a");
            displayDateTime = outputFormat.format(parsedDate);
        } catch (Exception e) {
            displayDateTime = "Invalid Date";
        }
    }
%>
<input type="text" id="dateTimeDisplay" name="dateTimeDisplay" value="<%= displayDateTime %>" readonly>

<!-- Masih hantar format asal ke backend -->
<input type="hidden" id="dateTime" name="dateTime" value="<%= dateTime != null ? dateTime : "" %>">

        
        <label for="submissionDateTime">Submission Date & Time:</label>
        <input type="datetime-local" id="submissionDateTime" name="submissionDateTime" readonly>
        
        <label for="programHours">Program Hours:</label>
        <!-- DIUBAH: Autofill guna parameter programHours -->
        <input type="number" id="programHours" name="programHours" value="<%= programHours != null ? programHours : "" %>" readonly required>

        <label>Status:</label>
        <div class="status-group">
            <label><input type="radio" name="status" value="Present"> Present</label>
            <label><input type="radio" name="status" value="Absent"> Absent</label>
        </div>

        <label for="reasonProof">Reason Proof (PDF/Image) [if absent]:</label>
        <input type="file" id="reasonProof" name="reasonProof" accept=".pdf, .jpg, .jpeg, .png">

        <div class="button-group">
            <button type="submit">Submit</button>
            <button type="button" onclick="location.href='attendanceunits_members.jsp'">Back</button>
        </div>
    </form>
</div>

<footer>
            © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
</footer>

</body>
</html>
