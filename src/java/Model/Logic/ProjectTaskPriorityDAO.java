/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.ProjectTaskPriority;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author HP
 */
public class ProjectTaskPriorityDAO {
    public static ProjectTaskPriority getByID(Session session, int id) {
        try {
            ProjectTaskPriority acc = (ProjectTaskPriority) session.load(ProjectTaskPriority.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static ProjectTaskPriority getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From ProjectTaskPriority as ProjectTaskPriority");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (ProjectTaskPriority) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<ProjectTaskPriority> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From ProjectTaskPriority as ProjectTaskPriority");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<ProjectTaskPriority> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From ProjectTaskPriority as ProjectTaskPriority");
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

    public static ProjectTaskPriority save(Session session, String name) {
        try {
            ProjectTaskPriority al = new ProjectTaskPriority();
           
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, ProjectTaskPriority al, String name) {
        try {
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, ProjectTaskPriority al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
