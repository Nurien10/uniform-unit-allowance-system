/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.Attendance;
import dao.AttendanceDAO;
import model.User;

@WebServlet("/AddAttendanceController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
                 maxFileSize = 1024 * 1024 * 10,         // 10MB
                 maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class AddAttendanceController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AttendanceDAO dao;

    private static final String UPLOAD_DIR = "uploads"; // Upload folder dalam server

    public AddAttendanceController() {
        super();
        dao = new AttendanceDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        // 📌 Ambil data daripada form
        String programName = request.getParameter("programName");
        String dateTime = request.getParameter("dateTime");
        String submissionDateTime = request.getParameter("submissionDateTime"); // Added: Get submission date and time
        String programHoursStr = request.getParameter("programHours");
        String status = request.getParameter("status");
        String message = "";
        String proofStatus = "";

        int programHours = 0;
        try {
            programHours = Integer.parseInt(programHoursStr); // Convert string ke int
        } catch (NumberFormatException e) {
            programHours = 0; // Kalau gagal, default 0
        }

        // 📌 Handle file upload
        Part filePart = request.getPart("reasonProof");
        String fileName = "";

        if (filePart != null && filePart.getSize() > 0) {
            fileName = new File(filePart.getSubmittedFileName()).getName();
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + fileName);

            proofStatus = "Submitted"; // ❗ Kalau upload file, proofStatus Submitted
        } else {
            fileName = "No Proof";     // ❗ Kalau tak upload, tetap ada value
            proofStatus = "Not Submitted";
        }

        // 📌 Create Attendance object
        Attendance attendance = new Attendance();
        attendance.setProgramName(programName);
        attendance.setDateTime(dateTime);
        attendance.setSubmissionDateTime(submissionDateTime); // Added: Set submission date and time
        attendance.setProgramHours(programHours);
        attendance.setStatus(status);
        attendance.setReasonProof(fileName); // ❗ Save nama file sahaja
        attendance.setMessage(message);
        attendance.setProofStatus(proofStatus);
        attendance.setMemberName(user.getName());

        // 📌 Insert ke database
        boolean success = dao.addAttendance(attendance);

        // 📌 Redirect dengan message
        if (success) {
            response.sendRedirect("attendanceunits_members.jsp?message=Attendance added successfully!");
        } else {
            response.sendRedirect("attendanceunits_members.jsp?error=Failed to add attendance!");
        }
    }
}
