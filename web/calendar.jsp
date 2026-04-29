<%-- 
    Document   : calendar
    Created on : 30 Jun 2025, 10:19:34 pm
    Author     : HP
--%>
<%@page import="java.util.List"%>
<%@page import="model.ProgramHighCouncil"%>
<%@page import="dao.ProgramHighCouncilDAO"%>
<%@page import="model.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Calendar"%>
<%
    // Get current logged in user
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ProgramHighCouncilDAO dao = new ProgramHighCouncilDAO();
    List<ProgramHighCouncil> programs = dao.getAllPrograms();
    SimpleDateFormat displayDateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
    SimpleDateFormat urlDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat dayFormat = new SimpleDateFormat("dd");
    SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM yyyy");

    // Initialize calendar with session-based offset
    Calendar cal = Calendar.getInstance();
    Integer monthOffset = (Integer) session.getAttribute("monthOffset");
    if (monthOffset == null) {
        monthOffset = 0; // Default to current month
    }
    cal.add(Calendar.MONTH, monthOffset);

    // Handle navigation
    String navParam = request.getParameter("nav");
    if ("prev".equals(navParam)) {
        monthOffset--;
    } else if ("next".equals(navParam)) {
        monthOffset++;
    }
    session.setAttribute("monthOffset", monthOffset);
    cal.setTime(Calendar.getInstance().getTime()); // Reset to current date
    cal.add(Calendar.MONTH, monthOffset);

    int currentMonth = cal.get(Calendar.MONTH);
    int currentYear = cal.get(Calendar.YEAR);
    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1; // 0-based index (Sunday = 0)
%>

 <h5 style="text-align: right; margin-right: 10px; margin-top: -50px; color: #34495e;">
        <img src="assets/images/people.png" alt="User Icon"
         style="width: 16px; height: 16px; vertical-align: middle; margin-right: 6px;">
        <%= ((User) request.getSession().getAttribute("user")).getName() %></h5>
    

<!DOCTYPE html>
<html>
<head>
    <title>Program Calendar</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Times New Roman', Times, serif;
            margin: 0;
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
            padding: 20px;
        }
        h1 {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #34495e;
        }
        .calendar {
            width: 80%;
            margin: 0 auto;
            background: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
        }
        .calendar-header {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background: #34495e;
            color: white;
            border-radius: 10px 10px 0 0;
        }
        .calendar-header a {
            color: white;
            text-decoration: none;
            margin: 0 5px;
        }
        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            text-align: center;
            padding: 10px;
            background: #ecf0f1;
        }
        .calendar-days div {
            padding: 5px;
            font-weight: bold;
        }
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            text-align: center;
            border-top: 1px solid #ccc;
        }
        .calendar-grid div {
            padding: 5px;
            border-right: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            min-height: 50px;
            position: relative;
        }
        .calendar-grid .empty {
            background: #f5f5f5;
        }
        .calendar-grid .today {
            background: #3498db;
            color: white;
        }
        .calendar-grid .event {
            background: #e74c3c;
            color: white;
            padding: 0 2px; /* Reduced vertical padding, kept horizontal */
            border-radius: 3px;
            font-size: 10px;
            margin: 1px 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;
            height: 12px; /* Fixed height to reduce vertical size */
            line-height: 12px; /* Match height for text alignment */
            cursor: pointer;
        }
        .calendar-grid .event:hover {
            background: #c0392b;
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
            background-color: transparent;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="assets/images/logo_umt.png" alt="Logo UMT">
        <a href="dashboardunits_members.jsp">Dashboard</a>
        <a href="ViewProgramController">Program Schedule</a>
        <a href="attendanceunits_members.jsp">Attendance</a>
        <a href="allowanceunits_members.jsp">Allowance</a>
        <a href="paymenunits_members.jsp">Payment</a>
        <a href="index.jsp">Logout</a>
    </div>

    <div id="content">
        
        
        <h1>Program (Units Members)</h1>

        <div class="calendar">
            <div class="calendar-header">
                <a href="?nav=prev"><</a>
                <span><%= monthFormat.format(cal.getTime()) %></span>
                <a href="?nav=next">></a>
            </div>
            <div class="calendar-days">
                <div>Sun</div><div>Mon</div><div>Tue</div><div>Wed</div><div>Thu</div><div>Fri</div><div>Sat</div>
            </div>
            <div class="calendar-grid">
                <% 
                    for (int i = 0; i < firstDayOfWeek; i++) { %>
                        <div class="empty"></div>
                <% }
                SimpleDateFormat monthDayFormat = new SimpleDateFormat("MM/dd/yyyy");
                for (int day = 1; day <= daysInMonth; day++) {
                    cal.set(Calendar.DAY_OF_MONTH, day);
                    String dayStr = dayFormat.format(cal.getTime());
                    String fullDateStr = monthDayFormat.format(cal.getTime());
                    boolean isToday = day == Calendar.getInstance().get(Calendar.DAY_OF_MONTH) &&
                                     currentMonth == Calendar.getInstance().get(Calendar.MONTH) &&
                                     currentYear == Calendar.getInstance().get(Calendar.YEAR);
                %>
                    <div class="<%= isToday ? "today" : "" %>">
                        <strong><%= dayStr %></strong>
                        <% for (ProgramHighCouncil program : programs) {
                            SimpleDateFormat programDateFormat = new SimpleDateFormat("MM/dd/yyyy");
                            String programDateStr = programDateFormat.format(program.getDateTime());
                            if (programDateStr.equals(fullDateStr)) { %>
                                <div class="event" onclick="location.href='addattendanceunits_members.jsp?programName=<%= URLEncoder.encode(program.getProgramName(), "UTF-8") %>&dateTime=<%= URLEncoder.encode(urlDateFormat.format(program.getDateTime()), "UTF-8") %>&programHours=<%= URLEncoder.encode(String.valueOf(program.getProgramHours()), "UTF-8") %>'">
                                    <%= program.getProgramName().length() > 10 ? program.getProgramName().substring(0, 10) + "..." : program.getProgramName() %>
                                </div>
                        <% } %>
                        <% } %>
                    </div>
                <% }
                int remainingCells = 7 - (firstDayOfWeek + daysInMonth) % 7;
                if (remainingCells < 7) {
                    for (int i = 0; i < remainingCells; i++) { %>
                        <div class="empty"></div>
                <% }
                } %>
            </div>
        </div>
    </div>

    <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>
</body>
</html>