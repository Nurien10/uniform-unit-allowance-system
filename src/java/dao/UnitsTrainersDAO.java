/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Units_trainers;
import model.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UnitsTrainersDAO {

    private Connection connection;

    public UnitsTrainersDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new IllegalStateException("Failed to establish a database connection!");
        }
    }

    // Register Trainer
    public boolean registerTrainer(Units_trainers trainer) {
        String sql = "INSERT INTO trainers (Name, Phone Number, Date of Birth, IC, Gender, Address, Email, Password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, trainer.getName());
            preparedStatement.setString(2, trainer.getPhoneNumber());
            preparedStatement.setString(3, trainer.getDateOfBirth());
            preparedStatement.setString(4, trainer.getIc());
            preparedStatement.setString(5, trainer.getGender());
            preparedStatement.setString(6, trainer.getAddress());
            preparedStatement.setString(7, trainer.getEmail());
            preparedStatement.setString(8, trainer.getPasswordHash());

            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve Trainer by Email
    public Units_trainers getTrainerByEmail(String email) {
        String sql = "SELECT * FROM trainers WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                Units_trainers trainer = new Units_trainers();
                trainer.setName(resultSet.getString("Name"));
                trainer.setPhoneNumber(resultSet.getString("Phone Number"));
                trainer.setDateOfBirth(resultSet.getString("Date of Birth"));
                trainer.setIc(resultSet.getString("IC"));
                trainer.setGender(resultSet.getString("Gender"));
                trainer.setAddress(resultSet.getString("Address"));
                trainer.setEmail(resultSet.getString("Email"));
                trainer.setPasswordHash(resultSet.getString("Password"));
                return trainer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Retrieve All Trainers
    public List<Units_trainers> getAllTrainers() {
        List<Units_trainers> trainers = new ArrayList<>();
        String sql = "SELECT * FROM trainers";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql); ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Units_trainers trainer = new Units_trainers();
                trainer.setName(resultSet.getString("Name"));
                trainer.setPhoneNumber(resultSet.getString("Phone Number"));
                trainer.setDateOfBirth(resultSet.getString("Date of Birth"));
                trainer.setIc(resultSet.getString("IC"));
                trainer.setGender(resultSet.getString("Gender"));
                trainer.setAddress(resultSet.getString("Address"));
                trainer.setEmail(resultSet.getString("Email"));
                trainers.add(trainer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trainers;
    }

    public boolean updateTrainer(Units_trainers trainer) {
        String sql = "UPDATE trainers SET `Name` = ?, `Phone Number` = ?, `Date of Birth` = ?, `IC` = ?, `Gender` = ?, `Address` = ?, `Password` = ? WHERE `Email` = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, trainer.getName());
            preparedStatement.setString(2, trainer.getPhoneNumber());
            preparedStatement.setString(3, trainer.getDateOfBirth());
            preparedStatement.setString(4, trainer.getIc());
            preparedStatement.setString(5, trainer.getGender());
            preparedStatement.setString(6, trainer.getAddress());
            preparedStatement.setString(7, trainer.getPasswordHash());
            preparedStatement.setString(8, trainer.getEmail());

            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
