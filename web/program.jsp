<%@page import="model.ProgramHighCouncil"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>

<%
    // Check if session exists and high council member is logged in
    if (session == null || session.getAttribute("name") == null) {
        response.sendRedirect("units_highcouncil.jsp");
        return;
    }

    // Retrieve name from session
    String name = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Program Schedule List</title>
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
            table {
                width: calc(100% - 40px);
                max-width: 800px;
                border-collapse: collapse;
                margin: 0 auto; /* Pusatkan jadual */
            }
            table th, table td {
                border: 1px solid black;
                padding: 10px;
                text-align: center;
            }
            table th {
                background-color: #A9A9A9;
            }
            
                .add-button {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                margin-bottom: 30px;
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
            <a href="dashboardunits_members.jsp"> Dashboard </a>
            <a href="ViewProgramController">Program Schedule</a>
            <a href="attendanceunits_members.jsp">Attendance</a>
            <a href="allowance.jsp">Allowance</a>
            <a href="payment.jsp">Payment</a>
            <a href="index.jsp">Logout</a>



            <% if ("HighCouncil".equals(session.getAttribute("role"))) { %>
            <% }%>
        </div>
        <div id="content">
           <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;"> <%= name %></h5>

            <h1>Program Schedule List</h1>

            <%-- Display success or error message --%>
            <%
                String message = request.getParameter("message");
                String error = request.getParameter("error");
                if (message != null) {
            %>
            <p class="message"><%= message%></p>
            <%
                }
                if (error != null) {
            %>
            <p class="error"><%= error%></p>
            <% } %>

            <%-- Ambil role dari sesi --%>
            <%
                String role = (String) session.getAttribute("role");
                if (role == null) {
                    role = "readonly"; // Default jika tiada role
                }
            %>
            
            <% if ("HighCouncil".equals(role)) { %>
            <div class="add-button">
                <a href="addprogram.jsp">Add Program</a>
            </div>
        <% } %>
            

            <%-- Display list of programs --%>
            <table>
                <tr>
                    <th>Program Name</th>
                    <th>Date & Time</th>
                    <th>Venue</th>
                    <th>Trainer</th>
                    <th>Program Hours</th>
                        <% if ("HighCouncil".equals(role)) { %>
                    <th>Action</th> <!-- Kolum Action hanya untuk High Council -->
                        <% } %>
                </tr>
                <%
                    List<ProgramHighCouncil> programs = (List<ProgramHighCouncil>) request.getAttribute("programs");
                    if (programs != null && !programs.isEmpty()) {
                        for (ProgramHighCouncil program : programs) {
                %>
                <tr>
                    <td><%= program.getProgramName()%></td>
                    <td>  
                        <%
                        Timestamp dateTime = program.getDateTime
                        ();
                        String formattedDateTime = dateTime !=
                        null ? new SimpleDateFormat("hh:mm a").
                        format(dateTime) : "N/A";
                        %>
                        <%= formattedDateTime %>
                    </td>

                    <td><%= program.getVenue()%></td>
                    <td><%= program.getTrainer()%></td>
                    <td><%= program.getProgramHours()%></td>
                    <% if ("HighCouncil".equals(role)) {%>
                    <td>
                        <form action="deleteprogram" method="post" style="display:inline;">
                            <input type="hidden" name="programName" value="<%= program.getProgramName()%>">
                            <button type="submit" class="delete-button" onclick="return confirm('Are you sure you want to delete this program?')">Delete</button>
                        </form>
                    </td>
                    <% } %>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5">No programs found.</td>
                </tr>
                <%
                    }
                %>
            </table>

            

        </div>
        <footer>
            © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
        </footer>  

    </body>
</html>
