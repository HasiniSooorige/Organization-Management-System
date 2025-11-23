/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.UserCredentialViewRequestType;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Jalana
 */
public class UserCredentialViewRequstTypeDAO {
    public static UserCredentialViewRequestType getByID(Session session, int id) {
        try {
            UserCredentialViewRequestType acc = (UserCredentialViewRequestType) session.load(UserCredentialViewRequestType.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserCredentialViewRequestType getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From UserCredentialViewRequestType as UserCredentialViewRequestType");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (UserCredentialViewRequestType) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<UserCredentialViewRequestType> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserCredentialViewRequestType as UserCredentialViewRequestType");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<UserCredentialViewRequestType> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserCredentialViewRequestType as UserCredentialViewRequestType");
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

    public static UserCredentialViewRequestType save(Session session, String name) {
        try {
            UserCredentialViewRequestType al = new UserCredentialViewRequestType();
           
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, UserCredentialViewRequestType al, String name) {
        try {
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, UserCredentialViewRequestType al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
