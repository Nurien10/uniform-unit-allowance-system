/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProgramHighCouncil;
import dao.ProgramHighCouncilDAO;

@WebServlet("/AddProgramController")
public class AddProgramController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProgramHighCouncilDAO dao;

    public AddProgramController() {
        super();
        dao = new ProgramHighCouncilDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve form data
            String programName = request.getParameter("programName");
            String dateTimeInput = request.getParameter("dateTime");
            String programHours = request.getParameter("programHours"); 
            String venue = request.getParameter("venue");
            String trainer = request.getParameter("trainer");

            // Convert dateTimeInput to Timestamp
            String formattedDateTime = dateTimeInput.replace("T", " ") + ":00";
            Timestamp dateTime = Timestamp.valueOf(formattedDateTime);

            // Create a new program object
            ProgramHighCouncil program = new ProgramHighCouncil(programName, dateTime, venue, trainer, programHours);

            // Save the program to the database
            dao.addProgram(program);

            // Redirect with success message
            response.sendRedirect("addprogram.jsp?message=Program successfully added!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addprogram.jsp?error=Failed to add program!");
        }
    }
}
