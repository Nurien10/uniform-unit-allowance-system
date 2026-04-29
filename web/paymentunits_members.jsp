<%-- 
    Document   : paymentunits_members
    Created on : 23 Jun 2025, 12:35:08 pm
    Author     : HP
--%>

<%@page import="model.DBConnection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %> <!-- Ditambah: Import SimpleDateFormat -->
<%@ page import="java.util.Date" %> <!-- Ditambah: Import Date untuk parsing -->
<%
    // Check if session exists and user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("units_members.jsp?error=Session expired. Please log in again.");
        return;
    }

    // Retrieve user from session
    User user = (User) session.getAttribute("user");

    // Database connection settings - update these!
    
    Connection conn = DBConnection.getConnection();
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<html>
    <head>
        <title>Unit Member Payment</title>
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <style>
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
            <a href="dashboardunits_members.jsp">Dashboard</a>
            <a href="ViewProgramController">Program Schedule</a>
            <a href="attendanceunits_members.jsp">Attendance</a>
            <a href="allowanceunits_members.jsp">Allowance</a>
            <a href="paymentunits_members.jsp">Payment</a>
            <a href="index.jsp">Logout</a>
        </div>

        <div id="content">
            <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
                <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
                <%= user.getName()%></h5>
            <h1>Payment Status (Unit Member)</h1>

            <table>
                <tr>
                    <th>No</th>
                    <th>Month</th>
                    <th>Year</th>
                    <th>Program Hours</th>
                    <th>Total Allowance</th>
                    <th>Status</th>
                    <th>Payment Date</th>
                </tr>
                <%
                    try {
                        String sql = "SELECT * FROM allowance_payment WHERE memberName = ? AND status = 'Paid' ORDER BY year DESC, month DESC";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, user.getName());
                        rs = stmt.executeQuery();

                        int counter = 1;
                        while (rs.next()) {
                            String month = rs.getString("month");
                            String year = rs.getString("year");
                            String programHours = rs.getString("programHours");
                            String amount = rs.getString("amount");
                            String status = rs.getString("status");
                            Timestamp paymentDate = rs.getTimestamp("created_at");
                            String formattedPaymentDate = paymentDate != null ? paymentDate.toString() : "N/A"; // Default fallback
                            // Ditambah: Format paymentDate ke 12-jam dengan AM/PM
                            try {
                                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                                Date date = inputFormat.parse(paymentDate.toString());
                                SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
                                formattedPaymentDate = outputFormat.format(date);
                            } catch (Exception e) {
                                // Fallback to raw format jika error
                            }
                %>
                <tr>
                    <td><%= counter++%></td>
                    <td><%= month%></td>
                    <td><%= year%></td>
                    <td><%= programHours%></td>
                    <td>RM <%= amount%></td>
                    <td><%= status%></td>
                    <td><%= formattedPaymentDate%></td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                %>
                <tr>
                    <td colspan="7" style="color:red;">Error fetching data: <%= e.getMessage()%></td>
                </tr>
                <%
                    } finally {
                        if (rs != null) try {
                            rs.close();
                        } catch (SQLException ignored) {
                        }
                        if (stmt != null) try {
                            stmt.close();
                        } catch (SQLException ignored) {
                        }
                        if (conn != null) try {
                            conn.close();
                        } catch (SQLException ignored) {
                        }
                    }
                %>
            </table>
        </div>

        <footer>
            © 2025 UMT Uniform Unit Allowance Management System
        </footer>

    </body>
</html>
