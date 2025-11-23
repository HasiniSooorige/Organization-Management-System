/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.UserRole;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author HP
 */
public class UserRoleDAO {
    public static UserRole getByID(Session session, int id) {
        try {
            UserRole acc = (UserRole) session.load(UserRole.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserRole getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From UserRole as UserRole");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (UserRole) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<UserRole> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserRole as UserRole");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<UserRole> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From UserRole as UserRole");
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

    public static UserRole save(Session session, String name) {
        try {
            UserRole al = new UserRole();
           al.setName(name);
           session.save(al);
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, UserRole al, String name) {
        try {
            al.setName(name);
           session.update(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, UserRole al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
