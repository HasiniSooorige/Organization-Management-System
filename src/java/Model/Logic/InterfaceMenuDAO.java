/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.InterfaceMenu;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Personal
 */
public class InterfaceMenuDAO {

    public static InterfaceMenu getByID(Session session, int id) {
        try {
            InterfaceMenu acc = (InterfaceMenu) session.load(InterfaceMenu.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static InterfaceMenu getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From InterfaceMenu as InterfaceMenu");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (InterfaceMenu) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<InterfaceMenu> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From InterfaceMenu as InterfaceMenu");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<InterfaceMenu> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From InterfaceMenu as InterfaceMenu");
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

    public static InterfaceMenu save(Session session, String name) {
        try {
            InterfaceMenu al = new InterfaceMenu();
            al.setMenuName(name);
            session.save(al);
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, InterfaceMenu al, String name) {
        try {
            al.setMenuName(name);
            session.update(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, InterfaceMenu al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
