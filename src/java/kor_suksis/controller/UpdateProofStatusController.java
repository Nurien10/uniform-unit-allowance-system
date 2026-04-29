/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import dao.AttendanceDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateproofstatus")
public class UpdateProofStatusController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String attendanceIdStr = request.getParameter("attendanceId");
        String proofStatus = request.getParameter("proofStatus"); // Menyimpan status buktian

        if (attendanceIdStr != null && proofStatus != null) {
            int attendanceId = Integer.parseInt(attendanceIdStr);  // Tukar attendanceId kepada integer

            AttendanceDAO dao = new AttendanceDAO();
            boolean success = dao.updateProofStatus(attendanceId, proofStatus); // Kemas kini status dalam database

            // Jika kemaskini berjaya
            if (success) {
                request.setAttribute("message", "Proof status updated successfully!"); // Set mesej kejayaan
            } else {
                request.setAttribute("error", "Failed to update proof status!"); // Set mesej ralat
            }
        } else {
            // Jika parameter hilang
            request.setAttribute("error", "Missing parameters!"); // Set mesej error jika parameter tidak lengkap
        }

        // Forwardkan ke halaman yang sama (attendanceunits_trainer.jsp) dengan mesej yang diset
        RequestDispatcher dispatcher = request.getRequestDispatcher("attendanceunits_trainer.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);  // Pastikan doGet menggunakan doPost
    }
}
