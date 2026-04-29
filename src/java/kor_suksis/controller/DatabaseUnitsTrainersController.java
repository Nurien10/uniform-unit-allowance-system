/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kor_suksis.controller;

import dao.UnitsTrainersDAO;
import model.Units_trainers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/databaseunits_trainers")
public class DatabaseUnitsTrainersController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch trainers data from the database
        UnitsTrainersDAO trainersDAO = new UnitsTrainersDAO();
        List<Units_trainers> trainersList = trainersDAO.getAllTrainers();

        // Set the trainers list as a request attribute
        request.setAttribute("trainersList", trainersList);

        // Forward the request to the JSP for display
        request.getRequestDispatcher("databaseunits_trainers.jsp").forward(request, response);
    }
}
