/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.UnitsHigh_council;
import model.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UnitsHighCouncilDAO {
    private Connection connection;

    // Constructor untuk mendapatkan sambungan ke database
    public UnitsHighCouncilDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new IllegalStateException("Failed to establish a database connection!");
        }
    }

    // **1. Register High Council**
    public boolean registerHighCouncil(UnitsHigh_council council) {
        String sql = "INSERT INTO high_council (Name, Squad, Position, Email, Password) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, council.getName());
            preparedStatement.setString(2, council.getSquad());
            preparedStatement.setString(3, council.getPosition());
            preparedStatement.setString(4, council.getEmail());
            preparedStatement.setString(5, council.getPasswordHash());

            int result = preparedStatement.executeUpdate();
            return result > 0; // Berjaya jika result > 0
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // **2. Retrieve High Council by Email**
    public UnitsHigh_council getHighCouncilByEmail(String email) {
        String sql = "SELECT * FROM high_council WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                UnitsHigh_council council = new UnitsHigh_council();
                council.setName(resultSet.getString("Name"));
                council.setSquad(resultSet.getString("Squad"));
                council.setPosition(resultSet.getString("Position"));
                council.setEmail(resultSet.getString("Email"));
                council.setPasswordHash(resultSet.getString("Password"));
                return council;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null jika tiada rekod dijumpai
    }

    // **3. Retrieve All High Council Members**
    public List<UnitsHigh_council> getAllHighCouncilMembers() {
        List<UnitsHigh_council> councils = new ArrayList<>();
        String sql = "SELECT * FROM high_council";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                UnitsHigh_council council = new UnitsHigh_council();
                council.setName(resultSet.getString("Name"));
                council.setSquad(resultSet.getString("Squad"));
                council.setPosition(resultSet.getString("Position"));
                council.setEmail(resultSet.getString("Email"));
                council.setPasswordHash(resultSet.getString("Password"));
                councils.add(council);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return councils;
    }

    // **4. Update High Council**
    public boolean updateHighCouncil(UnitsHigh_council council) {
        String sql = "UPDATE high_council SET Name = ?, Squad = ?, Position = ?, Password = ? WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, council.getName());
            preparedStatement.setString(2, council.getSquad());
            preparedStatement.setString(3, council.getPosition());
            preparedStatement.setString(4, council.getPasswordHash());
            preparedStatement.setString(5, council.getEmail());

            int result = preparedStatement.executeUpdate();
            return result > 0; // Berjaya jika result > 0
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // **5. Delete High Council by Email**
    public boolean deleteHighCouncilByEmail(String email) {
        String sql = "DELETE FROM high_council WHERE Email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);

            int result = preparedStatement.executeUpdate();
            return result > 0; // Berjaya jika result > 0
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
