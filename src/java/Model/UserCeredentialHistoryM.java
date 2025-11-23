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
public class UserCeredentialHistoryM {
   
    
    
     private Integer id;
     private String project;
     private String updatedby;
     private String roll;
     private String type;
     private String category;
       private String reason;
     private String requestType;
       private String password;
     private Date updateddate;
     private String username;

    public UserCeredentialHistoryM(Integer id, String project, String updatedby, String roll, String type, String category, String reason, String requestType, String password, Date updateddate, String username) {
        this.id = id;
        this.project = project;
        this.updatedby = updatedby;
        this.roll = roll;
        this.type = type;
        this.category = category;
        this.reason = reason;
        this.requestType = requestType;
        this.password = password;
        this.updateddate = updateddate;
        this.username = username;
    }

    public UserCeredentialHistoryM() {
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

    public String getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(String updatedby) {
        this.updatedby = updatedby;
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

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getUpdateddate() {
        return updateddate;
    }

    public void setUpdateddate(Date updateddate) {
        this.updateddate = updateddate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

  
}
