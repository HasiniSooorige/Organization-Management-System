/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Model.Mapping.Country;
import Model.Mapping.OrganizationType;
import java.util.Date;

/**
 *
 * @author HP
 */
public class GeneralOrganizationProfileM {

    private Integer id;
    private String country;
    private Integer organizationType;
    private String name;
    private String address1;
    private String address2;
    private String address3;
    private String email;
    private String contactNo;
    private String faxNo;
    private Date createdDate;
    private String logo;
    private Integer gupId;
    private String gupFirstName;
    private String gupLastName;
    private String gupNic;
    private String gupEmail;
    private String gupMobileNo;
    private boolean gupGopStatus;
    private String proName;
    private String proStatus;

    public GeneralOrganizationProfileM() {

    }

    public GeneralOrganizationProfileM(Integer id, String country, Integer organizationType, String name, String address1, String address2, String address3, String email, String contactNo, String faxNo, Date createdDate, String logo, Integer gupId, String gupFirstName, String gupLastName, String gupNic, String gupEmail, String gupMobileNo, boolean gupGopStatus, String proName, String proStatus) {
        this.id = id;
        this.country = country;
        this.organizationType = organizationType;
        this.name = name;
        this.address1 = address1;
        this.address2 = address2;
        this.address3 = address3;
        this.email = email;
        this.contactNo = contactNo;
        this.faxNo = faxNo;
        this.createdDate = createdDate;
        this.logo = logo;
        this.gupId = gupId;
        this.gupFirstName = gupFirstName;
        this.gupLastName = gupLastName;
        this.gupNic = gupNic;
        this.gupEmail = gupEmail;
        this.gupMobileNo = gupMobileNo;
        this.gupGopStatus = gupGopStatus;
        this.proName = proName;
        this.proStatus = proStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Integer getOrganizationType() {
        return organizationType;
    }

    public void setOrganizationType(Integer organizationType) {
        this.organizationType = organizationType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public Integer getGupId() {
        return gupId;
    }

    public void setGupId(Integer gupId) {
        this.gupId = gupId;
    }

    public String getGupFirstName() {
        return gupFirstName;
    }

    public void setGupFirstName(String gupFirstName) {
        this.gupFirstName = gupFirstName;
    }

    public String getGupLastName() {
        return gupLastName;
    }

    public void setGupLastName(String gupLastName) {
        this.gupLastName = gupLastName;
    }

    public String getGupNic() {
        return gupNic;
    }

    public void setGupNic(String gupNic) {
        this.gupNic = gupNic;
    }

    public String getGupEmail() {
        return gupEmail;
    }

    public void setGupEmail(String gupEmail) {
        this.gupEmail = gupEmail;
    }

    public String getGupMobileNo() {
        return gupMobileNo;
    }

    public void setGupMobileNo(String gupMobileNo) {
        this.gupMobileNo = gupMobileNo;
    }

    public boolean isGupGopStatus() {
        return gupGopStatus;
    }

    public void setGupGopStatus(boolean gupGopStatus) {
        this.gupGopStatus = gupGopStatus;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProStatus() {
        return proStatus;
    }

    public void setProStatus(String proStatus) {
        this.proStatus = proStatus;
    }

}
