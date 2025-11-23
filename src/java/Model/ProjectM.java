/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Model.Mapping.GeneralOrganizationProfile;
import Model.Mapping.Status;
import com.mysql.cj.util.DnsSrv;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Developer
 */
public class ProjectM {

  private Integer id;
    private String generalOrganizationProfileName;
    private String statusName;
    private Integer statusId;
    private String name;
    private String description;
    private Date startedDate;
    private Date completedDate;
    private String logoUrl;
    private String projectDocuments;
    private Set commentsManagers = new HashSet(0);
    private Set projectEmployeeses = new HashSet(0);

    private String address1;
    private String address2;
    private String address3;
    private String CountryName;
    private String email;
    private String contactNo;
    private String faxNo;

    private Integer EmpId;
    private Integer ProEmpRoleId;
    private String FirstName;
    private String LastName;
    private String Designation;
    private String ProjectEmpRole;

    public ProjectM() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGeneralOrganizationProfileName() {
        return generalOrganizationProfileName;
    }

    public void setGeneralOrganizationProfileName(String generalOrganizationProfileName) {
        this.generalOrganizationProfileName = generalOrganizationProfileName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartedDate() {
        return startedDate;
    }

    public void setStartedDate(Date startedDate) {
        this.startedDate = startedDate;
    }

    public Date getCompletedDate() {
        return completedDate;
    }

    public void setCompletedDate(Date completedDate) {
        this.completedDate = completedDate;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getProjectDocuments() {
        return projectDocuments;
    }

    public void setProjectDocuments(String projectDocuments) {
        this.projectDocuments = projectDocuments;
    }

    public Set getCommentsManagers() {
        return commentsManagers;
    }

    public void setCommentsManagers(Set commentsManagers) {
        this.commentsManagers = commentsManagers;
    }

    public Set getProjectEmployeeses() {
        return projectEmployeeses;
    }

    public void setProjectEmployeeses(Set projectEmployeeses) {
        this.projectEmployeeses = projectEmployeeses;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAddress3() {
        return address3;
    }

    public void setAddress3(String address3) {
        this.address3 = address3;
    }

    public String getCountryName() {
        return CountryName;
    }

    public void setCountryName(String CountryName) {
        this.CountryName = CountryName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getFaxNo() {
        return faxNo;
    }

    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo;
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

    public ProjectM(Integer id, String generalOrganizationProfileName, String statusName, Integer statusId, String name, String description, Date startedDate, Date completedDate, String logoUrl, String projectDocuments, String address1, String address2, String address3, String CountryName, String email, String contactNo, String faxNo, Integer EmpId, Integer ProEmpRoleId, String FirstName, String LastName, String Designation, String ProjectEmpRole) {
        this.id = id;
        this.generalOrganizationProfileName = generalOrganizationProfileName;
        this.statusName = statusName;
        this.statusId = statusId;
        this.name = name;
        this.description = description;
        this.startedDate = startedDate;
        this.completedDate = completedDate;
        this.logoUrl = logoUrl;
        this.projectDocuments = projectDocuments;
        this.address1 = address1;
        this.address2 = address2;
        this.address3 = address3;
        this.CountryName = CountryName;
        this.email = email;
        this.contactNo = contactNo;
        this.faxNo = faxNo;
        this.EmpId = EmpId;
        this.ProEmpRoleId = ProEmpRoleId;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Designation = Designation;
        this.ProjectEmpRole = ProjectEmpRole;
    }

   
}
