/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package dao;

import model.ProgramHighCouncil;
import model.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProgramHighCouncilDAO {

    private Connection connection;

    public ProgramHighCouncilDAO() {
        this.connection = DBConnection.getConnection();
    }

    // Add program
    public void addProgram(ProgramHighCouncil program) {
        String sql = "INSERT INTO programhigh_council (program_name, date_time, venue, trainer, program_hours) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, program.getProgramName());
            ps.setTimestamp(2, program.getDateTime());
            ps.setString(3, program.getVenue());
            ps.setString(4, program.getTrainer());
            ps.setString(5, program.getProgramHours());
            ps.executeUpdate();
            System.out.println("Program successfully added.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get all programs
    public List<ProgramHighCouncil> getAllPrograms() {
        List<ProgramHighCouncil> programs = new ArrayList<>();
        String sql = "SELECT * FROM programhigh_council";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                programs.add(new ProgramHighCouncil(
                        rs.getString("program_name"),
                        rs.getTimestamp("date_time"),
                        rs.getString("venue"),
                        rs.getString("trainer"),
                        rs.getString("program_hours")
                        
                ));
            }
            System.out.println("DAO here, after fetching, size is:" + programs.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return programs;
    }

    // Update program
    public void updateProgram(ProgramHighCouncil program) {
        String sql = "UPDATE programhigh_council SET dateTime = ?, venue = ?, trainer = ? WHERE programName = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, program.getDateTime());
            ps.setString(2, program.getVenue());
            ps.setString(3, program.getTrainer());
            ps.setString(4, program.getProgramHours());
            ps.setString(5, program.getProgramName());
            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Program successfully updated.");
            } else {
                System.out.println("No program found with the given name.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public ProgramHighCouncil getProgramByName(String programName) {
    ProgramHighCouncil program = null; // Inisialisasi objek
    String sql = "SELECT * FROM programhigh_council WHERE program_name = ?"; // SQL dengan parameter

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, programName); // Tetapkan parameter programName dalam SQL
        try (ResultSet rs = ps.executeQuery()) { // Jalankan query
            if (rs.next()) { // Jika rekod wujud
                program = new ProgramHighCouncil(
                    rs.getString("program_name"),
                    rs.getTimestamp("date_time"),
                    rs.getString("venue"),
                    rs.getString("trainer"),
                    rs.getString("program_hours")   
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Log error untuk debugging
    }
    return program; // Kembalikan objek ProgramHighCouncil
}


    // Delete program
  public void deleteProgram(String programName) {
    String sql = "DELETE FROM programhigh_council WHERE program_name = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        System.out.println("SQL Query: " + sql); // Debugging log
        ps.setString(1, programName);
        int rowsDeleted = ps.executeUpdate();
        System.out.println("Rows deleted: " + rowsDeleted);
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

}