/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.User;
import model.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        this.connection = DBConnection.getConnection(); // Sambungkan ke database
        if (this.connection == null) {
            throw new IllegalStateException("Failed to establish a database connection!");
        }
    }

    // Register pengguna baru
    public boolean registerUser(User user) {
        String sql = "INSERT INTO members (Name, `Phone Number`, `Date of Birth`, IC, Gender, Squad, Address, `Bank Account`, Email, Password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPhoneNumber());
            preparedStatement.setString(3, user.getDateOfBirth());
            preparedStatement.setString(4, user.getIc());
            preparedStatement.setString(5, user.getGender());
            preparedStatement.setString(6, user.getSquad());
            preparedStatement.setString(7, user.getAddress());
            preparedStatement.setString(8, user.getBankAccount());
            preparedStatement.setString(9, user.getEmail());
            preparedStatement.setString(10, user.getPasswordHash());

            int result = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + result); // Debug
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve pengguna berdasarkan email
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM members WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                User user = new User();
                user.setName(resultSet.getString("Name"));
                user.setPhoneNumber(resultSet.getString("Phone Number"));
                user.setDateOfBirth(resultSet.getString("Date of Birth"));
                user.setIc(resultSet.getString("IC"));
                user.setGender(resultSet.getString("Gender"));
                user.setSquad(resultSet.getString("Squad"));
                user.setAddress(resultSet.getString("Address"));
                user.setBankAccount(resultSet.getString("Bank Account"));
                user.setEmail(resultSet.getString("Email"));
                user.setPasswordHash(resultSet.getString("Password"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Perbarui data pengguna
    public boolean updateUser(User user) {
        String sql = "UPDATE members SET Name = ?, `Phone Number` = ?, `Date of Birth` = ?, IC = ?, Gender = ?, Squad = ?, Address = ?, `Bank Account` = ? WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPhoneNumber());
            preparedStatement.setString(3, user.getDateOfBirth());
            preparedStatement.setString(4, user.getIc());
            preparedStatement.setString(5, user.getGender());
            preparedStatement.setString(6, user.getSquad());
            preparedStatement.setString(7, user.getAddress());
            preparedStatement.setString(8, user.getBankAccount());
            preparedStatement.setString(9, user.getEmail()); // Email sebagai acuan

            int result = preparedStatement.executeUpdate();
            System.out.println("Update result: " + result); // Debug
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cari pengguna berdasarkan nama
    public List<User> searchUsersByName(String name) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM members WHERE Name LIKE ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setName(resultSet.getString("Name"));
                user.setPhoneNumber(resultSet.getString("Phone Number"));
                user.setDateOfBirth(resultSet.getString("Date of Birth"));
                user.setIc(resultSet.getString("IC"));
                user.setGender(resultSet.getString("Gender"));
                user.setSquad(resultSet.getString("Squad"));
                user.setAddress(resultSet.getString("Address"));
                user.setBankAccount(resultSet.getString("Bank Account"));
                user.setEmail(resultSet.getString("Email"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }


    // Ambil semua pengguna dari database
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM members";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                User user = new User();
                user.setName(resultSet.getString("Name"));
                user.setPhoneNumber(resultSet.getString("Phone Number"));
                user.setDateOfBirth(resultSet.getString("Date of Birth"));
                user.setIc(resultSet.getString("IC"));
                user.setGender(resultSet.getString("Gender"));
                user.setSquad(resultSet.getString("Squad"));
                user.setAddress(resultSet.getString("Address"));
                user.setBankAccount(resultSet.getString("Bank Account"));
                user.setEmail(resultSet.getString("Email"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    
}
