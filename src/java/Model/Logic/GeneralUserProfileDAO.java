/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.Country;
import Model.Mapping.Gender;
import Model.Mapping.GeneralUserProfile;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author HP
 */
public class GeneralUserProfileDAO {

    public static GeneralUserProfile getByID(Session session, int id) {
        try {
            GeneralUserProfile acc = (GeneralUserProfile) session.load(GeneralUserProfile.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static GeneralUserProfile getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From GeneralUserProfile as GeneralUserProfile");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (GeneralUserProfile) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<GeneralUserProfile> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From GeneralUserProfile as GeneralUserProfile");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<GeneralUserProfile> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From GeneralUserProfile as GeneralUserProfile");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            Query query = session.createQuery(sb.toString());
            return query.iterate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static GeneralUserProfile save(Session session, Country country, Gender gender, String nic, String firstName, String lastName, String address1, String address2, String address3, String mobileNo, String homeNo, String email, Date profileCreatedDate, String faxNo, String contactNo, String nameWithIn) {
        try {
            GeneralUserProfile al = new GeneralUserProfile();
            al.setCountry(country);
            al.setGender(gender);
            al.setNic(nic);
            al.setFirstName(firstName);
            al.setLastName(lastName);
            al.setAddress1(address1);
            al.setAddress1(address2);
            al.setAddress3(address3);
            al.setMobileNo(mobileNo);
            al.setHomeNo(homeNo);
            al.setEmail(email);
            al.setProfileCreatedDate(profileCreatedDate);
            al.setFaxNo(faxNo);
            al.setContactNo(contactNo);
            al.setNameWithIn(nameWithIn);
            session.save(al);
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, GeneralUserProfile al, Country country, Gender gender, String nic, String firstName, String lastName, String address1, String address2, String address3, String mobileNo, String homeNo, String email, Date profileCreatedDate, String faxNo, String contactNo, String nameWithIn) {
        try {
  al.setCountry(country);
            al.setGender(gender);
            al.setNic(nic);
            al.setFirstName(firstName);
            al.setLastName(lastName);
            al.setAddress1(address1);
            al.setAddress1(address2);
            al.setAddress3(address3);
            al.setMobileNo(mobileNo);
            al.setHomeNo(homeNo);
            al.setEmail(email);
            al.setProfileCreatedDate(profileCreatedDate);
            al.setFaxNo(faxNo);
            al.setContactNo(contactNo);
            al.setNameWithIn(nameWithIn);
             session.update(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, GeneralUserProfile al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
