/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import dao.AttendanceDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteAttendanceController")
public class DeleteAttendanceController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {

            int id = Integer.parseInt(idParam);

            AttendanceDAO dao = new AttendanceDAO();
            boolean success = dao.deleteAttendance(id); // ➔ Panggil method delete di DAO

            if (success) {
                response.sendRedirect("attendanceunits_members.jsp?message=Attendance deleted successfully");
            } else {
                response.sendRedirect("attendanceunits_members.jsp?error=Failed to delete attendance");
            }
        } else {
            response.sendRedirect("attendanceunits_members.jsp?error=Invalid ID");
        }
    }
}
