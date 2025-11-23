/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.Projects;
import Model.Mapping.Status;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author HP
 */
public class StatusDAO {
     public static Status getByID(Session session, int id) {
        try {
            Status acc = (Status) session.load(Status.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Status getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From Status as Status");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (Status) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<Status> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From Status as Status");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<Status> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From Status as Status");
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

    public static Status save(Session session, String name) {
        try {
            Status al = new Status();
           
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, Status al, String name) {
        try {
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, Status al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
