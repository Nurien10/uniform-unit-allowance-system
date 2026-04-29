/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kor_suksis.controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/databaseunits_members")
public class DatabaseUnitsMembersController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil data pengguna dari pangkalan data
        UserDAO userDAO = new UserDAO();
        List<User> userList = userDAO.getAllUsers();

        // Setkan senarai pengguna sebagai atribut
        request.setAttribute("userList", userList);

        // Hantar ke JSP untuk paparan
        request.getRequestDispatcher("databaseunits_members.jsp").forward(request, response);
    }
}
