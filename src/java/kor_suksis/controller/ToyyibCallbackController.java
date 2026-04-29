package kor_suksis.controller;

import dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/ToyyibCallbackController")
public class ToyyibCallbackController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ToyyibPay will send billcode and payment status here
        String billCode = request.getParameter("billCode");
        String status = request.getParameter("status"); // Should be "1" for success

        System.out.println("📩 Callback received: billCode=" + billCode + ", status=" + status);

        if (billCode != null && status != null && status.equals("1")) {
            PaymentDAO paymentDAO = new PaymentDAO();
            boolean updated = paymentDAO.updatePaymentStatusByBillCode(billCode, "Paid");

            if (updated) {
                System.out.println("✅ Payment status updated successfully for billCode: " + billCode);
            } else {
                System.out.println("⚠️ Failed to update payment status for billCode: " + billCode);
            }
        }

        // Always respond with 200 to prevent retry from ToyyibPay
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
