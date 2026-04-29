<%-- 
    Document   : attendanceunits_members
    Created on : 20 Apr 2025, 8:48:14 pm
    Author     : HP
--%>
<%@page import="model.User"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Attendance" %>
<%@ page import="dao.AttendanceDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Attendance History</title>
    <style>
    /* CSS */
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
.add-button {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}
.add-button a {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    font-size: 16px;
    border-radius: 5px;
    font-family: 'Times New Roman', Times, serif;
}
.add-button a:hover {
    background-color: #45a049;
}

.delete-button {
    background-color: #e74c3c; /* Merah terang */
    color: white;
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    font-family: 'Times New Roman', Times, serif;
    cursor: pointer;
    text-decoration: none;
}

.delete-button:hover {
    background-color: #c0392b; /* Merah gelap bila hover */
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
</head>
<body>

<div id="sidebar">
    <h2>UMT Uniform Unit Allowance Management System</h2>
    <img src="assets/images/logo_umt.png" alt="Logo UMT">
    <a href="dashboardunits_members.jsp">Dashboard</a>
    <a href="ViewProgramController.jsp">Program Schedule</a>
    <a href="attendanceunits_members.jsp">Attendance</a>
    <a href="allowanceunits_members.jsp">Allowance</a>
    <a href="paymentunits_members.jsp">Payment</a>
    <a href="index.jsp">Logout</a>

</div>

<div id="content">
    <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
        <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
        <%= ((User) request.getSession().getAttribute("user")).getName() %></h5>
    
    <h1>Attendance History (Units Members)</h1>

    <!-- Button Add Attendance kat tengah -->
    <div class="add-button">
        <a href="calendar.jsp">Add Attendance</a>
    </div>
    
    <!-- ➕ TAMBAHAN: Filter Bulan & Tahun -->
    <div style="display: flex; justify-content: center; margin-bottom: 20px;">
        <form method="get" action="attendanceunits_members.jsp" style="display: flex; gap: 10px; align-items: center;">
            <select name="month" style="padding: 5px;">
                <option value="">All</option>
                <option value="01">January</option>
                <option value="02">February</option>
                <option value="03">March</option>
                <option value="04">April</option>
                <option value="05">May</option>
                <option value="06">June</option>
                <option value="07">July</option>
                <option value="08">August</option>
                <option value="09">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
            </select>
            
            <input type="text" name="year" placeholder="Year" style="padding: 5px;" /> <!-- ✅ Manual input untuk tahun -->
            
            <button type="submit" style="padding: 6px 12px; background-color: #4CAF50; color: white; border: none; border-radius: 4px;">
                Filter
            </button>
        </form>
    </div>

    
    
    <% 
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) { %>
            <div class="message"><%= message %></div>
    <% } else if (error != null) { %>
            <div class="error"><%= error %></div>
    <% } %>

    <table>
        <tr>
            <th>Program Name</th>
            <th>Date & Time</th>
            <th>Submission Date & Time</th> <!-- Added: New header for submissionDateTime -->
            <th>Program Hours</th>
            <th>Status</th>
            <th>Reason Proof</th>
            <th>Proof Status</th> 
            <th>Action</th>
        </tr>

        <%
            User user = (User) request.getSession().getAttribute("user");
            String memberName = user.getName();
            AttendanceDAO dao = new AttendanceDAO();
            String selectedMonth = request.getParameter("month"); // ✅ Tambahan: Ambil nilai bulan dari form
            String selectedYear = request.getParameter("year");   // ✅ Tahun dari form

            List<Attendance> attendances = dao.getAllAttendanceByMembername(memberName);
            boolean found = false;
            
            int totalProgramHours = 0;
            
            for (Attendance att : attendances) {
            String rawDateTime = att.getDateTime();
            String rawSubmissionDateTime = att.getSubmissionDateTime(); // Added: Get submissionDateTime
                boolean match = true;

                if (selectedMonth != null && !selectedMonth.isEmpty()) {
                    match = rawDateTime.substring(5, 7).equals(selectedMonth); // 🆕 tapis ikut bulan
                }

                if (match && selectedYear != null && !selectedYear.isEmpty()) {
                    match = rawDateTime.substring(0, 4).equals(selectedYear); // 🆕 tapis ikut tahun
                }

                if (!match) continue;

                found = true;
                
                if ("Present".equalsIgnoreCase(att.getStatus())) {
                    totalProgramHours += att.getProgramHours();
                }
        %>
        <tr>
            <td><%= att.getProgramName() %></td>
           <td>
    <%
        String formattedDateTime = rawDateTime; // default fallback

        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date date = inputFormat.parse(rawDateTime);
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm a"); // format baru
            formattedDateTime = outputFormat.format(date);
        } catch (Exception e) {
            // fallback to rawDateTime jika error
        }
    %>
    <%= formattedDateTime %> <%-- ✅ Papar tarikh yang dah diformat --%>
</td>

    <td>
                <%
                    String formattedSubmissionDateTime = rawSubmissionDateTime; // default fallback

                    try {
                        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                        Date date = inputFormat.parse(rawSubmissionDateTime);
                        SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm a"); // format sama seperti dateTime
                        formattedSubmissionDateTime = outputFormat.format(date);
                    } catch (Exception e) {
                        // fallback to rawSubmissionDateTime jika error
                    }
                %>
                <%= formattedSubmissionDateTime %> <%-- Added: Papar submissionDateTime yang diformat --%>
            </td>

            <td><%= att.getProgramHours() %></td>
            <td><%= att.getStatus() %></td>
            <td>
                <% 
                    String proof = att.getReasonProof();
                    if (proof != null && !proof.trim().isEmpty() && !"No Proof".equalsIgnoreCase(proof)) {
                %>
                    <a href="uploads/<%= proof %>" target="_blank">View Proof</a>
                <% } else { %>
                    -
                <% } %>
            </td>
            
            <td>
                <% 
                    String attendanceStatus = att.getStatus();  // ini status kehadiran: Present/Absent
                    String proofStatus = att.getProofStatus();  // ini proof status: Approved/Not Approved/null

                    if ("Present".equalsIgnoreCase(attendanceStatus)) {
                        out.print("-");
                    } else if ("Absent".equalsIgnoreCase(attendanceStatus)) {
                        if (proofStatus == null || proofStatus.trim().isEmpty()) {
                            out.print("Pending");
                        } else {
                            out.print(proofStatus); // can be Approved or Not Approved
                        }
                    }
                %>
            </td>
          
            <td>
                <button class="delete-button" onclick="confirmDelete(<%= att.getAttendanceId() %>)">Delete</button> <!-- Delete Button -->
            </td>
        </tr>
        <% } %>
    </table>
    
     <% if (!found) { %> <!-- 🆕 Jika tiada data -->
        <div class="error">No attendance data found for selected month and year.</div>
    <% } %>
    
    <% if (selectedMonth != null && !selectedMonth.isEmpty()) { %>
        <div style="margin-top: 20px; font-weight: bold; font-size: 18px; text-align: center;">
            Total Program Hours: <%= totalProgramHours %>
        </div>
    <% } %>
    
</div>

<footer>
            © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.

</footer>

<script>
    function confirmDelete(attendanceId) {
        if (confirm('Are you sure want to delete this attendance?')) {
            window.location.href = 'DeleteAttendanceController?id=' + attendanceId;
        }
    }
</script>

</body>
</html>
