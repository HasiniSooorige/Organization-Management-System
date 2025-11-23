/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.UserCredentialViewRequest;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Jalana
 */
public class UserCredentialViewRequestDAO {
    public static UserCredentialViewRequest getByID(Session session, int id) {
        try {
            UserCredentialViewRequest acc = (UserCredentialViewRequest) session.load(UserCredentialViewRequest.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserCredentialViewRequest getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From UserCredentialViewRequest as UserCredentialViewRequest");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (UserCredentialViewRequest) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<UserCredentialViewRequest> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserCredentialViewRequest as UserCredentialViewRequest");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<UserCredentialViewRequest> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserCredentialViewRequest as UserCredentialViewRequest");
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

    public static UserCredentialViewRequest save(Session session, String name) {
        try {
            UserCredentialViewRequest al = new UserCredentialViewRequest();
           
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, UserCredentialViewRequest al, String name) {
        try {
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, UserCredentialViewRequest al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
