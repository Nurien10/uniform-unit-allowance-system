/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import dao.UserDAO;
import dao.UnitsHighCouncilDAO;
import dao.UnitsTrainersDAO;
import model.User;
import model.UnitsHigh_council;
import model.Units_trainers;
import utils.PasswordUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import dao.ExternalOfficerDAO;
import model.External_officer;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // Role to differentiate stakeholders

        HttpSession session = request.getSession();

        // Pastikan parameter role tidak null
        if (role == null || role.isEmpty()) {
            request.setAttribute("errorMessage", "Role is required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Determine which DAO to use based on the role
        switch (role) {
            case "UnitMembers":
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByEmail(email);
                if (user != null && PasswordUtils.verifyPassword(password, user.getPasswordHash())) {
                    session.setAttribute("user", user);
                    session.setAttribute("name", user.getName());
                    session.setAttribute("role", "UnitMembers"); // Tetapkan role

                    session.removeAttribute("highCouncil");
                    session.removeAttribute("trainer");
                    session.removeAttribute("officer");
                    response.sendRedirect("dashboardunits_members.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("units_members.jsp").forward(request, response);
                }
                break;

            case "HighCouncil":
                UnitsHighCouncilDAO highCouncilDAO = new UnitsHighCouncilDAO();
                UnitsHigh_council highCouncil = highCouncilDAO.getHighCouncilByEmail(email);
                if (highCouncil != null && PasswordUtils.verifyPassword(password, highCouncil.getPasswordHash())) {
                    session.setAttribute("highCouncil", highCouncil);
                    session.setAttribute("name", highCouncil.getName());
                    session.setAttribute("role", "HighCouncil"); // Tetapkan role

                    session.removeAttribute("user");
                    session.removeAttribute("trainer");
                    session.removeAttribute("officer");
                    response.sendRedirect("dashboardunits_highcouncil.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("units_highcouncil.jsp").forward(request, response);
                }
                break;

            case "Trainer":
                UnitsTrainersDAO trainersDAO = new UnitsTrainersDAO();
                Units_trainers trainer = trainersDAO.getTrainerByEmail(email);
                if (trainer != null && PasswordUtils.verifyPassword(password, trainer.getPasswordHash())) {
                    session.setAttribute("trainer", trainer);
                    session.setAttribute("name", trainer.getName());
                    session.setAttribute("role", "Trainer"); // Tetapkan role

                    session.removeAttribute("user");
                    session.removeAttribute("highCouncil");
                    session.removeAttribute("officer");
                    response.sendRedirect("dashboardunits_trainers.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("units_trainers.jsp").forward(request, response);
                }
                break;

            case "ExternalOfficer":
                ExternalOfficerDAO officerDAO = new ExternalOfficerDAO();
                External_officer officer = officerDAO.getOfficerByEmail(email);
                if (officer != null && PasswordUtils.verifyPassword(password, officer.getPasswordHash())) {
                    session.setAttribute("officer", officer);
                    session.setAttribute("name", officer.getName());
                    session.setAttribute("role", "ExternalOfficer");

                    response.sendRedirect("dashboardexternal_officer.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("external_officer.jsp").forward(request, response);
                }
                break;

            default:
                request.setAttribute("errorMessage", "Invalid role selected.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
        }
    }
}
