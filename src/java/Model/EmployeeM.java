/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;

/**
 *
 * @author kbnc
 */
public class EmployeeM {

    public EmployeeM() {
    }
    private Integer id;
    private String nic;
    private String firstname;
    private String lastname;
    private String address1;
    private String address2;
    private String address3;
    private String mobileno;
    private String homeno;
    private String emergencyContactNo;
    private String email;
    private Date profile_created_date;
    private String coutry;
    private Date registereddate;
    private Date dateofbirth;
    private String epfno;
    private String generalorganizationname;
    private String designation;
    private String gender;
    private Date resignationDate;

    public EmployeeM(Integer id, String nic, String firstname, String lastname, String address1, String address2, String address3, String mobileno, String homeno, String emergencyContactNo, String email, Date profile_created_date, String coutry, Date registereddate, Date dateofbirth, String epfno, String generalorganizationname, String designation, String gender, Date resignationDate) {
        this.id = id;
        this.nic = nic;
        this.firstname = firstname;
        this.lastname = lastname;
        this.address1 = address1;
        this.address2 = address2;
        this.address3 = address3;
        this.mobileno = mobileno;
        this.homeno = homeno;
        this.emergencyContactNo = emergencyContactNo;
        this.email = email;
        this.profile_created_date = profile_created_date;
        this.coutry = coutry;
        this.registereddate = registereddate;
        this.dateofbirth = dateofbirth;
        this.epfno = epfno;
        this.generalorganizationname = generalorganizationname;
        this.designation = designation;
        this.gender = gender;
        this.resignationDate = resignationDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
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

    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    public String getHomeno() {
        return homeno;
    }

    public void setHomeno(String homeno) {
        this.homeno = homeno;
    }

    public String getEmergencyContactNo() {
        return emergencyContactNo;
    }

    public void setEmergencyContactNo(String emergencyContactNo) {
        this.emergencyContactNo = emergencyContactNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getProfile_created_date() {
        return profile_created_date;
    }

    public void setProfile_created_date(Date profile_created_date) {
        this.profile_created_date = profile_created_date;
    }

    public String getCoutry() {
        return coutry;
    }

    public void setCoutry(String coutry) {
        this.coutry = coutry;
    }

    public Date getRegistereddate() {
        return registereddate;
    }

    public void setRegistereddate(Date registereddate) {
        this.registereddate = registereddate;
    }

    public Date getDateofbirth() {
        return dateofbirth;
    }

    public void setDateofbirth(Date dateofbirth) {
        this.dateofbirth = dateofbirth;
    }

    public String getEpfno() {
        return epfno;
    }

    public void setEpfno(String epfno) {
        this.epfno = epfno;
    }

    public String getGeneralorganizationname() {
        return generalorganizationname;
    }

    public void setGeneralorganizationname(String generalorganizationname) {
        this.generalorganizationname = generalorganizationname;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getResignationDate() {
        return resignationDate;
    }

    public void setResignationDate(Date resignationDate) {
        this.resignationDate = resignationDate;
    }

    
}
