/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Attendance;
import model.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class AttendanceDAO {

    private Connection connection;

    public AttendanceDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new IllegalStateException("Failed to establish a database connection!");
        }
    }

    // Add Attendance
    public boolean addAttendance(Attendance attendance) {
        String sql = "INSERT INTO attendance (programName, dateTime,submissionDateTime, programHours, status, reasonProof, message,memberName, proofStatus) VALUES (?, ?, ?, ?, ?,?,?, ?, ?)";
        // ❗ Ubah SQL statement untuk tambah semua column
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, attendance.getProgramName());
            preparedStatement.setString(2, attendance.getDateTime()); // ❗ Pastikan model betul guna 'datetTime'
            preparedStatement.setString(3, attendance.getSubmissionDateTime()); // ❗ Pastikan model betul guna 'datetTime'
            preparedStatement.setInt(4, attendance.getProgramHours());
            preparedStatement.setString(5, attendance.getStatus());
            preparedStatement.setString(6, attendance.getReasonProof());
            preparedStatement.setString(7, attendance.getMessage());
            preparedStatement.setString(8, attendance.getMemberName());
            preparedStatement.setString(9, attendance.getProofStatus());  // ❗ Tambah proofStatus

            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Attendance> getAllAttendanceByMembername(String memberName) {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance where memberName = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, memberName);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Attendance a = mapResultSetToAttendance(resultSet);
                attendanceList.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }
    
    // ➕ TAMBAH: Method tapis ikut bulan sahaja
    public List<Attendance> getAttendanceByMembernameAndMonth(String memberName, String month) {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE memberName = ? AND MONTH(dateTime) = ?"; // SQL tapis ikut bulan sahaja

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, memberName);
            preparedStatement.setInt(2, Integer.parseInt(month)); // convert bulan ke integer (01 -> 1)

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Attendance a = mapResultSetToAttendance(resultSet);
                attendanceList.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }

    // Get All Attendance
    public List<Attendance> getAllAttendance() {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Attendance a = mapResultSetToAttendance(resultSet);
                attendanceList.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }

    public boolean deleteAttendance(int attendanceId) {
        String sql = "DELETE FROM attendance WHERE attendanceID = ?"; // ➔ SQL delete by attendanceID

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, attendanceId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper Method to map ResultSet to Attendance object
    private Attendance mapResultSetToAttendance(ResultSet resultSet) throws SQLException {
        Attendance a = new Attendance();
        a.setAttendanceId(resultSet.getInt("attendanceID"));  // ❗ Pastikan ejaan ID konsisten
        a.setProgramName(resultSet.getString("programName"));
        a.setDateTime(resultSet.getString("dateTime"));       // ❗ Sama seperti SQL, bukan 'dateTime'
        a.setSubmissionDateTime(resultSet.getString("submissionDateTime"));
        a.setProgramHours(resultSet.getInt("programHours"));
        a.setStatus(resultSet.getString("status"));
        a.setReasonProof(resultSet.getString("reasonProof"));
        a.setMessage(resultSet.getString("message"));    
        a.setMemberName(resultSet.getString("memberName"));// ❗ Tambah message
        a.setProofStatus(resultSet.getString("proofStatus")); // ❗ Tambah proofStatus
        return a;
    }
// Update Proof Status (Newly Added)

    public boolean updateProofStatus(int attendanceId, String proofStatus) {
        String sql = "UPDATE attendance SET proofStatus = ? WHERE attendanceID = ?"; // Pastikan nama kolum konsisten dengan pangkalan data

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, proofStatus);  // Mengatur status bukti (Approved / Not Approved)
            stmt.setInt(2, attendanceId);    // Mengatur ID kehadiran yang ingin dikemaskini
            int affectedRows = stmt.executeUpdate(); // Dapatkan bilangan baris yang terkesan
            return affectedRows > 0;  // Jika ada baris yang terkesan, kembalikan true
        } catch (SQLException e) {
            e.printStackTrace();  // Tangkap kesalahan jika berlaku
            return false;  // Jika ada masalah, kembalikan false
        }
    }
    // ➕ TAMBAH: Method untuk ambil semua attendance (status 'Present') dan kumpulkan total jam ikut nama
    public Map<String, Integer> getTotalHoursByStudent(String selectedMonth, String selectedYear) {
        Map<String, Integer> studentHours = new HashMap<>();
        String sql = "SELECT memberName, programHours, dateTime FROM attendance WHERE status = 'Present'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String date = rs.getString("dateTime");
                String month = date.substring(5, 7);
                String year = date.substring(0, 4);

                boolean match = true;
                if (selectedMonth != null && !selectedMonth.isEmpty()) {
                    match = month.equals(selectedMonth);
                }
                if (match && selectedYear != null && !selectedYear.isEmpty()) {
                    match = year.equals(selectedYear);
                }

                if (!match) continue;

                String name = rs.getString("memberName");
                int hours = rs.getInt("programHours");
                studentHours.put(name, studentHours.getOrDefault(name, 0) + hours);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return studentHours;
    }

}
