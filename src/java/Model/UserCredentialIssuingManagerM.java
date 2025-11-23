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
public class UserCredentialIssuingManagerM {
   
     private Integer id;
      private Integer crdentialid;
     private String project;
  private String employeename;
 private String roll;
   private String username;
    private String password;
     private String status;
       private Date lastchangeddate;
     private String category;
       private String type;
        private Date assigndate; 
    private String editedby;
     private String viewed;
private String assigned;
private String note;

    public UserCredentialIssuingManagerM(Integer id, Integer crdentialid, String project, String employeename, String roll, String username, String password, String status, Date lastchangeddate, String category, String type, Date assigndate, String editedby, String viewed, String assigned, String note) {
        this.id = id;
        this.crdentialid = crdentialid;
        this.project = project;
        this.employeename = employeename;
        this.roll = roll;
        this.username = username;
        this.password = password;
        this.status = status;
        this.lastchangeddate = lastchangeddate;
        this.category = category;
        this.type = type;
        this.assigndate = assigndate;
        this.editedby = editedby;
        this.viewed = viewed;
        this.assigned = assigned;
        this.note = note;
    }

    public UserCredentialIssuingManagerM() {
   }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCrdentialid() {
        return crdentialid;
    }

    public void setCrdentialid(Integer crdentialid) {
        this.crdentialid = crdentialid;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public String getEmployeename() {
        return employeename;
    }

    public void setEmployeename(String employeename) {
        this.employeename = employeename;
    }

    public String getRoll() {
        return roll;
    }

    public void setRoll(String roll) {
        this.roll = roll;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getLastchangeddate() {
        return lastchangeddate;
    }

    public void setLastchangeddate(Date lastchangeddate) {
        this.lastchangeddate = lastchangeddate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getAssigndate() {
        return assigndate;
    }

    public void setAssigndate(Date assigndate) {
        this.assigndate = assigndate;
    }

    public String getEditedby() {
        return editedby;
    }

    public void setEditedby(String editedby) {
        this.editedby = editedby;
    }

    public String getViewed() {
        return viewed;
    }

    public void setViewed(String viewed) {
        this.viewed = viewed;
    }

    public String getAssigned() {
        return assigned;
    }

    public void setAssigned(String assigned) {
        this.assigned = assigned;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
   
}
