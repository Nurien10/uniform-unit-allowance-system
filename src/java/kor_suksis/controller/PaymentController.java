package kor_suksis.controller;

import dao.PaymentDAO;
import model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

@WebServlet("/PaymentController")
public class PaymentController extends HttpServlet {

    private static final String SECRET_KEY = "21v94x9c-5ble-v2oh-s877-32xcg70rxa67";
    private static final String CATEGORY_CODE = "dzbpgyhx";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberName = request.getParameter("memberName");
        String email = request.getParameter("email");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        int programHours = Integer.parseInt(request.getParameter("programHours"));
        String phone = request.getParameter("phone");

        BigDecimal amount = BigDecimal.valueOf(programHours * 8);
        PaymentDAO paymentDAO = new PaymentDAO();

        if (paymentDAO.billExists(memberName, month, year)) {
            response.getWriter().println("Bill already exists for this member.");
            return;
        }

        String billCode = createToyyibPayBill(memberName, email, phone, amount, month, year);

        if (billCode != null) {
            String paymentUrl = "https://dev.toyyibpay.com/" + billCode;

            Payment payment = new Payment();
            payment.setMemberName(memberName);
            payment.setMonth(month);
            payment.setYear(year);
            payment.setProgramHours(programHours);
            payment.setAmount(amount);
            payment.setStatus("Pending");
            payment.setPaymentUrl(paymentUrl);
            payment.setBillCode(billCode);

            paymentDAO.insertPaymentRecord(payment);

            // Redirect user to ToyyibPay payment page
            response.sendRedirect(paymentUrl);
        } else {
            response.getWriter().println("Failed to create bill.");
        }
    }

    private String createToyyibPayBill(String memberName, String email, String phone, BigDecimal amount, String month, String year) {
        try {
            URL url = new URL("https://dev.toyyibpay.com/index.php/api/createBill");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            String billAmount = String.valueOf(amount.multiply(BigDecimal.valueOf(100)).intValue());
            String externalRef = UUID.randomUUID().toString();

            String billReturnUrl = "http://localhost:8080/fypsystem/ToyyibReturnController?month=" + month + "&year=" + year;
            String billCallbackUrl = "http://localhost:8080/fypsystem/ToyyibCallbackController";

            String postData = "userSecretKey=" + URLEncoder.encode(SECRET_KEY, "UTF-8")
                    + "&categoryCode=" + URLEncoder.encode(CATEGORY_CODE, "UTF-8")
                    + "&billName=" + URLEncoder.encode("Allowance Kor Suksis UMT", "UTF-8")
                    + "&billDescription=" + URLEncoder.encode("Payment for " + month + "/" + year, "UTF-8")
                    + "&billPriceSetting=1"
                    + "&billPayorInfo=1"
                    + "&billAmount=" + URLEncoder.encode(billAmount, "UTF-8")
                    + "&billReturnUrl=" + URLEncoder.encode(billReturnUrl, "UTF-8")
                    + "&billCallbackUrl=" + URLEncoder.encode(billCallbackUrl, "UTF-8")
                    + "&billExternalReferenceNo=" + URLEncoder.encode(externalRef, "UTF-8")
                    + "&billTo=" + URLEncoder.encode(memberName, "UTF-8")
                    + "&billEmail=" + URLEncoder.encode(email, "UTF-8")
                    + "&billPhone=" + URLEncoder.encode(phone, "UTF-8");

            try (OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream())) {
                writer.write(postData);
                writer.flush();
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseText = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                responseText.append(line);
            }
            reader.close();

            String resStr = responseText.toString();
            if (resStr.contains("\"BillCode\":\"")) {
                int start = resStr.indexOf("\"BillCode\":\"") + "\"BillCode\":\"".length();
                int end = resStr.indexOf("\"", start);
                return resStr.substring(start, end);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
