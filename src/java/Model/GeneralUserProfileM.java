/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Model.Mapping.Country;
import java.util.Date;


/**
 *
 * @author kbnc
 */
public class GeneralUserProfileM{

    public GeneralUserProfileM(Integer empid, Integer id, Country country, String nic, String firstName, String lastName, String address1, String address2, String address3, String mobileNo, String homeNo, String email, Date profileCreatedDate, String Uaction) {
        this.empid = empid;
        this.id = id;
        this.country = country;
        this.nic = nic;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address1 = address1;
        this.address2 = address2;
        this.address3 = address3;
        this.mobileNo = mobileNo;
        this.homeNo = homeNo;
        this.email = email;
        this.profileCreatedDate = profileCreatedDate;
        this.Uaction = Uaction;
    }

     private Integer empid;
     private Integer id;
     private Country country;
     private String nic;
     private String firstName;
     private String lastName;
     private String address1;
     private String address2;
     private String address3;
     private String mobileNo;
     private String homeNo;
     private String email;
     private Date profileCreatedDate;
     private String  Uaction;

    public GeneralUserProfileM() {
    }

	
    public GeneralUserProfileM(Country country) {
        this.country = country;
    }
    
   
    
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Country getCountry() {
        return this.country;
    }
    
    public void setCountry(Country country) {
        this.country = country;
    }

    
    
    public String getNic() {
        return this.nic;
    }
    
    public void setNic(String nic) {
        this.nic = nic;
    }

   
    public String getFirstName() {
        return this.firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    
    public String getLastName() {
        return this.lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

   
    public String getAddress1() {
        return this.address1;
    }
    
    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    
    public String getAddress2() {
        return this.address2;
    }
    
    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAddress3() {
        return this.address3;
    }
    
    public void setAddress3(String address3) {
        this.address3 = address3;
    }

   
    public String getMobileNo() {
        return this.mobileNo;
    }
    
    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

   
    public String getHomeNo() {
        return this.homeNo;
    }
    
    public void setHomeNo(String homeNo) {
        this.homeNo = homeNo;
    }


    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    
    public Date getProfileCreatedDate() {
        return this.profileCreatedDate;
    }
    
    public void setProfileCreatedDate(Date profileCreatedDate) {
        this.profileCreatedDate = profileCreatedDate;
    }

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public String getUaction() {
        return Uaction;
    }

    public void setUaction(String Uaction) {
        this.Uaction = Uaction;
    }

  




}



