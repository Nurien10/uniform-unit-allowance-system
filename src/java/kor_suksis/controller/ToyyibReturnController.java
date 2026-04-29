package kor_suksis.controller;

import dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@WebServlet("/ToyyibReturnController")
public class ToyyibReturnController extends HttpServlet {

    private PaymentDAO paymentDAO = new PaymentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("-----------------return controller here--------");

        // Log all parameters
        request.getParameterMap().forEach((k, v) -> System.out.println(k + " = " + String.join(", ", v)));

        // Use lowercase "billcode" - check what ToyyibPay sends back
        String billCode = request.getParameter("billcode");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        System.out.println("billCode: " + billCode);

        if (billCode != null) {
            String paymentStatus = checkToyyibPaymentStatus(billCode);

            System.out.println("status: " + paymentStatus);

            if ("1".equals(paymentStatus)) {
                paymentDAO.updatePaymentStatusByBillCode(billCode, "Paid");
            } else if ("2".equals(paymentStatus)) {
                paymentDAO.updatePaymentStatusByBillCode(billCode, "Failed");
            } else {
                paymentDAO.updatePaymentStatusByBillCode(billCode, "Pending");
            }

            request.setAttribute("paymentStatus", paymentStatus);
            request.setAttribute("billCode", billCode);
            request.setAttribute("month", month);
            request.setAttribute("year", year);

            request.getRequestDispatcher("paymentexternal_officer.jsp").forward(request, response);
        } else {
            response.sendRedirect("paymentexternal_officer.jsp?month=" + month + "&year=" + year);
        }
    }

    private String checkToyyibPaymentStatus(String billCode) {
        try {
            URL url = new URL("https://dev.toyyibpay.com/index.php/api/getBillTransactions");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            String postData = "billCode=" + URLEncoder.encode(billCode, "UTF-8");

            try (OutputStream os = conn.getOutputStream()) {
                os.write(postData.getBytes());
                os.flush();
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseText = new StringBuilder();
            String line;
            while ((line = in.readLine()) != null) {
                responseText.append(line);
            }
            in.close();

            String response = responseText.toString();

            // Extract payment status from the JSON string
            int statusIndex = response.indexOf("\"billpaymentStatus\":\"");
            if (statusIndex != -1) {
                int start = statusIndex + "\"billpaymentStatus\":\"".length();
                int end = response.indexOf("\"", start);
                return response.substring(start, end);  // "1" = success, "2" = failed
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
