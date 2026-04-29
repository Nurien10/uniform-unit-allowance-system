/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProgramHighCouncilDAO;

@WebServlet("/deleteprogram")
public class DeleteProgramController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProgramHighCouncilDAO dao;

    public DeleteProgramController() {
        super();
        dao = new ProgramHighCouncilDAO();
    }
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        // Ambil parameter programName dari request
        String programName = request.getParameter("programName");
        System.out.println("Deleting program: " + programName); // Debugging log

        // Panggil DAO untuk hapuskan satu program
        dao.deleteProgram(programName);

        // Ambil senarai program terkini
        request.setAttribute("programs", dao.getAllPrograms());

        // Forward ke program.jsp dengan data terkini
        request.getRequestDispatcher("program.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        // Jika ada ralat, kekalkan di program.jsp dengan mesej ralat
        response.sendRedirect("program.jsp?error=Failed to delete program");
    }
}
}