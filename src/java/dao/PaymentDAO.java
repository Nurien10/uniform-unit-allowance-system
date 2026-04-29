/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.DBConnection;
import model.Payment;

public class PaymentDAO {

    private Connection connection;

    public PaymentDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new IllegalStateException("Failed to establish a database connection!");
        }
    }

    // Insert payment record selepas generate bill
    public void insertPaymentRecord(Payment payment) {
        String sql = "INSERT INTO allowance_payment (memberName, month, year, programHours, amount, status, paymentUrl, billCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, payment.getMemberName());
            ps.setString(2, payment.getMonth());
            ps.setString(3, payment.getYear());
            ps.setInt(4, payment.getProgramHours());
            ps.setBigDecimal(5, payment.getAmount());
            ps.setString(6, payment.getStatus());
            ps.setString(7, payment.getPaymentUrl());
            ps.setString(8, payment.getBillCode());
            int rowsAfftected = ps.executeUpdate();

            System.out.println("--------------ATTEMPTING TO INSERT A NEW PAYMENT RECORD--------");

            System.out.println("payment insert: " + rowsAfftected);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Check if bill already exist (avoid duplicate)
    public boolean billExists(String memberName, String month, String year) {
        String sql = "SELECT 1 FROM allowance_payment WHERE memberName = ? AND month = ? AND year = ? AND status = 'Paid'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, memberName);
            ps.setString(2, month);
            ps.setString(3, year);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Hanya pulangkan true jika status adalah 'Paid'
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update payment status via callback
    public boolean updatePaymentStatusByBillCode(String billCode, String status) {
        String sql = "UPDATE allowance_payment SET status = ? WHERE billCode = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, billCode);
            System.out.println("Attempting to update status to '" + status + "' for billCode: " + billCode); // Debug log
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Debug log
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQLException occurred while updating status for billCode " + billCode + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get payment data untuk display balik
    public List<Payment> getPaymentsByMonthYear(String month, String year) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM allowance_payment WHERE month = ? AND year = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, month);
            ps.setString(2, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment p = new Payment();
                p.setMemberName(rs.getString("memberName"));
                p.setMonth(rs.getString("month"));
                p.setYear(rs.getString("year"));
                p.setProgramHours(rs.getInt("programHours"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setStatus(rs.getString("status"));
                p.setPaymentUrl(rs.getString("paymentUrl"));
                p.setBillCode(rs.getString("billCode"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

// Get payment status based on memberName, month, and year
    public String getStatus(String memberName, String month, String year) {
        String sql = "SELECT status FROM allowance_payment WHERE memberName = ? AND month = ? AND year = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, memberName);
            ps.setString(2, month);
            ps.setString(3, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Pending"; // atau return default status jika tiada rekod
    }

    public List<Payment> getPaymentsByMemberName(String memberName) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM allowance_payment WHERE memberName = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, memberName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment p = new Payment();
                p.setMemberName(rs.getString("memberName"));
                p.setMonth(rs.getString("month"));
                p.setYear(rs.getString("year"));
                p.setProgramHours(rs.getInt("programHours"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setStatus(rs.getString("status"));
                p.setPaymentUrl(rs.getString("paymentUrl"));
                p.setBillCode(rs.getString("billCode"));
                p.setPaymentDate(rs.getDate("paymentDate"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
