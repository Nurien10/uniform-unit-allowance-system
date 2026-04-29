/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Attendance {

    private int attendanceId;
    private String programName;
    private String dateTime;
    private String submissionDateTime;
    private int programHours;
    private String status;
    private String reasonProof;
    private String message;
    private String proofStatus;
    private String memberName;

    // Getter dan Setter semua fields
    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getSubmissionDateTime() {
        return submissionDateTime;
    }

    public void setSubmissionDateTime(String submissionDateTime) {
        this.submissionDateTime = submissionDateTime;
    }
    
    

    public int getProgramHours() {
        return programHours;
    }

    public void setProgramHours(int programHours) {
        this.programHours = programHours;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReasonProof() {
        return reasonProof;
    }

    public void setReasonProof(String reasonProof) {
        this.reasonProof = reasonProof;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getProofStatus() {
        return proofStatus;
    }

    public void setProofStatus(String proofStatus) {
        this.proofStatus = proofStatus;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    @Override
    public String toString() {
        return "Attendance{"
                + "attendanceId=" + attendanceId
                + ", programName='" + programName + '\''
                + ", dateTime='" + dateTime + '\''
                + ", programHours=" + programHours
                + ", status='" + status + '\''
                + ", reasonProof='" + reasonProof + '\''
                + ", message='" + message + '\''
                + ", proofStatus='" + proofStatus + '\''
                + ", memberName='" + memberName + '\''
                + '}';
    }

}
