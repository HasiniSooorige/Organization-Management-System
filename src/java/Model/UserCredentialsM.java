/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;


import java.util.Date;

/**
 *
 * @author Jalana
 */
public class UserCredentialsM {

   

    public UserCredentialsM() {
    }
 private Integer id;
     private String project;
     private String username;
     private String roll;
     private String type;
     private String category;
     private String status;
     private String note;
       private String password;
     private Date createddate;
     private String employeename;

    public UserCredentialsM(Integer id, String project, String username, String roll, String type, String category, String status, String note, String password, Date createddate, String employeename) {
        this.id = id;
        this.project = project;
        this.username = username;
        this.roll = roll;
        this.type = type;
        this.category = category;
        this.status = status;
        this.note = note;
        this.password = password;
        this.createddate = createddate;
        this.employeename = employeename;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRoll() {
        return roll;
    }

    public void setRoll(String roll) {
        this.roll = roll;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public String getEmployeename() {
        return employeename;
    }

    public void setEmployeename(String employeename) {
        this.employeename = employeename;
    }

  

   
}
