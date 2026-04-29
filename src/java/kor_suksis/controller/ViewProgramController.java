package kor_suksis.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProgramHighCouncil;
import dao.ProgramHighCouncilDAO;

@WebServlet(name = "ViewProgramController", urlPatterns = {"/ViewProgramController"})
public class ViewProgramController extends HttpServlet {

    private ProgramHighCouncilDAO dao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new ProgramHighCouncilDAO(); // Initialize the DAO to fetch programs
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Fetch the list of programs from the database
            List<ProgramHighCouncil> programs = dao.getAllPrograms();
            
            // Set the programs as a request attribute
            request.setAttribute("programs", programs);
            
            // Forward the request to the JSP page
            request.getRequestDispatcher("program.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("program.jsp?error=Failed to fetch programs.");
        }
    }
}
