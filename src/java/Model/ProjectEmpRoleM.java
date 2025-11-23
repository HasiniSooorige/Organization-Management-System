/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;
import java.util.Set;

/**
 *
 * @author HP
 */
public class ProjectEmpRoleM {

    private Integer EmpId;
    private Integer ProEmpRoleId;
    private String FirstName;
    private String LastName;
    private Date startDate;
    private Date endDate;
    private String Designation;
    private String ProjectEmpRole;
    private Boolean IsActive;

    public ProjectEmpRoleM() {
    }

    public ProjectEmpRoleM(Integer EmpId, Integer ProEmpRoleId, String FirstName, String LastName, Date startDate, Date endDate, String Designation, String ProjectEmpRole, Boolean IsActive) {
        this.EmpId = EmpId;
        this.ProEmpRoleId = ProEmpRoleId;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.Designation = Designation;
        this.ProjectEmpRole = ProjectEmpRole;
        this.IsActive = IsActive;
    }

    public Integer getEmpId() {
        return EmpId;
    }

    public void setEmpId(Integer EmpId) {
        this.EmpId = EmpId;
    }

    public Integer getProEmpRoleId() {
        return ProEmpRoleId;
    }

    public void setProEmpRoleId(Integer ProEmpRoleId) {
        this.ProEmpRoleId = ProEmpRoleId;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getDesignation() {
        return Designation;
    }

    public void setDesignation(String Designation) {
        this.Designation = Designation;
    }

    public String getProjectEmpRole() {
        return ProjectEmpRole;
    }

    public void setProjectEmpRole(String ProjectEmpRole) {
        this.ProjectEmpRole = ProjectEmpRole;
    }

    public Boolean getIsActive() {
        return IsActive;
    }

    public void setIsActive(Boolean IsActive) {
        this.IsActive = IsActive;
    }
}
