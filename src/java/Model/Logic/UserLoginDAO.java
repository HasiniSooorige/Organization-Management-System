/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.UserLogin;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author HP
 */
public class UserLoginDAO {

    public static UserLogin getByID(Session session, int id) {
        try {
            UserLogin acc = (UserLogin) session.load(UserLogin.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserLogin getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From UserLogin as UserLogin");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (UserLogin) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<UserLogin> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserLogin as UserLogin");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<UserLogin> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserLogin as UserLogin");
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

    public static UserLogin save(Session session, int GeneralUserProfile, int UserRole, String usernamen, String password, int MaxLoginAttempt, int CountAttempt, boolean isactive) {
        try {
            UserLogin al = new UserLogin();

            al.setCountAttempt(CountAttempt);
            al.setGeneralUserProfile(GeneralUserProfileDAO.getByID(session, GeneralUserProfile));
            al.setIsActive(isactive);
            al.setMaxLoginAttemp(MaxLoginAttempt);
            al.setPassword(password);
            al.setUserRole(UserRoleDAO.getByID(session, UserRole));
            al.setUsername(usernamen);
            session.save(al);
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, UserLogin al, String name, int GeneralUserProfile, int UserRole, String password, int MaxLoginAttempt, int CountAttempt, boolean isactive) {
        try {
            al.setCountAttempt(CountAttempt);
            al.setGeneralUserProfile(GeneralUserProfileDAO.getByID(session, GeneralUserProfile));
            al.setIsActive(isactive);
            al.setMaxLoginAttemp(MaxLoginAttempt);
            al.setPassword(password);
            al.setUserRole(UserRoleDAO.getByID(session, UserRole));
            al.setUsername(name);
             session.update(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, UserLogin al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
