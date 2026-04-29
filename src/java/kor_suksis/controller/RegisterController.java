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
import utils.PasswordUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role"); // Determine role for registration
        
        switch (role) {
            case "UnitMembers":
                registerUnitMembers(request, response);
                break;

            case "HighCouncil":
                registerHighCouncil(request, response);
                break;

            case "Trainer":
                registerTrainer(request, response);
                break;

            case "ExternalOfficer":
                registerExternalOfficer(request, response);
                break;

            default:
                response.sendRedirect("register.jsp?error=Invalid role selected");
                break;
        }
    }

    private void registerUnitMembers(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String ic = request.getParameter("ic");
        String gender = request.getParameter("gender");
        String squad = request.getParameter("squad");
        String address = request.getParameter("address");
        String bank = request.getParameter("bank");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String passwordHash = PasswordUtils.hashPassword(password);

        User user = new User();
        user.setName(name);
        user.setPhoneNumber(phone);
        user.setDateOfBirth(dob);
        user.setIc(ic);
        user.setGender(gender);
        user.setUniform("SUKSIS");
        user.setSquad(squad);
        user.setAddress(address);
        user.setBankAccount(bank);
        user.setEmail(email);
        user.setPasswordHash(passwordHash);

        UserDAO userDAO = new UserDAO();
        if (userDAO.registerUser(user)) {
            response.sendRedirect("registerunits_members.jsp?message=Account Successfully Added..");
        } else {
            response.sendRedirect("registerunits_members.jsp?error=Account Already Exist...");
        }
    }

    private void registerHighCouncil(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String position = request.getParameter("position");
        String squad = request.getParameter("squad");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passwordHash = PasswordUtils.hashPassword(password);

        UnitsHigh_council highCouncil = new UnitsHigh_council();
        highCouncil.setName(name);
        highCouncil.setUniform("SUKSIS");
        highCouncil.setPosition(position);
        highCouncil.setSquad(squad);
        highCouncil.setEmail(email);
        highCouncil.setPasswordHash(passwordHash);

        UnitsHighCouncilDAO highCouncilDAO = new UnitsHighCouncilDAO();
        if (highCouncilDAO.registerHighCouncil(highCouncil)) {
            response.sendRedirect("registerunits_highcouncil.jsp?message=Account Successfully Added..");
        } else {
            response.sendRedirect("registerunits_highcouncil.jsp?error=Account Already Exist...");
        }
    }

    private void registerTrainer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String ic = request.getParameter("ic");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String passwordHash = PasswordUtils.hashPassword(password);

        Units_trainers trainer = new Units_trainers();
        trainer.setName(name);
        trainer.setPhoneNumber(phone);
        trainer.setDateOfBirth(dob);
        trainer.setIc(ic);
        trainer.setGender(gender);
        trainer.setAddress(address);
        trainer.setEmail(email);
        trainer.setPasswordHash(passwordHash);

        UnitsTrainersDAO trainersDAO = new UnitsTrainersDAO();
        if (trainersDAO.registerTrainer(trainer)) {
            response.sendRedirect("registerunits_trainers.jsp?message=Account Successfully Added..");
        } else {
            response.sendRedirect("registerunits_trainers.jsp?error=Account Already Exist...");
        }
    }
private void registerExternalOfficer(HttpServletRequest request, HttpServletResponse response) throws IOException {
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String dob = request.getParameter("dob");
    String ic = request.getParameter("ic");
    String gender = request.getParameter("gender");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String passwordHash = PasswordUtils.hashPassword(password);

    External_officer officer = new External_officer();
    officer.setName(name);
    officer.setPhoneNumber(phone);
    officer.setDateOfBirth(dob);
    officer.setIc(ic);
    officer.setGender(gender);
    officer.setAddress(address);
    officer.setEmail(email);
    officer.setPasswordHash(passwordHash);

    ExternalOfficerDAO externalOfficerDAO = new ExternalOfficerDAO();
    if (externalOfficerDAO.registerOfficer(officer)) {
        response.sendRedirect("registerexternal_officer.jsp?message=Account Successfully Added.");
    } else {
        response.sendRedirect("registerexternal_officer.jsp?error=Account Already Exist.");
    }
}

}