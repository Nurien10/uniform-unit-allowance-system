/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package kor_suksis.controller;

import dao.UserDAO;
import dao.UnitsHighCouncilDAO;
import dao.UnitsTrainersDAO;
import dao.ExternalOfficerDAO;
import model.User;
import model.UnitsHigh_council;
import model.Units_trainers;
import model.External_officer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateController")
public class UpdateController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp?error=Session expired. Please log in again.");
            return;
        }

        // Check user type in session (units members, high council, or trainers)
        Object userObj = session.getAttribute("user");
        Object highCouncilObj = session.getAttribute("highCouncil");
        Object trainerObj = session.getAttribute("trainer");

        if (userObj != null) {
            // === Logik untuk Units Members ===
            User user = (User) userObj;

            try {
                // Ambil data dari form
                user.setName(request.getParameter("name"));
                user.setPhoneNumber(request.getParameter("phoneNumber"));
                user.setDateOfBirth(request.getParameter("dateOfBirth"));
                user.setIc(request.getParameter("ic"));
                user.setGender(request.getParameter("gender"));
                user.setSquad(request.getParameter("squad"));
                user.setAddress(request.getParameter("address"));
                user.setBankAccount(request.getParameter("bankAccount"));

                // Simpan ke database
                UserDAO userDAO = new UserDAO();
                boolean isUpdated = userDAO.updateUser(user);

                if (isUpdated) {
                    // Update sesi dengan data baru
                    session.setAttribute("user", user);
                    response.sendRedirect("dashboardunits_members.jsp?message=Update successful");
                } else {
                    response.sendRedirect("updateunits_members.jsp?error=Update failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("updateunits_members.jsp?error=An unexpected error occurred.");
            }

        } else if (highCouncilObj != null) {
            // === Logik untuk Units High Council ===
            UnitsHigh_council highCouncil = (UnitsHigh_council) highCouncilObj;

            try {
                // Ambil data dari form
                highCouncil.setName(request.getParameter("name"));
                highCouncil.setSquad(request.getParameter("squad"));
                highCouncil.setPosition(request.getParameter("position"));

                // Simpan ke database
                UnitsHighCouncilDAO dao = new UnitsHighCouncilDAO();
                boolean isUpdated = dao.updateHighCouncil(highCouncil);

                if (isUpdated) {
                    // Update sesi dengan data baru
                    session.setAttribute("highCouncil", highCouncil);
                    response.sendRedirect("dashboardunits_highcouncil.jsp?message=Update successful");
                } else {
                    response.sendRedirect("updateunits_highcouncil.jsp?error=Update failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("updateunits_highcouncil.jsp?error=An unexpected error occurred.");
            }

        } else if (trainerObj != null) {
            // === Logik untuk Units Trainers ===
            Units_trainers trainer = (Units_trainers) trainerObj;

            try {
                // Ambil data dari form
                trainer.setName(request.getParameter("name"));
                trainer.setPhoneNumber(request.getParameter("phoneNumber"));
                trainer.setDateOfBirth(request.getParameter("dateOfBirth"));
                trainer.setIc(request.getParameter("ic"));
                trainer.setGender(request.getParameter("gender"));
                trainer.setAddress(request.getParameter("address"));

                // Simpan ke database
                UnitsTrainersDAO dao = new UnitsTrainersDAO();
                boolean isUpdated = dao.updateTrainer(trainer);

                if (isUpdated) {
                    // Update sesi dengan data baru
                    session.setAttribute("trainer", trainer);
                    response.sendRedirect("dashboardunits_trainers.jsp?message=Update successful");
                } else {
                    response.sendRedirect("updateunits_trainers.jsp?error=Update failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("updateunits_trainers.jsp?error=An unexpected error occurred.");
            }
            
            }else if  (session.getAttribute("officer") != null) {
    // === Logic for External Officer ===
    External_officer officer = (External_officer) session.getAttribute("officer");

    try {
        // Retrieve data from form
        officer.setName(request.getParameter("name"));
        officer.setPhoneNumber(request.getParameter("phoneNumber"));
        officer.setDateOfBirth(request.getParameter("dateOfBirth"));
        officer.setIc(request.getParameter("ic"));
        officer.setGender(request.getParameter("gender"));
        officer.setAddress(request.getParameter("address"));

        // Save to database
        ExternalOfficerDAO dao = new ExternalOfficerDAO();
        boolean isUpdated = dao.updateOfficer(officer);

        if (isUpdated) {
            // Update session with new data
            session.setAttribute("officer", officer);
            response.sendRedirect("dashboardexternal_officer.jsp?message=Update successful");
        } else {
            response.sendRedirect("updateexternal_officer.jsp?error=Update failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("updateexternal_officer.jsp?error=An unexpected error occurred.");
    }


        } else {
            // Jika tiada sesi pengguna, redirect ke login
            response.sendRedirect("login.jsp?error=Session expired. Please log in again.");
        }
    }
}
