/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package kor_suksis.controller;

import dao.UnitsHighCouncilDAO;
import model.UnitsHigh_council;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/databaseunits_highcouncil")
public class DatabaseUnitsHighCouncilController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch high council data from the database
        UnitsHighCouncilDAO highCouncilDAO = new UnitsHighCouncilDAO();
        List<UnitsHigh_council> highCouncilList = highCouncilDAO.getAllHighCouncilMembers();

        // Set the high council list as a request attribute
        request.setAttribute("highCouncilList", highCouncilList);

        // Forward the request to the JSP for display
        request.getRequestDispatcher("databaseunits_highcouncil.jsp").forward(request, response);
    }
}
