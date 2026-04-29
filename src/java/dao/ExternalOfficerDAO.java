/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.External_officer;
import model.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ExternalOfficerDAO {

    private Connection connection;

    public ExternalOfficerDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new IllegalStateException("Failed to establish a database connection!");
        }
    }

    // Register External Officer
    public boolean registerOfficer(External_officer officer) {
        String sql = "INSERT INTO external_officer (Name, Phone_Number, Date_of_Birth, IC, Gender, Address, Email, Password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, officer.getName());
            preparedStatement.setString(2, officer.getPhoneNumber());
            preparedStatement.setString(3, officer.getDateOfBirth());
            preparedStatement.setString(4, officer.getIc());
            preparedStatement.setString(5, officer.getGender());
            preparedStatement.setString(6, officer.getAddress());
            preparedStatement.setString(7, officer.getEmail());
            preparedStatement.setString(8, officer.getPasswordHash());

            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve External Officer by Email
    public External_officer getOfficerByEmail(String email) {
        String sql = "SELECT * FROM external_officer WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                External_officer officer = new External_officer();
                officer.setName(resultSet.getString("Name"));
                officer.setPhoneNumber(resultSet.getString("Phone_Number"));
                officer.setDateOfBirth(resultSet.getString("Date_of_Birth"));
                officer.setIc(resultSet.getString("IC"));
                officer.setGender(resultSet.getString("Gender"));
                officer.setAddress(resultSet.getString("Address"));
                officer.setEmail(resultSet.getString("Email"));
                officer.setPasswordHash(resultSet.getString("Password"));
                return officer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Retrieve All External Officers
    public List<External_officer> getAllOfficers() {
        List<External_officer> officers = new ArrayList<>();
        String sql = "SELECT * FROM external_officer";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql); ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                External_officer officer = new External_officer();
                officer.setName(resultSet.getString("Name"));
                officer.setPhoneNumber(resultSet.getString("Phone_Number"));
                officer.setDateOfBirth(resultSet.getString("Date_of_Birth"));
                officer.setIc(resultSet.getString("IC"));
                officer.setGender(resultSet.getString("Gender"));
                officer.setAddress(resultSet.getString("Address"));
                officer.setEmail(resultSet.getString("Email"));
                officers.add(officer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return officers;
    }

    // Update External Officer
   public boolean updateOfficer(External_officer officer) {
    String sql = "UPDATE external_officer SET Name = ?, Phone_Number = ?, Date_of_Birth = ?, IC = ?, Gender = ?, Address = ? WHERE Email = ?";
    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        preparedStatement.setString(1, officer.getName());
        preparedStatement.setString(2, officer.getPhoneNumber());
        preparedStatement.setString(3, officer.getDateOfBirth());
        preparedStatement.setString(4, officer.getIc());
        preparedStatement.setString(5, officer.getGender());
        preparedStatement.setString(6, officer.getAddress());
        preparedStatement.setString(7, officer.getEmail());

        int result = preparedStatement.executeUpdate();
        return result > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }

   }
}