/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class ProgramHighCouncil {
    private int id;
    private String programName;
    private Timestamp dateTime;
    private String venue;
    private String trainer;
    private String programHours;

    // Constructor
    public ProgramHighCouncil(int id, String programName, Timestamp dateTime, String venue, String trainer, String programHours) {
        this.id = id;
        this.programName = programName;
        this.dateTime = dateTime;
        this.venue = venue;
        this.trainer = trainer;
        this.programHours = programHours;
    }

    public ProgramHighCouncil(String programName, Timestamp dateTime, String venue, String trainer, String programHours) {
        this.programName = programName;
        this.dateTime = dateTime;
        this.venue = venue;
        this.trainer = trainer;
        this.programHours = programHours;

    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }

    public Timestamp getDateTime() {
        return dateTime;
    }

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getTrainer() {
        return trainer;
    }

    public void setTrainer(String trainer) {
        this.trainer = trainer;
    }

    public String getProgramHours() {
        return programHours;
    }

    public void setProgramHours(String programHours) {
        this.programHours = programHours;
    }
    
    
}
