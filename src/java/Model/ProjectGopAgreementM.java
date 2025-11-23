/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Model.Mapping.Projects;
import java.util.Date;

/**
 *
 * @author HP
 */
public class ProjectGopAgreementM {

    private Integer id;
    private Integer generalOrganizationProfile;
    private Integer projects;
    private String document;
    private Date uploadedDate;

    public ProjectGopAgreementM(){
        
    }
    
    public ProjectGopAgreementM(Integer id, Integer generalOrganizationProfile, Integer projects, String document, Date uploadedDate) {
        this.id = id;
        this.generalOrganizationProfile = generalOrganizationProfile;
        this.projects = projects;
        this.document = document;
        this.uploadedDate = uploadedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGeneralOrganizationProfile() {
        return generalOrganizationProfile;
    }

    public void setGeneralOrganizationProfile(Integer generalOrganizationProfile) {
        this.generalOrganizationProfile = generalOrganizationProfile;
    }

    public Integer getProjects() {
        return projects;
    }

    public void setProjects(Integer projects) {
        this.projects = projects;
    }

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public Date getUploadedDate() {
        return uploadedDate;
    }

    public void setUploadedDate(Date uploadedDate) {
        this.uploadedDate = uploadedDate;
    }
}
