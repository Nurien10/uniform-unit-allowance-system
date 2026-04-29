package kor_suksis.controller;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject; // TAMBAHAN

import model.Attendance;
import dao.AttendanceDAO;
import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/GeneratePDFController")
public class GeneratePDFController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Allowance_Report.pdf");

        String selectedMonth = request.getParameter("month");
        String selectedYear = request.getParameter("year");
        String monthYear = (selectedMonth != null && !selectedMonth.isEmpty() ? selectedMonth : "All") + "/" + (selectedYear != null && !selectedYear.isEmpty() ? selectedYear : "All");

        AttendanceDAO dao = new AttendanceDAO();
        List<Attendance> allAttendance = dao.getAllAttendance();
        UserDAO userDAO = new UserDAO();
        Map<String, Integer> studentHours = new HashMap<>();

        for (Attendance att : allAttendance) {
            String date = att.getDateTime();
            String month = date.substring(5, 7);
            String year = date.substring(0, 4);

            boolean match = true;
            if (selectedMonth != null && !selectedMonth.isEmpty()) {
                match = month.equals(selectedMonth);
            }
            if (match && selectedYear != null && !selectedYear.isEmpty()) {
                match = year.equals(selectedYear);
            }

            if (!match || !"Present".equalsIgnoreCase(att.getStatus())) {
                continue;
            }

            String name = att.getMemberName();
            int hours = att.getProgramHours();
            studentHours.put(name, studentHours.getOrDefault(name, 0) + hours);
        }

        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage(PDRectangle.A4);
            document.addPage(page);

            // TAMBAHAN: Gambar logo kiri dan kanan
            PDImageXObject leftLogo = PDImageXObject.createFromFile(
                    getServletContext().getRealPath("/assets/images/kor_suksis.png"), document); // TAMBAHAN
            PDImageXObject rightLogo = PDImageXObject.createFromFile(
                    getServletContext().getRealPath("/assets/images/logo_umt.png"), document); // TAMBAHAN

            PDPageContentStream contentStream = new PDPageContentStream(document, page);

            contentStream.drawImage(leftLogo, 50, 700, 60, 60); // TAMBAHAN
            contentStream.drawImage(rightLogo, 490, 700, 60, 60); // TAMBAHAN

            // TAMBAHAN: Teks header di tengah dan emel bawah tel
            contentStream.beginText();
            contentStream.setFont(PDType1Font.TIMES_BOLD, 12);
            contentStream.newLineAtOffset(120, 750);
            contentStream.showText("KOR SUKARELAWAN SIMPANAN POLIS SISWA / SISWI (SUKSIS)");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("UNIVERSITI MALAYSIA TERENGGANU");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("21030 KUALA NERUS, TERENGGANU DARUL IMAN");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("Tel: 09 - 6693461");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("E-Mel: suksis_umt@rmp.gov.my");
            contentStream.endText();


            // TAMBAHAN: Garisan bawah header
            contentStream.setStrokingColor(0, 0, 0);
            contentStream.setLineWidth(1f);
            contentStream.moveTo(50, 675);
            contentStream.lineTo(550, 675);
            contentStream.stroke();

            // TAMBAHAN: Slogan
            contentStream.beginText();
            contentStream.setFont(PDType1Font.TIMES_ITALIC, 12);
            contentStream.newLineAtOffset(50, 660);
            contentStream.showText("\"POLIS DAN MASYARAKAT BERPISAH TIADA\"");
            contentStream.endText();

            // Rujukan dan penerima
            contentStream.beginText();
            contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
            contentStream.newLineAtOffset(400, 645);
            contentStream.showText("Rujukan: SUKSIS/UMT/140/25/6");
            contentStream.endText();

            contentStream.beginText();
            contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
            contentStream.newLineAtOffset(50, 620);
            contentStream.showText("Ibu Pejabat Polis Diraja Malaysia");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("Bukit Aman");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("50560 Kuala Lumpur.");
            contentStream.endText();

            contentStream.beginText();
            contentStream.setFont(PDType1Font.TIMES_BOLD, 12);
            contentStream.newLineAtOffset(50, 570);
            contentStream.showText("BORANG PENGESAHAN TUNTUTAN ELAUN AHLI UNIT KOR SUKSIS UNIVERSITI");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("MALAYSIA TERENGGANU.");
            contentStream.endText();

            contentStream.beginText();
            contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
            contentStream.newLineAtOffset(50, 530);
            contentStream.showText("BULAN DAN TAHUN: " + monthYear);
            contentStream.newLineAtOffset(0, -20);
            contentStream.showText("SENARAI AHLI KOR SUKSIS DAN JUMLAH ELAUN:");
            contentStream.endText();

            // TABLE
            float tableTopY = 480;
            float[] colWidths = {30, 150, 60, 130, 130};
            float[] colOffsets = {50, 80, 230, 300, 430};
            float rowHeight = 22;
            int rowCount = Math.max(1, studentHours.size());

            // Garisan menegak
            
            // Garisan mendatar
            for (int i = 0; i <= rowCount + 1; i++) {
                float y = tableTopY - i * rowHeight;
                contentStream.moveTo(colOffsets[0], y);
                contentStream.lineTo(colOffsets[4] + colWidths[4], y);
                contentStream.stroke();
            }

            // Header jadual
            contentStream.setFont(PDType1Font.HELVETICA_BOLD, 10);
            contentStream.beginText();
            contentStream.newLineAtOffset(colOffsets[0] + 5, tableTopY - rowHeight + 5);
            contentStream.showText("Bil");
            contentStream.newLineAtOffset(colOffsets[1] - colOffsets[0], 0);
            contentStream.showText("Nama Pelajar");
            contentStream.newLineAtOffset(colOffsets[2] - colOffsets[1], 0);
            contentStream.showText("Jumlah Jam");
            contentStream.newLineAtOffset(colOffsets[3] - colOffsets[2], 0);
            contentStream.showText("Jumlah Elaun(RM)");
            contentStream.newLineAtOffset(colOffsets[4] - colOffsets[3], 0);
            contentStream.showText("Nombor Akaun (CIMB)");
            contentStream.endText();

            // Isi data
            contentStream.setFont(PDType1Font.TIMES_ROMAN, 10);
            float yPosition = tableTopY - 2 * rowHeight;
            int index = 1;

            for (Map.Entry<String, Integer> entry : studentHours.entrySet()) {
                String name = entry.getKey();
                int totalHours = entry.getValue();
                int totalAllowance = totalHours * 8;
                User user = userDAO.searchUsersByName(name).stream().findFirst().orElse(null);
                String bankAccount = (user != null && user.getBankAccount() != null) ? user.getBankAccount() : "-";
                float cellY = yPosition + (rowHeight - 10) / 2;

                contentStream.beginText();
                contentStream.newLineAtOffset(colOffsets[0] + 5, cellY);
                contentStream.showText(String.valueOf(index++));
                contentStream.endText();

                contentStream.beginText();
                contentStream.newLineAtOffset(colOffsets[1] + 5, cellY);
                contentStream.showText(name.length() > 20 ? name.substring(0, 20) + "..." : name);
                contentStream.endText();

                contentStream.beginText();
                contentStream.newLineAtOffset(colOffsets[2] + 5, cellY);
                contentStream.showText(String.valueOf(totalHours));
                contentStream.endText();

                contentStream.beginText();
                contentStream.newLineAtOffset(colOffsets[3] + 5, cellY);
                contentStream.showText("RM " + totalAllowance);
                contentStream.endText();

                contentStream.beginText();
                contentStream.newLineAtOffset(colOffsets[4] + 5, cellY);
                contentStream.showText(bankAccount);
                contentStream.endText();

                yPosition -= rowHeight;
            }

            // Footer
            contentStream.setFont(PDType1Font.TIMES_BOLD, 10);
            contentStream.beginText();
            contentStream.newLineAtOffset(50, 130);
            contentStream.showText("\"MALAYSIA MADANI\"");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("\"BERKHIDMAT UNTUK NEGARA\"");
            contentStream.endText();

            contentStream.setFont(PDType1Font.TIMES_ROMAN, 10);
            contentStream.beginText();
            contentStream.newLineAtOffset(50, 85);
            contentStream.showText("Saya yang menjalankan amanah,");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("Disahkan oleh:");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("Nama Jurulatih: ____________________");
            contentStream.newLineAtOffset(0, -15);
            contentStream.showText("Tarikh: ____________________");
            contentStream.endText();

            contentStream.close();

            try (OutputStream out = response.getOutputStream()) {
                document.save(out);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF");
        }
    }
}
