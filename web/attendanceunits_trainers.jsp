<%-- 
    Document   : attendanceunits_trainers
    Created on : 22 Apr 2025, 1:50:54 am
    Author     : HP
--%>
<%@page import="model.Units_trainers"%>

<%@ page import="java.util.List" %>
<%@ page import="model.Attendance" %>
<%@ page import="dao.AttendanceDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Attendance History (Trainer View)</title>
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
    left: 0;
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
.radio-container {
    display: inline-block;
    margin-right: 20px;
}
.selected {
    background-color: #3e8e41;
    color: white;
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
        <script>
            function submitForm(attendanceId, proofStatus) {
                // Buat borang dinamik dan hantar
                var form = document.createElement("form");
                form.action = ""; // Set borang untuk hantar ke halaman yang sama
                form.method = "post"; // Gunakan POST method

                var inputAttendanceId = document.createElement("input");
                inputAttendanceId.type = "hidden";
                inputAttendanceId.name = "attendanceId";
                inputAttendanceId.value = attendanceId;

                var inputProofStatus = document.createElement("input");
                inputProofStatus.type = "hidden";
                inputProofStatus.name = "proofStatus";
                inputProofStatus.value = proofStatus;

                form.appendChild(inputAttendanceId);
                form.appendChild(inputProofStatus);

                document.body.appendChild(form);
                form.submit(); // Hantar borang
            }

        </script>
    </head>
    <body>
        <%
            String attendanceIdParam = request.getParameter("attendanceId");
            String proofStatusParam = request.getParameter("proofStatus");
            if (attendanceIdParam != null && proofStatusParam != null) {
                int attendanceId = Integer.parseInt(attendanceIdParam);
                AttendanceDAO daoUpdate = new AttendanceDAO();
                daoUpdate.updateProofStatus(attendanceId, proofStatusParam);
            }
        %>

        <div id="sidebar">
            <h2>UMT Uniform Unit Allowance Management System</h2>
            <img src="assets/images/logo_umt.png" alt="Logo UMT">
            <a href="dashboardunits_trainers.jsp">Dashboard</a>
            <a href="ViewProgramController">Program Schedule</a>
            <a href="attendanceunits_trainers.jsp">Attendance</a>
            <a href="allowanceunits_trainers.jsp">Allowance</a>
            <a href="paymentunits_trainers.jsp"> Payment</a>
            <a href="index.jsp">Logout</a>

 
        </div>

        <div id="content">
            <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
                <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
                <%= ((Units_trainers) request.getSession().getAttribute("trainer")).getName() %></h5>

            <h1>Attendance Units Members (Units Trainers)</h1>

            <%
                String message = request.getParameter("message");
                String error = request.getParameter("error");
                if (message != null) {%>
            <div class="message"><%= message%></div>
            <% } else if (error != null) {%>
            <div class="error"><%= error%></div>
            <% } %>

            <table>
                <tr>
                    <th>No.</th> <!-- New Column for No. -->
                    <th>Member Name</th> <!-- New Column for Member Name -->
                    <th>Program Name</th>
                    <th>Date & Time</th>
                    <th>Submission Date & Time</th>
                    <th>Program Hours</th>
                    <th>Status</th>
                    <th>Reason Proof</th>
                    <th>Proof Status</th>
                </tr>

                <%
                    AttendanceDAO dao = new AttendanceDAO();
                    List<Attendance> attendances = dao.getAllAttendance();
                    int index = 1; // Initialize index for No.
                    for (Attendance att : attendances) {
                        String proof = att.getReasonProof();
                        String proofStatus = att.getProofStatus();
                %>
                <tr>
                    <td><%= index++%></td> <!-- Display the index (No.) -->
                    <td><%= att.getMemberName()%></td> <!-- Display Member Name -->
                    <td><%= att.getProgramName()%></td>
                    <td>
    <%
        String rawDateTime = att.getDateTime(); // contoh: 2025-04-22T20:31
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
                            String rawSubmissionDateTime = att.getSubmissionDateTime(); // Added: Get submissionDateTime
                            String formattedSubmissionDateTime = rawSubmissionDateTime;

                            try {
                                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                                Date date = inputFormat.parse(rawSubmissionDateTime);
                                SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
                                formattedSubmissionDateTime = outputFormat.format(date);
                            } catch (Exception e) {
                                // fallback to rawSubmissionDateTime jika error
                            }
                        %>
                        <%= formattedSubmissionDateTime %> <!-- Added: Display formatted submissionDateTime -->
                    </td>

                    
                    <td><%= att.getProgramHours()%></td>
                    <td><%= att.getStatus()%></td>
                    <td>
                        <% if (proof != null && !proof.trim().isEmpty() && !"No Proof".equalsIgnoreCase(proof)) {%>
                        <a href="uploads/<%= proof%>" target="_blank">View Proof</a>
                        <% } else { %>
                        -
                        <% } %>
                    </td>
                    <td>
                        <% if (proof != null && !proof.trim().isEmpty() && !"No Proof".equalsIgnoreCase(proof)) {%>
                        <div class="radio-container">
                            <input type="radio" id="approved_<%= att.getAttendanceId()%>" name="proofStatus_<%= att.getAttendanceId()%>" value="Approved" 
                                   <% if ("Approved".equals(proofStatus)) { %> checked <% }%> onchange="submitForm(<%= att.getAttendanceId()%>, 'Approved');
                                           setButtonState('approved_<%= att.getAttendanceId()%>')" />
                            <label for="approved_<%= att.getAttendanceId()%>">Approved</label>
                        </div>
                        <div class="radio-container">
                            <input type="radio" id="notApproved_<%= att.getAttendanceId()%>" name="proofStatus_<%= att.getAttendanceId()%>" value="Not Approved" 
                                   <% if ("Not Approved".equals(proofStatus)) { %> checked <% }%> onchange="submitForm(<%= att.getAttendanceId()%>, 'Not Approved'); setButtonState('notApproved_<%= att.getAttendanceId()%>')" />
                            <label for="notApproved_<%= att.getAttendanceId()%>">Not Approved</label>
                        </div>
                        <% } else { %>
                        -
                        <% } %>
                    </td>
                </tr>
                <% }%>

            </table>


        </div>

        <footer>
            © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.

        </footer>

    </body>
</html>
